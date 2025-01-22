//
//  CDTag+Ext.swift
//  Countorama
//
//  Created by Raj Singh on 13/01/25.
//


import Foundation
import CoreData

extension CDTag {

    // MARK: - Properties
    
    var label: String {
        get { label_ ?? "" }
        set { label_ = newValue }
    }
    
    var uuid: UUID {
        get { uuid_ ?? UUID() }
        set { uuid_ = newValue }
    }
    
//    var counters: Set<CDCounter> {
//        get { (counters_ as? Set<CDCounter>) ?? [] }
//        set { counters_ = newValue as NSSet }
//    }
    
    // MARK: - Convenience Initializer
    convenience init(context: NSManagedObjectContext, label: String) {
        self.init(context: context)
        self.label = label
        createdAt_ = Date()
        self.uuid = UUID()
    }
    
    // MARK: - Preview Object
    static func preview(context: NSManagedObjectContext) -> CDTag {
        let previewTag = CDTag(context: context)
        previewTag.label = "Countoramasos"
        previewTag.uuid = UUID()
        previewTag.createdAt_ = Date()
        
        return previewTag
    }
}
