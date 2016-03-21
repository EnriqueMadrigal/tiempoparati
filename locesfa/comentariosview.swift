//
//  comentariosview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 05/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class comentariosview: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var hasrefresh: Bool = false
    var hasWaitDialog: Bool = false
    
    private lazy var dataSource: DataSourceComentariosFixed! = nil
    var refreshControl:UIRefreshControl!
    

    @IBOutlet weak var labelComentarios: UITextView!
    //@IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var ratingView: UIView!
    
    
    @IBAction func addComentario(sender: AnyObject) {
      AgregarComentario()
    }
    
    
    var ratingControl: RatingControl!
    var ratingwidth: CGFloat = 0.0
    var ratingheight: CGFloat = 0.0
    var hasratinginit: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         SetBackGroundImage(self)
        
        self.ratingwidth = self.ratingView.frame.width
        self.ratingheight = self.ratingView.frame.height
        
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
    

    
    ///Delegate
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let curHeight:CGFloat = (42.0 + 36.0) * dataAccess.sharedInstance.multiplier
        return curHeight
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
        
          dispatch_async(dispatch_get_main_queue()){
        let IdEstetica = dataAccess.sharedInstance.currentEstetica
        let datapost: String = "idestetica=\(IdEstetica)"
        
        self.dataSource = DataSourceComentariosFixed(cururl: "getcomentarios.php", posdata: datapost)
        
        
        if (self.dataSource.comentarios.count == 0 && self.dataSource.responsecode != 0) {
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
        }
        
        self.dataSource.setTableView(self.tableView)
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
        }
        
        
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
    
    
    //// Agregar comentario
 
    func AgregarComentario(){
     
        
        let uuid: String = dataAccess.sharedInstance.UIID
        let name: String = dataAccess.sharedInstance.curPersona.Nombre!
        let comentario: String = self.labelComentarios.text!
        let curEstetica: Int = dataAccess.sharedInstance.currentEstetica
        let sexo: Int = dataAccess.sharedInstance.curPersona.sexo!
        let rating: Int = self.ratingControl.rating
        
        
        if (name.characters.count<4){
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su nombre en preferencias!:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            return
        }
        
        
        if (comentario.characters.count<4){
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Debe de ser un comentario valido!:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            return
        }
        
        
        
        let datos = SentRequest(curaction: "addcomentario.php")
        datos.AddPosData(DataPost(newItem: "uuid", newValue: uuid))
        datos.AddPosData(DataPost(newItem: "name", newValue: name))
        datos.AddPosData(DataPost(newItem: "comentario", newValue: comentario))
        datos.AddPosData(DataPost(newItem: "sexo", newValue: "\(sexo)" ))
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curEstetica)"))
        datos.AddPosData(DataPost(newItem: "rate", newValue: "\(rating)"))
        
        datos.ObtenData()
        
        if (datos.result==1){
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
            
            
        }

        self.ratingControl.rating = 0
        self.labelComentarios.text = ""
        
        self.refreshControl.beginRefreshing()
        LoadData()
        self.refreshControl.endRefreshing()
        
        
    }
        
        
        
    /*
    func addTextField(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "Definition"
        self.newWordField = textField
        
    }
*/

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        if (self.ratingView.frame.width == self.ratingwidth)  // Todavia no se tiene el tamaño correcto
        {
            return
        }
        
        if (self.hasratinginit == false){
            self.hasratinginit = true
            self.configureRatingControl()
        }
    }
    
    func configureRatingControl(){
        
        self.ratingControl = RatingControl(frame: self.ratingView.frame)
        self.ratingView.addSubview(self.ratingControl)
        
    }

    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
             SetBackGroundImage(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("willAppear")
        //SetBackGroundImage(self)
        //setGradient2(self)
        //SetBackGroundImage2(self)
        
        
        
        
    }

    
    
}
