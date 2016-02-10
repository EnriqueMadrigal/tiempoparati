//
//  ViewController.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 28/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var Dialogo = Dialogs()
    var physicalx :Int = 0
    var physicaly :Int = 0
    
    var deviceType :String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame1: CGRect = UIScreen.mainScreen().bounds

        let backgroundImage = UIImageView(frame: frame1)
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        let UUIDValue = UIDevice.currentDevice().identifierForVendor!.UUIDString
        dataAccess.sharedInstance.UIID = UUIDValue
        print("UUID: \(UUIDValue)")
        let curPersona = ObtenPersona()
        
        if let newPerson: Persona = curPersona.GetPerson()
        {
        dataAccess.sharedInstance.curPersona = newPerson
            
        }
        else {
            let newPerson: Persona = Persona(newName: "", newemail: "", newsexo: 0)
            dataAccess.sharedInstance.curPersona = newPerson
        }
        
calculateVars()
        print(dataAccess.sharedInstance.curScreen.width)
        print(dataAccess.sharedInstance.curScreen.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print(segue.identifier)
        
        Dialogo.setPos(view.frame.midX - 90, view.frame.midY - 25)
        view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        view.alpha=0.5
        let messageDialog: UIView = Dialogo.showWaitDialog("Un momento")
        view.addSubview(messageDialog)
        
        
        
    }

   
    
    //////
    func calculateVars()
    {
    
    if (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
    {
    self.deviceType = "Ipad"
    }
    
    
    if (UIDevice.currentDevice().userInterfaceIdiom == .Phone)
    {
    self.deviceType = "Iphone"
    }
    
    
    if (self.deviceType == "Iphone")
    {
    
    
    if (ScreenSize.SCREEN_HEIGHT == 320 && ScreenSize.SCREEN_WIDTH == 480)
    {
    // Iphone 4
    self.physicalx = 960
    self.physicaly = 640
    }
    
    
    
    if (ScreenSize.SCREEN_HEIGHT == 320 && ScreenSize.SCREEN_WIDTH == 568)
    {
    // Iphone 5
    self.physicalx = 1136
    self.physicaly = 640
    }
    
    if (ScreenSize.SCREEN_HEIGHT == 375 && ScreenSize.SCREEN_WIDTH == 667)
    {
    // Iphone 6
    self.physicalx = 1134
    self.physicaly = 750
    }
    
    
    if (ScreenSize.SCREEN_HEIGHT == 414 && ScreenSize.SCREEN_WIDTH == 763)
    {
    // Iphone 6
    self.physicalx = 1920
    self.physicaly = 1080
    }
    
    
    }
    
    
    if (self.deviceType == "Ipad")
    {
    
    if (ScreenSize.scale == 1.0)
    {
    // Ipad, Ipad2 , Ipad mini
    
    self.physicalx = 1024
    self.physicaly = 768
    }
    
    if (ScreenSize.scale == 2.0)
    {
    // Ipad Air, Ipad Mini Retina
    
    self.physicalx = 2048
    self.physicaly = 1536
    }
    
    
    
    
    }
    
        
    dataAccess.sharedInstance.curScreen = ScreenBounds(newWidth: self.physicalx, newHeight: self.physicaly, typeDevice: self.deviceType)
    ////
    
        //// Multiplier
        
        if (self.deviceType == "Ipad"){
            dataAccess.sharedInstance.multiplier = 2.0
            
        }
        

        
        
        
    }
    

}

