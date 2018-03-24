//
//  AlertViewController.swift
//  TableViewCheckMark
//
//  Created by Yuta S. on 2018/03/24.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let sectionList = ["項目選択"]
    let cellText = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]]
    
    var defaultAction: UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.setEditing(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlertMessage() {
        let alertController: UIAlertController = UIAlertController(title: "選択", message: "項目を選択してください。", preferredStyle: .alert)
        
        let height = NSLayoutConstraint(item: alertController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.80)
        alertController.view.addConstraint(height)
        
        self.tableView.reloadData()
        
        
        defaultAction = UIAlertAction(title: "OK", style: .default) { action in
            let selectedRows = self.tableView.indexPathsForSelectedRows
            let selectedData = selectedRows?.map { self.cellText[$0.section][$0.row] }
            let selectedSortedData = selectedData?.sorted()
            print(selectedSortedData!)
        }
        defaultAction?.isEnabled = false
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction!)
        
        self.present(alertController, animated: true) {
            self.tableView.top = alertController.view.top + 25
            self.tableView.frame.size.width = alertController.view.frame.width
            self.tableView.frame.size.height = (alertController.view.frame.height - self.tableView.top) - 45
            alertController.view.addSubview(self.tableView)
        }
    }
    
    @IBAction func tappedAlertMessageButton(_ sender: UIButton) {
        showAlertMessage()
    }
}

extension AlertViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellText[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel?.text = cellText[indexPath.section][indexPath.row]
        cell.multipleSelectionBackgroundView = UIView(frame: cell.frame)
        cell.multipleSelectionBackgroundView?.backgroundColor  = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 3)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defaultAction?.isEnabled = self.tableView.indexPathsForSelectedRows != nil ? true : false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        defaultAction?.isEnabled = self.tableView.indexPathsForSelectedRows != nil ? true : false
    }
}
