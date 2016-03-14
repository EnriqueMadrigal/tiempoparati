//
//  DataSourceEsteticasFixed.swift
//  salonEstudio
//
//  Created by Enrique Madrigal Gutierrez on 29/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import UIKit

class DataSourceEsteticasFixed: NSObject , UITableViewDataSource {
    
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
        
        
        for item in data {
               esteticas.append(Estetica(json: item as! NSDictionary))
        }

        
        /*
        for estetica in esteticas{
            
            let curid: Int = estetica.id!
            let datosimage = GetImage()
            datosimage.setURL("http://192.168.15.201/nailsalon/app/getimagesalon.php")
            datosimage.setPostData("idestetica=\(curid)&width=64&height=64")
            datosimage.ObtenData()
            
            let curtime = NSDate()
            
            var passedTime: Double = 0
            
            
            while (datosimage.isDataReady == false && passedTime < self.maxWaitTime && datosimage.resulterror == 0 ){
                passedTime = curtime.timeIntervalSinceNow * -1000.0
                
            }
            if (datosimage.resulterror==1){
                break
            }
            
            let newImage: Estetica_Images = Estetica_Images(idEstetica: curid, newimage: datosimage.GetcurImage())
                esteticasImages.append(newImage)
            
        }
        */
        
        self.responsecode = 0
    }
    

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.esteticas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let item = self.items[indexPath.row]
        let item = self.esteticas[indexPath.row]
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(self.CellIdentifier, forIndexPath: indexPath) as! customTableView1
        let cell =  customTableView4(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        
        
        cell.campo0.text = item.title!
        cell.campo1.text = item.descripcion!
        //cell.campo1.text = item.calle! + " " + item.exterior! + " " + item.interior!
        //cell.campo2.text = item.colonia! + " " + item.ciudad!
        cell.id = item.id!
       // let imagename: NSString = item.imageFileName!
       // let filename = imagename.stringByDeletingPathExtension
        
        //let sexo = dataAccess.sharedInstance.curPersona.sexo
        //let atencion = item.atencion!
        //var curImage = UIImage(named: "menwoman")
        
        
        //if (atencion==1){
        //    curImage = UIImage(named: "woman")
        //}
        
        //if (atencion==2){
        //    curImage = UIImage(named: "men")
        //}
        
        //if (atencion==3){
        //    curImage = UIImage(named: "childs")
        //}
        
        
        
        //cell.image1.image = curImage
        cell.rating = item.rate!
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
    
    
    
    func showWaitDialog()
    {
        print ("Fire")
        
        
    }

   
   private var tableView: UITableView!
    private var esteticasImages = [Estetica_Images]()
    internal var esteticas = [Estetica]()
    //private var CellIdentifier: String
    var responsecode: Int!
    
}


