//
//  CounterListItemView.swift
//  Countorama
//
//  Created by Raj Singh on 04/01/25.
//

import SwiftUI

struct CounterListItemView: View {
    @EnvironmentObject var homeVM:HomeViewModel
    var counter:CDCounter
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 132)
            .foregroundColor(Color(hex: counter.color!))
            .listRowSeparator(.hidden)
            .listRowBackground(Color(.systemBackground))
            .onTapGesture {
                    homeVM.path.append(counter)
                }
            .overlay{
                VStack(alignment:.leading){
                    Text(counter.name)
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
                        Text("\(counter.value)")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .scaleEffect(CGSize(width: 1.4, height: 1.4))
                            .padding(.leading,10)
                        
                        
                        Spacer()
                        //TODO: Change this interaction in zstack
                        Button(action: {homeVM.incrementCount(counter: counter)}, label: {
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
    CounterListItemView(counter: CDCounter.preview(context: PersistenceController.preview.container.viewContext))
}
