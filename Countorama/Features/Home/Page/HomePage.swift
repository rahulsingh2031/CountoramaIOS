
//  HomeView.swift
//  Countorama


import SwiftUI

struct HomePage: View {
    
    @State var searchText = ""
    @State var showDrawer = false
    @State  var isShowingAddCounter = false
    @State var showListView = false
    var body: some View {
        
        ZStack{
            NavigationStack{
                
                CountersView(showListView: $showListView)
                    .searchable(text: $searchText,prompt: Text("Search Your Counters"))
                    .navigationTitle("Home")
                    .toolbar(content: {
                        
                        ToolbarItemGroup(placement: .navigationBarTrailing ){
                            Button(action: {
                                isShowingAddCounter = true
                            }, label: {
                                Image(systemName: "plus")
                            })
                            Button(action: {
                                showListView.toggle()
                            }
                                   , label: {
                                Image(systemName: showListView ? "square.grid.3x3.fill":"line.3.horizontal")
                            })
                        }
                    })
            }
            .sheet(isPresented: $isShowingAddCounter, content: {
                AddCounterPage(isShowingAddCounter: $isShowingAddCounter)
            })
            .disabled(showDrawer)
            
            
            
            
        }
    }
}


#Preview {
    HomePage()
}




