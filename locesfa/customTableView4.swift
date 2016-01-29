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
    let image1 = UIImageView()
    var id: Int?
    
    let notavil = UIImage(named: "notavail")!
    var rating: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingImages = [UIImageView]()
    var spacing = 5
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
    
    
        self.image1.image = self.notavil
        contentView.addSubview(self.image1)
        
        
        self.campo0.translatesAutoresizingMaskIntoConstraints = false
        self.campo0.text = ""
        self.campo0.font = UIFont(name: "System Font", size: 14)
        //self.campo0.frame = CGRect(x: 32, y: 0, width: 240, height: 16)
        contentView.addSubview(self.campo0)
        
        
        for _ in 0..<5 {
            let image = UIImageView()
            image.image = self.emptyStarImage
            
            addSubview(image)
            ratingImages.append(image)
        }
        
        self.campo1.translatesAutoresizingMaskIntoConstraints = false
        self.campo1.text = ""
        self.campo1.font = UIFont(name: "System Font", size: 12)
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
        
        self.campo0.frame = CGRect(x: 42, y: 0, width: 240, height: 14)
        self.campo1.frame = CGRect(x: 42, y: 32, width: 240, height: 12)
        self.image1.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        
        
        
        for (index, image) in ratingImages.enumerate() {
            
            let imagesize = (index * (16 + spacing) )
            let imageframe = CGRect(x: 42 + imagesize, y: 14, width: 16, height: 16)
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
    

    
    
    
}
