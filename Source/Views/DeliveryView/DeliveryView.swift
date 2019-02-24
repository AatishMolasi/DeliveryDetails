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

class DeliveryView: UIView, ViewSetupProtocol {

    private var deliveryImageView: UIImageView
    private var deliveryTitleLabel: UILabel
    private var deliveryLocationLabel: UILabel
    private var delivery: Delivery?


    func setupViews() {
        self.addSubview(deliveryImageView)
        self.addSubview(deliveryTitleLabel)
        self.addSubview(deliveryLocationLabel)
    }

    func setupAppearance() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1

        deliveryImageView.contentMode = .scaleAspectFit

        deliveryTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        deliveryTitleLabel.numberOfLines = 0

        deliveryLocationLabel.font = UIFont.systemFont(ofSize: 14)
        deliveryLocationLabel.numberOfLines = 0
    }

    func setupConstraints() {
        deliveryImageView.translatesAutoresizingMaskIntoConstraints = false
        deliveryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryLocationLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            deliveryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            deliveryImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            deliveryImageView.heightAnchor.constraint(equalToConstant: 60),
            deliveryImageView.widthAnchor.constraint(equalToConstant: 60)
            ]);

        NSLayoutConstraint.activate([
            deliveryTitleLabel.leadingAnchor.constraint(equalTo: deliveryImageView.trailingAnchor, constant: 10),
            deliveryTitleLabel.topAnchor.constraint(equalTo: deliveryImageView.topAnchor, constant: 0),
            deliveryTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            ]);

        NSLayoutConstraint.activate([
            deliveryLocationLabel.leadingAnchor.constraint(equalTo: deliveryTitleLabel.leadingAnchor, constant: 0),
            deliveryLocationLabel.topAnchor.constraint(equalTo: deliveryTitleLabel.bottomAnchor, constant: 10),
            deliveryLocationLabel.trailingAnchor.constraint(equalTo: deliveryTitleLabel.trailingAnchor, constant: 0),
            ]);

        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: deliveryLocationLabel.bottomAnchor, constant: 20),
            ]);
    }

    init() {
        deliveryImageView = UIImageView()
        deliveryTitleLabel = UILabel()
        deliveryLocationLabel = UILabel()

        super.init(frame: .zero)

        setupUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(delivery: Delivery) {
        self.delivery = delivery
        self.reload()
    }

    func reload() {
        guard let delivery = self.delivery else {
            return
        }
        if let imageUrl = delivery.imageUrl {
            self.deliveryImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "bgNoimage"), options: [], progress: nil, completed: nil)
        } else {
            //Handle no imageUrl
        }
        self.deliveryTitleLabel.text = delivery.description
        self.deliveryLocationLabel.text = delivery.location.address
    }
}
