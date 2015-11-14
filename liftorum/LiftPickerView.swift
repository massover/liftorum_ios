//
//  LiftPickerView.swift
//  liftorum
//
//  Created by Voxy on 11/14/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

class LiftPickerView:
    UIPickerView,
    UIPickerViewDataSource,
    UIPickerViewDelegate
{
    
    var pickerDataSource = ["Squat", "Bench", "Deadlift"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func getSelectedLiftName() -> String{
        let row = self.selectedRowInComponent(0)
        return pickerDataSource[row]
    }
    
}