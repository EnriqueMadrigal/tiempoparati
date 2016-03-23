//
//  tipsview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 21/03/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class tipsview: UIViewController , UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentCategoria: UISegmentedControl!
    
    
    @IBAction func changeCategoria(sender: AnyObject) {
    self.categoria = segmentCategoria.selectedSegmentIndex + 1
    LoadData()
        
    }
    
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    
    private lazy var dataSource: DataSourceTipsFixed! = nil
    var refreshControl:UIRefreshControl!
    var categoria: Int = 1
    var sexo: Int = 1
    
    
    var Dialogo = Dialogs()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         SetGradient3(self)
       
        LoadData()
        
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl)
        tableView.rowHeight = 42
        tableView.estimatedRowHeight = 42
        //tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        if (self.dataSource.tips.count==0)
        {
            let alert :UIAlertController = UIAlertController(title: "Advertencia", message: "No se encontraron tips de belleza", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
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

    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //print(segue.identifier)
        
        ////
        
        
        if let selectedEsteticaCell = sender as? customTableView1!{
            let indexPath = tableView.indexPathForCell(selectedEsteticaCell)!
            let row = indexPath.row
            let curTip = self.dataSource.tips[row]
            let tipid = curTip.id
            
            let esteticaDetailViewController = segue.destinationViewController as! showtipview
            
            esteticaDetailViewController.CurrentTip = tipid
            
            
            
        }
        
        
        ///
        
        
    }

    
    
    
    //Delegate
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let curHeight:CGFloat = (42.0) * dataAccess.sharedInstance.multiplier
       return curHeight
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.Dialogo.setPos(self.view.frame.midX - 90, self.view.frame.midY - 25)
        self.view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        self.view.alpha=0.5
        let messageDialog: UIView = self.Dialogo.showWaitDialog("Un momento")
        self.view.addSubview(messageDialog)
        self.hasWaitDialog = true
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        
        
       // let row = indexPath.row
        
        let cell: customTableView1 = tableView.cellForRowAtIndexPath(indexPath) as! customTableView1
        performSegueWithIdentifier("showTip", sender: cell)
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
          SetGradient3(self)
        //SetBackGroundImage2(self)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        //super.viewWillAppear(animated)
        super.viewDidAppear(animated)
        //print("didAppear")
        if (self.hasWaitDialog){
            Dialogo.closeWaitDialog()
            view.alpha = 1.0
            view.userInteractionEnabled = true
            self.hasWaitDialog = false
        }
        //SetBackGroundImage(self)
        //setGradient2(self)
        //SetBackGroundImage2(self)
        LoadData()
        
    }

    
    
    
    
    
    
    
    ///////
    
    
    func LoadData(){
        
        let datapost: String = "categoria=\(self.categoria)"
        
        self.dataSource = DataSourceTipsFixed(cururl: "gettips.php", posdata: datapost)
        self.dataSource.setTableView(self.tableView)
        
        if (self.dataSource.tips.count == 0 && self.dataSource.responsecode != 0) {
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
                SetGradient3(self)
                self.LoadData()
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    

    
}
