//
//  MenuDataFlow.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 05.04.2023.
//

import Foundation

enum MenuDataFlow {
    struct Request {}
    
    struct Response {
        var pizza: [Food]
        var deserts: [Food]
    }
    
    struct ViewModel {
        var presentedPizza: [PresentedFood]
        var presenteDeserts: [PresentedFood]
    }
}
