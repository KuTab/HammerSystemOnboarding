//
//  MenuFactory.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 04.04.2023.
//

import Foundation
import CoreData

class MenuFactory {
    public func build() -> MenuViewController {
        let presenter = MenuPresenter()
        let fetchWorker = FetchMenuWorker()
        let coreDataWorker = CoreDataWorker()
        let interactor = MenuInteractor(presenter: presenter, fetchWorker: fetchWorker, coreDataWorker: coreDataWorker)
        let viewController = MenuViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
