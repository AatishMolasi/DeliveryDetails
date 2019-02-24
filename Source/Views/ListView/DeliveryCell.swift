//
//  DeliveryCell.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DeliveryCell: UITableViewCell, ViewSetupProtocol {

    var deliveryView: DeliveryView

    func setupViews() {
        self.contentView.addSubview(deliveryView)
    }

    func setupConstraints() {
        deliveryView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            deliveryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            deliveryView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            deliveryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ]);

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: deliveryView.bottomAnchor, constant: 10),
            ]);
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        deliveryView = DeliveryView()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupAppearance() {
        self.selectionStyle = .none
    }

    func updateData(delivery: Delivery) {
        deliveryView.updateData(delivery: delivery)
    }

    class func getCellIdentifier() -> String {
        return String(describing: DeliveryCell.self)
    }
}
