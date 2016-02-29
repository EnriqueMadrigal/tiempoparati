//
//  mapLocation.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 22/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class mapLocation: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var  firstTime: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetBackGroundImage(self)
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
        mapView.showsUserLocation = true
        mapView.delegate = self
       
        LoadData()
        
        //let region = MKCoordinateRegionMakeWithDistance(coordinates!, 200, 200)
        //
        //mapView.setRegion(region, animated: true)
        

        // Do any additional setup after loading the view.
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

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    let location = manager.location
        let latitude: Double = location!.coordinate.latitude
        let longitude: Double = location!.coordinate.longitude
        
        print("current latitude :: \(latitude)")
        print("current longitude :: \(longitude)")
        
        if (self.firstTime){
            
             let region = MKCoordinateRegionMakeWithDistance(location!.coordinate, 4000, 4000)
                mapView.setRegion(region, animated: true)
                print("FirstTime")
                self.firstTime = false
            
            //
            
            
        }
        
    }
    
    
    func LoadData(){
        let datos = SentRequest(curaction: "getlocation.php")
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "0"))
        
        datos.ObtenData()
        
        if (datos.result==1){
            print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "O.K.", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
        }
        
        
        let data = datos.GetJson()
        
        for item in data {
            
            
            let curLocation = Localizacion(json: item as! NSDictionary)
            // let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
            
            if (curLocation.lat != 0.0 || curLocation.lng != 0.0){
                
                //let initialLocation = CLLocation(latitude: curLocation.lng!, longitude: curLocation.lat!)
                //let initialLocation = CLLocation(latitude: -103.425331, longitude: 20.638838)
                //centerMapOnLocation(initialLocation)
                
                
                let artwork = Artwork(title: curLocation.title!,
                    locationName: curLocation.calle! + " " + curLocation.exterior! + " "  + curLocation.interior!,
                    discipline: "Estetica",
                    coordinate: CLLocationCoordinate2D(latitude: curLocation.lng!, longitude: curLocation.lat!),
                    id: curLocation.idestetica!)
                
                mapView.addAnnotation(artwork)
                print(curLocation.idestetica)
                print(artwork.id)
            }

            
            
            
        }

   
        
        
        
    }
   
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                   // .buttonWithType(.DetailDisclosure) as UIView
                print("annotation")
            }
            return view
        }
        return nil
    }

    
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,calloutAccessoryControlTapped control: UIControl) {
            let location = view.annotation as! Artwork
            //let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            //location.mapItem().openInMapsWithLaunchOptions(launchOptions)
            print(location.id)
        print(location.title)
        
        
        
        let oldEstetica = dataAccess.sharedInstance.currentEstetica
        let curEstetica = location.id
     
        if (oldEstetica != curEstetica)
        {
            dataAccess.sharedInstance.currentEstetica = location.id!
        }
        
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Estetica") as! esteticaview
        vc.IdEstetica = location.id
        self.showViewController(vc, sender: nil)

        
    }

    
    
}
