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
        /// チェックマークテーブルビューの位置
        let increaseAndDecreaseValues: CGFloat = 60
        /// セルが増えるごとに増加させる値
        var incrementValues = 0.0687
        /// セルのベースの値
        var baseValues = 0.21
        
        // 画面ごとの制約を取得
        switch UIScreen.main.bounds.size {
        case CGSize(width: 320.0, height: 568.0):  // 4  inch
            incrementValues = 0.081
            baseValues = 0.245
        case CGSize(width: 375.0, height: 667.0):  // 4.7inch
            incrementValues = 0.0687
            baseValues = 0.21
        case CGSize(width: 414.0, height: 736.0):  // 5.5inch
            incrementValues = 0.0624
            baseValues = 0.19
        case CGSize(width: 375.0, height: 812.0):  // 5.8inch
            incrementValues = 0.0565
            baseValues = 0.173
        default: break
        }
        
        let alertController: UIAlertController = UIAlertController(title: "選択", message: "項目を選択してください。", preferredStyle: .alert)
        /// 高さ制約
        let constant = cellText.first!.count < 10 ? CGFloat(baseValues + incrementValues * Double(cellText.first!.count - 1)) : 0.80
        let height = NSLayoutConstraint(item: alertController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.height * constant)
        alertController.view.addConstraint(height)
        
        self.tableView.reloadData()
        
        
        defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.tableView.top -= increaseAndDecreaseValues
            let selectedRows = self.tableView.indexPathsForSelectedRows
            let selectedData = selectedRows?.map { self.cellText[$0.section][$0.row] }
            let selectedSortedData = selectedData?.sorted()
            print(selectedSortedData!)
        }
        defaultAction?.isEnabled = false
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
            self.tableView.top -= increaseAndDecreaseValues
        }
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction!)
        
        self.present(alertController, animated: true) {
            self.tableView.top += increaseAndDecreaseValues
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
