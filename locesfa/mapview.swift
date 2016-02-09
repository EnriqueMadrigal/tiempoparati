//
//  mapview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 09/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit
import MapKit
class mapview: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        
        let navControllerheight: CGFloat = self.navigationController!.navigationBar.bounds.height
        let frame1: CGRect = CGRect(x: 0, y: navControllerheight, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        
        let backgroundImage = UIImageView(frame: frame1)
        
        backgroundImage.image = UIImage(named: "background1")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        ///////
        
        
        let curEstetica: Int = dataAccess.sharedInstance.currentEstetica
        let datos = SentRequest(curaction: "getlocation.php")
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curEstetica)"))

        datos.ObtenData()
        
        if (datos.result==1){
            print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
        }

        
        let data = datos.GetJson()
        print(data)
        
        if let item = data.firstObject{
            
            print(item)
            let curLocation = Localizacion(json: item as! NSDictionary)
           // let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
           
        
            let initialLocation = CLLocation(latitude: curLocation.lng!, longitude: curLocation.lat!)
            //let initialLocation = CLLocation(latitude: -103.425331, longitude: 20.638838)
            centerMapOnLocation(initialLocation)
            
            
            let artwork = Artwork(title: curLocation.title!,
                locationName: curLocation.calle! + " " + curLocation.exterior! + " "  + curLocation.interior!,
                discipline: "Estetica",
                coordinate: CLLocationCoordinate2D(latitude: curLocation.lng!, longitude: curLocation.lat!))
            
            mapView.addAnnotation(artwork)
            
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

    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
}


class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let discipline: String?
    let coordinate: CLLocationCoordinate2D
  
    
    var subtitle: String? {
        get {
            return self.locationName!
        }
    }

    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
               super.init()
    }
    
  }
