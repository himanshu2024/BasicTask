//
//  APIService.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 19/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation

enum APIError: Error{
    case JSONParingError
    case HttpResponseError
    case NoDataError
}

class APIService {
    func get(urlRequest: URLRequest, completion: @escaping (Result<ResponseModel, APIError>) -> Void){
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let dataTask = session.dataTask(with: urlRequest) {
            (data, response, error) in
            let newData = self.removeForwardSlash(slashData: data)
            guard let httpResponse = response as? HTTPURLResponse,
                let receivedData = newData else {
                    print("No data found")
                    completion(.failure(.NoDataError))
                    return
            }
            switch (httpResponse.statusCode)
            {
            case 200:
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ResponseModel.self, from: receivedData)
                    completion(.success(response))
                } catch {
                    print("Error parsing JSON")
                    completion(.failure(.JSONParingError))
                }
            default:
                completion(.failure(.HttpResponseError))
            }
        }
        dataTask.resume()
    }
    
    private func removeForwardSlash(slashData : Data?) -> Data?{
        guard let data = slashData else { return slashData }
        let json = String(data: data, encoding: .utf8)
        if let json = json{
            if Array(json)[0] == "/"{
                let jsonFine = json.replacingOccurrences(of: "/", with: "")
                let newData = jsonFine.data(using: .utf8)
                return newData
            }
            else{
                return data
            }
        }
        return data
    }
}

protocol CardsInteractor {
    func fetchCards()
}

protocol CardsInteractorDelegate: AnyObject {
    func fetchCardsSuccess(data: ResponseModel)
    func fetchCardsError(error: String)
}

class CardsAPIService:APIService, CardsInteractor {
    
    weak var delegate: CardsInteractorDelegate?
    
    func fetchCards() {
        let path = "https://gist.githubusercontent.com/anishbajpai014/d482191cb4fff429333c5ec64b38c197/raw/b11f56c3177a9ddc6649288c80a004e7df41e3b9/HiringTask.json"
        
        guard let urlComponent = URLComponents(string: path) else { return }
        guard let url = urlComponent.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30
        
        get(urlRequest: request) { [weak self] result in
            switch(result){
            case .success(let articles):
                DispatchQueue.main.async {
                self?.delegate?.fetchCardsSuccess(data: articles)
                }
            case .failure( _):
                DispatchQueue.main.async {
                self?.delegate?.fetchCardsError(error: "Something went wrong. Please try again")
                }
            }
        }
    }
    
}
