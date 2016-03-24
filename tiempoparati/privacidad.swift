//
//  privacidad.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 01/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class privacidad: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         SetGradient3(self)
        
        
        
       
        
        // read aviso de privacidad
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textView.setContentOffset(CGPointZero, animated: false)
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
