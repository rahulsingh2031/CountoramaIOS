//
//  TagSearchView.swift
//  Countorama
//
//  Created by Raj Singh on 21/01/25.
//

import Foundation
import SwiftUI

struct TagSearchView: View {
    @Binding var counters : [CDCounter]
    var body: some View {
        
            if true{
                CounterListView(counters:$counters)
            }
            else{
                CounterGridView(counters:$counters)
            }
        
    }
}
