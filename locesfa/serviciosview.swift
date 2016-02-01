//
//  serviciosview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 30/01/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class serviciosview: UIViewController {
    
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelDescripcion: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var curServicio: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        
        let navControllerheight: CGFloat = self.navigationController!.navigationBar.bounds.height
        let frame1: CGRect = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        let backgroundImage = UIImageView(frame: frame1)
        
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)

       
        if let curServicio = curServicio{
            
            
            
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

}
