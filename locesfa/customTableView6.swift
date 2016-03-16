//
//  customTableView1.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 31/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class customTableView6: UITableViewCell {

    let title = UILabel()
    let campo0 = UILabel()
    let campo1 = UILabel()
    let campo2 = UILabel()
    let campo3 = UILabel()
    
    let separator = UIView()
    
    var id: Int?

    ///// default 1X
    
    var multiplier: CGFloat = 1.0
    
    var title_width:CGFloat = 120
    var title_height: CGFloat = 48
    var title_fontsize: CGFloat = 20
    
    var campo0_width:CGFloat = 120
    var campo0_height: CGFloat = 12
    var campo0_fontsize: CGFloat = 12
    
    
    ///
    var tableView_Width: CGFloat = 0
    
    
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
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.text = ""
        self.title.font = UIFont(name: "System Font", size: self.title_fontsize)
        self.title.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        contentView.addSubview(self.title)
        
        
        self.campo0.translatesAutoresizingMaskIntoConstraints = false
        self.campo0.text = ""
        self.campo0.font = UIFont(name: "System Font", size: self.campo0_fontsize)
        contentView.addSubview(self.campo0)
        
        
        self.campo1.translatesAutoresizingMaskIntoConstraints = false
        self.campo1.text = ""
        self.campo1.font = UIFont(name: "System Font", size: self.campo0_fontsize)
        contentView.addSubview(self.campo1)
        
        self.campo2.translatesAutoresizingMaskIntoConstraints = false
        self.campo2.text = ""
        self.campo2.font = UIFont(name: "System Font", size: self.campo0_fontsize)
        //self.campo2.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        contentView.addSubview(self.campo2)
       
        
        self.campo3.translatesAutoresizingMaskIntoConstraints = false
        self.campo3.text = ""
        self.campo3.font = UIFont(name: "System Font", size: self.campo0_fontsize)
        contentView.addSubview(self.campo3)
        
        
        
        self.separator.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        contentView.addSubview(self.separator)
        
         layoutSubviews()
        
        
        
    }
    
    
    override func layoutSubviews() {

        self.title.frame = CGRect(x: 0.0 ,y: 0.0, width: self.title_width, height: self.title_height)
        self.campo0.frame = CGRect(x: self.title_width + 1, y: 0.0, width: self.campo0_width, height: self.campo0_height)
        self.campo1.frame = CGRect(x: self.title_width + 1, y: self.campo0_height,  width: self.campo0_width, height: self.campo0_height)
        self.campo2.frame = CGRect(x: self.title_width + 1, y: self.campo0_height * 2.0  , width: self.campo0_width, height: self.campo0_height)
        self.campo3.frame = CGRect(x: self.title_width + 1, y: self.campo0_height * 3.0 , width: self.campo0_width, height: self.campo0_height)

        
        self.separator.frame = CGRect(x: 0.0, y: self.title_height , width: self.title_width + self.campo0_width, height: 1)
        
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
        
        self.title_width = self.title_width * multiplier
        self.title_height = self.title_height * multiplier
        self.title_fontsize = self.title_fontsize * multiplier
        
        
        ////
        
        
    }
 
    func setWidth(newWidth: CGFloat)
    {
        self.tableView_Width = newWidth
        
        self.campo0_width = newWidth - self.title_width
        
        layoutSubviews()
    }

    
    

}
