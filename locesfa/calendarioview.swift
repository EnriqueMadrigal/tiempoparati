//
//  calendarioview.swift
//  locesfa
//
//  Created by Enrique Madrigal Gutierrez on 25/02/16.
//  Copyright © 2016 datalabor.com.mx. All rights reserved.
//

import UIKit

class calendarioview: UIViewController {

    @IBOutlet weak var calendarView: NWCalendarView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    SetBackGroundImage(self)
    
    
        calendarView.layer.borderWidth = 1
        calendarView.layer.borderColor = UIColor.lightGrayColor().CGColor
        calendarView.backgroundColor = UIColor.whiteColor()
        calendarView.selectionRangeLength = 1
        calendarView.delegate = self
        calendarView.createCalendar()
        
        datePicker.setValue(UIColor.blackColor(), forKeyPath: "textColor")
        datePicker.backgroundColor = UIColor.brownColor()
        
        print(calendarView.bounds.width)
        print(calendarView.bounds.height)
        
        
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
extension calendarioview: NWCalendarViewDelegate {
    
    func didChangeFromMonthToMonth(fromMonth: NSDateComponents, toMonth: NSDateComponents) {
         let dateFormatter: NSDateFormatter = NSDateFormatter()
        let months = dateFormatter.standaloneMonthSymbols
        let fromMonthName = months[fromMonth.month-1] as String
        let toMonthName = months[toMonth.month-1] as String
         print("Change From '\(fromMonthName)' to '\(toMonthName)'")
        
    }
    func didSelectDate(fromDate: NSDateComponents, toDate: NSDateComponents) {
        print("Selected date '\(fromDate.month)/\(fromDate.day)/\(fromDate.year)' to date '\(toDate.month)/\(toDate.day)/\(toDate.year)'")
        
    }
    
}

