//
//  ViewController.swift
//  AssignmentApp
//
//  Created by Nikhil Wagh on 4/15/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class FactsViewController: UITableViewController {
    
    //MARK: - Parameters
    
    var factsViewModel: FactsViewModel?
    var activityView: UIActivityIndicatorView?
    
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
        setupTableView()
        addActivityIndicator()
    }
    
    func setupTableView() {
        tableView.register(FactsCell.self, forCellReuseIdentifier: Constant.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.themeColor
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.barTintColor = UIColor.themeColor
    }
    
    func addActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView?.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        activityView?.hidesWhenStopped = true
        view.addSubview(activityView!)
    }
    
    func getFactsDataFromAPI() {
        activityView?.startAnimating()
        ServiceManager.sharedInstance.getAPIData { (data, error) in
            DispatchQueue.main.async {
                self.activityView?.stopAnimating()
                if data != nil {
                    self.factsViewModel = FactsViewModel(dataModel: data!)
                    self.navigationItem.title = self.factsViewModel?.screenTitle
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: Constant.errorTitle, message: error?.localizedDescription , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: Constant.ok, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        getFactsDataFromAPI()
        refreshControl.endRefreshing()
    }
    
}

extension FactsViewController {
    
    //MARK: - Delegate and DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as? FactsCell else { return FactsCell() }
        guard let currentLastItem = factsViewModel?.rowsArray[indexPath.row] else { return cell }
        cell.setUpCellData(row: currentLastItem)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsViewModel?.rowsArray.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
