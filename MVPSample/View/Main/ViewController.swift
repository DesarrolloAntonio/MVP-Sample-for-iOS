//
//  ViewController.swift
//  MVPSample
//
//  Created by Antonio Corrales on 27/6/18.
//  Copyright © 2018 DesarrolloManzana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let mainPresenter = MainViewControllerPresenter()
    var data: [Data] = [Data]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainPresenter.attachView(self)
        mainPresenter.getData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.lblTitle.text = data[indexPath.row].title
        cell.lblSubTitle.text = data[indexPath.row].subTitle
        return cell
    }
}

extension ViewController: MainView {
    func startLoading() {
        DispatchQueue.main.async { self.activityIndicator.startAnimating() }
    }
    
    func finishLoading() {
        DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
    }
    
    func getDataSuccess(data: [Data]) {
        self.data = data
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func getDataError() {
        DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
    }
}

