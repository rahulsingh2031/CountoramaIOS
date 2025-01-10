
//  HomeView.swift
//  Countorama


import SwiftUI

struct HomePage: View {
    
    @State var searchText = ""
    @State var showDrawer = false
    @State  var isShowingAddCounter = false
    var body: some View {
        
        ZStack{
            
            
            NavigationView{
                List{
                    CounterListItemView()
                    CounterListItemView()
                    CounterListItemView()
                    CounterListItemView()
                    CounterListItemView()
                }
                .listStyle(.plain)
                .searchable(text: $searchText,prompt: Text("Search Your Counters"))
                .navigationTitle("Home")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading, content:  {
                        Button(action: {
                            withAnimation{
                                
                                showDrawer = true
                                
                            }
                        }, label: {
                            Image(systemName: "line.horizontal.3")
                                .bold()
                                .scaleEffect(CGSize(width: 1.25, height: 1.25))
                                
                        })})
                    ToolbarItemGroup(placement: .navigationBarTrailing ){
                        Button(action: {
                            isShowingAddCounter = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "square.grid.3x3.fill")
                        })
                    }
                })
            }
            .sheet(isPresented: $isShowingAddCounter, content: {
                AddCounterPage(isShowingAddCounter: $isShowingAddCounter)
            })
            .disabled(showDrawer)
           
            HomeDrawer(isOn: $showDrawer)
            
            
        }
    }
}


#Preview {
    HomePage()
}

