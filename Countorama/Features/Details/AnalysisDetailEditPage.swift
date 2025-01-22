//
//  analysisDetailEditPage.swift
//  Countorama
//
//  Created by Raj Singh on 09/01/25.
//

import SwiftUI

struct AnalysisDetailEditPage: View {
    @State var newNameText = ""
    @State var newDate = Date()
    @State var newColor = Color(.systemGray5)
    

    @Binding var isShowingEditDetail:Bool;
    var body: some View {
        ZStack(alignment:.topTrailing){
            Button(action: {isShowingEditDetail = false}, label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .bold()
            })
            .padding()
            
            VStack{
                VStack(alignment:.leading,spacing: 4){
                    VStack(alignment:.leading,spacing:14){
                        Text("Daily Frequency: 1")
                            .fontWeight(.semibold)
                            .font(.title2)
                        
                        Text("This is where you can modify name,target date and its color")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.leading)
                       
                    }
                    .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))
                   
                        
                    Form{
                        TextField("Enter New Name", text: $newNameText)
                            
                        DatePicker("Pick a Date", selection: $newDate,displayedComponents: .date)
                            
                        ColorPicker("Pick a Color", selection: $newColor)
                       
                       
                    }
                    .frame(height:180)
                    
                   

                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Confirm & Modify")
                })
                .buttonStyle(.bordered)
                .tint(.accent)
               Spacer()
               

            }
            .padding(.top,64)
        }
       
       
    }
}

#Preview {
    AnalysisDetailEditPage(isShowingEditDetail: .constant(false))
}
