import Foundation
import CoreData

class CDCountRepository {
    static let shared = CDCountRepository()
    private let controller:PersistenceController
    private let context:NSManagedObjectContext

    init() {
        self.controller = PersistenceController.shared
        context = controller.container.viewContext
    }
    

    
    func updateCount(value:Int,count:CDCount)-> CDCount{
        count.value = value
        context.refresh(count, mergeChanges: true)
        controller.saveChange()
        return count
    }

   

    // Create a CDCount object with an associated Counter
    func createObjectWithCounter( counter: CDCounter,context:NSManagedObjectContext)  -> CDCount? {
        let collection = CDCount(context: context, value: 0, counter: counter)
        
        context.insert(collection)
        
        controller.saveChange()
        return collection
    }

    // Delete multiple CDCount objects
    func deleteMultipleObjects(collections: [CDCount]) throws {
        for collection in collections {
            context.delete(collection)
        }
        controller.saveChange()
    }

    // Delete a single CDCount object
    func deleteObject(collection: CDCount) throws {
        context.delete(collection)
        controller.saveChange()
    }

    // Fetch all CDCount objects
    func getAllObjects() throws -> [CDCount] {
        let fetchRequest = CDCount.fetchRequest()
        return try context.fetch(fetchRequest)
    }

    // Fetch a single CDCount object by ID
    func getObject(id: UUID) throws -> CDCount? {
        let fetchRequest = CDCount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid_ == %@", id as CVarArg)
        return try context.fetch(fetchRequest).first
    }

    

    // Fetch CDCount for a specific day
    func getCDCountForDay(counter: CDCounter, day: Int, month: Int, year: Int = 2024) throws -> CDCount? {
        let startOfDay = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
        let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!

        let fetchRequest: NSFetchRequest<CDCount> = CDCount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "counter == %@ AND createdAt_ >= %@ AND createdAt_ <= %@",
                                             counter, startOfDay as NSDate, endOfDay as NSDate)

        return try context.fetch(fetchRequest).first
    }

    // Fetch all CDCount objects for a specific counter
    func getTotalCountForCounter(counter: CDCounter) -> CDCount?{
        let fetchRequest: NSFetchRequest<CDCount> = CDCount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "counter == %@", counter)
        do {
            let count = try context.fetch(fetchRequest)
            return count.first
        }
        catch{
            return nil
        }
        
         
    }

    // Clear all CDCount objects
    func clearData() throws {
        let fetchRequest: NSFetchRequest<CDCount> = CDCount.fetchRequest()
        let allObjects = try context.fetch(fetchRequest)
        for object in allObjects {
            context.delete(object)
        }
        controller.saveChange()
    }

   
}

