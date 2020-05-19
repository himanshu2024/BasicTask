//
//  Coordinator.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 19/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
