//
//  ViewController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 28/10/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url: URL = URL(string: "https://rapidapi.p.rapidapi.com/current") else {
            errorAppeared()
            return
        }
        
        let headers = [
            "x-rapidapi-key": "ae6e46d234mshe1c4c4a265082dep116db9jsna16eae645ee6",
            "x-rapidapi-host": "weatherbit-v1-mashape.p.rapidapi.com"
        ]
        
        let params = [
            "lat" : "19.3934164",
            "lon" : "-99.1616135"
        ]
        
        getWeatherAlamofireWith(url, headers: headers, params: params)
    }
    
    private func getWeatherAlamofireWith(_ url: URL, headers: [String:String], params: [String:String]) {
        AF.request(url,
                   parameters: params,
                   headers: HTTPHeaders(headers)).responseJSON { (response) in
            print(response)
        }
    }
    
    private func getWeatherURLSessionWith(_ url: URL, headers: [String: String], params: [String:String]) {
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        }
        
        dataTask.resume()
    }

    private func errorAppeared() {
        // manage error
        print("URL invalida")
    }

}

