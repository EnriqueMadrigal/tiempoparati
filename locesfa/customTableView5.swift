//
//  customTableView5.swift
//  studioSalon
//
//  Created by Enrique Madrigal Gutierrez on 15/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class customTableView5: UITableViewCell {

    let campo0 = UILabel()
    let campo1 = UILabel()
    //let campo2 = UITextView()
    let campo2 = UILabel()
    let image1 = UIImageView()
    var id: Int?

    ///// default 1X
    
    var multiplier: CGFloat = 1.0
    
    var campo0_width:CGFloat = 240
    var campo0_height: CGFloat = 14
    var campo0_fontsize: CGFloat = 14
    
    var campo1_width:CGFloat = 240
    var campo1_height: CGFloat = 12
    var campo1_fontsize: CGFloat = 12
    
    var campo2_width:CGFloat = 240
    var campo2_height: CGFloat = 36
    var campo2_fontsize: CGFloat = 12
    
    var rating_widht: CGFloat = 16
    var rating_height: CGFloat = 16

    var image1_width:CGFloat = 42
    var image1_height: CGFloat = 42
    
    var tableView_Width: CGFloat = 0
    ///

    
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
        
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        GetMultiplier()
        // Initialization code
        self.image1.image = self.notavil
        contentView.addSubview(self.image1)
        
        
        self.campo0.translatesAutoresizingMaskIntoConstraints = false
        self.campo0.text = ""
        self.campo0.font = UIFont(name: "System Font", size: self.campo0_fontsize)
        contentView.addSubview(self.campo0)
        
        
        self.campo1.translatesAutoresizingMaskIntoConstraints = false
        self.campo1.text = ""
        self.campo1.font = UIFont(name: "System Font", size: self.campo1_fontsize)
        self.campo1.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        contentView.addSubview(self.campo1)
        
        self.campo2.translatesAutoresizingMaskIntoConstraints = false
        self.campo2.text = ""
        self.campo2.font = UIFont(name: "System Font", size: self.campo2_fontsize)
        self.campo2.numberOfLines = 0
        self.campo2.lineBreakMode = .ByWordWrapping
        self.campo2.backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(self.campo2)
        
        
        for _ in 0..<5 {
            let image = UIImageView()
            image.image = self.emptyStarImage
            
            addSubview(image)
            ratingImages.append(image)
        }

        
        layoutSubviews()

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override func layoutSubviews() {
        /*
        self.campo0.frame = CGRect(x: 48, y: 0, width: 240, height: 14)
        self.campo1.frame = CGRect(x: 48, y: 33, width: 240, height: 12)
        
        self.campo2.frame = CGRect(x: 0, y: 48, width: 248, height: 32)
        self.image1.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
      
        for (index, image) in ratingImages.enumerate() {
            
            let imagesize = (index * (16 + spacing) )
            let imageframe = CGRect(x: 48 + imagesize, y: 14, width: 16, height: 16)
            image.frame = imageframe
        }
        */
        self.campo0.frame = CGRect(x: self.image1_width, y: 0.0, width: self.campo0_width, height: self.campo0_height)
        self.campo1.frame = CGRect(x: self.image1_width, y: self.campo0_height + self.rating_height, width: self.campo1_width, height: self.campo1_height)
        self.campo2.frame = CGRect(x: 0.0, y: self.image1_height, width: self.campo2_width, height: self.campo2_height)
        
        
        self.image1.frame = CGRect(x: 0.0, y: 0.0, width: self.image1_width, height: self.image1_height)
        
        for (index, image) in ratingImages.enumerate() {
            
            let imagesize = (CGFloat(index) * (self.rating_widht + spacing) )
            let imageframe = CGRect(x: self.image1_width + imagesize, y: self.campo0_height, width: self.rating_widht, height: self.rating_height)
            image.frame = imageframe
        }

        
        
        
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
        
        
        self.campo0_width = self.campo0_width * multiplier
        self.campo0_height = self.campo0_height * multiplier
        self.campo0_fontsize = self.campo0_fontsize * multiplier
        
        self.campo1_width = self.campo1_width * multiplier
        self.campo1_height = self.campo1_height * multiplier
        self.campo1_fontsize = self.campo1_fontsize * multiplier
        
        self.campo2_width = self.campo2_width * multiplier
        self.campo2_height = self.campo2_height * multiplier
        self.campo2_fontsize = self.campo2_fontsize * multiplier
        
        self.rating_widht = self.rating_widht * multiplier
        self.rating_height = self.rating_height * multiplier
        
        self.image1_width = self.image1_width * multiplier
        self.image1_height = self.image1_height * multiplier
        
        
        ////
        
        
    }
  
    func setWidth(newWidth: CGFloat)
    {
        self.tableView_Width = newWidth
        self.campo0_width = newWidth - self.image1_width
        self.campo1_width = newWidth - self.image1_width
        self.campo2_width = newWidth
        
        layoutSubviews()
    }
}
