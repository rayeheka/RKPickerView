//
//  RKPickerViewDataSource.swift
//  PickerView
//
//  Created by Rayehe on 7/10/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

public protocol RKPickerViewDataSource : class {
    
    func buttonTitleFor(_ RKpickerView: RKPickerView) -> String
}
