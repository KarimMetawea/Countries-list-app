//
//  CountriesService.swift
//  Countries List App
//
//  Created by karim metawea on 5/26/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CountriesService {
    
    
    static func getCountries(completion: @escaping(Bool,Error?)->()) {
        
        let urlStr = "https://restcountries.eu/rest/v1/all"
        Alamofire.request(urlStr).responseData { (data) in
            do {
                guard let data = data.data else { return }
                let res  = try JSONDecoder().decode([Country].self,from:data)
                print("success")
                DispatchQueue.main.async {
                DataModel.countries = res
                completion(true,nil)
                }

            }
            catch {
                print(error)
                completion(false,error)
            }
        }
    }
    
}
