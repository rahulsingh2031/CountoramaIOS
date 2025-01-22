//
//  CountersView.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct CountersView: View {
    
    @EnvironmentObject var homeVM:HomeViewModel
    
    
    var body: some View {
        
            if homeVM.showListView{
                CounterListView(counters:$homeVM.counters)
                
            }
            else{
                CounterGridView(counters:$homeVM.counters)
            }
        
        
       
    }
}


