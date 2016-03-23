//
//  citasview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 02/03/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class citasview: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func agendaCita(sender: AnyObject) {
        
       let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
       let vc = mainStoryboard.instantiateViewControllerWithIdentifier("calendario") as! calendarioview
        
        self.showViewController(vc, sender: nil)
        //.showViewController(vc, animated: true, completion: nil)
    }
 
    
    
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    
    private lazy var dataSource: DataSourceCitasFixed! = nil
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
        //tableView.rowHeight = 60
        //tableView.estimatedRowHeight = 100
        //tableView.rowHeight = UITableViewAutomaticDimension
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

    
    ///Delegate
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let curHeight:CGFloat = (42.0) * dataAccess.sharedInstance.multiplier
        return curHeight
    }
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let row = indexPath.row
        
        let currentCita = self.dataSource.citas[row]
        
        
        //let cell: customTableView2 = tableView.cellForRowAtIndexPath(indexPath) as! customTableView2
        
        //print(cell.id!)
        //print(currentCita.id!)
        let estatuscita: Int = currentCita.idestatuscita!
        let idcita: Int = currentCita.id!
        
        
        
    
       let ConfirmaCita = { (action:UIAlertAction!) -> Void in
                //self.AgregaFav()
                //print("Confirmar Cita")
                self.ConfirmarCita(idcita)
            }
        
        
        let CancelaCita = { (action:UIAlertAction!) -> Void in
            //self.AgregaFav()
            //print("Cancelar Cita")
            self.CancelarCita(idcita)
        }
        
       
        let Cancelar = { (action:UIAlertAction!) -> Void in
            //self.AgregaFav()
            //print("Cancelar")
        }
        
        
        
        switch estatuscita {
        case  1:
            let alert1 :UIAlertController = UIAlertController(title: "Información:", message: "La estetica aún no ha confirmado su cita, desea cancelarla?:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton1 : UIAlertAction = UIAlertAction(title: "Si", style: UIAlertActionStyle.Default, handler: CancelaCita)
            let CancelButton1 : UIAlertAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: Cancelar)

            alert1.addAction(OkButton1)
            alert1.addAction(CancelButton1)
            self.presentViewController(alert1, animated: false, completion: nil)
  
            
        case  2:
            let alert2 :UIAlertController = UIAlertController(title: "Confirmar o cancelar", message: "Desea confirmar o cancelar esta cita?", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton2 : UIAlertAction = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.Default, handler: ConfirmaCita)
            let CancelButton2 : UIAlertAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Default, handler: CancelaCita)
            
            alert2.addAction(OkButton2)
            alert2.addAction(CancelButton2)
            self.presentViewController(alert2, animated: false, completion: nil)

        case 3:
            let alert3 :UIAlertController = UIAlertController(title: "Información:", message: "La estetica cancelo esta cita:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton3 : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: Cancelar)
            alert3.addAction(OkButton3)
            self.presentViewController(alert3, animated: false, completion: nil)
       
        case 4:
            let alert4 :UIAlertController = UIAlertController(title: "Información:", message: "El usuario cancelo esta cita:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton4 : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: Cancelar)
            alert4.addAction(OkButton4)
            self.presentViewController(alert4, animated: false, completion: nil)
        
        case  5:
            let alert5 :UIAlertController = UIAlertController(title: "Información:", message: "Esta cita ya esta confirmada, desea cancelarla?:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton5 : UIAlertAction = UIAlertAction(title: "Si", style: UIAlertActionStyle.Default, handler: CancelaCita)
            let CancelButton5 : UIAlertAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: Cancelar)
            
            alert5.addAction(OkButton5)
            alert5.addAction(CancelButton5)
            self.presentViewController(alert5, animated: false, completion: nil)
            
        case  6:
            let alert6 :UIAlertController = UIAlertController(title: "Información:", message: "Esta cita ya fue realizada:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton6 : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: Cancelar)
            alert6.addAction(OkButton6)
            self.presentViewController(alert6, animated: false, completion: nil)
            
        case  7:
            let alert7 :UIAlertController = UIAlertController(title: "Información:", message: "El usuario no se presento en la cita:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton7 : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: Cancelar)
            alert7.addAction(OkButton7)
            self.presentViewController(alert7, animated: false, completion: nil)
            
            
            
            
        default: break
            
             }

        
        
        
        
        
            

        
        
        
        
    }
    

    
    
    
    
    //////

   
    func LoadData(){
        
        let IdEstetica = dataAccess.sharedInstance.currentEstetica
        let uuid = dataAccess.sharedInstance.UIID
        
        let datapost: String = "idestetica=\(IdEstetica)&uuid=" + uuid
        
        self.dataSource = DataSourceCitasFixed(cururl: "getcitas.php", posdata: datapost)
        
        
        if (self.dataSource.citas.count == 0 && self.dataSource.responsecode != 0) {
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
        }
        
        self.dataSource.setTableView(self.tableView)
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
        
        
        
    }

    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (self.hasrefresh){
            return
        }
        //print("Scroll")
        self.refreshControl.beginRefreshing()
        LoadData()
        self.refreshControl.endRefreshing()
        
        
        
    }

    func refreshdata(sender:AnyObject) {
        //print("refresh")
        self.hasrefresh = true
        self.refreshControl.beginRefreshing()
        LoadData()
        self.refreshControl.endRefreshing()
        
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.refreshControl.beginRefreshing()
        LoadData()
        //self.refreshControl.endRefreshing()

    
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("willAppear")
        //SetBackGroundImage(self)
        //setGradient2(self)
        SetBackGroundImage2(self)
        //SetBackGroundImage2(self)
        
    }

    
    func CancelarCita(idcita: Int){
        let datos = SentRequest(curaction: "updatecita.php")
        datos.AddPosData(DataPost(newItem: "id", newValue: "\(idcita)"))
        datos.AddPosData(DataPost(newItem: "estatuscita", newValue: "4"))
        
        datos.ObtenData()
        
        if (datos.result==1){
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
        }
        

        LoadData()
        
        
    }
    
    func ConfirmarCita(idcita: Int) {
   
        let datos = SentRequest(curaction: "updatecita.php")
        datos.AddPosData(DataPost(newItem: "id", newValue: "\(idcita)"))
        datos.AddPosData(DataPost(newItem: "estatuscita", newValue: "5"))
        
        datos.ObtenData()
        
        if (datos.result==1){
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
        }
        
        
        LoadData()
        
        
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
