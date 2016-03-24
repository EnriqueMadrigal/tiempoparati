//
//  showtipview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 21/03/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class showtipview: UIViewController {

    var CurrentTip: Int!
    
    @IBOutlet weak var image1: UIImageView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetGradient3(self)
        
        if let CurrentTip = CurrentTip{
           
            
            let datosImage = SentRequest_image(curaction: "getimagetip.php")
            datosImage.AddPosData(DataPost(newItem: "idtip", newValue: "\(CurrentTip)"))
            datosImage.AddPosData(DataPost(newItem: "width", newValue: "240"))
            datosImage.AddPosData(DataPost(newItem: "height", newValue: "320"))
            
            datosImage.ObtenData()
            
            if (datosImage.result==1){
                self.image1.image = UIImage(named: "notavail")
            }
                
                
            else {
                if let curImage: UIImage = datosImage.curimage {
                    
                self.image1.image = curImage
                }
               
                
                
            }
   
            
            
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

    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            //let orient = UIApplication.sharedApplication().statusBarOrientation
            
            
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                //print("rotation completed")
                SetGradient3(self)
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    

    
}
