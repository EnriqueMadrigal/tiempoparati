//
//  customTableView1.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 31/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class customTableView2: UITableViewCell {

    let campo0 = UILabel()
    let campo1 = UILabel()
    let campo2 = UILabel()
    
    let separator = UIView()
    
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
    var campo2_height: CGFloat = 12
    var campo2_fontsize: CGFloat = 12

    
    var image1_width:CGFloat = 42
    var image1_height: CGFloat = 42
    
    
    ///
    var tableView_Width: CGFloat = 0
    
    
    
      let notavil = UIImage(named: "notavail")!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        contentView.addSubview(self.campo1)
        
        self.campo2.translatesAutoresizingMaskIntoConstraints = false
        self.campo2.text = ""
        self.campo2.font = UIFont(name: "System Font", size: self.campo2_fontsize)
        self.campo2.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        contentView.addSubview(self.campo2)
        
        self.separator.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        contentView.addSubview(self.separator)
        
         layoutSubviews()
        
        
        
    }
    
    
    override func layoutSubviews() {
        self.campo0.frame = CGRect(x: self.image1_width + 1, y: 0.0, width: self.campo0_width, height: self.campo0_height)
        
        self.campo1.frame = CGRect(x: self.image1_width + 1, y: self.campo0_height,  width: self.campo1_width, height: self.campo1_height)

        self.campo2.frame = CGRect(x: self.image1_width + 1, y: self.campo0_height + self.campo1_height, width: self.campo1_width, height: self.campo1_height)

        self.image1.frame = CGRect(x: 0.0, y: 0.0, width: self.image1_width, height: self.image1_height)
        self.separator.frame = CGRect(x: 0.0, y: self.image1_height - 2, width: self.image1_width + self.campo2_width, height: 1)
        
    }

    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        
        self.campo2_width = self.campo2_width * multiplier
        self.campo2_height = self.campo2_height * multiplier
        self.campo2_fontsize = self.campo2_fontsize * multiplier
        
        
        self.image1_width = self.image1_width * multiplier
        self.image1_height = self.image1_height * multiplier
        
        
        ////
        
        
    }
 
    func setWidth(newWidth: CGFloat)
    {
        self.tableView_Width = newWidth
        self.campo0_width = newWidth - self.image1_width
        self.campo1_width = newWidth - self.image1_width
        self.campo2_width = newWidth - self.image1_width
        
        layoutSubviews()
    }

    
    

}
