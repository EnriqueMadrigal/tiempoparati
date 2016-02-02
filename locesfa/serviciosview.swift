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

    private lazy var dataSource: DataSourceSubServiciosFixed! = nil
    var refreshControl:UIRefreshControl!
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    var idservicio: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        
        let navControllerheight: CGFloat = self.navigationController!.navigationBar.bounds.height
        let frame1: CGRect = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        let backgroundImage = UIImageView(frame: frame1)
        
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)

       
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
                
            default:
                imagename = "notavail"
                
            }
            
            self.image1.image = UIImage(named: imagename)

            
            
            
            
            
            
           
         
        LoadData()
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl)
        tableView.rowHeight = 48

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
    
    
    
    func LoadData(){
        
        let IdEstetica = dataAccess.sharedInstance.currentEstetica
        let datapost: String = "idestetica=\(IdEstetica)&idservicio=\(self.idservicio)"
        
        self.dataSource = DataSourceSubServiciosFixed(cururl: "http://192.168.15.201/nailsalon/app/getsubservicios.php", posdata: datapost)
        
        
        if (self.dataSource.subservicios.count == 0 && self.dataSource.responsecode != 0) {
            print ("No se encontro el servidor")
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
        print("Scroll")
        self.refreshControl.beginRefreshing()
        LoadData()
        self.refreshControl.endRefreshing()
        
        
        
    }
    
    
    func refreshdata(sender:AnyObject) {
        print("refresh")
        self.hasrefresh = true
        self.refreshControl.beginRefreshing()
        LoadData()
        self.refreshControl.endRefreshing()
        
    }
    

    

}
