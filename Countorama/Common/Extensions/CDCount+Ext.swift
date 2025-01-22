//
//  CDCount+Ext.swift
//  Countorama
//
//  Created by Raj Singh on 13/01/25.
//

import Foundation
import CoreData

extension CDCount {

   
    
    var value: Int {
        get { Int(value_) }
        set { value_ = Int32(newValue) }
    }
    
    var uuid: UUID {
        get { uuid_ ?? UUID() }
        set { uuid_ = newValue }
    }
    
    var createdAt: Date {
        get { createdAt_ ?? Date() }
        set { createdAt_ = newValue }
    }
    
    
    
    // MARK: - Convenience Initializer
    convenience init(context: NSManagedObjectContext,
                     value: Int,
                     counter: CDCounter) {
        self.init(context: context)
        self.value_ = Int32(value)
        self.counter = counter
        self.uuid_ = UUID()
        self.createdAt_ = Date()
        
    }
    
    // MARK: - Preview Object
    static func preview(context: NSManagedObjectContext, counter: CDCounter) -> CDCount {
        let previewCount = CDCount(context: context)
        previewCount.value = 10
        previewCount.uuid = UUID()
        previewCount.createdAt = Date()
        previewCount.counter = counter
        return previewCount
    }
}
