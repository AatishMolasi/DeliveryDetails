//
//  BaseViewController.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation
import UIKit

protocol ViewSetupProtocol {
    func setupViews()
    func setupAppearance()
    func setupConstraints()
    func setupUI()
}

extension ViewSetupProtocol {
    func setupUI() {
        self.setupViews()
        self.setupConstraints()
        self.setupAppearance()
    }
}

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
