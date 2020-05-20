//
//  MainCoordinator.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 19/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator{
    var navigationController: UINavigationController
    init(navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    
    //implement the entry point of app
    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        let interactor = CardsAPIService()
        let viewModel = CardsViewModel(view: vc, apiService: interactor)
        vc.viewModel = viewModel
        interactor.delegate = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
}
