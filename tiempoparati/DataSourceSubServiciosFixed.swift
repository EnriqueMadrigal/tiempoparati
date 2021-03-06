//
//  DataSourceEsteticasFixed.swift
//  salonEstudio
//
//  Created by Enrique Madrigal Gutierrez on 29/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import UIKit

class DataSourceSubServiciosFixed: NSObject , UITableViewDataSource {
    
    var maxWaitTime: Double = 40000.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(cururl: String, posdata: String) {
       
        
        //self.tableView = tableView
        //self.CellIdentifier = cellIdentifier
        
       //let Name = "EsteticasData"
        
         super.init()
        
        //let timer1 = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("showWaitDialog"), userInfo: nil, repeats: true)
        //timer1.fire()
        
        
        //////
        let datos = SentRequest(curaction: cururl)
        datos.setPostData(posdata)
        
        datos.ObtenData()
        
        if (datos.result==1){
            self.responsecode = 1
            return
        }
        
        let data = datos.GetJson()
        
        //print(data)
        
        
        for item in data {
               subservicios.append(SubServicio(json: item as! NSDictionary))
        }

        
        
        for subservicio in subservicios{
            /*
            let curid: Int = subservicio.id!
            let datosimage = GetImage()
            datosimage.setURL("http://192.168.15.201/nailsalon/app/getimagesubservicio.php")
            datosimage.setPostData("idsubservicio=\(curid)&width=64&height=64")
            datosimage.ObtenData()
            
            let curtime = NSDate()
            
            var passedTime: Double = 0
            
            
            while (datosimage.isDataReady == false && passedTime < self.maxWaitTime && datosimage.resulterror == 0 ){
                passedTime = curtime.timeIntervalSinceNow * -1000.0
                
            }
            if (datosimage.resulterror==1){
                break
            }
            
            let newImage: Servicios_Images = Servicios_Images(idServicio: curid, newimage: datosimage.GetcurImage())
                serviciosImages.append(newImage)
            */
            
            let curid: Int = subservicio.id!
            let datosImage = SentRequest_image(curaction: "getimagesubservicio.php")
            datosImage.AddPosData(DataPost(newItem: "idsubservicio", newValue: "\(curid)"))
            datosImage.AddPosData(DataPost(newItem: "width", newValue: "64"))
            datosImage.AddPosData(DataPost(newItem: "height", newValue: "64"))
            
            datosImage.ObtenData()
            
            if (datosImage.result==1){
                break
            }
                
            let newImage: Servicios_Images = Servicios_Images(idServicio: curid, newimage: datosImage.curimage!)
            serviciosImages.append(newImage)
            
        }
        
        self.responsecode = 0
        
    }
    

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subservicios.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let item = self.items[indexPath.row]
        let item = self.subservicios[indexPath.row]
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(self.CellIdentifier, forIndexPath: indexPath) as! customTableView1
        let cell =  customTableView2(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        
        
        cell.campo0.text = item.title!
        cell.campo1.text = item.descripcion!
        cell.campo2.text = "costo $ \(item.costoservicio!) m.n."
        //cell.campo1.text = item.calle! + " " + item.exterior! + " " + item.interior!
        //cell.campo2.text = item.colonia! + " " + item.ciudad!
        cell.id = item.id!
       // let imagename: NSString = item.imageFileName!
       // let filename = imagename.stringByDeletingPathExtension
        let curImage = serviciosImages[indexPath.row]
        
        cell.image1.image = curImage.imagedata!
        //cell.rating = item.rate!
        cell.setWidth(self.tableView.bounds.width)
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    
    func setTableView (newtableView: UITableView)
    {
        self.tableView = newtableView
    }
    
    
    
   
   
    private var tableView: UITableView!
    private var serviciosImages = [Servicios_Images]()
    internal var subservicios = [SubServicio]()
    //private var CellIdentifier: String
    var responsecode: Int!
    
}


