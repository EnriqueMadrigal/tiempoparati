//
//  messages.swift
//  estudiosalon
//
//  Created by Enrique Madrigal Gutierrez on 12/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import Foundation
import UIKit

class Dialogs
{
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    var thisview = UIView()
    var posx: CGFloat = 0
    var posy: CGFloat = 0

    init()
    {
        // perform some initialization here
        // startConnection()
        
       //self.thisview.frame.midX - 90
        //self.thisview.frame.midY - 25 
            }

    
    func progressBarDisplayer(msg:String, _ indicator:Bool )  {
        print(msg)
        self.strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        self.strLabel.text = msg
        self.strLabel.textColor = UIColor.whiteColor()
        self.messageFrame = UIView(frame: CGRect(x: posx, y: posy, width: 180, height: 50))
        self.messageFrame.layer.cornerRadius = 15
        self.messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            self.activityIndicator.startAnimating()
            self.messageFrame.addSubview(activityIndicator)
        }
        self.messageFrame.addSubview(strLabel)
        
        //self.thisview.addSubview(messageFrame)
    }
    
    func setPos (currentposx: CGFloat, _ currentposy: CGFloat){
        self.posx = currentposx
        self.posy = currentposy
    }

    func showWaitDialog(msg: String) ->UIView{
    progressBarDisplayer(msg, true)
        return self.messageFrame
    }
    
    func closeWaitDialog(){
     self.messageFrame.removeFromSuperview()
        
    }
    
}

