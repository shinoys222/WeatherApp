//
//  WAWeatherCollectionVC.swift
//  WeatherApp
//
//  Created by Mohammed Shinoys  on 2/2/16.
//  Copyright © 2016 Kalypso. All rights reserved.
//

import UIKit
import SwiftLayoutKit
import MagicalRecord
import AFNetworking
import SVProgressHUD

private let reuseIdentifier = "Cell"

class WAWeatherCollectionVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{

    var collectionLayout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView!
    var monthLabel = UILabel(frame: CGRectZero)
    
    var forecastData : [WeatherForecast] = []

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        forecastData = WeatherForecast.MR_findAllSortedBy("date", ascending: true) as! [WeatherForecast]
        
        view.backgroundColor = UIColor.whiteColor()
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.textAlignment = .Right
        monthLabel.text = "October"
        monthLabel.font = UIFont.systemFontOfSize(18)
        
        collectionLayout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        let width = (UIScreen.mainScreen().bounds.size.width - 30)/3
        collectionLayout.itemSize = CGSize(width: width, height: width)
        collectionLayout.minimumInteritemSpacing = 5
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLayout)
        collectionView.collectionViewLayout = collectionLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = false
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(WACollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.view.addSubview(monthLabel)
        self.view.addSubview(collectionView)

        
        view +| monthLabel.attribute(.Leading) == view.attribute(.Leading)
        view +| monthLabel.attribute(.Trailing) == view.attribute(.Trailing) - 10
        view +| monthLabel.attribute(.Top) == view.attribute(.Top) + 40
        view +| monthLabel.attribute(.Height) == 25
        
        view +| collectionView.attribute(.Leading) == view.attribute(.Leading)
        view +| collectionView.attribute(.Trailing) == view.attribute(.Trailing)
        view +| collectionView.attribute(.Top) == monthLabel.attribute(.Bottom) + 20
        view +| collectionView.attribute(.Bottom) == view.attribute(.Bottom)
        
        getData()
        if forecastData.count > 0
        {
            monthLabel.text = forecastData[0].month
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return forecastData.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! WACollectionViewCell
        
        cell.forecast = forecastData[indexPath.row]
    
        // Configure the cell
    
        return cell
    }
    
    func getData()
    {
        
        let sessionManager = AFHTTPSessionManager(baseURL: NSURL(string: "http://www.focalloid.com/bunker/"))
        let responseSerializer = AFJSONResponseSerializer(readingOptions: .AllowFragments)
        responseSerializer.acceptableContentTypes = NSSet(array: ["multipart/form-data","text/plain","text/html","application/json"]) as? Set<String>
        sessionManager.responseSerializer = responseSerializer
        
        SVProgressHUD.showWithMaskType(.Gradient)
        
        let paramters = ["q":"bangalore","format":"json","num_of_days":"5","key":"329c87ezzdxyx73v8wahx9cm"]
        sessionManager.GET("http://api.worldweatheronline.com/free/v1/weather.ashx?", parameters: paramters, progress: nil, success:
            { (dataTask, result) -> Void in
            
                SVProgressHUD.dismiss()
                
                WeatherForecast.MR_truncateAll()
                
                if let data = (result as! [String:AnyObject])["data"] as? [String:AnyObject]
                {
                    if let weatherArray = data["weather"] as? [Dictionary<String,AnyObject>]
                    {
                        for weatherDict in weatherArray
                        {
                            WeatherForecast.updateWithDictionary(weatherDict)
                        }
                    }
                }
                
                self.forecastData = WeatherForecast.MR_findAllSortedBy("date", ascending: true) as! [WeatherForecast]
                if self.forecastData.count > 0
                {
                    self.monthLabel.text = self.forecastData[0].month
                }
                

                self.collectionView.reloadData()
                
                
            })
            { (dataTask, error) -> Void in
            
                SVProgressHUD.showErrorWithStatus(error.localizedDescription)
            }
        

        
    }



}
