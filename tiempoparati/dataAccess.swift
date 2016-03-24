//
//  dataAccess.swift
//  salonEstudio
//
//  Created by Enrique Madrigal Gutierrez on 30/12/15.
//  Copyright © 2015 datalabor.com.mx. All rights reserved.
//

import Foundation

import UIKit

class dataAccess {
    
    let testvar = 100
    var currentEstetica = 0
    
    var multiplier: CGFloat = 1.0
    
   var UIID: String = ""
    var curPersona: Persona!
    var curScreen: ScreenBounds!
    var curOrientation: String!
    var curScale: CGFloat = 1.0
    
    //let curUrl: String = "http://189.208.124.8:8080/nailsalon/app/"
    
    //let curUrl: String = "http://192.168.15.201/nailsalon/app/"
    let curUrl: String = "http://www.expimed.com.mx/nailsalon/app/"
    
    
    static let sharedInstance = dataAccess()
    
    private init() {
        //print(__FUNCTION__)
    }
    
    
}
