//
//  privacidad.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 01/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class privacidad: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        
        let navControllerheight: CGFloat = self.navigationController!.navigationBar.bounds.height
        let frame1: CGRect = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        let backgroundImage = UIImageView(frame: frame1)
        
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)

        
      
        
        
       
        
        // read aviso de privacidad
        
        if let path = NSBundle.mainBundle().pathForResource("assets/aviso", ofType: "txt", inDirectory: "archivos")
        {
           

            do {
                let text2 = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                print(text2)
            }
            catch let error1 as NSError {
            print ("read error")
                print(error1)
            }
            
        }
        
        else {
            
            print("Could no read file")
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
