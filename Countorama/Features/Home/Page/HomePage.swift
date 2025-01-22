
//  HomeView.swift
//  Countorama


import SwiftUI

struct HomePage: View {
    
        @State var showDrawer = false
   
    @State var isShowingAddCounter = false
    @EnvironmentObject var homeVM :HomeViewModel
    
    var body: some View {
        
        ZStack{
            NavigationStack(path: $homeVM.path){
                
                CountersView()
                   
                    .searchable(text: $homeVM.searchText,prompt: Text("Search Your Counters"))
                   
                    
                    .navigationTitle("Home")
                    .navigationDestination(for: CDCounter.self, destination: { counter in
                        AnalysisDetailPage(counter: counter )
                            
                    })
                    .toolbar(homeVM.path.count > 0 ? .hidden : .visible, for: .tabBar)
                    .toolbar(content: {
                        
                        ToolbarItemGroup(placement: .navigationBarTrailing ){
                            Button(action: {
                                isShowingAddCounter = true
                            }, label: {
                                Image(systemName: "plus")
                            })
                            Button(action: {
                                homeVM.toggleView()
                            }
                                   , label: {
                                Image(systemName: homeVM.showListView ? "square.grid.3x3.fill":"line.3.horizontal")
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




