//
//
//  TagPage.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct TagPage: View {
    @State var tagName  = ""
    var body: some View {
        
        NavigationView{
            VStack{
                HStack{
                    TextField(text: $tagName, label: {
                        Text("Create new tag")
                    })
                    .padding()
                    .frame(height: 40)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    Button(action: {}, label: {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .frame(width: 36, height: 36)
                        
                    })
                    
                }
                
                List{
                    Text("Hello 1")
                        .listRowSeparator(.hidden)
                    
                    Text("Hello 2")
                        .listRowSeparator(.hidden)
                    Text("Hello 3")
                        .listRowSeparator(.hidden)
                    Text("Hello 4")
                        .listRowSeparator(.hidden)
                    
                    
                }
                
                .listStyle(.plain)
                
                Spacer()
                
            }
            .padding()
            
            .navigationTitle("Tags")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    EditButton()
                })
            })
        }
        
    }
}

#Preview {
    TagPage()
}
