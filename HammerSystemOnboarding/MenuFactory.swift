//
//  MenuFactory.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 04.04.2023.
//

import Foundation

class MenuFactory {
    public func build() -> MenuViewController {
        let presenter = MenuPresenter()
        let interactor = MenuInteractor(presenter: presenter)
        let viewController = MenuViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
