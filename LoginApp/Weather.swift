//
//  Weather.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 03/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeatherData: Mappable {
    var data: [ZoneWeather]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        data <- map["data"]
    }
}

struct ZoneWeather: Mappable {
    
    var city: String!
    var contryCode: String!
    var weather: Weather!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        city <- map["city_name"]
        contryCode <- map["country_code"]
        weather <- map["weather"]
    }
}

struct Weather: Mappable {
    var description: String!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        description <- map["description"]
    }
}
