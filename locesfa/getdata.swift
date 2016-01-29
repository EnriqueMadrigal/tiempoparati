//
//  getdata.swift
//  estudiosalon
//
//  Created by Enrique Madrigal Gutierrez on 10/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import Foundation


class GetData {

    init() {
        // perform some initialization here
        // startConnection()
    }
   
    var datos: NSArray = []
    var isDataReady: Bool = false
    var resulterror: Int = 0
    var cururl: String!
    var postdata: NSString!

    
    func ObtenData()  {
        var jsonData: NSArray = []
        self.isDataReady = false
        self.resulterror = 0
        
        //let post: NSString = "data=1"
        let post: NSString = self.postdata
        let url = NSURL(string: self.cururl)
        
        //let url = NSURL(string: "http://192.168.15.201/nailsalon/app/getsalons.php")!
        //print(url)
        
        let postData = post.dataUsingEncoding(NSUTF8StringEncoding)!
        //print(postData)
        
        let postLength = String(postData.length)
        //print(postLength)
        //Setting up `request` is similar to using NSURLConnection
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.timeoutInterval = 30
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {urlData, response, reponseError in
            
           
            
            if let receivedData = urlData {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if 200..<300 ~= res.statusCode {
                    do {
                        jsonData = try NSJSONSerialization.JSONObjectWithData(receivedData, options: []) as! NSArray
                        //On success, invoke `completion` with passing jsonData.
                        //completion(jsonData: jsonData, error: nil)
                        
                        //print(jsonData)
                        //let ciudad: String = jsonData.dictionaryWithValuesForKeys(["ciudad"])
                        //let item = jsonData[0]
                        //let ciudad = item["ciudad"]!
                        //print(ciudad)
                        self.datos = jsonData
                        self.isDataReady = true;
                        self.resulterror = 0
                        //print(self.datos)

                    } catch let error as NSError {
                        let returnedError = NSError(domain: "findBeerAsync", code: 3, userInfo: [
                            "title": "Busca falhou!",
                            "message": "Dados inválidos!",
                            "cause": error
                            ])
                        //On error, invoke `completion` with NSError.
                        //completion(jsonData: nil, error: returnedError)
                        self.resulterror=1
                        print(returnedError)
                    }
                } else {
                    let returnedError = NSError(domain: "findBeerAsync", code: 1, userInfo: [
                        "title": "Busca falhou!",
                        "message": "Falha de conexão!"
                        ])
                    //On error, invoke `completion` with NSError.
                    //completion(jsonData: nil, error: returnedError)
                    self.resulterror = 1
                print(returnedError)
                }
            } else {
                var userInfo: [NSObject: AnyObject] = [
                    "title": "Busca falhou!",
                    "message": "Conexão falhou"
                ]
                if let error = reponseError {
                    userInfo["message"] = error.localizedDescription
                    userInfo["cause"] = error
                }
                let returnedError = NSError(domain: "findBeerAsync", code: 2, userInfo: userInfo)
                //On error, invoke `completion` with NSError.
                //completion(jsonData: nil, error: returnedError)
                self.resulterror = 1
            print(returnedError)
            }
        }
        task.resume()
        //You should not write any code after `task.resu
        
       
        //return self.datos
    }
    
    func IsDataReady() ->Bool{
        return self.isDataReady
    }
    
    func GetJson() ->NSArray{
        return self.datos
    }
    
    func setURL(newurl: String)
    {
        self.cururl = newurl
    }
    
    func setPostData(newpostdata: NSString)
    {
        self.postdata = newpostdata
    }

    ////////
    
    
    
    //////
    
    
    
    
   }




    
    
    
    
    



