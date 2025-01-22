//
//  HomeViewModel.swift
//  Countorama
//
//  Created by Raj Singh on 13/01/25.
//

import Foundation





class HomeViewModel:CounterViewModel
{

    private var controller = PersistenceController.shared
    @Published var counters: [CDCounter] = []
    @Published var completedCounters: [CDCounter] = []
    @Published var showListView = false
    
    @Published var path = NavigationPath()
    @Published var searchText  = "" {
        didSet{
            searchItem()
        }
    }
    
   
    
     override init(counterRepository: CDCounterRepository, countRepository: CDCountRepository) {
      
        super.init(counterRepository: counterRepository, countRepository: countRepository)

        self.fetchCounters()
    }
    
    
    
    func fetchCounters(){
        searchItem()
    }
    
    func searchItem(){
        if searchText.isEmpty {
            do{
                counters = try counterRepository.fetchAllCounters()
               
            }catch let error{
                print("\(error.localizedDescription)")
            }
            
            return
        }
        
        do{
            counters = try counterRepository.searchCounters(byName: searchText)
            
        }catch let error{
            print("\(error.localizedDescription)")
        }
    }
    
    //Mark: switch to addCounterVM
    
    func addCounter(counterParam: CounterParam)  {
        let counter = CDCounter(context: controller.container.viewContext, name: counterParam.name, dailyFrequency: counterParam.dailyFrequency, color: counterParam.counterColor == nil ? Color(.systemGray5).toHexString()  :counterParam.counterColor?.toHexString() )
        counter.tag = counterParam.tag
        counter.targetDate = counterParam.targetDate
            _ = counterRepository.createCounter(counter)
            fetchCounters()
//        (name: counterParam.name,
//                                             dailyFrequency: counterParam.dailyFrequency,
//                                             targetDate: counterParam.targetDate,
//                                             targetCount: counterParam.targetCount,
//                                             tag: counterParam.tag,
//                                             color: counterParam.counterColor)
       }

       // Delete an existing counter
       func deleteCounter(counter: CDCounter) async {
            counterRepository.deleteCounter(counter)
       }
    
    func toggleView(){
        showListView.toggle()
    }
    
    func incrementCount(counter: CDCounter)  {
            // Set the counter process state to loading
            // (Assuming you have a state management system)
            print("Counter process is loading...")

            // Fetch today's count for the counter
            var count =  countRepository.getTotalCountForCounter(counter: counter)

            // First time: Create the count if it doesn't exist
            if count == nil {
                print("First time count, creating new count.")
                
                count =  countRepository.createObjectWithCounter(counter: counter, context: controller.container.viewContext)
            }

            // If there's no count at all, something went wrong
            guard var validCount = count else {
                print("Something went wrong, no count found.")
                return
            }

            // Increment the count value
            let countValue = validCount.value + 1

            // Check if the new count value is within daily frequency
            if countValue <= counter.dailyFrequency {
                // Create a new count with the updated value, ensuring it doesn't exceed the daily frequency
                
                validCount = countRepository.updateCount(value: min(validCount.value + 1, counter.dailyFrequency), count: validCount)
                
                
//                if counter.counterValueIndictor == .today {
//                    // If the counter value indicator is 'today', update the counter's value
                counter.value = validCount.value
//                } else {
//                    // Otherwise, increment the counter's value
//                    newCounter = counter.copyWith(value: counter.value + 1)
//                }

                // Trigger a task completion celebration (you may have this implemented in your app)
//                triggerTaskCompletionCelebration(newCount.value, counter.dailyFrequency)

                // Update the counter and the count in their respective repositories
                counterRepository.updateCounter(counter)
                fetchCounters()

                print("Counter updated successfully!")
                return
            }

            // If count exceeds the daily frequency, mark the process as failed
            print("Counter process failed: Exceeded daily frequency.")
        }
    
    
    func decreaseCount(counter: CDCounter)  {
            // Set the counter process state to loading
            // (Assuming you have a state management system)
            print("Counter process is loading...")

            // Fetch today's count for the counter
            var count =  countRepository.getTotalCountForCounter(counter: counter)

            // First time: Create the count if it doesn't exist
            if count == nil {
                print("First time count, creating new count.")
                
                count =  countRepository.createObjectWithCounter(counter: counter, context: controller.container.viewContext)
            }

            // If there's no count at all, something went wrong
            guard var validCount = count else {
                print("Something went wrong, no count found.")
                return
            }

            // Increment the count value
            let countValue = validCount.value - 1

            // Check if the new count value is within daily frequency
        if countValue >= 0 {
                // Create a new count with the updated value, ensuring it doesn't exceed the daily frequency
                
                validCount = countRepository.updateCount(value: min(validCount.value - 1, counter.dailyFrequency), count: validCount)
                
                
//                if counter.counterValueIndictor == .today {
//                    // If the counter value indicator is 'today', update the counter's value
                counter.value = validCount.value
//                } else {
//                    // Otherwise, increment the counter's value
//                    newCounter = counter.copyWith(value: counter.value + 1)
//                }

                // Trigger a task completion celebration (you may have this implemented in your app)
//                triggerTaskCompletionCelebration(newCount.value, counter.dailyFrequency)

                // Update the counter and the count in their respective repositories
                counterRepository.updateCounter(counter)
                fetchCounters()

                print("Counter updated successfully!")
                return
            }

            // If count exceeds the daily frequency, mark the process as failed
            print("Counter process failed: Cant go below 0")
        }

