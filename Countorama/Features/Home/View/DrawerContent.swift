//
//  DrawerContent.swift
//  Countorama
//
//  Created by Raj Singh on 04/01/25.
//

import SwiftUI

struct DrawerContent: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 16){
            HStack(){
                Image(systemName: "star")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.accent)
                Text("Countorama")
                    .font(.title)
                    .fontWeight(.medium)
                
            }
          
            
            Spacer()
                .frame(height: 24)
            
            VStack(alignment: .leading,spacing: 24){
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Label(
                        title: { Text("Counter")
                                .font(.title3)
                                .fontWeight(.regular) },
                        icon: { Image(systemName: "alarm") }
                    )
                })
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Label(
                        title: { Text("Tags")
                                .font(.title3)
                                .fontWeight(.regular) },
                        icon: { Image(systemName: "tag") }
                    )
                })
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Label(
                        title: { Text("Settings")
                                .font(.title3)
                                .fontWeight(.regular) },
                        icon: { Image(systemName: "gear") }
                    )
                })
            }
          
            Spacer()
         
            
        }
        .safeAreaPadding(EdgeInsets(top: 60, leading: 30, bottom: 0, trailing: 30))
        
    }
}

#Preview {
    DrawerContent()
}
