//
//  ViewController.swift
//  JsonParse
//
//  Created by TDCC_IFD on 2022/4/26.
//

import UIKit

class ListViewController: UITableViewController {
    
    var brokers: [Broker]? {
        AppService.shared.brokers
    }
    
    @IBAction func rightBarBtnAction(_ sender: Any) {
        AppService.shared.save()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我是標題"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
        AppService.shared.loadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "star")
        
        let broker = brokers![indexPath.row]
        content.text = broker.billNum
        content.secondaryText = broker.total
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brokers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, view, completionHandler) in
            
            tableView.beginUpdates()
            AppService.shared.delete(row: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
        
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let insertAction = UIContextualAction(style: .destructive, title: "新增") { (action, view, completionHandler) in
            
            tableView.beginUpdates()
            AppService.shared.insert(row: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            completionHandler(true)
        }
        insertAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [insertAction])
    }
    
    
}

