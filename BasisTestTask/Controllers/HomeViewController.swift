//
//  ViewController.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 18/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    private let name = "Cards"
    private let cellId = "CardCell"
    
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel: CardsViewModelProtocol!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = name
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewModel.loadData()
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardCollectionViewCell
        cell.text = viewModel.getCard(at: indexPath.row)?.text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        countLabel.text = "\(indexPath.row+1) / \(viewModel.numberOfItems)"
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension HomeViewController: CardsView{
    func reloadView() {
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        Alert.showAlert(on: self, with: "Error", message: message)
    }
}


