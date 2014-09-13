////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

import Foundation

public class CityDaoUserDefaultsImpl : NSObject, PFCityDao {
    
    var defaults : NSUserDefaults
    let citiesListKey = "pfWeather.cities"
    let currentCityKey = "pfWeather.currentCityKey"
    
    
    init(defaults : NSUserDefaults) {
        self.defaults = defaults
    }
    
    public func listAllCities() -> [AnyObject]! {
        
        var cities : NSArray? = self.defaults.arrayForKey(self.citiesListKey)
        if (cities == nil) {
            cities = [
                "Manila",
                "Madrid",
                "San Francisco",
                "Phnom Penh",
                "Omsk"
            ]
            self.defaults.setObject(cities, forKey:self.citiesListKey)
        }
        return cities!.sortedArrayUsingSelector("caseInsensitiveCompare:")
    }
    
    public func saveCity(name: String!) {

        let trimmedName = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        var cities = NSMutableArray(array: self.defaults.arrayForKey(self.citiesListKey)!)
        var canAddCity = true
        for city in cities {
            if (city.lowercaseString == trimmedName.lowercaseString) {
                canAddCity = false
            }
        }
        if (canAddCity) {
            cities.addObject(trimmedName)
            self.defaults.setObject(cities, forKey: self.citiesListKey)
        }
    }
    
    public func deleteCity(name: String!) {
        
        let trimmedName = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        var cities = NSMutableArray(array: self.defaults.arrayForKey(self.citiesListKey)!)
        var cityToRemove : String?
        for city in cities {
            if (city.lowercaseString == trimmedName.lowercaseString) {
                cityToRemove = city as? String
            }
        }
        if (cityToRemove != nil)
        {
            cities.removeObject(cityToRemove!)
        }

        self.defaults.setObject(cities, forKey: self.citiesListKey)
    }
    
    public func saveCurrentlySelectedCity(cityName: String!) {
        
        let trimmed = cityName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (!trimmed.isEmpty) {
            self.defaults.setObject(trimmed, forKey: self.currentCityKey)
        }
    }
    
    
    public func clearCurrentlySelectedCity() {
        
        self.defaults.setObject(nil, forKey: self.currentCityKey)
        
    }
    
    public func loadSelectedCity() -> String? {
        return self.defaults.objectForKey(self.currentCityKey) as? String
    }

//    
//    
//    - (NSString*)loadSelectedCity
//    {
//    return [_defaults objectForKey:pfCurrentCityKey];
//    }

    
}