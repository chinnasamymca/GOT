//
//  APiWorker.swift
//  GOT
//
//  Created by Chinnasamy ChinnaRaj on 06/05/18.
//  Copyright © 2018 Chinnasamy ChinnaRaj. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum APIResponse {
    case Success(data: JSON)
    case Failiur(errorCode: Int)
}

class APiWorker {
    
    func fetchJSONDatafromServer(completion: @escaping (APIResponse) -> (Void)) {
       
        let jsonUrlString = "http://starlord.hackerearth.com/gotjson"
        let jsonUrl = URL(string: jsonUrlString)
        
        let urlRequest: URLRequest?
        do {
           urlRequest = try URLRequest(url: jsonUrl!, method: .get)
        }
        catch {
           print("Something wrong with URL, Please recheck")
            return
        }
        
        guard urlRequest != nil else {
            print("URL is empty, Please recheck")
            return
        }
        
        Alamofire.SessionManager.default.request(urlRequest!).responseJSON { (data) in
            print(data)
            do {
                let jsonData =  try JSON(data: data.data!)
                completion(APIResponse.Success(data: jsonData))
            }
            catch {
                print("Error processing JSON: \(error.localizedDescription)")
                completion(APIResponse.Failiur(errorCode: 404))
            }
            
        }
    }
}
