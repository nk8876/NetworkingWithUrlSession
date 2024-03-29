//
//  HttpClientApi.swift
//  NetworkingWithUrlSession
//
//  Created by Dheeraj Arora on 16/12/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation

//HTTP Methods
enum HttpMethod : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}


class HttpClientApi: NSObject{
    
    var request : URLRequest?
    var session : URLSession?
    
    static func instance() ->  HttpClientApi{
        return HttpClientApi()
}
    func makeAPICall(url: String,params: Dictionary<String, Any>?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
        
       
        request = URLRequest(url: URL(string: url)!)
        print("URL = \(url)")
        if let params = params {
            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.httpBody = jsonData //?.base64EncodedData()
            
        }
        request?.httpMethod = method.rawValue
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        session = URLSession(configuration: configuration)
        //session?.configuration.timeoutIntervalForResource = 5
        //session?.configuration.timeoutIntervalForRequest = 5
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data , response , error as NSError?)
                } else {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            }else {
                
                failure(data , response as? HTTPURLResponse, error as NSError?)
                
            }
        }.resume()
        
    }
    
}
