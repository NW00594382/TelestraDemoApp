//
//  ViewController.swift
//  AssignmentApp
//
//  Created by Nikhil Wagh on 4/15/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Parameters
    
    let cellIndentifier = "Cell"
    var rowsArray : [Row]  = [Row]()

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellIndentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.themeColor
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.barTintColor = UIColor.themeColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAPIData()
    }
    
    
    //MARK: - Private Methods
    
    func getAPIData() {
        SKActivityIndicator.show()
        Services.sharedInstance.getAPIData { (data, error) in
            DispatchQueue.main.async {
                SKActivityIndicator.dismiss()
                if data != nil {
                    self.navigationItem.title = data?.title
                    self.rowsArray = data!.rows.filter{ $0.title != nil }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        rowsArray.removeAll()
        tableView.reloadData()
        getAPIData()
        refreshControl.endRefreshing()
    }
    
    //MARK: - Delegate and DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? CustomCell else { return CustomCell() }
        let currentLastItem = rowsArray[indexPath.row]
        cell.setUpCellData(row: currentLastItem)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


