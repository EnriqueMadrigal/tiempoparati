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
    
    let image1 = UIImageView()
    var id: Int?

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
        contentView.addSubview(self.campo2)

        
        
         layoutSubviews()
        
        
        
    }
    
    
    override func layoutSubviews() {
        
        self.campo0.frame = CGRect(x: 48, y: 0, width: 240, height: 14)
        self.campo1.frame = CGRect(x: 48, y: 16, width: 240, height: 12)
        self.campo2.frame = CGRect(x: 48, y: 32, width: 240, height: 12)
        self.image1.frame = CGRect(x: 0, y: 0, width: 48, height: 48)

             
    }

    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    

}
