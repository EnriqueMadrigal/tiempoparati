//
//  CustomButton1.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 14/03/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class CustomButton2: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var textsize: CGFloat = 12.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func layoutSubviews() {
     super.layoutSubviews()
        let multiplier = dataAccess.sharedInstance.multiplier
        
        let buttomFrame = self.frame
        let buttonHeight = buttomFrame.height - self.textsize * multiplier
        let buttonWidth = buttonHeight
        
        let totalWidth = buttomFrame.width
        let middlepos = totalWidth / 2
        let middleimage = buttonWidth / 2
        let middletext = (self.titleLabel?.frame.width)! / 2
        
        var textFrame = self.titleLabel?.frame
        
        self.imageView?.frame = CGRectMake(middlepos - middleimage, 0, buttonWidth, buttonHeight)
        
        textFrame?.origin.x = middlepos - middletext
        textFrame?.origin.y = buttonHeight
        
        textFrame?.origin.x = 0
        textFrame?.origin.y = 0
        
        
        //self.titleLabel?.frame = textFrame!
        
        //self.titleLabel?.frame = CGRectMake(0, buttonHeight, (self.titleLabel?.frame.width)!, (self.titleLabel?.frame.height)!)
        self.titleLabel?.frame = CGRectMake(10, buttonHeight, totalWidth, self.textsize * multiplier )
        
        
        self.layer.cornerRadius = 0.1 * buttomFrame.size.width
        
        self.titleLabel?.font = UIFont(name: "Arial", size: 12 * multiplier)
    }
    

}
