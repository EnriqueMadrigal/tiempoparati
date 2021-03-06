//
//  serviciosview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 30/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class serviciosview: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelDescripcion: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var curServicio: Servicio!
    var hasloadedData: Bool = false
    

    private lazy var dataSource: DataSourceSubServiciosFixed! = nil
    var refreshControl:UIRefreshControl!
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    var idservicio: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetBackGroundImage2(self)
       
        if let curServicio = curServicio{
            self.labelNombre.text = curServicio.title!
            self.labelDescripcion.text = curServicio.descripcion!
            self.idservicio = curServicio.id!
            
            var imagename: String!
            
            switch curServicio.id!{
                
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
                imagename = "notavail"
                
            }
            
            
            if let newimage = UIImage(named: imagename) {
                self.image1.image = newimage
                
            }
            
            else {
            self.image1.image = UIImage(named: "servicios")
            }
            
            
            
            
            
            
           
         
        LoadData()
            self.hasloadedData = true
            
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            let returnEsteticas = { (action:UIAlertAction!) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            if (self.dataSource.subservicios.count==0)
            {
                let alert :UIAlertController = UIAlertController(title: "Advertencia", message: "No se encontraron servicios", preferredStyle: UIAlertControllerStyle.Alert)
                let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: returnEsteticas)
                alert.addAction(OkButton)
                self.presentViewController(alert, animated: false, completion: nil)
            }
   
    
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
      
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    ///Delegate
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let curHeight:CGFloat = (42.0) * dataAccess.sharedInstance.multiplier
        return curHeight
    }
    
    ////////
    
    
    func LoadData(){
        
        let IdEstetica = dataAccess.sharedInstance.currentEstetica
        let datapost: String = "idestetica=\(IdEstetica)&idservicio=\(self.idservicio)"
        
        self.dataSource = DataSourceSubServiciosFixed(cururl: "getsubservicios.php", posdata: datapost)
        self.dataSource.setTableView(self.tableView)
        
        if (self.dataSource.subservicios.count == 0 && self.dataSource.responsecode != 0) {
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
        }
        
        
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
        
        
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (self.hasrefresh){
            return
        }
       
        self.refreshControl.beginRefreshing()
        LoadData()
        self.refreshControl.endRefreshing()
        
        
        
    }
    
    
    func refreshdata(sender:AnyObject) {
        
        self.hasrefresh = true
        self.refreshControl.beginRefreshing()
        LoadData()
        self.refreshControl.endRefreshing()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //print("didAppear")
        //SetBackGroundImage(self)
        
        
        if (!hasloadedData){
            
            self.LoadData()
            
        }
        
        self.hasloadedData = false
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("willAppear")
        SetBackGroundImage2(self)
        //setGradient3(self)
        //SetBackGroundImage2(self)
        
        
        
        
    }

    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            //let orient = UIApplication.sharedApplication().statusBarOrientation
            
            
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                //print("rotation completed")
                SetBackGroundImage2(self)
                self.LoadData()
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    

    

}
