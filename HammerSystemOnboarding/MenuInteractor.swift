//
//  MenuInteractor.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 04.04.2023.
//

import Foundation
import CoreData

protocol MenuBusinessLogic: AnyObject {
    func fetchFood(_ request: MenuDataFlow.Request)
}

class MenuInteractor {
    private var presenter: MenuPresentationLogic
    private var fetchWorker: FetchesMenuLogic
    private var coreDataWorker: CoreDataLogic
    
    init(presenter: MenuPresentationLogic, fetchWorker: FetchesMenuLogic, coreDataWorker: CoreDataLogic) {
        self.presenter = presenter
        self.fetchWorker = fetchWorker
        self.coreDataWorker = coreDataWorker
    }
    
}

extension MenuInteractor: MenuBusinessLogic {
    func fetchFood(_ request: MenuDataFlow.Request) {
        fetchWorker.fetchData { [weak presenter, coreDataWorker] result in
            switch result {
            case .success(let food):
                coreDataWorker.saveData(pizzas: food.0, deserts: food.1)
                presenter?.presentFood(.init(pizza: food.0, deserts: food.1))
            case .failure(let error):
                print(error)
                //todo
                let food = coreDataWorker.getData()
                presenter?.presentFood(.init(pizza: food.0, deserts: food.1))
            }
        }
    }
}
