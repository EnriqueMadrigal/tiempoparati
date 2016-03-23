//
//  promocionesview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 04/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class promocionesview: UIViewController , UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    
    private lazy var dataSource: DataSourcePromocionesFixed! = nil
    var refreshControl:UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       SetBackGroundImage2(self)
        
        LoadData()
        
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl)
        tableView.rowHeight = 60
        tableView.estimatedRowHeight = 60
        //tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let returnEsteticas = { (action:UIAlertAction!) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }

        if (self.dataSource.promociones.count==0)
        {
        let alert :UIAlertController = UIAlertController(title: "Advertencia", message: "No se encontraron promociones para el día de hoy", preferredStyle: UIAlertControllerStyle.Alert)
        let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: returnEsteticas)
        alert.addAction(OkButton)
        self.presentViewController(alert, animated: false, completion: nil)
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

    
    func LoadData(){
        
        let IdEstetica = dataAccess.sharedInstance.currentEstetica
        let datapost: String = "idestetica=\(IdEstetica)"
        
        self.dataSource = DataSourcePromocionesFixed(cururl: "getpromociones.php", posdata: datapost)
        self.dataSource.setTableView(self.tableView)
    
        if (self.dataSource.promociones.count == 0 && self.dataSource.responsecode != 0) {
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
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
