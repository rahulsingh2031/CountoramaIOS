//
//  CounterGridItemView.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct CounterGridItemView: View {
    
    var itemWidth:CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .frame(width:200, height: 245)
        
            .foregroundColor(.gray)
            .overlay{
                VStack(spacing:8){
                    Text("Read 15 min daily")
                        .fontWeight(.medium)
                        .font(.headline)
                        .lineLimit(1) // Restrict to 1 line
                        .truncationMode(.tail)
                    Text("Today")
                        .fontWeight(.regular)
                        .font(.footnote)
                    
                    VStack(spacing:12){
                        Spacer()
                        Text("0")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .scaleEffect(CGSize(width: 1.4, height: 1.4))
                        
                        Label(
                            title: { Text("0")
                                    .fontWeight(.light)
                            },
                            icon: { Image(systemName: "chart.bar.fill")
                                    .foregroundColor(.white)
                            }
                        )
                        
                        .scaleEffect(CGSize(width: 0.7, height: 0.7))
                        
                        
                    }
                    
                    //TODO: Change this interaction in zstack
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "arrowshape.up.fill")
                            .frame(width: 84 , height: 56)
                            .foregroundColor(.gray.opacity(0.8))
                            .background(Color(.systemBackground.withAlphaComponent(0.6)))
                            .clipShape(.capsule)
                    })
                    .padding(.bottom,8)
                    
                    
                }.padding()
            }
        
        
    }
}

#Preview {
    CounterGridItemView(itemWidth:80)
}
