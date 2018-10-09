//
//  Presenters.swift
//  RKPickerView
//
//  Created by Rayehe on 7/3/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

public protocol RKPickerViewPresenter : class {
    
    var RKSelectedItemHandler : (String) -> Void { get set }
    var RKTitle: String { get set }
    var RKDataSource: [String] { get set }
    var RKStatus: RKPickerDataStatus { get set }
    func showRKPickerView()
}

public extension RKPickerViewPresenter where Self: UIViewController {
    
    public func showRKPickerView() {
        
        guard
            let callerDelegate = self as? RKPickerViewDelegate,
            let callerDatasource = self as? RKPickerViewDataSource else { return }
        
        let pickerVC = RKPickerViewController()
        let transition = transitionManager()
        pickerVC.transitioningDelegate = transition
        
        pickerVC.delegate = callerDelegate
        pickerVC.datasource = callerDatasource
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(pickerVC, animated: true, completion: nil)
        }
    }
}

extension UIViewController : RKPickerViewPresenter {
    
    private struct storedHandler {
        static var _handler : (String) -> Void = { _ in }
    }
    
    public var RKSelectedItemHandler: (String) -> Void {
        get {
            return storedHandler._handler
        }
        set(newValue) {
            storedHandler._handler = newValue
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                if let topVC = topController as? RKPickerViewController {
                    topVC.itemHandler = newValue
                }
            }
        }
    }
    
    private struct storedTitle {
        static var _title : String = "Default Title"
    }
    
    public var RKTitle: String {
        get {
            return storedTitle._title
        }
        set(newValue) {
            storedTitle._title = newValue
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                if let topVC = topController as? RKPickerViewController {
                    topVC.headerTitle = newValue
                }
            }
        }
    }
    
    private struct storedDatasource {
        static var _datasource : [String] = []
    }
    
    public var RKDataSource: [String] {
        get {
            return storedDatasource._datasource
        }
        set(newValue) {
            storedDatasource._datasource = newValue
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                if let topVC = topController as? RKPickerViewController {
                    topVC.tableViewDatasource?.datasource = newValue
                }
            }
        }
    }
    
    private struct storedStatus {
        static var _status : RKPickerDataStatus = .ready
    }
    
    public var RKStatus: RKPickerDataStatus {
        get {
            return storedStatus._status
        }
        set(newValue) {
            storedStatus._status = newValue
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                if let topVC = topController as? RKPickerViewController {
                    topVC.pickerView.reloadData()
                }
            }
        }
    }
}
