//
//  AddCounterPage.swift
//  Countorama
//
//  Created by Raj Singh on 04/01/25.
//

import SwiftUI

struct AddCounterPage: View {
    @Binding var isShowingAddCounter:Bool;
    @State private var counterName = ""
    @State private var counterColor = Color(.systemGray5)
    @State private var counterFrequency = ""
    @State private var hasTargetDate = false
    @State private var counterTargetDate = Date()
    
    
    @State private var selectedOption = "Option 1"
    let options = ["Default", "Exercise", "Wrestling"]
    
    var body: some View {
        ZStack(alignment:.topTrailing){
            
            Button(action: {isShowingAddCounter = false}, label: {
                Text("Cancel")
            })
            .padding()
            VStack(alignment:.center){
                Text("Create New Counter").bold()
                    .padding()
                
                Form{
                    TextField("Name", text: $counterName)
                    TextField("Frequency", text: $counterFrequency)
                        .textContentType(.telephoneNumber)
                    Section("Counter Configuration") {
                        
                        ColorPicker("Color", selection: $counterColor)
                        
                        
                        Picker("Tag", selection: $selectedOption) {
                            ForEach(options, id: \.self) { option in
                                Text(option)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .fontWeight(.regular)
                    
                    
                    Section("Optional"){
                        Toggle("Set Target Date", isOn: $hasTargetDate)
                        if(hasTargetDate)
                        {
                            DatePicker("Target Date", selection: $counterTargetDate, displayedComponents: .date)
                        }
                        
                    }.fontWeight(.regular)
                }
                
                Button(action: {isShowingAddCounter = false}, label: {
                    Text("Confirm")
                        .frame(width: 260, height: 42)
                    
                    
                    
                })
                .buttonStyle(.bordered)
                .tint(.accent)
                .padding(.bottom,36)
                
            }
            
        }
        
    }
}

#Preview {
    AddCounterPage(isShowingAddCounter: .constant(false))
}
