//
//  WACollectionViewCell.swift
//  WeatherApp
//
//  Created by Mohammed Shinoys  on 2/2/16.
//  Copyright © 2016 Kalypso. All rights reserved.
//

import UIKit
import SwiftLayoutKit

class WACollectionViewCell: UICollectionViewCell
{
    
    var dateLabel = UILabel(frame: CGRectZero)
    var temperatureLabel = UILabel(frame: CGRectZero)
    var forecastImageView = UIImageView(frame: CGRectZero)
    
    var forecast : WeatherForecast?
    {
        didSet
        {
            dateLabel.text = forecast?.day
            temperatureLabel.text = forecast?.temperature
            if let imageName = forecast?.forecast
            {
                forecastImageView.image = UIImage(named: imageName)
                print("imagename : \(imageName)")

            }
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "10"
        dateLabel.textAlignment = .Left
        dateLabel.font = UIFont.systemFontOfSize(22)
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.textAlignment = .Right
        temperatureLabel.text = "24"
        temperatureLabel.font = UIFont.systemFontOfSize(18)
        
        
        forecastImageView.translatesAutoresizingMaskIntoConstraints = false
        forecastImageView.contentMode = .ScaleAspectFit
        
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(forecastImageView)
        
        
        contentView +| dateLabel.attribute(.Height) == 40
        contentView +| dateLabel.attribute(.Width) == 40
        contentView +| dateLabel.attribute(.Leading) == contentView.attribute(.Leading) + 5
        contentView +| dateLabel.attribute(.Bottom) == contentView.attribute(.Bottom)
        
        contentView +| temperatureLabel.attribute(.Height) == 40
        contentView +| temperatureLabel.attribute(.Width) == 40
        contentView +| temperatureLabel.attribute(.Trailing) == contentView.attribute(.Trailing) - 5
        contentView +| temperatureLabel.attribute(.Top) == contentView.attribute(.Top) 
        
        contentView +| forecastImageView.attribute(.Height) == 40
        contentView +| forecastImageView.attribute(.Width) == 40
        contentView +| forecastImageView.attribute(.Trailing) == contentView.attribute(.Trailing) - 5
        contentView +| forecastImageView.attribute(.Bottom) == contentView.attribute(.Bottom) - 5
        

        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        
        super.init(coder: aDecoder)
        
    }
    
}
