//
//  customTableView4.swift
//  studioSalon
//
//  Created by Enrique Madrigal Gutierrez on 19/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class customTableView4: UITableViewCell {
    
    let campo0 = UILabel()
    let campo1 = UILabel()
    //let image1 = UIImageView()
    var id: Int?
    let separator = UIView()
    
    ///// default 1X
    
    var multiplier: CGFloat = 1.0
   
    var campo0_width:CGFloat = 240
    var campo0_height: CGFloat = 14
    var campo0_fontsize: CGFloat = 14
    
    var campo1_width:CGFloat = 240
    var campo1_height: CGFloat = 12
    var campo1_fontsize: CGFloat = 12
    
    var image1_width:CGFloat = 42
    var image1_height: CGFloat = 42
    
    var rating_widht: CGFloat = 16
    var rating_height: CGFloat = 16
    
    ///
    var tableView_Width: CGFloat = 0
    
    let notavil = UIImage(named: "notavail")!
    var rating: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingImages = [UIImageView]()
    var spacing: CGFloat = 5.0
    var stars = 5
    
    
    let filledStarImage = UIImage(named: "star2")
    let emptyStarImage = UIImage(named: "star1")
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        GetMultiplier()
        
        //self.image1.image = self.notavil
        //contentView.addSubview(self.image1)
        
        
        self.campo0.translatesAutoresizingMaskIntoConstraints = false
        self.campo0.text = ""
        self.campo0.font = UIFont(name: "System Font", size: self.campo0_fontsize)
        
        //self.campo0.frame = CGRect(x: 32, y: 0, width: 240, height: 16)
        contentView.addSubview(self.campo0)

        self.separator.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        contentView.addSubview(self.separator)

        
        for _ in 0..<5 {
            let image = UIImageView()
            image.image = self.emptyStarImage
            
            addSubview(image)
            ratingImages.append(image)
        }
        
        self.campo1.translatesAutoresizingMaskIntoConstraints = false
        self.campo1.text = ""
        self.campo1.font = UIFont(name: "System Font", size: self.campo1_fontsize)
        self.campo1.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        //self.campo1.frame = CGRect(x: 32, y: 0, width: 240, height: 16)
        contentView.addSubview(self.campo1)
        contentView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0)
        
        
        /*
        let viewsDict = [
        
        
        "image" : imgUser,
        "username" : labUerName,
        "message" : labMessage,
        "labTime" : labTime,
        ]
        */
        
        layoutSubviews()
        
    
    
    
    }
    
    
    override func layoutSubviews() {
        
        self.campo0.frame = CGRect(x: 0, y: 0.0, width: self.campo0_width, height: self.campo0_height)
        self.campo1.frame = CGRect(x: 0, y: self.campo0_height + self.rating_height, width: self.campo1_width, height: self.campo1_height)
        //self.image1.frame = CGRect(x: 0.0, y: 0.0, width: self.image1_width, height: self.image1_height)
        
        
        //self.campo0.frame = CGRect(x: 42, y: 0, width: 240, height: 14)
        //self.campo1.frame = CGRect(x: 42, y: 32, width: 240, height: 12)
        //self.image1.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        
        
        /*
        for (index, image) in ratingImages.enumerate() {
            
            let imagesize = (index * (16 + spacing) )
            let imageframe = CGRect(x: 42 + imagesize, y: 14, width: 16, height: 16)
            image.frame = imageframe
        }
        */
        
        for (index, image) in ratingImages.enumerate() {
            
            let imagesize = (CGFloat(index) * (self.rating_widht + spacing) )
            let imageframe = CGRect(x: imagesize, y: self.campo0_height, width: self.rating_widht, height: self.rating_height)
            image.frame = imageframe
        }
        
        
         self.separator.frame = CGRect(x: 0.0, y: self.image1_height - 1, width: self.image1_width + self.campo1_width, height: 1)
        
        updateImageSelectionStates()
        
        
    }
    
    
    func updateImageSelectionStates() {
        for (index, image) in ratingImages.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            if index < self.rating {
                image.image = self.filledStarImage
            }
            
            
        }
    }
    
    func GetMultiplier(){
        
        let multiplier:CGFloat = dataAccess.sharedInstance.multiplier
       ////
        
        self.campo0_width = self.campo0_width * multiplier
        self.campo0_height = self.campo0_height * multiplier
        self.campo0_fontsize = self.campo0_fontsize * multiplier
        
        self.campo1_width = self.campo1_width * multiplier
        self.campo1_height = self.campo1_height * multiplier
        self.campo1_fontsize = self.campo1_fontsize * multiplier
        
        self.image1_width = self.image1_width * multiplier
        self.image1_height = self.image1_height * multiplier
        
        self.rating_widht = self.rating_widht * multiplier
        self.rating_height = self.rating_height * multiplier

        ////
        
        
    }
    func setWidth(newWidth: CGFloat)
    {
        self.tableView_Width = newWidth
        self.campo0_width = newWidth - self.image1_width
        self.campo1_width = newWidth - self.image1_width
         layoutSubviews()
    }

    
    
}
