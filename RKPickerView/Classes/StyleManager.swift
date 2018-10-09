//
//  StyleManager.swift
//  RKPickerView
//
//  Created by Rayehe on 7/8/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

internal class StyleManager {
    static let sharedManager = StyleManager()
    
    var pickerViewCornerRadius : CGFloat = CGFloat(10.0)
    var pickerViewBackgroundColor : UIColor = UIColor.white
    var pickerViewBorderColor : UIColor = RKColors.grayColor
    var pickerViewBorderWidth : CGFloat = CGFloat(1.0)
    
    var headerFont : UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    var headerTitleColor : UIColor = .black
    
    var selectedCellFont : UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    var selectedCellTitleColor : UIColor = .white
    var selectedCellBackgroundColor : UIColor = RKColors.dodgerBuleColor
    
    var unselectedCellFont : UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    var unselectedCellTitleColor : UIColor = RKColors.greyishBrown
    var unselectedCellBackgroundColor : UIColor = .white
    
    var buttonFont : UIFont = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
    var buttonTextColor : UIColor = UIColor.white
    var enabledButtonColor : UIColor = RKColors.dodgerBuleColor
    var disabledButtonColor : UIColor = UIColor.lightGray
}
