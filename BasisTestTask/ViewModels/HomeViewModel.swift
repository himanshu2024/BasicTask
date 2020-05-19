//
//  HomeViewModel.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 19/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation

protocol CardsView: AnyObject {
    func reloadView()
    func showError(message: String)
}

protocol CardsViewModelProtocol {
    init(view: CardsView, apiService: CardsInteractor)
    func getData()
}

class CardsViewModel : CardsViewModelProtocol {
    private unowned let view: CardsView
    private let apiService: CardsInteractor
    private var cards: [CardData]?
    
    required init(view: CardsView, apiService: CardsInteractor){
        self.view = view
        self.apiService = apiService
    }
    
    func getData() {
        apiService.fetchCards()
    }
    
}

extension CardsViewModel : CardsInteractorDelegate{
    func fetchCardsSuccess(data: ResponseModel) {
        cards = data.data
        view.reloadView()
    }
    
    func fetchCardsError(error: String) {
        view.showError(message: error)
    }
    
    
}
