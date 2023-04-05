//
//  MenuInteractor.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 04.04.2023.
//

import Foundation

protocol MenuBusinessLogic: AnyObject {
    
}

class MenuInteractor {
    private var presenter: MenuPresentationLogic
    
    init(presenter: MenuPresentationLogic) {
        self.presenter = presenter
    }
    
}

extension MenuInteractor: MenuBusinessLogic {
    
}
