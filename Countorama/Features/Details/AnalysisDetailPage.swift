//
//  AnalysisDetailPage.swift
//  Countorama
//
//  Created by Raj Singh on 09/01/25.
//

import SwiftUI


enum CounterAnalysis:Hashable,CaseIterable,Identifiable {
    var id: Self { self }
    
    case today
    case thisMonth
    case total
    case days
}

struct AnalysisDetailPage: View {
    
    
    let counterAnalysisType = [CounterAnalysis.today:"Today",
                               CounterAnalysis.thisMonth:"This Month",
                               CounterAnalysis.total:"Total",
                               CounterAnalysis.days:"30 Days"]
    @State var selectedCounterAnalysisType = CounterAnalysis.days
    @State var isShowingEditDetail = false
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                HStack{
                    Text("34")
                        .font(.system(size: 60,weight: .semibold))
                    Spacer()
                }
                
                Picker(selection: $selectedCounterAnalysisType) {
                    ForEach(CounterAnalysis.allCases) { counterType in
                        Text(counterAnalysisType[counterType] ?? "")
                                                 .tag(counterType)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(.segmented)

              
                 Spacer()
            }
            
            .safeAreaPadding()
                .navigationTitle("Exercise")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {isShowingEditDetail = true}, label: {
                            Image(systemName: "square.and.pencil")
                                .bold()
                                
                        })
                    }
                })
        }
        .blur(radius: isShowingEditDetail ? 10 : 0)
        .sheet(isPresented: $isShowingEditDetail, content: {
             AnalysisDetailEditPage(isShowingEditDetail: $isShowingEditDetail)
        })
       
    }
}

#Preview {
    AnalysisDetailPage(selectedCounterAnalysisType: .days)
}
