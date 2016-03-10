//
//  preferencias.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 01/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit
import CoreData

class preferencias: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelNombre: UITextField!
    @IBOutlet weak var labelEmail: UITextField!
    @IBOutlet weak var segment1: UISegmentedControl!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    
    
    
    @IBAction func enableEmail(sender: AnyObject) {
        
        if(self.switch2.on){
            
            self.labelEmail.enabled = true
        }
        
        else {
            
            self.labelEmail.enabled = false
            self.labelEmail.text = ""
        }
    }
    
    @IBAction func saveData(sender: AnyObject) {
        print("Saving")
        if (SavePreferences()){
          navigationController?.popViewControllerAnimated(true)
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       SetBackGroundImage(self)        
        loadDatos()
        
        self.labelEmail.delegate = self
        self.labelNombre.delegate = self
        
        
        
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

    func SavePreferences()->Bool{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        var people: [NSManagedObject]!
        
        
        // Revisar sexo
        
        let cursexo: Int = self.segment1.selectedSegmentIndex
        var sexo: Bool = false
        if (cursexo==0) {
            sexo = false
        }
        
        if (cursexo==1){
            sexo=true
        }
        
        
        // Revisar promocion
        let promocion = self.switch1.on
        let promocionemail = self.switch2.on
        
        // Revisar Nombre
        let nombre:String = self.labelNombre.text!
        if(nombre.characters.count < 5){
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Nombre invalido", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            return false
        }
        
        // Revisar Email
        let email: String = self.labelEmail.text!
        
        
        
        
        if (promocionemail)
        {
            let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let result: Bool = emailTest.evaluateWithObject(email)
            
            if (!result){
            let alert1 :UIAlertController = UIAlertController(title: "ERROR", message: "Direcciòn de correo invalida", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton1 : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert1.addAction(OkButton1)
            self.presentViewController(alert1, animated: false, completion: nil)
            return false
            
        }
        }
        
        
        //2
        let entity =  NSEntityDescription.entityForName("Person",inManagedObjectContext:managedContext)
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return false
        }
        
        /////// delete first if exists
        if (people.count>0){
        managedContext.deleteObject(people.first!)
        print("deleting")
        }
        
        
        
        do {
        try managedContext.save()
      
        
    } catch let error as NSError  {
    print("Could not delete \(error), \(error.userInfo)")
    }

    ///// insert
        
        
        let person = NSManagedObject(entity: entity!,insertIntoManagedObjectContext: managedContext)
        person.setValue(nombre, forKey: "nombre")
        person.setValue(email, forKey: "email")
        person.setValue(sexo, forKey: "female")
        person.setValue(promocion, forKey: "recibir_prom")
        person.setValue(promocionemail, forKey: "recibir_email")
        
        
        
        do {
                try managedContext.save()
                //5
                people.append(person)
            
            let newPersona: Persona = Persona(newName: nombre, newemail: email, newsexo: cursexo)
            dataAccess.sharedInstance.curPersona = newPersona
            
            UpdateUser(newPersona, recibir_p: promocion, recibir_e: promocionemail)
            
            
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        
        return true
    }
    
    func loadDatos(){
     var people: [NSManagedObject]!
       
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
//print(people.count)
        
        if (people.count==1){
            
            
            if let element: NSManagedObject = people.first {
                let nombre: String = (element.valueForKey("nombre") as? String)!
                let email: String = (element.valueForKey("email") as? String)!
                let female: Bool = (element.valueForKey("female") as? Bool)!
                let recibir_prom: Bool = (element.valueForKey("recibir_prom") as? Bool)!
                let recibir_email: Bool = (element.valueForKey("recibir_email") as? Bool)!
              
                
                self.labelNombre.text = nombre
                self.labelEmail.text = email
                var sexo: Int = 0
                
                
                if (female){
                    sexo = 1
                }
                else {
                    sexo = 0
                }
                
                self.segment1.selectedSegmentIndex = sexo
                
                self.switch1.on = recibir_prom
                self.switch2.on = recibir_email
                
                if (email.characters.count>5){
                    
                    self.labelEmail.enabled = true
                    
                }
                
            }
            
            
        }
        
        
    }
   
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       loadDatos()
    }
    
    
    func UpdateUser(newPersona: Persona, recibir_p: Bool, recibir_e: Bool){
        
        let uuid: String = dataAccess.sharedInstance.UIID
       // let datos = GetData()
       // var posdata: String = ""
        var recibir_prom: Int = 0
        var recibir_email: Int = 0
        
        if (recibir_p){
            recibir_prom = 1
        }
        
        if (recibir_e){
            recibir_email = 1
        }
        
        
        let datos = SentRequest(curaction: "updateuser.php")
        datos.AddPosData(DataPost(newItem: "uuid", newValue: uuid))
        datos.AddPosData(DataPost(newItem: "name", newValue: newPersona.Nombre!))
        datos.AddPosData(DataPost(newItem: "email", newValue: newPersona.email!))
        datos.AddPosData(DataPost(newItem: "sexo", newValue: "\(newPersona.sexo!)" ))
        datos.AddPosData(DataPost(newItem: "recibir_prom", newValue: "\(recibir_prom)"))
        datos.AddPosData(DataPost(newItem: "recibir_email", newValue: "\(recibir_email)"))
        
        datos.ObtenData()
        
        if (datos.result==1){
            print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
            
            
        }
        
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        print("Enter")
        return true;
    }

    
}
