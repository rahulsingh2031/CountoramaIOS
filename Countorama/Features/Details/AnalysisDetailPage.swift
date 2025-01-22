//
//  AnalysisDetailPage.swift
//  Countorama
//
//  Created by Raj Singh on 09/01/25.
//

import SwiftUI
import Charts


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
    @EnvironmentObject var homeVM : HomeViewModel
    @ObservedObject var counter:CDCounter
    @State var counterValue = ""
    @State var disableTextField = true
    @FocusState var showKeyboard:Bool {
        didSet{
            disableTextField.toggle()
        }
    }
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(alignment:.leading){
                HStack{
                    TextField("\(counter.value)", text: $counterValue)
                        .onChange(of: counter.value, {
                            counterValue = String(counter.value)
                        })
                        .onSubmit {
                            showKeyboard = false
                            homeVM.editTodayCountByCustomValue(value: counterValue, counter: counter)
                            counterValue = String(counter.value)
                    }
                        .disabled(disableTextField)
                        .focused($showKeyboard)
                        
                        .font(.system(size: 60,weight: .semibold))
                    Spacer()
                }
                .onAppear(perform: {
                    counterValue = String(counter.value)
                })
                
                Picker(selection: $selectedCounterAnalysisType) {
                    ForEach(CounterAnalysis.allCases) { counterType in
                        Text(counterAnalysisType[counterType] ?? "")
                            .tag(counterType)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(.segmented)
                
                
                HStack(spacing:32){
                    Spacer()
                    Button(action: {
                        homeVM.incrementCount(counter: counter)
                        showKeyboard = false
                    }, label: {
                        Image(systemName: "arrowshape.backward.circle")
                            .resizable()
                            .frame(width: 48,height: 48)
                            .rotationEffect(.degrees(90))
                        
                    })
                    Button(action: {
                        homeVM.decreaseCount(counter: counter)
                        showKeyboard = false
                    }, label: {
                        Image(systemName: "arrowshape.backward.circle")
                            .resizable()
                            .frame(width: 48,height: 48)
                            .rotationEffect(.degrees(270))
                        
                    })
                    
                    Button(action: {
                        showKeyboard.toggle()
                    }, label: {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .frame(width: 48,height: 48)
                            .fontWeight(.semibold)
                            .rotationEffect(.degrees(90))
                        
                        
                    })
                    
                    Spacer()
                    
                }
                .tint(.white)
                .padding()
                
                
                GroupBox(label:Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                    .font(.title3), content: {
                        VStack(spacing:24){
                            GroupBox {
                                HStack{
                                    VStack{
                                        Text("Max Streak")
                                        Text("1")
                                            .bold()
                                            .font(.title)
                                    }
                                    Spacer()
                                    Text("•")
                                    Spacer()
                                    VStack{
                                        Text("Current Streak")
                                        Text("1")
                                            .bold()
                                            .font(.title)
                                    }
                                    
                                }
                            }
                            GroupBox{
                                HeatmapChartView()
                                    .frame(height: 200)
                                    .aspectRatio(contentMode: .fill)
                            }
                        }
                        
                    })
                
                
                
                
                
                
                
                .navigationTitle(counter.name)
                
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {isShowingEditDetail = true}, label: {
                            Image(systemName: "square.and.pencil")
                                .bold()
                            
                        })
                    }
                })
                
                
                .sheet(isPresented: $isShowingEditDetail, content: {
                    AnalysisDetailEditPage(isShowingEditDetail: $isShowingEditDetail)
                })
                
            }
            .safeAreaPadding()
            
        })
        .ignoresSafeArea(.keyboard)
          
            
           
        
    }
    
}

#Preview {
    AnalysisDetailPage(selectedCounterAnalysisType: .days,counter: CDCounter.preview(context: PersistenceController.preview.container.viewContext), counterValue: "0")
}
