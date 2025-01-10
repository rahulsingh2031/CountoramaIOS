//
//  CounterListItemView.swift
//  Countorama
//
//  Created by Raj Singh on 04/01/25.
//

import SwiftUI

struct CounterListItemView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 132)
            .foregroundColor(.gray)
            .listRowSeparator(.hidden)
            .listRowBackground(Color(.systemBackground))
            .overlay{
                VStack(alignment:.leading){
                    Text("Counter Name")
                        .fontWeight(.medium)
                        .font(.title3)
                        .lineLimit(1) // Restrict to 1 line
                        .truncationMode(.tail)
                    
                    HStack{
                        Text("Today")
                            .fontWeight(.regular)
                            .font(.footnote)
                        Spacer()
                        Label(
                            title: { Text("0")
                                    .fontWeight(.light)
                            },
                            icon: { Image(systemName: "chart.bar.fill")
                                    .foregroundColor(.white)
                            }
                        )
                        
                        .scaleEffect(CGSize(width: 0.7, height: 0.7))
                        Spacer()
                            .frame(width: 12)
                    }
                    
                    HStack {
                        Text("0")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .scaleEffect(CGSize(width: 1.4, height: 1.4))
                        
                        
                        Spacer()
                        //TODO: Change this interaction in zstack
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "arrowshape.up.fill")
                                .frame(width: 72 , height: 48)
                                .foregroundColor(.gray.opacity(0.8))
                                .background(Color(.systemBackground.withAlphaComponent(0.6)))
                                .clipShape(.capsule)
                        })
                    }
                    
                }.padding()
            }
    }
}


#Preview {
    CounterListItemView()
}
