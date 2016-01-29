//
//  mainscene.swift
//  encesfa
//
//  Created by Enrique Madrigal Gutierrez on 22/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class mainscene: UIViewController ,UITableViewDelegate  {

    
     private lazy var dataSource: DataSourceEsteticasFixed! = nil
    @IBOutlet weak var tableView: UITableView!
   
 
    
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.bounds = CGRectMake(0, 0, refreshControl.bounds.size.width, refreshControl.bounds.size.height) // Change position of refresh view
        refreshControl.tintColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()

    
    var Dialogo = Dialogs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        
        let navControllerheight: CGFloat = self.navigationController!.navigationBar.bounds.height
        let frame1: CGRect = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        let backgroundImage = UIImageView(frame: frame1)
        
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)

        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
        self.tableView.delegate = self
        self.tableView.addSubview(self.refreshControl)
 
    LoadData()
     
        
        
        
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("willAppear")
        
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
       
       
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
   
        print(segue.identifier)
        
        Dialogo.setPos(view.frame.midX - 90, view.frame.midY - 25)
        view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        view.alpha=0.5
        let messageDialog: UIView = Dialogo.showWaitDialog("Un momento")
        view.addSubview(messageDialog)
        self.hasWaitDialog = true

    
        ////
        
        
        if let selectedEsteticaCell = sender as? customTableView4!{
            let indexPath = tableView.indexPathForCell(selectedEsteticaCell)!
            let row = indexPath.row
            let currentEstetica = self.dataSource.esteticas[row]
            
            let oldEstetica = dataAccess.sharedInstance.currentEstetica
            let curEstetica = currentEstetica.id
            if (oldEstetica != curEstetica)
            {
                dataAccess.sharedInstance.currentEstetica = currentEstetica.id!
               
                
            }
            
            
            let esteticaDetailViewController = segue.destinationViewController as! esteticaview
            
            esteticaDetailViewController.CurEstetica = currentEstetica
            

            
            
        }
        
     
        ///
        
    
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
    
     func LoadData(){
        self.dataSource = nil
    self.dataSource = DataSourceEsteticasFixed(cururl: "http://192.168.15.201/nailsalon/app/getsalons.php", posdata: "IdPersona=0", tableView: self.tableView)
    
    if (self.dataSource.esteticas.count==0 && self.dataSource.responsecode != 0) {
    print ("No se encontro el servidor")
    let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
    let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
    alert.addAction(OkButton)
    self.presentViewController(alert, animated: false, completion: nil)
    
    }
    
    self.tableView.dataSource = self.dataSource
    self.tableView.reloadData()
    
    
}


    
    ////// Delegate
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let row = indexPath.row
        
        let currentEstetica = self.dataSource.esteticas[row]
        let oldEstetica = dataAccess.sharedInstance.currentEstetica
        let curEstetica = currentEstetica.id
        if (oldEstetica != curEstetica)
        {
            dataAccess.sharedInstance.currentEstetica = currentEstetica.id!
                        
        }
        
        
        
        let cell: customTableView4 = tableView.cellForRowAtIndexPath(indexPath) as! customTableView4
        
        print(cell.id)
        
        performSegueWithIdentifier("showEstetica", sender: cell)
    }
    
    
    

}




