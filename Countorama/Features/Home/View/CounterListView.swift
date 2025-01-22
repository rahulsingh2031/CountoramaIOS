//
//  CounterListView.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct CounterListView: View {
    @Binding var counters :[CDCounter] 
    var body: some View {
        List{
            ForEach(counters) { counter in
                CounterListItemView(counter:counter)
                    
            }
            
       
        }
        .listStyle(.plain)
    }
}

#Preview {
    CounterListView(counters: .constant([CDCounter.preview(context: PersistenceController.preview.container.viewContext)]))
        
}
