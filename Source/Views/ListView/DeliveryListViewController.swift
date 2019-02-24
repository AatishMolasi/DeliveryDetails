//
//  DeliveryListViewController.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation
import UIKit

class DeliveryListViewController: BaseViewController, ViewSetupProtocol {

    var deliveriesTable: UITableView
    var refreshControl: UIRefreshControl
    var deliveryManager: DeliveryManager
    var currentPage = 1

    var deliveries:[Delivery] = []

    init(deliveryManager: DeliveryManager) {
        deliveriesTable = UITableView()
        refreshControl = UIRefreshControl()
        self.deliveryManager = deliveryManager
        super.init()

        setupUI()
    }

    func setupViews() {
        deliveriesTable.backgroundView = refreshControl
        deliveriesTable.separatorStyle = .none
        refreshControl.addTarget(self, action: #selector(self.fetchPins), for: .valueChanged)
        self.view.addSubview(deliveriesTable)
    }

    func setupAppearance() {
        self.view.backgroundColor = UIColor.white

        self.title = NSLocalizedString("Things to deliver", comment: "")
        self.deliveriesTable.register(DeliveryCell.self, forCellReuseIdentifier: DeliveryCell.getCellIdentifier())
        self.deliveriesTable.delegate = self
        self.deliveriesTable.dataSource = self
    }

    func setupConstraints() {
        deliveriesTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            deliveriesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            deliveriesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            deliveriesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            deliveriesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ]);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchPins()
    }

    @IBAction func fetchPins() {
        self.deliveryManager.getDeliveries(page: 0) { (deliveries, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.showError(title: "Error", message: "Unable to fetch images")
                }
            }
            guard let deliveries = deliveries else {
                return
            }
            //will have some sort of appending once we add pagination
            //TODO: move this to a data source
            self.deliveries = deliveries
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.deliveriesTable.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadMore() {
        //TODO: Implement the logic to load more data
    }
}

extension DeliveryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryCell.getCellIdentifier()) as? DeliveryCell {
            let currentDelivery = deliveries[indexPath.row]
            cell.updateData(delivery: currentDelivery)
            if indexPath.row == deliveries.count - 1 {
                self.loadMore()
            }

            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentDelivery = deliveries[indexPath.row]
        let deliveryDetailsView = DeliveryDetailViewController(delivery: currentDelivery)
        self.navigationController?.pushViewController(deliveryDetailsView, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliveries.count
    }
}
