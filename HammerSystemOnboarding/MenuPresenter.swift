//
//  MenuPresenter.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 04.04.2023.
//

import Foundation

protocol MenuPresentationLogic: AnyObject {
    func presentFood(_ response: MenuDataFlow.Response)
}

class MenuPresenter {
    weak var viewController: MenuDisplayLogic?
    
    
}

extension MenuPresenter: MenuPresentationLogic {
    func presentFood(_ response: MenuDataFlow.Response) {
        let presentedPizza = response.pizza.map {
            PresentedFood(name: $0.name, price: $0.price, description: $0.description, image: $0.image)
        }
        let presentedDeserts = response.deserts.map {
            PresentedFood(name: $0.name, price: $0.price, description: $0.description, image: $0.image)
        }

        viewController?.displayFood(.init(presentedPizza: presentedPizza, presenteDeserts: presentedDeserts))
    }
}
