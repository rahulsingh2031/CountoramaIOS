//
//  tagViewModel.swift
//  Countorama
//
//  Created by Raj Singh on 14/01/25.
//

import Foundation
import SwiftUI

class TagViewModel:ObservableObject{
    private var tagRepository:CDTagRepository
    private var counterRepository:CDCounterRepository
    @Published var tags:Array<CDTag> = []
    @Published var path = NavigationPath()
    @Published var counters:[CDCounter] = []
    @Published var tagName = ""
    private var controller = PersistenceController.shared
    
    init(tagRepository:CDTagRepository,counterRepository:CDCounterRepository) {
     
        self.tagRepository = tagRepository
        self.counterRepository  = counterRepository

        self.fetchTags()
   }
   
   func fetchTags(){
       do{
           tags = try tagRepository.fetchAllTags()
           
       }
       catch let error{
           print("\(error)")
       }
       
   }
    func addTag(){
        if ((tagName.count) == 0)
        {
            return
        }
        
        do{
            let tag = CDTag(context: controller.container.viewContext, label: tagName)
                _ = try tagRepository.createObject(collection: tag)
                fetchTags()
        }
        catch {
            print("Error in adding tags")
        }
        
        tagName = ""
        fetchTags()
        
    }
    
    func deleteTag(tag:CDTag){
        do{
            try tagRepository.deleteObject(collection: tag)
                fetchTags()
        }
        catch {
            print("Error in adding tags")
        }
        
        fetchTags()
    }
    
    
    func updateTag(tag:CDTag,label:String){
        if ((tagName.count) != 0)
        {
                return
        }
        tag.label = label
        tagRepository.updateTag(tag: tag)
        fetchTags()
    }
    
    func getCounterByTag(tag:CDTag){
            counters =  counterRepository.fetchCountersByTag(tag)
        print(counters.count)
    }
    
    
}

