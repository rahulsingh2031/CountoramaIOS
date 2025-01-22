import Foundation
import SwiftUI
class CounterParam {
    let name: String
    let dailyFrequency: Int
    var counterColor: Color?
    var targetDate: Date?
    var tag:CDTag?
 
    

    init(name: String, dailyFrequency: Int,tag:CDTag?,targetDate:Date?,color:Color?) {
        self.name = name
        self.dailyFrequency = dailyFrequency
        self.targetDate = targetDate
        self.counterColor = color
        self.tag = tag
    }
}
