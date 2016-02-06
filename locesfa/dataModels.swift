//
//  dataModels.swift
//  salonEstudio
//
//  Created by Enrique Madrigal Gutierrez on 29/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import Foundation
import UIKit


class Persona {
    
    var Nombre: String?
    var email: String?
    var sexo: Int?
    
    init(newName: String, newemail: String, newsexo: Int)
    {
        self.Nombre = newName
        self.email = newemail
        self.sexo = newsexo
    }
    
    
}


class DataPost {
    var item: String?
    var value: String?
    init(newItem: String, newValue: String){
        self.item = newItem
        self.value = newValue
    }
    
}

class Estetica {
    var id: Int?
    var title: String?
    var calle :String?
    var exterior: String?
    var interior: String?
    var colonia: String?
    var ciudad: String?
    var estado: String?
    var telefono1: String?
    var idhorario: Int?
    var rate: Int?
    var imageFileName: String?
    var descripcion: String?
    
    
    
    
    init(json: NSDictionary) {
        self.id = Int((json["id"] as? String)!)!
        self.title = json["title"] as? String
        self.calle = json["calle"] as? String
        self.exterior = json["exterior"] as? String
        self.interior = json["interior"] as? String
        self.colonia = json["colonia"] as? String
        self.ciudad = json["ciudad"] as? String
        self.estado = json["estado"] as? String
        self.telefono1 = json["telefono1"] as? String
        self.idhorario = Int((json["idhorario"] as? String)!)!
        self.rate = Int((json["rate"] as? String)!)!
        self.imageFileName = json["imageFileName"] as? String
        self.descripcion = json["descripcion"] as? String
    }
    
}

class Servicio {
    var id: Int?
    var title: String?
    var descripcion: String?
    //var imageFileName: String?
    
   
    init(json: NSDictionary) {
        self.id = Int((json["id"] as? String)!)!
        self.title = json["title"] as? String
        self.descripcion = json["descripcion"] as? String
        //self.imageFileName = json["imageFileName"] as? String
    }
    
}


class SubServicio {
    var id: Int?
    var title: String?
    var descripcion: String?
    var idservicio: Int?
    //var imageFileName: String?
    var costoservicio: Double?
    var tiemposervicio: Int?
    
    
    init(json: NSDictionary) {
        self.id = Int((json["id"] as? String)!)!
        self.title = json["title"] as? String
        self.descripcion = json["descripcion"] as? String
        self.idservicio = Int((json["idservicio"] as? String)!)!
        //self.imageFileName = json["imageFileName"] as? String
        self.costoservicio = Double((json["costoservicio"] as? String)!)!
        self.tiemposervicio = Int((json["tiemposervicio"] as? String)!)!
    }
    
}



class Comentarios_Esteticas {
    var id: Int?
    var idestetica: Int?
    var created: String?
    var nombre: String?
    var comentarios: String?
    var rate: Int?
    var sexo: Int?
    
    
    init(json: NSDictionary) {
        self.id = Int((json["id"] as? String)!)!
        self.idestetica = Int((json["idestetica"] as? String)!)!
        self.rate = Int((json["rate"] as? String)!)!
        self.sexo = Int((json["sexo"] as? String)!)!

        self.created = json["created"] as? String
        self.nombre = json["nombre"] as? String
        self.comentarios = json["comentarios"] as? String
    }
    
}


class Promociones_Esteticas {
    var id: Int?
    var idestetica: Int?
    //var created: String?
    var title: String?
    var descripcion: String?
    
    
    
    init(json: NSDictionary) {
        self.id = Int((json["id"] as? String)!)!
        self.idestetica = Int((json["idestetica"] as? String)!)!
        self.title = json["title"] as? String
        self.descripcion = json["descripcion"] as? String
       
    }
    
}



class Catalogos_Esteticas {
    var id: Int?
    var idestetica: Int?
    var title: String?
    var descripcion: String?
    
    
    init(json: NSDictionary) {
        self.id = Int((json["id"] as? String)!)!
        self.idestetica = Int((json["idestetica"] as? String)!)!
        self.title = json["title"] as? String
        self.descripcion = json["descripcion"] as? String
        
    }
    
}



class Estetica_Images{
    
    var id: Int?
    var imagedata: UIImage?
    
    
    init (idEstetica: Int, newimage: UIImage){
        self.id = idEstetica
        self.imagedata = newimage
    }
    
}

class Servicios_Images{
    
    var id: Int?
    var imagedata: UIImage?
    
    
    init (idServicio: Int, newimage: UIImage){
        self.id = idServicio
        self.imagedata = newimage
    }
}

class Servicios_Estetica{
    var id: Int?
    var descripcion: String?
    var nombre: String?
    
    init(idServicio: Int, Nombre: String, Descripcion: String){
        self.id = idServicio
        self.descripcion = Descripcion
        self.nombre = Nombre
    }
    
}
