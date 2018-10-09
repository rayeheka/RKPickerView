//
//  RKPickerViewDelegate.swift
//  PickerView
//
//  Created by Rayehe on 7/10/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

public protocol RKPickerViewDelegate : class {
    
    func RKPickerTitleColorFor(_ RKpickerView: RKPickerView) -> UIColor
    func RKPickerTitleFontFor(_ RKpickerView: RKPickerView) -> UIFont
    
    func RKPickerSelectedCellBackgroundColor(_ RKpickerView: RKPickerView) -> UIColor
    func RKPickerSelectedCellTitleColor(_ RKpickerView: RKPickerView) -> UIColor
    func RKPickerSelectedCellTitleFont(_ RKpickerView: RKPickerView) -> UIFont
    
    func RKPickerUnselectedCellBackgroundColor(_ RKpickerView: RKPickerView) -> UIColor
    func RKPickerUnselectedCellTitleColor(_ RKpickerView: RKPickerView) -> UIColor
    func RKPickerUnselectedCellTitleFont(_ RKpickerView: RKPickerView) -> UIFont
    
    func RKPickerEnabledButtonBackgroundColor(_ RKpickerView: RKPickerView) -> UIColor
    func RKPickerDisabledButtonBackgroundColor(_ RKpickerView: RKPickerView) -> UIColor
    func RKPickerButtonTitleColor(_ RKpickerView: RKPickerView) -> UIColor
    func RKPickerButtonTitleFont(_ RKpickerView: RKPickerView) -> UIFont
}

extension RKPickerViewDelegate {
    
    func RKPickerTitleColorFor(_ RKpickerView: RKPickerView) -> UIColor {
        return StyleManager.sharedManager.headerTitleColor
    }
    
    func RKPickerTitleFontFor(_ RKpickerView: RKPickerView) -> UIFont {
        return StyleManager.sharedManager.headerFont
    }
    
    func RKPickerSelectedCellBackgroundColor(_ RKpickerView: RKPickerView) -> UIColor {
        return StyleManager.sharedManager.selectedCellBackgroundColor
    }
    
    func RKPickerSelectedCellTitleColor(_ RKpickerView: RKPickerView) -> UIColor {
        return StyleManager.sharedManager.selectedCellTitleColor
    }
    
    func RKPickerSelectedCellTitleFont(_ RKpickerView: RKPickerView) -> UIFont {
        return StyleManager.sharedManager.selectedCellFont
    }
    
    func RKPickerUnselectedCellBackgroundColor(_ RKpickerView: RKPickerView) -> UIColor {
        return StyleManager.sharedManager.unselectedCellBackgroundColor
    }
    
    func RKPickerUnselectedCellTitleColor(_ RKpickerView: RKPickerView) -> UIColor {
        return StyleManager.sharedManager.unselectedCellTitleColor
    }
    
    func RKPickerUnselectedCellTitleFont(_ RKpickerView: RKPickerView) -> UIFont {
        return StyleManager.sharedManager.unselectedCellFont
    }
    
    func RKPickerEnabledButtonBackgroundColor(_ RKpickerView: RKPickerView) -> UIColor {
        return StyleManager.sharedManager.enabledButtonColor
    }
    
    func RKPickerDisabledButtonBackgroundColor(_ RKpickerView: RKPickerView) -> UIColor {
        return StyleManager.sharedManager.disabledButtonColor
    }
    
    func RKPickerButtonTitleColor(_ RKpickerView: RKPickerView) -> UIColor {
        return StyleManager.sharedManager.buttonTextColor
    }
    
    func RKPickerButtonTitleFont(_ RKpickerView: RKPickerView) -> UIFont {
        return StyleManager.sharedManager.buttonFont
    }
    
}
