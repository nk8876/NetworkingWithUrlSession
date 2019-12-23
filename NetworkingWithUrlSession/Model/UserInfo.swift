//
//  UserInfo.swift
//  NetworkingWithUrlSession
//
//  Created by Dheeraj Arora on 16/12/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation
struct User:Decodable {
    let company : Company
    let email : String
    let id : Int
    let name : String
    let phone : String
    let username : String
    let website : String
    let address : Address
    
    
}
struct Company:Decodable {
    let name:String
    let catchPhrase:String
    let bs:String
}

struct Address : Decodable {
    let street : String
    let suite : String
    let city : String
    let zipcode : String
    let geo : Geo
    
    
}
struct Geo : Decodable {
    let lat : String
    let lng : String
    
}

struct Post:Codable {
    let userId : String
    let id : Int
    let title : String
    let body : String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
}

struct UserInfo {
    
    var company : String
    var email : String
    var id : Int
    var name : String
    var phone : String
    var username : String
    var website : String
    var address : String
    
    init(dictionary: [String: Any]) {
//        guard let company = json["company"] as? String ,
//            let id = json["id"] as? Int,
//            let name = json["name"] as? String,
//            let email = json["email"] as? String,
//            let phone = json["phone"] as? String,
//            let username = json["username"] as? String,
//            let website = json["website"] as? String,
//            let address = json["website"] as? String else {
//                return nil
//        }
        self.company = dictionary["company"] as? String ?? ""
        self.id =  dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.email =  dictionary["email"] as? String ?? ""
        self.username =  dictionary["username"] as? String ?? ""
        self.phone =  dictionary["phone"] as? String ?? ""
        self.website =  dictionary["website"] as? String ?? ""
        self.address =  dictionary["address"] as? String ?? ""
    
    }
}
