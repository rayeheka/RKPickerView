//
//  RKPickerTableViewDatasource.swift
//  RKPickerView
//
//  Created by Rayehe on 7/1/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

internal class RKPickerTableViewDatasource: NSObject, UITableViewDataSource {
    
    private unowned var tableView: RKPickerView
    private unowned var vc: RKPickerViewController
    
    var datasource : [String]? {
        didSet {
            tableView.reloadData()
            vc.update(count: datasource?.count)
        }
    }
    
    init(vc: RKPickerViewController, tableView: RKPickerView) {
        self.tableView = tableView
        self.vc = vc
        
        tableView.registerReusableCell(RKPickerTableViewCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch vc.RKStatus {
        case .loading:
            return 0
        default:
            return datasource?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RKPickerTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.delegate = vc.delegate
        cell.titleLabel.text = datasource?[indexPath.row]
        return cell
    }
    
}
