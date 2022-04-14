//
//  APIResult.swift
//  My Weather App
//
//  Created by Youssef Bhl on 11/02/2022.
//

import Foundation

struct APIResult: Decodable {
    var list: [WeatherInfo]
}

struct WeatherInfo: Decodable {
    var dt : Float
    var main : main
    var weather : [weather]
    var wind: wind
    var dt_txt: String
}

struct main: Decodable {
    var temp : Float
    var temp_min : Float
    var temp_max : Float
    var humidity : Float
}

struct weather: Decodable {
    var main : String
    var description: String
    var icon : String
}

struct wind: Decodable {
    var speed: Float
}
