//
//  ViewController.swift
//  NetworkingWithUrlSession
//
//  Created by Dheeraj Arora on 16/12/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    var userArray: [User] = []
    var model = [UserInfo]() //Initialising Model Array
    var street = ""
    var city = ""
    var zipCode = ""
    var comapnyName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        getRequestData()
    }

    func getRequestData() {
        let url = Get_Url
        HttpClientApi.instance().makeAPICall(url: url, params: nil, method: .GET, success: { (data, response, error) in
            if error == nil{
                guard let data = data else{ return }
                //print(data)
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                    data, options: [])
                    //Response result
                    //print(jsonResponse)
                   
                    guard let jsonArray = jsonResponse as? [[String: Any]] else {
                        return
                    }
                    //print(jsonArray)
                    
                    for dic in jsonArray {
                        
                        let address = dic["address"] as! [String : Any]
                        let company = dic["company"] as! [String : Any]
                        self.street = address["street"] as! String
                        self.city = address["city"] as! String
                        self.zipCode = address["zipcode"] as! String
                        self.comapnyName = company["name"] as! String
                        print(address)
                        // adding now value in Model array
                        self.model.append(UserInfo(dictionary: dic))
                         DispatchQueue.main.async {
                             self.myTableView.reloadData()
                                  }

                    }
                   
//
//                  self.userArray = try JSONDecoder().decode([User].self, from: data)
//                    for mainArr in self.userArray {
//                        print(mainArr)
//                        DispatchQueue.main.async {
//                             self.myTableView.reloadData()
//                        }
//                    }
                 
                }catch {
                    print(error.localizedDescription)
                }
                
            }else{
                print("Error connecting Network", error!.localizedDescription)

            }
        }, failure: { (data, responce, error) in
            print("error connecting network", error!.localizedDescription)
        })
    }
   
    @IBAction func postRequestAction(_ sender: UIBarButtonItem) {
        postRequest()
    }
    func postRequest()  {
        let paramsDictionary : [String : Any] = ["userId":"100","id":"12","title":"Hey There","body":"what are you doing this weekend"]

        let url = Post_Url
        HttpClientApi.instance().makeAPICall(url: url, params: paramsDictionary, method: .POST, success: { (data, responce, error) in
            guard let data = data else{
                if error ==  nil{
                    print(error?.localizedDescription ?? "Unknown Error")
                }
                return
            }
            
            if let responce = responce{
                guard (200  ... 299) ~= responce.statusCode else{
                    print("Status Code : \(responce.statusCode)")
                    print(responce)
                    return
                }
            }
            
            do{
                //let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                //print(jsonData)
                let jsonData1 =  try JSONDecoder().decode(Post.self, from: data)
                print(jsonData1)
            }catch {
                print(error.localizedDescription)
            }
        }, failure: { (data, responce, error) in
            print("error connecting network", error!.localizedDescription)
        })
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return userArray.count
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as! UserInfoTableViewCell
        
        //let obj = userArray[indexPath.row]
        let obj1 = model[indexPath.row]
        cell.lblName.text = "Name : " + obj1.name
        cell.lbluserName.text = "Username : " + obj1.username
        cell.lblEmail.text = "Email : " + obj1.email
        cell.lblPhone.text = "Phone : " + obj1.phone
        cell.lblAddress.text = "Address : \(street)"
        cell.lblZipCode.text = "Zip Code : \(zipCode)"
        cell.lblOrganizationName.text = "Company Name : \(comapnyName)"
        cell.lblWebsite.text = "Website : " + obj1.website
        cell.lblCity.text = "City : \(city)"
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
