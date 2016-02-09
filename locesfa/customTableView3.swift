//
//  customTableView3.swift
//  studioSalon
//
//  Created by Enrique Madrigal Gutierrez on 15/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class customTableView3: UITableViewCell {

    let campo0 = UILabel()
    let campo1 = UILabel()
    let campo2 = UILabel()

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
        
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
        // Initialization code
        self.image1.image = self.notavil
        contentView.addSubview(self.image1)
        
        
        self.campo0.translatesAutoresizingMaskIntoConstraints = false
        self.campo0.text = ""
        self.campo0.font = UIFont(name: "System Font", size: 14)
        contentView.addSubview(self.campo0)
        
        
        self.campo1.translatesAutoresizingMaskIntoConstraints = false
        self.campo1.text = ""
        self.campo1.font = UIFont(name: "System Font", size: 12)
        contentView.addSubview(self.campo1)
        
        self.campo2.translatesAutoresizingMaskIntoConstraints = false
        self.campo2.text = ""
        self.campo2.font = UIFont(name: "System Font", size: 12)
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
        
        self.campo0.frame = CGRect(x: 48, y: 0, width: 240, height: 14)
        self.campo1.frame = CGRect(x: 48, y: 33, width: 240, height: 12)
        
        self.campo2.frame = CGRect(x: 0, y: 48, width: 248, height: 32)
        self.image1.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
      
        for (index, image) in ratingImages.enumerate() {
            
            let imagesize = (index * (16 + spacing) )
            let imageframe = CGRect(x: 48 + imagesize, y: 14, width: 16, height: 16)
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
