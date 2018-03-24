//
//  TableViewController.swift
//  TableViewCheckMark
//
//  Created by Yuta S. on 2018/03/24.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let sectionList = ["項目選択"]
    let cellText = [["1", "2", "3", "4"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.setEditing(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellText[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel?.text = cellText[indexPath.section][indexPath.row]
        cell.multipleSelectionBackgroundView = UIView(frame: cell.frame)
        cell.multipleSelectionBackgroundView?.backgroundColor  = .clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 3)!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationItem.rightBarButtonItem?.isEnabled = self.tableView.indexPathsForSelectedRows != nil ? true : false
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.navigationItem.rightBarButtonItem?.isEnabled = self.tableView.indexPathsForSelectedRows != nil ? true : false
    }

    @IBAction func tappedeDoneButton(_ sender: UIBarButtonItem) {
        let selectedRows = self.tableView.indexPathsForSelectedRows
        let selectedData = selectedRows?.map { cellText[$0.section][$0.row] }
        let selectedSortedData = selectedData?.sorted()
        print(selectedSortedData!)
    }
}
