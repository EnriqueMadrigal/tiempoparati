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
    
    @IBAction func showCatalogo(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("catalogoView") as! catalogViewController
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
    
    @IBAction func getPeinados(sender: UIButton) {
        //performSegueWithIdentifier("showServicios", sender: nil)
       // let vc :serviciosview = self.storyboard?.instantiateViewControllerWithIdentifier("Servicios") as! serviciosview
         //      self.presentViewController(vc, animated: true, completion: nil)
        
        
        Dialogo.setPos(view.frame.midX - 90, view.frame.midY - 25)
        view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        view.alpha=0.5
        let messageDialog: UIView = Dialogo.showWaitDialog("Un momento")
        view.addSubview(messageDialog)
        self.hasWaitDialog = true

        
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Servicios") as! serviciosview
        //vc.curServicio = 1
        self.showViewController(vc, sender: nil)
            //.showViewController(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func getPromociones(sender: AnyObject) {
      
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Promociones") as! promocionesview
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
    
    @IBAction func getComentarios(sender: AnyObject) {
    
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Comentarios") as! comentariosview
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
    
    @IBAction func getLocation(sender: AnyObject) {
     
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("MapView") as! mapview
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
    
    @IBAction func getProductos(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Productos") as! productosview
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
    
    var CurEstetica: Estetica!
    private lazy var dataSource: DataSourceServiciosFixed! = nil
    var refreshControl:UIRefreshControl!
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        SetBackGroundImage(self)
        
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
            let datosImage = SentRequest_image(curaction: "getimagesalon.php")
            datosImage.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curid)"))
            datosImage.AddPosData(DataPost(newItem: "width", newValue: "240"))
            datosImage.AddPosData(DataPost(newItem: "height", newValue: "240"))
            
            datosImage.ObtenData()
            
            if (datosImage.result==1){
                self.image1.image = UIImage(named: "notavail")
            }
            
            
            else {
            self.image1.image = datosImage.curimage!
            }
            
            
            
        
            LoadData()
            tableView.dataSource = self.dataSource
            tableView.delegate = self
            
            self.refreshControl = UIRefreshControl()
            self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
            self.tableView.addSubview(self.refreshControl)
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            
            
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
