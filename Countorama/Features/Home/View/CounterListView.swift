//
//  CounterListView.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct CounterListView: View {
    var body: some View {
        List{
            CounterListItemView()
            CounterListItemView()
            CounterListItemView()
            CounterListItemView()
            CounterListItemView()
        }
        .listStyle(.plain)
    }
}

#Preview {
    CounterListView()
}
