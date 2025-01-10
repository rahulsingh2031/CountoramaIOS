//
//  CountersView.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct CountersView: View {
    
    @Binding var showListView:Bool
    var body: some View {
        if showListView{
            CounterListView()
        }
        else{
            CounterGridView()
        }
    }
}


