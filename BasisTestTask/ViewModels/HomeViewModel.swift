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
    var numberOfItems : Int { get }
    func getCard(at index : Int) -> CardData?
    func loadData()
}

class CardsViewModel : CardsViewModelProtocol {
    private unowned let view: CardsView
    private let apiService: CardsInteractor
    var cards: [CardData] = [CardData]()
    
    required init(view: CardsView, apiService: CardsInteractor){
        self.view = view
        self.apiService = apiService
    }
    
    var numberOfItems: Int{
        return cards.count
    }
    
    func getCard(at index: Int) -> CardData? {
        if index < numberOfItems{
            return cards[index]
        }
        return nil
    }
    
    func loadData() {
        apiService.fetchCards()
    }
    
}

extension CardsViewModel : CardsInteractorDelegate{
    func fetchCardsSuccess(data: ResponseModel) {
        if let arr = data.data{
            cards = arr
            view.reloadView()
        }
        else{
            view.showError(message: "Empty data!")
        }
    }
    
    func fetchCardsError(error: String) {
        view.showError(message: error)
    }
}
