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
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    @IBAction func addComentario(sender: AnyObject) {
      AgregarComentario()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        
        let navControllerheight: CGFloat = self.navigationController!.navigationBar.bounds.height
        let frame1: CGRect = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        let backgroundImage = UIImageView(frame: frame1)
        
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        LoadData()
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshdata:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(self.refreshControl)
        tableView.rowHeight = 60
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        

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
        
        self.dataSource = DataSourceComentariosFixed(cururl: "http://192.168.15.201/nailsalon/app/getcomentarios.php", posdata: datapost)
        
        
        if (self.dataSource.comentarios.count == 0 && self.dataSource.responsecode != 0) {
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
    
    
    //// Agregar comentario
 
    func AgregarComentario(){
        
        
        let AddFavorite = { (action:UIAlertAction!) -> Void in
            self.AgregaCom()
            
            
            
        }
        
        let alert :UIAlertController = UIAlertController(title: "Agregar un comentario", message: "Abstengase de hacer comentarios ofensivos, desea continuar:", preferredStyle: UIAlertControllerStyle.Alert)
     
        let OkButton : UIAlertAction = UIAlertAction(title: "SI.", style: UIAlertActionStyle.Default, handler: AddFavorite)
        let CancelButton : UIAlertAction = UIAlertAction(title: "NO.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
        
        alert.addAction(OkButton)
        alert.addAction(CancelButton)
        self.presentViewController(alert, animated: false, completion: nil)
        
        
    }

    func AgregaCom(){
        print(self.labelComentarios.text)
        print(self.ratingControl.rating)
    
    }
    
    /*
    func addTextField(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "Definition"
        self.newWordField = textField
        
    }
*/

}
