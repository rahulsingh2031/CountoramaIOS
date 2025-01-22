//
//  TagTextField.swift
//  Countorama
//
//  Created by Raj Singh on 14/01/25.
//

import SwiftUI

struct TagTextField: View {
    var tag:CDTag
    let action: () -> Void
    @EnvironmentObject var vm : TagViewModel
    
    @State private var isEditing: Bool = false
    @State private var textFieldTagName = ""
    
    var body: some View {
        ZStack {
            
            Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                    if isEditing {
                        isEditing = false
                    }
                }
                .ignoresSafeArea()
            
            VStack {
                
                TextField("\(tag.label)", text: $textFieldTagName)
                    .onSubmit {
                        vm.updateTag(tag: tag, label: textFieldTagName)
                        isEditing = false
                    }
                    .padding(.horizontal,40)
                                   .frame(height: 36)                                 
                                   .onTapGesture {
                                       isEditing = true
                                   }
                .overlay {
                    if isEditing {
                   
                        HStack {
                            Image(systemName: "trash.circle.fill")
                                
                                .scaleEffect(CGSize(width: 1.5, height: 1.5))
                                .onTapGesture {
                                    vm.deleteTag(tag: tag)
                                }
                            Spacer()
                            Image(systemName: "checkmark.circle")
                               
                                .scaleEffect(CGSize(width: 1.5, height: 1.5))
                                .onTapGesture {
                                    isEditing = false
                                    vm.updateTag(tag: tag, label: textFieldTagName)
                                }
                        }
                        
                        
                    }
                    else{
                        
                        HStack{
                            Image(systemName: "tag")
                                
                                .scaleEffect(CGSize(width: 1.2, height: 1.2))
                                
                            Spacer()
                            Image(systemName: "magnifyingglass.circle.fill")
                                
                                .scaleEffect(CGSize(width: 1.5, height: 1.5))
                                .onTapGesture {
                                  //MARK: Search all counters by this tag
                                    action()
                                }
                        }
                        
                    }
                }
                
            }
           
        }
        .onAppear{
            textFieldTagName = tag.label
        }
    }
}
#Preview {
    TagTextField(tag: CDTag.preview(context: PersistenceController.preview.container.viewContext), action: {})
}
