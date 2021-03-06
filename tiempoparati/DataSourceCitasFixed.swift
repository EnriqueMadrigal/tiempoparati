//
//  DataSourceComentariosFixed.swift
//  studioSalon
//
//  Created by Enrique Madrigal Gutierrez on 05/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class DataSourceCitasFixed: NSObject ,UITableViewDataSource {
    
init(cururl: String, posdata: String) {
        
      
    let datos = SentRequest(curaction: cururl)
    datos.setPostData(posdata)
    
    datos.ObtenData()
    
    if (datos.result==1){
        self.responsecode = 1
        return
    }
    
    let data = datos.GetJson()

    for item in data {
        self.citas.append(Citas_Esteticas(json: item as! NSDictionary))
    }
    
   
    datos.result==1
    self.responsecode = 0
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let item = self.items[indexPath.row]
        let item = self.citas[indexPath.row]
        
      //  let cell = tableView.dequeueReusableCellWithIdentifier(self.CellIdentifier, forIndexPath: indexPath) as! customTableView3
      
        let cell = customTableView2(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        
        cell.campo0.text = item.estatuscita!
        cell.campo1.text = item.fecha!
        cell.campo2.text = item.hora!
        //cell.campo2.numberOfLines = 0
        //cell.campo2.lineBreakMode = .ByWordWrapping
        
        cell.id = item.id!
        
       cell.image1.image = UIImage(named: "appointment-icon")
        
        cell.clipsToBounds = true
        cell.setWidth(self.tableView.bounds.width)
        
        cell.setNeedsLayout()
        return cell
    }
  
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 128
    }

    
    func setTableView (newtableView: UITableView)
    {
        self.tableView = newtableView
    }
    
    
    private var tableView: UITableView!
    
    internal var citas = [Citas_Esteticas]()
    //private var CellIdentifier: String
    var responsecode: Int!
    

}
