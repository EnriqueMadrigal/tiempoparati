//
//  catalogViewController.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 04/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class catalogViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    internal var catalogos = [Catalogos_Esteticas]()
    internal var imageCatalogos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      SetBackGroundImage2(self)
        LoadData()

    self.collectionView.dataSource = self
    self.collectionView.delegate = self
        
      //  collectionView!.registerClass(CollectionViewCell1.self, forCellWithReuseIdentifier: "collectionViewCell")
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.collectionView.alpha = 0.8
        //self.view.addSubview(collectionView!)
        
        
        let returnEsteticas = { (action:UIAlertAction!) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        if (self.catalogos.count==0)
        {
            let alert :UIAlertController = UIAlertController(title: "Advertencia", message: "No se encontraron catalogos para la estetica", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: returnEsteticas)
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
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

    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.catalogos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell1 = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! CollectionViewCell1
        cell.backgroundColor = UIColor.blackColor()
        //cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
       
        let curCatalogo = self.catalogos[indexPath.row]
        cell.image1.image = self.imageCatalogos[indexPath.row]
        cell.id = curCatalogo.id!
        return cell
    }
    
    //// flow layoout
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            return CGSize(width: 80 * dataAccess.sharedInstance.multiplier, height: 100 * dataAccess.sharedInstance.multiplier)
    }
    
    //3
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
            
        //let currentcell: CollectionViewCell1 = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell1
        //print(currentcell.id)
        let currentCatalog = self.catalogos[indexPath.row]
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("catalogviewImage") as! catalogoviewImage
        //vc.curServicio = 1
        vc.curCatalogo = currentCatalog
        
        self.showViewController(vc, sender: nil)

        
        
    }
    
    
    func LoadData(){
        
        let datos = SentRequest(curaction: "getcatalogos.php")
        let curEstetica = dataAccess.sharedInstance.currentEstetica
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curEstetica)"))
        
        datos.ObtenData()
        let Catalogos = datos.GetJson()
        
        if (datos.result==1){
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            return
        }

        
        for item in Catalogos {
            self.catalogos.append(Catalogos_Esteticas(json: item as! NSDictionary))
        }
        
        
        
        for curCatalogo in self.catalogos{
        
        //print(curCatalogo.descripcion)
        let datosImage = SentRequest_image(curaction: "getimagecatalogo.php")
        datosImage.AddPosData(DataPost(newItem: "idcatalogo", newValue: "\(curCatalogo.id!)"))
        datosImage.AddPosData(DataPost(newItem: "width", newValue: "80"))
        datosImage.AddPosData(DataPost(newItem: "height", newValue: "100"))
            
        datosImage.ObtenData()
           
            if (datosImage.result==1){
            break
            }
            
        self.imageCatalogos.append(datosImage.curimage!)
        
     
        }
        
        
    }
    
    
    
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
