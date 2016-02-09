//
//  DataSourceComentariosFixed.swift
//  studioSalon
//
//  Created by Enrique Madrigal Gutierrez on 05/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class DataSourceComentariosFixed: NSObject ,UITableViewDataSource {
    
init(cururl: String, posdata: NSString) {
        
      
    let datos = GetData()
    
    datos.setURL(cururl)
    datos.setPostData(posdata)
    
    datos.ObtenData()
    
    let curtime = NSDate()
    var passedTime: Double = 0

    
    while (datos.isDataReady == false && passedTime < 10000.0 && datos.resulterror == 0 ){
        passedTime = curtime.timeIntervalSinceNow * -1000.0
    }
 
    self.responsecode = datos.resulterror
    
    let data = datos.GetJson()
    //print(data)
    //print(data.count)

    for item in data {
        self.comentarios.append(Comentarios_Esteticas(json: item as! NSDictionary))
    }
    

    
    
    
    
    
    
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comentarios.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let item = self.items[indexPath.row]
        let item = self.comentarios[indexPath.row]
        
      //  let cell = tableView.dequeueReusableCellWithIdentifier(self.CellIdentifier, forIndexPath: indexPath) as! customTableView3
      
        let cell = customTableView3(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        
        cell.campo0.text = item.nombre!
        cell.campo1.text = item.created!
        cell.campo2.text = item.comentarios!
        cell.campo2.numberOfLines = 0
        cell.campo2.lineBreakMode = .ByWordWrapping
        
        cell.id = item.id!
        
        let sexo: Int = item.sexo!
        
        if (sexo==1) {
            cell.image1.image = UIImage(named: "men")
        }
        
        else {
            cell.image1.image = UIImage(named: "woman")
        }
        
        cell.rating = item.rate!
        cell.clipsToBounds = true
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
    
    internal var comentarios = [Comentarios_Esteticas]()
    //private var CellIdentifier: String
    var responsecode: Int!
    

}
