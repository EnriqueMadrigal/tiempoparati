//
//  ObtenPersona.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 02/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ObtenPesona {
    
    private var curPersona: Persona!

    init()
    {
     
        
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
            
                var sexo: Int = 0
                if (female){
                    sexo = 1
                }
            
                else {
                    sexo = 0
                }
      self.curPersona = Persona(newName: nombre, newemail: email, newsexo: sexo)
            }
            
        
        }
        
        
        }
    
    
    func GetPerson()->Persona{
        
        return self.curPersona
        
    }
    
}