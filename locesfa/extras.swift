//
//  extras.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 02/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import Foundation
import UIKit


func SetBackGroundImage (curController: UIViewController)
{
    
    let menModel = UIImage(named: "background3")
    let womanModel = UIImage(named: "background1")
    let menBack = UIImage(named: "background4")
    let womanBack = UIImage(named: "background1")
    
    var curImage: UIImage!
    var curBack: UIImage!
    
    let sexo = dataAccess.sharedInstance.curPersona.sexo
   
    curImage = womanModel
    curBack = womanBack
    
    if (sexo==1){
        curImage = menModel
        curBack = menBack
    }
        
   
    
    
    var frame1: CGRect = UIScreen.mainScreen().bounds
    curController.view.backgroundColor = UIColor(patternImage: curBack!)
    
    if let curNavigationController = curController.navigationController{
        
        let navControllerheight: CGFloat = curNavigationController.navigationBar.bounds.height
     frame1 = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
   
    }
    
    let backgroundImage = UIImageView(frame: frame1)
    
    backgroundImage.image = curImage
    backgroundImage.tag = 100
    
    if let viewWithTag = curController.view.viewWithTag(100) {
        viewWithTag.removeFromSuperview()
    }
    
    curController.view.insertSubview(backgroundImage, atIndex: 0)
    
    
    
}

class SentRequest {

    private var CurAction: String!
    let globalUrl: String = dataAccess.sharedInstance.curUrl
    var posData: String!
    
    private var PostData = [DataPost]()
    var result: Int = 0
     var datos: NSArray = []
    
    init(curaction: String) {
        self.CurAction = curaction;
    }
    
    func AddPosData(newdata: DataPost){
        PostData.append(newdata)
    }
    
    func setPostData(newDataPost: String){
        self.posData = newDataPost
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
        
        if (posdata.characters.count==0){
            posdata = self.posData
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
        self.datos = datos.GetJson()
        
    }
    
    
    func GetJson() ->NSArray{
        return self.datos
    }

    
    
}



class SentRequest_image {
    
    private var CurAction: String!
    let globalUrl: String = dataAccess.sharedInstance.curUrl
    
    
    private var PostData = [DataPost]()
    var result: Int = 0
   var curimage: UIImage?
    
    init(curaction: String) {
        self.CurAction = curaction;
    }
    
    func AddPosData(newdata: DataPost){
        PostData.append(newdata)
    }
    
    func ObtenData(){
        let datos = GetImage()
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
        
        //print(posdata)
        
        datos.setPostData(posdata)
        datos.ObtenData()
        
        let curtime = NSDate()
        var passedTime: Double = 0
        
        while (datos.isDataReady == false && passedTime < 10000.0 && datos.resulterror == 0 ){
            passedTime = curtime.timeIntervalSinceNow * -1000.0
        }
        
        print(datos.resulterror)
        self.result = datos.resulterror
        self.curimage = datos.GetcurImage()
        
    }
    
    
    func GetJson() ->UIImage{
        return self.curimage!
    }
    
    
    
}

