//
//  CDTagRepository.swift
//  Countorama
//
//  Created by Raj Singh on 13/01/25.
//

import Foundation

import Foundation
import CoreData

class CDTagRepository {
    
    static let shared = CDTagRepository()
    // MARK: - Core Data Context
    private let controller:PersistenceController
    private let context:NSManagedObjectContext

    init() {
        self.controller = PersistenceController.shared
        context = controller.container.viewContext
    }


    // Create a single CDTag object
    func createObject(collection: CDTag) throws -> CDTag? {
        context.insert(collection)
        controller.saveChange()
        return collection
    }

    

    // Delete a single CDTag object
    func deleteObject(collection: CDTag) throws {
        context.delete(collection)
        controller.saveChange()
    }

    // Fetch all CDTag objects
    func fetchAllTags() throws -> [CDTag] {
        let fetchRequest: NSFetchRequest<CDTag> = CDTag.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CDTag.createdAt_, ascending: false)]
        controller.saveChange()
        return try context.fetch(fetchRequest)
    }

    // Fetch a single CDTag object by UUID
    func getObject(uuid: UUID) throws -> CDTag? {
        let fetchRequest: NSFetchRequest<CDTag> = CDTag.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid_ == %@", uuid as CVarArg)
        controller.saveChange()
        return try context.fetch(fetchRequest).first
    }

    

    // Fetch a CDTag object by label
    func getObjectByLabel(label: String) throws -> CDTag? {
        let fetchRequest: NSFetchRequest<CDTag> = CDTag.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "label_ == %@", label)
        controller.saveChange()
        return try context.fetch(fetchRequest).first
    }

    // Clear all CDTag objects
    func clearData() throws {
        let fetchRequest: NSFetchRequest<CDTag> = CDTag.fetchRequest()
        let allObjects = try context.fetch(fetchRequest)
        for object in allObjects {
            context.delete(object)
        }
        controller.saveChange()
    }

    func updateTag(tag:CDTag){       
        context.refresh(tag, mergeChanges: true)
        controller.saveChange()
        
    }
   
}
