//
//  Weather.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 03/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    var data: [ZoneWeather]?
}

struct ZoneWeather: Codable {
    
    let cityName: String
    let countryCode: String
    let weather: Weather
}

struct Weather: Codable {
    let description: String
}
