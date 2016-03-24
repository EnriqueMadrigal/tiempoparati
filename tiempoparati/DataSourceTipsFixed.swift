//
//  DataSourceServiciosFixed.swift
//  salonEstudio
//
//  Created by Enrique Madrigal Gutierrez on 30/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import UIKit

class DataSourceTipsFixed: NSObject, UITableViewDataSource {
    
    
    init(cururl: String, posdata: String) {
        
       
             
            
        //////
        let datos = SentRequest(curaction: cururl)
        datos.setPostData(posdata)
        
        datos.ObtenData()
        
        if (datos.result==1){
            self.responsecode = 1
            return
        }
        
        let data = datos.GetJson()
        
        //print(data.count)
        
        
        for item in data {
            self.tips.append(Tips_Belleza(json: item as! NSDictionary))
        }
        
        
       self.responsecode = 0
        
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tips.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let item = self.items[indexPath.row]
        let item = self.tips[indexPath.row]
        
         let cell = customTableView1(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(self.CellIdentifier, forIndexPath: indexPath) as! customTableView1
        cell.campo0.text = item.title
        cell.campo1.text = ""
        cell.layoutIfNeeded()
        
        //cell.campo2.text = item.colonia! + " " + item.ciudad!
      //  cell.campo2.text = ""
        cell.id = item.id!
        cell.image1.image = UIImage(named: "tips")
        cell.setWidth(self.tableView.bounds.width)
        
  
        //cell.bounds = CGRect(x: 0, y: 0, width: CGRectGetWidth(tableView.bounds), height: 99999)
        //cell.contentView.bounds = cell.bounds
       
        /*
        cell.campo1.preferredMaxLayoutWidth = CGRectGetWidth(cell.campo1.frame)
        cell.campo0.preferredMaxLayoutWidth = CGRectGetWidth(cell.campo0.frame)
        
        let cellWidth = CGRectGetWidth(tableView.bounds) - 20
        cell.bounds = CGRect(x: 0, y: 0, width: cellWidth, height: 99999)
        */
        return cell
    }
    
    func setTableView (newtableView: UITableView)
    {
        self.tableView = newtableView
    }
    

    
      
    /*
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
    }
    */
    
    //private (set) internal var items: [String]
    private var tableView: UITableView!
    //private var serviciosImages = [Servicios_Images]()
    internal var tips = [Tips_Belleza]()
   
   var responsecode: Int!

}
