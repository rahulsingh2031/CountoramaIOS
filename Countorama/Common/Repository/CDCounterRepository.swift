import Foundation
import CoreData

class CDCounterRepository {
    
    static let shared = CDCounterRepository()
    private let controller:PersistenceController
    private let context:NSManagedObjectContext

    init() {
        self.controller = PersistenceController.shared
        context = controller.container.viewContext
    }
    
   

    // MARK: - Create Single Counter
    func createCounter(_ counter: CDCounter) -> CDCounter? {
        context.insert(counter)
        controller.saveChange()
        return counter
    }
    
    
    func createCounterWithTag(counter: CDCounter, tag: CDTag) throws -> CDCounter? {
        counter.tag = tag
        context.insert(counter)
        controller.saveChange()
        return counter
    }
    
    // MARK: - Delete Multiple Counters
    func deleteMultipleCounters(_ counters: [CDCounter]) throws {
        for counter in counters {
            context.delete(counter)
        }
        
        controller.saveChange()
    }

    // MARK: - Delete Single Counter
    func deleteCounter(_ counter: CDCounter)  {
        context.delete(counter)
        controller.saveChange()
    }
    
    // MARK: - Fetch All Counters
    func fetchAllCounters() throws -> [CDCounter] {
        let fetchRequest = CDCounter.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CDCounter.createdAt_, ascending: false)]
        return try context.fetch(fetchRequest)
    }

    // MARK: - Fetch Unarchived Counters
    func fetchUnarchivedCounters() throws -> [CDCounter] {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == false")
        return try context.fetch(fetchRequest)
    }

    // MARK: - Fetch Archived Counters
    func fetchArchivedCounters() throws -> [CDCounter] {
        let fetchRequest = CDCounter.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == true")
        return try context.fetch(fetchRequest)
    }

    // MARK: - Fetch Counter by ID
    func fetchCounterById(_ id: UUID) throws -> CDCounter? {
        let fetchRequest = CDCounter.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
        let results = try context.fetch(fetchRequest)
        return results.first
    }
    
    // MARK: - Update Counter
    func updateCounter(_ counter: CDCounter) {
        context.refresh(counter, mergeChanges: true)
        controller.saveChange()
    }
    
    // MARK: - Full Text Search (Name)
    func searchCounters(byName searchText: String) throws -> [CDCounter] {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CDCounter.createdAt_, ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "name_ CONTAINS[c] %@", searchText)

        return try context.fetch(fetchRequest)
    }
    
    // MARK: - Fetch Counters by Tag
    func fetchCountersByTag(_ tag: CDTag) -> [CDCounter] {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "tag == %@", tag)
        do{
            return try context.fetch(fetchRequest)
        }
        catch{
            return []
        }
       
    }

    // MARK: - Get Today's Count for a Counter
    func getTodayCount(for counter: CDCounter) throws -> Int {
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: now)!
        
        let fetchRequest = CDCount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "counter == %@ AND createdAt >= %@ AND createdAt <= %@", counter, startOfDay as CVarArg, endOfDay as CVarArg)
        
        let counts = try context.fetch(fetchRequest)
        return counts.reduce(0) { $0 + Int($1.value) }
    }

    // MARK: - Get Total Count for a Counter
    func getTotalCount(for counter: CDCounter) throws -> Int {
        let fetchRequest: NSFetchRequest<CDCount> = CDCount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "counter == %@", counter)
        
        let counts = try context.fetch(fetchRequest)
        return counts.reduce(0) { $0 + Int($1.value) }
    }

    // MARK: - Get Count for Last N Days
    func getCountForLastNDays(for counter: CDCounter, days: Int) throws -> Int {
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.date(byAdding: .day, value: -days, to: now)!
        let endDate = now

        let fetchRequest: NSFetchRequest<CDCount> = CDCount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "counter == %@ AND createdAt >= %@ AND createdAt <= %@", counter, startDate as CVarArg, endDate as CVarArg)
        
        let counts = try context.fetch(fetchRequest)
        return counts.reduce(0) { $0 + Int($1.value) }
    }

    // MARK: - Clear All Data
    func clearAllCounters() throws {
        let fetchRequest: NSFetchRequest<CDCounter> = CDCounter.fetchRequest()
        let counters = try context.fetch(fetchRequest)
        for counter in counters {
            context.delete(counter)
        }
        controller.saveChange()
    }

    
    
}
