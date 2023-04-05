//
//  FetchMenuWorker.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 05.04.2023.
//

import Foundation

protocol FetchesMenuLogic {
    func fetchData(completion: @escaping (Result<([Food], [Food]), Error>) -> Void)
}

class FetchMenuWorker: FetchesMenuLogic {
    func fetchData(completion: @escaping (Result<([Food], [Food]), Error>) -> Void) {
        var pizza: [Food] = []
        var deserts: [Food] = []
        let headers = [
            "X-RapidAPI-Key": "c836cd3bfdmshc3736e8ade00b2dp189a99jsn2283dff84ba3",
            "X-RapidAPI-Host": "pizza-and-desserts.p.rapidapi.com"
        ]
        let urls = [URL(string: "https://pizza-and-desserts.p.rapidapi.com/pizzas"), URL(string: "https://pizza-and-desserts.p.rapidapi.com/desserts")]
        let urlDownloadGroup = DispatchGroup()
        let urlDownloadQueue = DispatchQueue(label: "ru.fetchFood.urlqueue")
        
        for url in urls {
            urlDownloadGroup.enter()
            guard let url = url else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    urlDownloadQueue.async {
                        urlDownloadGroup.leave()
                    }
                    return
                }
                
                guard response is HTTPURLResponse else {
                    urlDownloadQueue.async {
                        urlDownloadGroup.leave()
                    }
                    return
                }
                
                guard let data = data, let fetchedFood = try? JSONDecoder().decode([Food].self, from: data) else {
                    urlDownloadQueue.async {
                        urlDownloadGroup.leave()
                    }
                    return
                }
                
                urlDownloadQueue.async {
                    if url == urls[0] {
                        pizza.append(contentsOf: fetchedFood)
                    } else {
                        deserts.append(contentsOf: fetchedFood)
                    }
                    urlDownloadGroup.leave()
                }
            }.resume()
        }
        
        urlDownloadGroup.notify(queue: DispatchQueue.main) {
            completion(.success((pizza, deserts)))
        }
    }
}
