//
//  CustomButton1.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 14/03/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class CustomButton1: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func layoutSubviews() {
     super.layoutSubviews()
        
        let buttomFrame = self.frame
        let buttonHeight = buttomFrame.height
        let buttonWidth = buttonHeight
        
        let totalWidth = buttomFrame.width
        
        self.imageView?.frame = CGRectMake(5, 0, buttonWidth, buttonHeight)
        
        self.titleLabel?.frame = CGRectMake(buttonWidth + 10, 0, totalWidth - buttonWidth, buttonHeight)
        
        self.layer.cornerRadius = 0.1 * buttomFrame.size.width
        
        self.titleLabel?.font = UIFont(name: "Arial", size: 18 * dataAccess.sharedInstance.multiplier)
    }
    

}
