//
//  calendarioview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 25/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class calendarioview: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var viewCalendar: UIView!
       @IBOutlet weak var datePicker: UIDatePicker!
   
    @IBOutlet weak var textView: UITextField!
  
    @IBAction func Aceptar(sender: AnyObject) {
      AgregaCita()
    }
    
    @IBAction func setDate(sender: AnyObject) {
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: self.datePicker.date)
        self.selectedHour = comp.hour
        self.selectedMin = comp.minute
    }
    var calendarView: NWCalendarView!
    var selectedYear: Int = 0
    var selectedMonth: Int = 0
    var selectedDay: Int = 0
    
    var selectedHour: Int = 0
    var selectedMin: Int = 0
    var hasSelectedDate: Bool = false
    
    
    var hascalendarcreated: Bool = false
    
    var newCalendarWidth: CGFloat = 0.0
    var newCalendarHeight: CGFloat = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    SetBackGroundImage(self)
    
     
           
        //viewCalendar.setNeedsLayout()
        //viewCalendar.layoutIfNeeded()
        
        self.newCalendarWidth = self.viewCalendar.frame.width
        self.newCalendarHeight = self.viewCalendar.frame.height
        
        
        
        
        //viewCalendar.layer.borderWidth = 1
        //viewCalendar.layer.borderColor = UIColor.lightGrayColor().CGColor
        //viewCalendar.backgroundColor = UIColor.whiteColor()
        //viewCalendar.selectionRangeLength = 1
        //viewCalendar.delegate = self
        //viewCalendar.createCalendar()
        
        
        datePicker.setValue(UIColor.blackColor(), forKeyPath: "textColor")
        datePicker.backgroundColor = UIColor.brownColor()
        
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: self.datePicker.date)
        self.selectedHour = comp.hour
        self.selectedMin = comp.minute
        
        self.textView.delegate = self
        
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

    
    func AgregaCita(){
        
        let uuid: String = dataAccess.sharedInstance.UIID
        let name: String = dataAccess.sharedInstance.curPersona.Nombre!
        let comentarios: String = self.textView.text!
        let curEstetica: Int = dataAccess.sharedInstance.currentEstetica
        
        
        if (name.characters.count<4){
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su nombre en preferencias!:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            return
        }
        
        
        if (comentarios.characters.count<4){
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Debe de ser un comentario valido!:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            return
        }
        
        if (!hasSelectedDate){
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Debe seleccionar la fecha!:", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            return
        }
        
       
        
        
        let curDate = NSDate(day: self.selectedDay, month: self.selectedMonth, year: self.selectedYear, hour: self.selectedHour, min: self.selectedMin)
        //print(curDate.formattedISO8601)
        
        
       
        let datos = SentRequest(curaction: "addcita.php")
        datos.AddPosData(DataPost(newItem: "uuid", newValue: uuid))
        datos.AddPosData(DataPost(newItem: "idestetica", newValue: "\(curEstetica)"))
        datos.AddPosData(DataPost(newItem: "comentarios", newValue: comentarios))
        datos.AddPosData(DataPost(newItem: "idtipocita", newValue: "1"))
        datos.AddPosData(DataPost(newItem: "start_time", newValue: curDate.formattedISO8601))

        
        datos.ObtenData()

        //print(datos.GetJson())


        if (datos.result==1){
            //print ("No se encontro el servidor")
            let alert :UIAlertController = UIAlertController(title: "ERROR", message: "Favor de verificar su conexiòn de datos", preferredStyle: UIAlertControllerStyle.Alert)
            let OkButton : UIAlertAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in print("Foo")})
            alert.addAction(OkButton)
            self.presentViewController(alert, animated: false, completion: nil)
            
            
            
        }
       
        
        
        self.navigationController?.popViewControllerAnimated(true)
       
        
    }
    
    
    
    
}




extension calendarioview: NWCalendarViewDelegate {
    
    func didChangeFromMonthToMonth(fromMonth: NSDateComponents, toMonth: NSDateComponents) {
         //let dateFormatter: NSDateFormatter = NSDateFormatter()
        //let months = dateFormatter.standaloneMonthSymbols
        //let fromMonthName = months[fromMonth.month-1] as String
        //let toMonthName = months[toMonth.month-1] as String
         //print("Change From '\(fromMonthName)' to '\(toMonthName)'")
        
    }
    func didSelectDate(fromDate: NSDateComponents, toDate: NSDateComponents) {
        //print("Selected date '\(fromDate.month)/\(fromDate.day)/\(fromDate.year)' to date '\(toDate.month)/\(toDate.day)/\(toDate.year)'")
        
        self.selectedDay = fromDate.day
        self.selectedMonth = fromDate.month
        self.selectedYear = fromDate.year
        self.hasSelectedDate = true
               
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        //print("Enter")
        return true;
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        if (self.viewCalendar.frame.width == self.newCalendarWidth)  // Todavia no se tiene el tamaño correcto
        {
            return
        }
     
        if (self.hascalendarcreated == false){
            self.CreateCorrectCalendar()
        }
    }
    
   
    func CreateCorrectCalendar(){
        
    self.hascalendarcreated = true
     
        calendarView = NWCalendarView(frame: self.viewCalendar.frame)
        calendarView.layer.borderWidth = 1
        calendarView.layer.borderColor = UIColor.lightGrayColor().CGColor
        calendarView.backgroundColor = UIColor.whiteColor()
        calendarView.selectionRangeLength = 1
        calendarView.delegate = self
        calendarView.createCalendar()
        
        
        viewCalendar.addSubview(calendarView)
        viewCalendar.layoutSubviews()
        

        
    }
    
    
}

