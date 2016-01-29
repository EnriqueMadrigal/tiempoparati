//
//  getimage.swift
//  estudiosalon
//
//  Created by Enrique Madrigal Gutierrez on 18/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import Foundation
import UIKit


class GetImage{
    

    
    init() {
        // perform some initialization here
        // startConnection()
    }
    
    var curimage: UIImage?
    
    var isDataReady: Bool = false
    var resulterror: Int = 0
    var cururl: String!
    var postdata: NSString!
    
    func ObtenData()  {
       
        self.isDataReady = false
        self.resulterror = 0
        
        //let post: NSString = "idestetica=1&width=240&height=240"
        let post: NSString = self.postdata
        //let url = NSURL(string: "http://192.168.15.201/nailsalon/app/getimagesalon.php")!
        let url = NSURL(string: self.cururl)
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
                        let data =  NSData(data: receivedData)
                        self.curimage =  UIImage(data: data)
                        
                        //On success, invoke `completion` with passing jsonData.
                        //completion(jsonData: jsonData, error: nil)
                        
                        //print(jsonData)
                        //let ciudad: String = jsonData.dictionaryWithValuesForKeys(["ciudad"])
                        //let item = jsonData[0]
                        //let ciudad = item["ciudad"]!
                        //print(ciudad)
                        
                        self.isDataReady = true;
                        self.resulterror = 0
                        //print(self.datos)
                }
                else {
                    let returnedError = NSError(domain: "findBeerAsync", code: 1, userInfo: [
                        "title": "Busca falhou!",
                        "message": "Falha de conexão!"
                        ])
                    //On error, invoke `completion` with NSError.
                    //completion(jsonData: nil, error: returnedError)
                    self.resulterror = 1
                    print(returnedError)
                }
            }
            else
            {
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
    
    func GetcurImage() -> UIImage{
        return self.curimage!
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

