//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Mohammed Shinoys  on 2/2/16.
//  Copyright © 2016 Kalypso. All rights reserved.
//

import Foundation
import CoreData

class WeatherForecast: NSManagedObject
{

    class func updateWithDictionary(dict:[String:AnyObject])
    {
        let forecastObject = WeatherForecast.MR_createEntity()
        
        if let dateString = dict["date"] as? String
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.dateFromString(dateString)
            {
                forecastObject?.date = date
                dateFormatter.dateFormat = "yyyy MMMM dd"
                let newDateString = dateFormatter.stringFromDate(date)
                
                let components = newDateString.componentsSeparatedByString(" ")
                if components.count == 3
                {
                    forecastObject?.month = components[1]
                    forecastObject?.day = components[2]
                }
                
                print("newdateString : \(newDateString)")

            }
    
        }
        
        if let weatherDesc = dict["weatherDesc"] as? [Dictionary<String,AnyObject>] where weatherDesc.count>0
        {
             forecastObject!.forecast = weatherDesc[0]["value"] as? String
        }
        
        if let minimumTemp = dict["tempMinC"] as? String
        {
            forecastObject!.temperature = "\(minimumTemp)°"
        }
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion { (success, error) -> Void in
            
            if (success)
            {
            } else if ((error) != nil) {
                print("Error saving context: %@", error!.description);
            }
            
        }
        

        
    }
    
// Insert code here to add functionality to your managed object subclass

}
