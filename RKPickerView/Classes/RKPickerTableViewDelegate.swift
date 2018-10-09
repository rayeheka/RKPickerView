//
//  RKPickerTableViewDelegate.swift
//  RKPickerView
//
//  Created by Rayehe on 7/1/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

internal class RKPickerTableViewDelegate : NSObject, UITableViewDelegate {
    
    private unowned var vc: RKPickerViewController
    
    init(vc: RKPickerViewController) {
        self.vc = vc
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 67.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch vc.RKStatus {
        case .loading:
            let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 67.0))
            LoadingOverlay.shared.showOverlay(view: view)
            return view
            
        case .ready:
            let view = RKPickerHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 67.0))
            view.titleLabel.text = vc.headerTitle
            view.titleLabel.font = vc.delegate?.RKPickerTitleFontFor(vc.pickerView)
            view.titleLabel.textColor = vc.delegate?.RKPickerTitleColorFor(vc.pickerView)
            return view
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if
            let datasource = vc.tableViewDatasource?.datasource,
            datasource.count != 0
        {
            vc.selectedItem = datasource[indexPath.row]
            vc.submitButton.isEnabled = true
            
            vc.submitButton.backgroundColor = vc.delegate?.RKPickerEnabledButtonBackgroundColor(vc.pickerView)
        }
    }
    
}
