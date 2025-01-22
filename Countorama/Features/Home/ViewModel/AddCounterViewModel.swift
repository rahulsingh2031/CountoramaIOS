//
//  AddCounterViewModel.swift
//  Countorama
//
//  Created by Raj Singh on 13/01/25.
//

import Foundation
import SwiftUI

class AddCounterViewModel:CounterViewModel{
    @Published  var counterName = ""
    @Published  var counterColor = Color(.systemGray5)
    @Published  var counterFrequency = ""
    @Published  var hasTargetDate = false
    @Published  var counterTargetDate = Date()
    @Published  var selectedOption :CDTag?
    var tagRepository : CDTagRepository
    @Published var tags : [CDTag] = []
    
    init(counterRepository: CDCounterRepository, countRepository: CDCountRepository, tagRepository: CDTagRepository) {
        self.tagRepository = tagRepository
        
        super.init(counterRepository: counterRepository, countRepository: countRepository) // Calling the superclass's designated initializer
           
            fetchTags()
        }
    
    func fetchTags() {
        do {
            tags = try tagRepository.fetchAllTags()
            if let firstTag = tags.first, selectedOption == nil {
                selectedOption = firstTag
            }
        } catch let error {
            print("Error fetching tags: \(error)")
        }
        
        print(tags.count)
    }
    
    
    
    
    
}
