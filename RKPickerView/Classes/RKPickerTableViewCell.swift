//
//  RKPickerTableViewCell.swift
//  RKPickerView
//
//  Created by Rayehe on 7/1/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

internal class RKPickerTableViewCell : UITableViewCell, Reusable {
    
    let titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var delegate : RKPickerViewDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        guard let pickerView = self.superview as? RKPickerView else { return }
        
        if selected {
            
            self.backgroundColor = delegate?.RKPickerSelectedCellBackgroundColor(pickerView)
            self.titleLabel.textColor = delegate?.RKPickerSelectedCellTitleColor(pickerView)
            self.titleLabel.font = delegate?.RKPickerSelectedCellTitleFont(pickerView)
            
        } else {
            self.backgroundColor = delegate?.RKPickerUnselectedCellBackgroundColor(pickerView)
            self.titleLabel.textColor = delegate?.RKPickerUnselectedCellTitleColor(pickerView)
            self.titleLabel.font = delegate?.RKPickerUnselectedCellTitleFont(pickerView)
        }
    }
}

extension RKPickerTableViewCell : RKPickerViewDelegate {
}
