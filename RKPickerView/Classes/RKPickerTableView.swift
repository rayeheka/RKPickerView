//
//  RKPickerTableView.swift
//  RKPickerView
//
//  Created by Rayehe on 7/1/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

public class RKPickerView : UITableView {
    
    var title : String = "Default" {
        didSet {
            print(self.title)
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = StyleManager.sharedManager.pickerViewBackgroundColor
        self.layer.cornerRadius = StyleManager.sharedManager.pickerViewCornerRadius
        self.layer.borderColor = StyleManager.sharedManager.pickerViewBorderColor.cgColor
        self.layer.borderWidth = StyleManager.sharedManager.pickerViewBorderWidth
        self.layer.masksToBounds = true
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
