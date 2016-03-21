//
//  esteticaview.swift
//  encesfa
//
//  Created by Enrique Madrigal Gutierrez on 28/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit
import MapKit

class esteticaview: UIViewController ,UITableViewDelegate{

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelDescripcion: UILabel!
    @IBOutlet weak var labelDireccion: UILabel!
   
    @IBOutlet weak var tel1: CustomButton2!
    @IBOutlet weak var tel2: CustomButton2!
    @IBOutlet weak var tel3: CustomButton1!
    
    
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
        //self.showViewController(vc, sender: nil)
            //.showViewController(vc, animated: true, completion: nil)
        
        dispatch_async(dispatch_get_main_queue()) {
        self.showViewController(vc, sender: nil)
            
            
           // dispatch_async(dispatch_get_main_queue()) {
          //  }
        }
        
        
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
        
       
        
        self.self.Dialogo.setPos(self.view.frame.midX - 90, self.view.frame.midY - 25)
        self.view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        self.view.alpha=0.5
        let messageDialog: UIView = self.Dialogo.showWaitDialog("Un momento")
        self.view.addSubview(messageDialog)
        self.hasWaitDialog = true
       
        
        
        self.showViewController(vc, sender: nil)

        
    
    
    }
    
    @IBAction func getLocation(sender: AnyObject) {
     
        /*
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

        */
        
        
        let curEstetica: Int = dataAccess.sharedInstance.currentEstetica
        let datos = SentRequest(curaction: "getlocation.php")
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curEstetica)"))
        
        datos.ObtenData()
        
        if (datos.result==1){
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
        }
        
        
        let data = datos.GetJson()
        //print(data)
        
        if let item = data.firstObject{
            
           
            let curLocation = Localizacion(json: item as! NSDictionary)
            // let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
            
            if (curLocation.lat != 0.0 || curLocation.lng != 0.0){
                
                //let initialLocation = CLLocation(latitude: curLocation.lng!, longitude: curLocation.lat!)
                //let initialLocation = CLLocation(latitude: -103.425331, longitude: 20.638838)
                //centerMapOnLocation(initialLocation)
                
                
                let artwork = Artwork(title: curLocation.title!,
                    locationName: curLocation.calle! + " " + curLocation.exterior! + " "  +  curLocation.interior!,
                    discipline: "Estetica",
                    coordinate: CLLocationCoordinate2D(latitude: curLocation.lng!, longitude: curLocation.lat!),
                    id: curLocation.idestetica!)
                
                let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                artwork.mapItem().openInMapsWithLaunchOptions(launchOptions)
                
            }
               
            else {
                let alert :UIAlertController = UIAlertController(title: "!Advertencia", message: "No se ha definido, la ubicación:", preferredStyle: UIAlertControllerStyle.Alert)
                let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
                alert.addAction(OkButton)
                self.presentViewController(alert, animated: false, completion: nil)
            }

        
        }
        
        
        
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
    
    
    @IBAction func getCalendario(sender: AnyObject) {

      
        if (self.CurEstetica.citas == 1){
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("citas") as! citasview
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
        
        else {
            
            let alert :UIAlertController = UIAlertController(title: "!Advertencia", message: "No disponible servicio de citas", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
        }
        
        
    }
    
    
    @IBAction func getServices(sender: AnyObject) {
     
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("ServiciosEstetica") as! serviciosestetica
        
        //vc.curServicio = 1
        
        Dialogo.setPos(view.frame.midX - 90, view.frame.midY - 25)
        view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        view.alpha=0.5
        let messageDialog: UIView = Dialogo.showWaitDialog("Un momento")
        view.addSubview(messageDialog)
        self.hasWaitDialog = true
        
        
        self.showViewController(vc, sender: nil)

        
        
    }
    
    @IBAction func callPhone1(sender: AnyObject) {
        
        let telefono1 = self.CurEstetica.telefono1!
        if (telefono1.characters.count > 7){
            
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://" + telefono1)!)
            
         }
        
        else {
            let alert :UIAlertController = UIAlertController(title: "!Advertencia", message: "No se ha definido el número de teléfono", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)

            
        }
        
    }
    
    @IBAction func callPhone2(sender: AnyObject) {
        
        let telefono2 = self.CurEstetica.telefono2!
        if (telefono2.characters.count > 7){
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://" + telefono2)!)
  
        }
            
        else {
            let alert :UIAlertController = UIAlertController(title: "!Advertencia", message: "No se ha definido el número de teléfono", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
            
        }
  
        
    }
    
    
    @IBAction func getHorarios(sender: AnyObject) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("HorariosEstetica") as! horariosview
        
        //vc.curServicio = 1
        
        Dialogo.setPos(view.frame.midX - 90, view.frame.midY - 25)
        view.userInteractionEnabled = false
        //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        view.alpha=0.5
        let messageDialog: UIView = Dialogo.showWaitDialog("Un momento")
        view.addSubview(messageDialog)
        self.hasWaitDialog = true
        
        
        self.showViewController(vc, sender: nil)

        
    }
    
    
    
    
    var CurEstetica: Estetica!
    private lazy var dataSource: DataSourceServiciosFixed! = nil
    var refreshControl:UIRefreshControl!
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    var IdEstetica: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        SetBackGroundImage(self)
        //SetBackGroundImage2(self)
        if let CurEstetica = CurEstetica{
            self.labelNombre.text = CurEstetica.title!
            self.labelDescripcion.text = CurEstetica.descripcion!
            self.labelDescripcion.numberOfLines = 0
            self.labelDescripcion.lineBreakMode = .ByWordWrapping
            self.IdEstetica = CurEstetica.id!
            
            let calle = self.CurEstetica.calle! + " " + self.CurEstetica.exterior! + " " + self.CurEstetica.interior!
            let colonia = self.CurEstetica.colonia!
            let ciudad = self.CurEstetica.ciudad!
            let estado = self.CurEstetica.estado!
            
            let direccion = calle + " " + colonia + " " + ciudad + " " + estado
            
            self.labelDireccion.text = direccion
            
            let telefono1 = self.CurEstetica.telefono1
            tel1.setTitle(telefono1, forState: UIControlState.Normal)

            let telefono2 = self.CurEstetica.telefono2
            tel2.setTitle(telefono2, forState: UIControlState.Normal)

            
             }
        
        
        
        ///// Si viene del Mapa
        else if let IdEstetica = IdEstetica
        {
            
         let datosEstetica = SentRequest(curaction: "getsalons.php")
            datosEstetica.AddPosData(DataPost(newItem: "idestetica", newValue: "\(IdEstetica)"))
            datosEstetica.AddPosData(DataPost(newItem: "tipo", newValue: "5"))
     
          datosEstetica.ObtenData()
            if (datosEstetica.result == 1){
                //print ("No se encontro el servidor")
                let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
                let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
                alert.addAction(OkButton)
                self.presentViewController(alert, animated: false, completion: nil)
            }
            
       let data = datosEstetica.GetJson()
            if let item  = data.firstObject {
                self.CurEstetica = Estetica(json: item as! NSDictionary)
                self.labelNombre.text = CurEstetica.title!
                self.labelDescripcion.text = CurEstetica.descripcion!
                self.labelDescripcion.numberOfLines = 0
                self.labelDescripcion.lineBreakMode = .ByWordWrapping
                self.IdEstetica = CurEstetica.id!
                
                let calle = self.CurEstetica.calle! + " " + self.CurEstetica.exterior! + " " + self.CurEstetica.interior!
                let colonia = self.CurEstetica.colonia!
                let ciudad = self.CurEstetica.ciudad!
                let estado = self.CurEstetica.estado!
                
                let direccion = calle + colonia + ciudad + estado
                
                self.labelDireccion.text = direccion
               let telefono1 = self.CurEstetica.telefono1
                tel1.setTitle(telefono1, forState: UIControlState.Normal)
                let telefono2 = self.CurEstetica.telefono2
                tel2.setTitle(telefono2, forState: UIControlState.Normal)
                
            }
            
            
            
            
        }
        
        
        
            let datosImage = SentRequest_image(curaction: "getimagesalon.php")
            datosImage.AddPosData(DataPost(newItem: "idestetica", newValue: "\(self.IdEstetica!)"))
            datosImage.AddPosData(DataPost(newItem: "width", newValue: "240"))
            datosImage.AddPosData(DataPost(newItem: "height", newValue: "240"))
            
            datosImage.ObtenData()
            
            if (datosImage.result==1){
                self.image1.image = UIImage(named: "notavail")
            }
            
            
            else {
            self.image1.image = datosImage.curimage!
            }
            
            
        
            ////
            
            
        
        
        
        
        
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
        
    }
   

    
    
   
    
    
    ////// Delegate
    
    /*
    Dialogo.setPos(view.frame.midX - 90, view.frame.midY - 25)
    view.userInteractionEnabled = false
    //view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    view.alpha=0.5
    let messageDialog: UIView = Dialogo.showWaitDialog("Un momento")
    view.addSubview(messageDialog)
    self.hasWaitDialog = true

*/
   
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("willAppear")
        //SetBackGroundImage(self)
        setGradient2(self)
        //SetBackGroundImage2(self)
        
    }
    
 
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
               if (self.hasWaitDialog){
            Dialogo.closeWaitDialog()
            view.alpha = 1.0
            view.userInteractionEnabled = true
            self.hasWaitDialog = false
        }
        //SetBackGroundImage(self)
        //SetBackGroundImage2(self)
    }
    func AgregarFavorito(){
        
     
         let AddFavorite = { (action:UIAlertAction!) -> Void in
            self.AgregaFav()
        }
   
        
        let DelFavorite = { (action:UIAlertAction!) -> Void in
            self.BorraFav()
        }
        
        
        
        let alert :UIAlertController = UIAlertController(title: "Agregar a favoritos", message: "Desea que la estetica este su lista de favoritos", preferredStyle: UIAlertControllerStyle.Alert)
        let OkButton : UIAlertAction = UIAlertAction(title: "SI.", style: UIAlertActionStyle.Default, handler: AddFavorite)
        let CancelButton : UIAlertAction = UIAlertAction(title: "NO.", style: UIAlertActionStyle.Default, handler: DelFavorite)
        
        alert.addAction(OkButton)
        alert.addAction(CancelButton)
        self.presentViewController(alert, animated: false, completion: nil)
        
        
    }
    
    func AgregaFav(){
        
        //print("AgregandoFavorio")
        let uuid: String = dataAccess.sharedInstance.UIID
        let curestetica: Int = dataAccess.sharedInstance.currentEstetica

        let datos = SentRequest(curaction: "addfavorito.php")
        datos.AddPosData(DataPost(newItem: "uuid", newValue: uuid))
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curestetica)"))
        datos.ObtenData()
        
        if (datos.result==1){
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
        }
      
    }
  
    
    func BorraFav(){
        
        //print("AgregandoFavorio")
        let uuid: String = dataAccess.sharedInstance.UIID
        let curestetica: Int = dataAccess.sharedInstance.currentEstetica
        
        let datos = SentRequest(curaction: "delfavorito.php")
        datos.AddPosData(DataPost(newItem: "uuid", newValue: uuid))
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curestetica)"))
        datos.ObtenData()
        
               
        if (datos.result==1){
            print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
        }
        
    }
    
    
    
    
}
