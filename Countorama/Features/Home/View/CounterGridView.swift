//
//  CounterGridView.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct CounterGridView: View {
    //    @Binding var searchText:String
    let columns:[GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        
        
        GeometryReader{
            reader in
            
            ScrollView {
                LazyVGrid(columns: columns,spacing: 0) {
                    CounterGridItemView(itemWidth: reader.size.width/2)
                    CounterGridItemView(itemWidth: reader.size.width/2)
                    CounterGridItemView(itemWidth: reader.size.width/2)
                    CounterGridItemView(itemWidth: reader.size.width/2)
                    CounterGridItemView(itemWidth: reader.size.width/2)
                    CounterGridItemView(itemWidth: reader.size.width/2)
                    CounterGridItemView(itemWidth: reader.size.width/2)
                    
                    
                    
                    
                }
                
            }
            
            
        }
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        
    }
}

#Preview {
    CounterGridView()
}
