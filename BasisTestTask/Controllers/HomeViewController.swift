//
//  ViewController.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 18/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {

    var viewModel: CardsViewModelProtocol!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getData()
    }


}

extension HomeViewController: CardsView{
    func reloadView() {
        
    }
    
    func showError(message: String) {
        Alert.showAlert(on: self, with: "Error", message: message)
    }
}


