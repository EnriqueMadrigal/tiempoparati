//
//  mainscene.swift
//  encesfa
//
//  Created by Enrique Madrigal Gutierrez on 22/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class mainscene: UIViewController ,UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate  {

    
     private lazy var dataSource: DataSourceEsteticasFixed! = nil
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var searchView: UIView!
     
    
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    var searchController: UISearchController!
    
    
    var cadenaBusqueda: String = ""
    var tipoBusqueda: Int = 0
    
    //// search controls
    var dataArray = [String]()
    
    var filteredArray = [String]()
    
    var shouldShowSearchResults = false
    ////
    
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
    
    
    @IBAction func showMap(sender: AnyObject) {
    
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("mapLocation1") as! mapLocation
        //vc.curServicio = 1
        
        Dialogo.setPos(view.frame.midX - 90, view.frame.midY - 25)
        view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        view.alpha=0.5
        let messageDialog: UIView = Dialogo.showWaitDialog("Un momento")
        view.addSubview(messageDialog)
        self.hasWaitDialog = true
        
        
        self.showViewController(vc, sender: nil)
        //.showViewController(vc, animated: true, completion: nil)
 
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        SetBackGroundImage(self)
        /*
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        
        let navControllerheight: CGFloat = self.navigationController!.navigationBar.bounds.height
        let frame1: CGRect = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        let backgroundImage = UIImageView(frame: frame1)
        
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        */
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
        self.tableView.delegate = self
        self.tableView.addSubview(self.refreshControl)
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //let myCustomlabel = UILabel()
        //myCustomlabel.text = "HOla Mundo"
        //self.tableView.tableHeaderView?.addSubview(myCustomlabel)
        
        /*
        var frame = CGRectMake(0, 0, self.view.frame.size.width, 60)
        var headerImageView = UIImageView(frame: frame)
        var image: UIImage = UIImage(named: "notavail")!
        headerImageView.image = image
    self.tableView.tableHeaderView = headerImageView
        */
        
    LoadData()
    RegisterUser()
    configureSearchController()
        
        
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("willAppear")
        self.labelNombre.text = "Hola " + dataAccess.sharedInstance.curPersona.Nombre!
        SetBackGroundImage(self)
        
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
        LoadData()
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
   
        //print(segue.identifier)
        
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
        let datapost: String = "IdPersona=0&tipo=\(self.tipoBusqueda)&cadenabusqueda=" + self.cadenaBusqueda + "&uuid=" + dataAccess.sharedInstance.UIID + "&sexo=\(dataAccess.sharedInstance.curPersona.sexo!)"
       print(datapost)
        
    self.dataSource = nil
    self.dataSource = DataSourceEsteticasFixed(cururl: "getsalons.php", posdata: datapost)
    self.dataSource.setTableView(self.tableView)
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
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       
        let curHeight:CGFloat = (42.0) * dataAccess.sharedInstance.multiplier
        return curHeight
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
 /*
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /*
        let myCustomlabel = UILabel()
        
        
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView!
        header.addSubview(myCustomlabel)
        return header
        */
        let items = ["Nombre", "Servicio", "Producto"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = UIColor.blackColor()
        customSC.tintColor = UIColor.whiteColor()
        customSC.addTarget(self, action: "changeSearch:", forControlEvents: .ValueChanged)
        //uilbl.numberOfLines = 0
        //uilbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //uilbl.text = "blablabla"
        customSC.sizeToFit()
        //uilbl.backgroundColor =  UIColor(patternImage: UIImage(named: "background1")!)
        
        return customSC


    }
*/
    
    func changeSearch(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            self.view.backgroundColor = UIColor.greenColor()
        case 2:
            self.view.backgroundColor = UIColor.blueColor()
        default:
            self.view.backgroundColor = UIColor.purpleColor()
        }
    }
    
    
    //////
    
    func RegisterUser(){
        
        let uuid: String = dataAccess.sharedInstance.UIID
        let datos = GetData()
        datos.setURL("http://192.168.15.201/nailsalon/app/registeruser.php")
        datos.setPostData("uuid=" + uuid)
        datos.ObtenData()
        
        let curtime = NSDate()
        var passedTime: Double = 0
        
        
        while (datos.isDataReady == false && passedTime < 10000.0 && datos.resulterror == 0 ){
            passedTime = curtime.timeIntervalSinceNow * -1000.0
        }
        
        if (datos.resulterror==1){
            print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
            
            
        }
        
        
        
        
    }
   
    
    ///// search bar
    
    
    
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = true
   
        searchController.searchBar.placeholder = "Busqueda..."
        searchController.searchBar.delegate = self
        //searchController.searchBar.sizeToFit()
        
        //let curSize = CGSize(width: self.searchView.bounds.width, height: self.searchView.bounds.height)
        //searchController.searchBar.sizeThatFits(curSize)
        var currentSize  = self.searchView.bounds.width

        currentSize = currentSize / 2
        print(currentSize)
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: CGFloat(currentSize), height: self.searchView.bounds.height)
    
        searchController.searchBar.scopeButtonTitles = ["Nombre", "Servicios", "Productos"]
    print(self.searchView.bounds.width)
        
        //searchController.searchBar.bounds.width = self.tableView.bounds.width
        
        // Place the search bar view to the tableview headerview.
        //self.tableView.tableHeaderView = searchController.searchBar
        self.searchView.addSubview(searchController.searchBar)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        print("true")
        //LoadData()
       
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        //LoadData()
        print("cancel")
        self.cadenaBusqueda = ""
        LoadData()
       
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        /*
        if !shouldShowSearchResults {
            shouldShowSearchResults = false
            //LoadData()
        }
        */
        shouldShowSearchResults = false
        print("Click")
        
        //searchController.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResultsForSearchController(searchController)
        //print(selectedScope)
        self.tipoBusqueda = selectedScope
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        //print(searchString)
        // Filter the data array and get only those countries that match the search text.
        
        //let countryText: NSString = country
        
        self.cadenaBusqueda = searchString!
        //self.tipoBusqueda = 3
        
            //self.refreshControl.beginRefreshing()
        
        if shouldShowSearchResults {
           // shouldShowSearchResults = true
            LoadData()
        }
        //self.refreshControl.endRefreshing()
            //return (countryText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        
        // Reload the tableview.
        //LoadData()
    }
    
    ///////

}




