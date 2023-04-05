//
//  CoreDataWorker.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 05.04.2023.
//

import Foundation
import CoreData

protocol CoreDataLogic {
    func saveData(pizzas: [Food], deserts: [Food])
    
    func getData() -> ([Food], [Food])
}

class CoreDataWorker: CoreDataLogic {
    
    func saveData(pizzas: [Food], deserts: [Food]) {
        UserDefaults.standard.pizzas = pizzas
        UserDefaults.standard.deserts = deserts
    }
    
    func getData() -> ([Food], [Food]) {
        let pizzas = UserDefaults.standard.pizzas
        let deserts = UserDefaults.standard.deserts
        return (pizzas, deserts)
    }
}

extension UserDefaults {
    var pizzas: [Food] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "pizzas") else { return [] }
            return (try? PropertyListDecoder().decode([Food].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "pizzas")
        }
    }
    var deserts: [Food] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "deserts") else { return [] }
            return (try? PropertyListDecoder().decode([Food].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "deserts")
        }
    }
}
