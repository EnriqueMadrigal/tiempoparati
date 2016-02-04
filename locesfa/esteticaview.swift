//
//  esteticaview.swift
//  encesfa
//
//  Created by Enrique Madrigal Gutierrez on 28/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class esteticaview: UIViewController ,UITableViewDelegate{

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelDescripcion: UILabel!
   
   
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func Favoritos(sender: AnyObject) {
     AgregarFavorito()
    }
       
     internal var servicios = [Servicio]()
     var Dialogo = Dialogs()
    
    
    @IBAction func getPeinados(sender: UIButton) {
        print("Peinados")
        //performSegueWithIdentifier("showServicios", sender: nil)
       // let vc :serviciosview = self.storyboard?.instantiateViewControllerWithIdentifier("Servicios") as! serviciosview
         //      self.presentViewController(vc, animated: true, completion: nil)
        
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Servicios") as! serviciosview
        //vc.curServicio = 1
        self.showViewController(vc, sender: nil)
            //.showViewController(vc, animated: true, completion: nil)
        
    }
    
    
    
    var CurEstetica: Estetica!
    private lazy var dataSource: DataSourceServiciosFixed! = nil
    var refreshControl:UIRefreshControl!
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        
        let navControllerheight: CGFloat = self.navigationController!.navigationBar.bounds.height
        let frame1: CGRect = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        let backgroundImage = UIImageView(frame: frame1)
        
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)

        
        if let CurEstetica = CurEstetica{
         self.labelNombre.text = CurEstetica.title!
            self.labelDescripcion.text = CurEstetica.descripcion!
            //let dir1: String = CurEstetica.calle! + " " + CurEstetica.exterior! + " " + CurEstetica.interior!
            //let dir2: String =  CurEstetica.colonia! + "," + CurEstetica.ciudad! + "," + CurEstetica.estado!
            self.labelDescripcion.numberOfLines = 0
            self.labelDescripcion.lineBreakMode = .ByWordWrapping
            //self.labelDireccion.text =  dir1 + "," + dir2
            //self.labelTelefono1.text = CurEstetica.telefono1
            
            
            /////
            let curid: Int = CurEstetica.id!
            let datosimage = GetImage()
            datosimage.setURL("http://192.168.15.201/nailsalon/app/getimagesalon.php")
            datosimage.setPostData("idestetica=\(curid)&width=240&height=240")
            datosimage.ObtenData()
            
            let curtime = NSDate()
            
            var passedTime: Double = 0
            let maxWaitTime: Double = 40000.0
            
            while (datosimage.isDataReady == false && passedTime < maxWaitTime && datosimage.resulterror == 0 ){
                passedTime = curtime.timeIntervalSinceNow * -1000.0
                
            }
            
            let newImage: Estetica_Images = Estetica_Images(idEstetica: curid, newimage: datosimage.GetcurImage())
           self.image1.image = newImage.imagedata
            
        
            LoadData()
            tableView.dataSource = self.dataSource
            tableView.delegate = self
            
            self.refreshControl = UIRefreshControl()
            self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
            tableView.addSubview(self.refreshControl)
            tableView.rowHeight = 48
            
            
            
            ////
            
            
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
        
       
    
    
    
    }
   

    
    
    func LoadData(){
        
        let IdEstetica = dataAccess.sharedInstance.currentEstetica
        let datapost: String = "idestetica=\(IdEstetica)"
        
        self.dataSource = DataSourceServiciosFixed(cururl: "http://192.168.15.201/nailsalon/app/getservicios.php", posdata: datapost)
        
              
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
    func AgregarFavorito(){
        
     
         let AddFavorite = { (action:UIAlertAction!) -> Void in
            self.AgregaFav()
            
            
            
        }
        
        let alert :UIAlertController = UIAlertController(title: "Agregar a favoritos", message: "Desea añadir esta estetica en su lista de favoritos", preferredStyle: UIAlertControllerStyle.Alert)
        let OkButton : UIAlertAction = UIAlertAction(title: "SI.", style: UIAlertActionStyle.Default, handler: AddFavorite)
        let CancelButton : UIAlertAction = UIAlertAction(title: "NO.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
        
        alert.addAction(OkButton)
        alert.addAction(CancelButton)
        self.presentViewController(alert, animated: false, completion: nil)
        
        
    }
    
    func AgregaFav(){
        
        print("AgregandoFavorio")
        let uuid: String = dataAccess.sharedInstance.UIID
        let curestetica: Int = dataAccess.sharedInstance.currentEstetica

        let datos = SentRequest(curaction: "addfavorito.php")
        datos.AddPosData(DataPost(newItem: "uuid", newValue: uuid))
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curestetica)"))
        datos.ObtenData()
        
        if (datos.result==1){
            print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
            
            
        }

        
        
    }
    
}
