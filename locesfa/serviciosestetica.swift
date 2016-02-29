//
//  serviciosestetica.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 26/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class serviciosestetica: UIViewController ,UITableViewDelegate{

    private lazy var dataSource: DataSourceServiciosFixed! = nil
    var refreshControl:UIRefreshControl!
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    var Dialogo = Dialogs()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetBackGroundImage(self)
        LoadData()
        
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
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
        let datapost: String = "idestetica=\(IdEstetica)"
        
        self.dataSource = DataSourceServiciosFixed(cururl: "getservicios.php", posdata: datapost)
        self.dataSource.setTableView(self.tableView)
        
        if (self.dataSource.servicios.count == 0 && self.dataSource.responsecode != 0) {
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
    
    
    
    ////// Delegate
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let row = indexPath.row
        let currentServicio = self.dataSource.servicios[row]
        
        
        let cell: customTableView1 = tableView.cellForRowAtIndexPath(indexPath) as! customTableView1
        
        print(cell.id)
        
        
        
        
        //performSegueWithIdentifier("showEstetica", sender: cell)
        
        
        Dialogo.setPos(view.frame.midX - 90, view.frame.midY - 25)
        view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        view.alpha=0.5
        let messageDialog: UIView = Dialogo.showWaitDialog("Un momento")
        view.addSubview(messageDialog)
        self.hasWaitDialog = true
        
        
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Servicios") as! serviciosview
        vc.curServicio = currentServicio
        self.showViewController(vc, sender: nil)
        //.showViewController(vc, animated: true, completion: nil)
        
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let curHeight:CGFloat = (42.0 ) * dataAccess.sharedInstance.multiplier
        return curHeight
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("didAppear")
        if (self.hasWaitDialog){
            Dialogo.closeWaitDialog()
            view.alpha = 1.0
            view.userInteractionEnabled = true
            self.hasWaitDialog = false
        }
        SetBackGroundImage(self)
    }

    
    

}
