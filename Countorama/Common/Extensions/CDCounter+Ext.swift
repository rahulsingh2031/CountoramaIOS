//
//  CDCounter+Ext.swift
//  Countorama
//
//  Created by Raj Singh on 13/01/25.
//

import Foundation

import Foundation
import CoreData

extension CDCounter {
    
    var createdAt: Date {
        get { createdAt_ ?? Date() }
        set { createdAt_ = newValue }
    }
    
    var uuid:UUID{
        get{uuid_ ?? UUID()}
    }

    var targetDate: Date? {
        get { targetDate_ }
        set { targetDate_ = newValue }
    }

   

    var name: String {
        get { name_ ?? "" }
        set { name_ = newValue }
    }

    var dailyFrequency: Int {
        get { Int(dailyFrequency_) }
        set { dailyFrequency_ = Int32(newValue) }
    }


    var isArchived: Bool {
        get { isArchieved_ }
        set { isArchieved_ = newValue }
    }

//    var counterValueIndicator: CounterValueIndicator {
//        get { CounterValueIndicator(rawValue: Int(counterValueIndicator_)) ?? .default }
//        set { counterValueIndicator_ = Int16(newValue.rawValue) }
//    }

//    var stats: Stats? {
//        get { statsData != nil ? try? JSONDecoder().decode(Stats.self, from: statsData!) : nil }
//        set { statsData = try? JSONEncoder().encode(newValue) }
//    }

    var color: String? {
        get { color_ }
        set { color_ = newValue }
    }

    var value: Int {
        get { Int(value_) }
        set { value_ = Int32(newValue) }
    }
    
    convenience init(context: NSManagedObjectContext,
                         name: String,
                         dailyFrequency: Int,
                     color: String? = nil) {
            self.init(context: context)
        
            self.createdAt = Date()
            self.uuid_ = UUID()
            self.name = name
            self.dailyFrequency = dailyFrequency
            self.color = color
        }
    
    static func preview(context: NSManagedObjectContext) -> CDCounter {
            let previewCounter = CDCounter(context: context)
            previewCounter.createdAt = Date()
            previewCounter.uuid_ = UUID()
            previewCounter.name = "Sample Counter"
            previewCounter.dailyFrequency = 5
            previewCounter.color = "#FF5733"
            previewCounter.value = 100
            previewCounter.isArchived = false
            previewCounter.targetDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())
            return previewCounter
        }
}

// MARK: - CounterValueIndicator Enum
//
//enum CounterValueIndicator: Int {
//    case default = 0
//    case custom // Add additional cases as needed
//}
//
///MARK: - Stats Struct
//
//struct Stats: Codable {
//    let totalCount: Int
//    let dailyAverage: Double
//}
