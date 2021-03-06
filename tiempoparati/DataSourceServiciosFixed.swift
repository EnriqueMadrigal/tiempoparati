//
//  DataSourceServiciosFixed.swift
//  salonEstudio
//
//  Created by Enrique Madrigal Gutierrez on 30/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import UIKit

class DataSourceServiciosFixed: NSObject, UITableViewDataSource {
    
    var maxWaitTime: Double = 40000.0

    init(cururl: String, posdata: String) {
        
       /////
        
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
            self.servicios.append(Servicio(json: item as! NSDictionary))
        }
        
        
        self.responsecode = 0
        
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.servicios.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let item = self.items[indexPath.row]
        let item = self.servicios[indexPath.row]
        
         let cell = customTableView1(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(self.CellIdentifier, forIndexPath: indexPath) as! customTableView1
        cell.campo0.text = item.title
        cell.campo1.text = item.descripcion
        //cell.campo2.text = item.colonia! + " " + item.ciudad!
      //  cell.campo2.text = ""
        cell.id = item.id!
        
        var imagename: String!
        
        switch item.id!{
            
        case 1:
            imagename = "womancomb"
            
        case 2:
            imagename = "womanmakeup"
            
        case 3:
            imagename = "womanfacial"
            
        case 4:
            imagename = "womanhair"
            
        case 5:
            imagename = "womancut"
            
        case 6:
            imagename = "womanmassage"
            
        case 7:
            imagename = "womantreatment"
            
        case 8:
            imagename = "womannails"
        
        case 9:
            imagename = "menicon1"
        
        case 10:
            imagename = "menhaircut"
            
        case 11:
            imagename = "menbeard"
            
        case 12:
            imagename = "relajacion"
        
        case 13:
            imagename = "spa"
            
        case 14:
            imagename = "pedicure"
            
        case 15:
            imagename = "childs"
        
        case 16:
            imagename = "married"
            
        case 17:
            imagename = "fisico"
            
        case 18:
            imagename = "manicure"
            
        default:
            imagename = "services"
            
        }
        
       
        
        if let newimage = UIImage(named: imagename) {
            cell.image1.image = newimage
            
        }
            
        else {
            cell.image1.image = UIImage(named: "servicios")
        }

        
        
        cell.setWidth(self.tableView.bounds.width)
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
    internal var servicios = [Servicio]()
   
   var responsecode: Int!

}
