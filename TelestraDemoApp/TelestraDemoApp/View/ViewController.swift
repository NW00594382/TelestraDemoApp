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
    
    var viewModel: ViewControllerVM?

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFactsDataFromAPI()
    }
    
    
    //MARK: - Private Methods
    
    func setUpInitialView() {

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(CustomCell.self, forCellReuseIdentifier: Constant.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.themeColor
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.barTintColor = UIColor.themeColor
    }

    func getFactsDataFromAPI() {
        SKActivityIndicator.show()
        ServiceManager.sharedInstance.getAPIData { (data, error) in
            DispatchQueue.main.async {
                SKActivityIndicator.dismiss()
                if data != nil {
                    self.viewModel = ViewControllerVM(dataModel: data!)
                    self.navigationItem.title = self.viewModel?.screenTitle
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: Constant.errorTitle, message: error?.localizedDescription , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: Constant.ok, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        getFactsDataFromAPI()
        refreshControl.endRefreshing()
    }
    
    //MARK: - Delegate and DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as? CustomCell else { return CustomCell() }
        guard let currentLastItem = viewModel?.rowsArray[indexPath.row] else { return cell }
        cell.setUpCellData(row: currentLastItem)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rowsArray.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


