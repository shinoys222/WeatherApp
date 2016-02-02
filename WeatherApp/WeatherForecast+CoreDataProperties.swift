//
//  WeatherForecast+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Mohammed Shinoys  on 2/2/16.
//  Copyright © 2016 Kalypso. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WeatherForecast
{

    @NSManaged var date: NSDate?
    @NSManaged var forecast: String?
    @NSManaged var temperature: String?
    @NSManaged var month: String?
    @NSManaged var day: String?

}