    func editTodayCountByCustomValue( value:String,counter:CDCounter){
        
        let parsedValue = Int(value) ?? counter.value
        var count =  countRepository.getTotalCountForCounter(counter: counter)

        // First time: Create the count if it doesn't exist
        if count == nil {
            print("First time count, creating new count.")
            count =  countRepository.createObjectWithCounter(counter: counter, context: controller.container.viewContext)
            counter.value = max(0, min(parsedValue, counter.dailyFrequency))
            counterRepository.updateCounter(counter)
            return
        }
        
        
        if (parsedValue < 0 || parsedValue > counter.dailyFrequency) {
             //MARK: SHOW ERROR
            print("PARSED VALUE CROSSED")
             return;
        }
        
        count?.value = max(0, min(parsedValue, counter.dailyFrequency))
        counter.value = max(0, min(parsedValue, counter.dailyFrequency))
        _ = countRepository.updateCount(value: count!.value, count: count!)
        counterRepository.updateCounter(counter)
        fetchCounters()
        print("PARSED VALUE PASSED")
     
        
    }
        // This method is for triggering celebrations when a task is completed.
    func triggerTaskCompletionCelebration(_ countValue: Int, _ dailyFrequency: Int) {
            // Implement task completion logic (e.g., showing a celebration animation)
            print("Task Completed! Current value: \(countValue), Target value: \(dailyFrequency)")
        }
    
}


import SwiftUI
extension Color {
    
    init?(hex: String) {
          var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
          hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

          var rgb: UInt64 = 0
          guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

          let red, green, blue: Double
          let length = hexSanitized.count

          if length == 6 {
              red = Double((rgb >> 16) & 0xFF) / 255.0
              green = Double((rgb >> 8) & 0xFF) / 255.0
              blue = Double(rgb & 0xFF) / 255.0
          } else {
              return nil
          }

          self.init(red: red, green: green, blue: blue)
      }
    
    func toHexString() -> String? {
        // Convert SwiftUI Color to UIColor
        let uiColor = UIColor(self)
        
        // Get RGBA components
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            // Convert components to hex
            let r = Int(red * 255)
            let g = Int(green * 255)
            let b = Int(blue * 255)
            
            // Format as hex string
            return String(format: "#%02X%02X%02X", r, g, b)
        }
        
        // Return nil if color conversion fails
        return nil
    }
}
