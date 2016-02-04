//
//  extras.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 02/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import Foundation
import UIKit


class SentRequest {

    private var CurAction: String!
    let globalUrl: String = "http://192.168.15.201/nailsalon/app/"
    
    private var PostData = [DataPost]()
    var result: Int = 0
    
    
    init(curaction: String) {
        self.CurAction = curaction;
    }
    
    func AddPosData(newdata: DataPost){
        PostData.append(newdata)
    }
    
    func ObtenData(){
        let datos = GetData()
        datos.setURL(self.globalUrl + self.CurAction )
        
        var posdata: String = ""
        var firtdata:Bool = true
        
        for dato: DataPost in PostData{
            
            if (!firtdata){
            posdata.appendContentsOf("&")
            }
          
            posdata.appendContentsOf(dato.item!)
            posdata.appendContentsOf("=")
            posdata.appendContentsOf(dato.value!)
            firtdata = false
            
        }
        
            print(posdata)
        
        datos.setPostData(posdata)
        datos.ObtenData()

        let curtime = NSDate()
        var passedTime: Double = 0
        
        while (datos.isDataReady == false && passedTime < 10000.0 && datos.resulterror == 0 ){
            passedTime = curtime.timeIntervalSinceNow * -1000.0
        }

        self.result = datos.resulterror
        
        
    }
    
    
}
