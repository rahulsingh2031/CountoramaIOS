//
//  CounterViewModel.swift
//  Countorama
//
//  Created by Raj Singh on 13/01/25.
//

import Foundation

class CounterViewModel:ObservableObject{
     var counterRepository: CDCounterRepository
     var countRepository: CDCountRepository
    private var controller = PersistenceController.shared
    
    init(counterRepository: CDCounterRepository, countRepository: CDCountRepository) {
        self.counterRepository = counterRepository
        self.countRepository = countRepository
    }
}
