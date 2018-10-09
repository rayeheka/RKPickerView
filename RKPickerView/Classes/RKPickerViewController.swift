//
//  RKPickerViewController.swift
//  RKPickerView
//
//  Created by Rayehe on 7/1/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import UIKit

public enum RKPickerDataStatus {
    case loading
    case ready
}

class RKPickerViewController: UIViewController {
    
    let gestureHolderView : UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let closeButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView : UIStackView = {
        let stackview = UIStackView(frame: .zero)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 20.0
        return stackview
    }()
    
    let pickerView : RKPickerView = {
        let tableView = RKPickerView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = RKColors.whiteTwo
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        return tableView
    }()
    
    let submitButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10.0
        button.isEnabled = false
        button.layer.masksToBounds = true
        return button
    }()
    
    var tableViewDelegate : RKPickerTableViewDelegate?
    var tableViewDatasource : RKPickerTableViewDatasource?
    
    var tableViewHeightConstraint = NSLayoutConstraint()
    
    var selectedItem : String?
    
    var delegate : RKPickerViewDelegate?
    
    var datasource : RKPickerViewDataSource?
    
    var headerTitle : String? {
        didSet {
            pickerView.reloadData()
        }
    }
    var itemHandler : ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gestureHolderView)
        view.addSubview(closeButton)
        view.addSubview(stackView)
        stackView.addArrangedSubview(pickerView)
        stackView.addArrangedSubview(submitButton)
        
        tableViewHeightConstraint = pickerView.heightAnchor.constraint(equalToConstant: 67.0)
        let constraints = [
            gestureHolderView.topAnchor.constraint(equalTo: view.topAnchor),
            gestureHolderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gestureHolderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gestureHolderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalToConstant: 30.0),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.73),
            
            submitButton.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 49.0),
            
            pickerView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            tableViewHeightConstraint
        ]
        
        NSLayoutConstraint.activate(constraints)
        self.stackView.layoutIfNeeded()
        
        let frameworkBundle = Bundle(for: RKPickerViewController.self)
        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("RKPickerView.bundle")
        let resourceBundle = Bundle(url: bundleURL!)
        let image = UIImage(named: "RKClose", in: resourceBundle, compatibleWith: nil)
        closeButton.setImage(image, for: .normal)
        
        closeButton.addTarget(self, action: #selector(RKPickerViewController.dismissPickerView), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(RKPickerViewController.submitItemSelection), for: .touchUpInside)
        
        tableViewDelegate = RKPickerTableViewDelegate(vc: self)
        tableViewDatasource = RKPickerTableViewDatasource(vc: self, tableView: pickerView)
        
        pickerView.delegate = tableViewDelegate
        pickerView.dataSource = tableViewDatasource
        
        submitButton.setTitle(datasource?.buttonTitleFor(pickerView), for: .normal)
        submitButton.setTitle(datasource?.buttonTitleFor(pickerView), for: .disabled)
        submitButton.backgroundColor = delegate?.RKPickerDisabledButtonBackgroundColor(pickerView)
        submitButton.titleLabel?.font = delegate?.RKPickerButtonTitleFont(pickerView)
    }
    
    func update(count: Int?) {
        
        guard let count = count else { return }
        if count >= 5 {
            tableViewHeightConstraint.constant = 312.0
        } else if count == 0 {
            tableViewHeightConstraint.constant = 67.0
        } else {
            let height = count * 47 + 70
            tableViewHeightConstraint.constant = CGFloat(height)
        }
        UIView.animate(withDuration: 0.7) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    @objc func dismissPickerView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func submitItemSelection() {
        if let item = selectedItem {
            self.itemHandler?(item)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

internal class LoadingOverlay {
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    internal func showOverlay(view: UIView) {
        
        overlayView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor.white
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
        activityIndicator.startAnimating()
    }
    
    internal func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
