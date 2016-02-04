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
        let curPersona = ObtenPesona()
        
        if let newPerson: Persona = curPersona.GetPerson()
        {
        dataAccess.sharedInstance.curPersona = newPerson
            
        }
        else {
            let newPerson: Persona = Persona(newName: "", newemail: "", newsexo: 0)
            dataAccess.sharedInstance.curPersona = newPerson
        }
        

        
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

    

}

