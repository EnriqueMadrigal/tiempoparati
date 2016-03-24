//
//  catalogoviewImage.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 04/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class catalogoviewImage: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var labelDescripcion: UILabel!
    
    var curCatalogo: Catalogos_Esteticas!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      SetBackGroundImage2(self)
        
        if let curCatalogo = curCatalogo{
            
            self.labelDescripcion.text = curCatalogo.descripcion!
            self.labelDescripcion .font = UIFont(name: "Arial", size: 17 * dataAccess.sharedInstance.multiplier)
            self.image1.setNeedsDisplay()
            self.image1.layoutIfNeeded()
            
            let curWidth = Int(self.image1.frame.width)
            let curHeight = Int(self.image1.frame.height)
            
            let datosImage = SentRequest_image(curaction: "getimagecatalogo.php")
            datosImage.AddPosData(DataPost(newItem: "idcatalogo", newValue: "\(curCatalogo.id!)"))
            datosImage.AddPosData(DataPost(newItem: "width", newValue: "\(curWidth)"))
            datosImage.AddPosData(DataPost(newItem: "height", newValue: "\(curHeight)"))
            
            datosImage.ObtenData()
            
            if (datosImage.result==1){
                return
            }
            
            if let newImage: UIImage = datosImage.curimage!{
                self.image1.image = newImage
                
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
                SetBackGroundImage2(self)
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }

    
}
