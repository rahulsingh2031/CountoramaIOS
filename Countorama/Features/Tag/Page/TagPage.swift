//
//
//  TagPage.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct TagPage: View {
    @StateObject var vm = TagViewModel(tagRepository: CDTagRepository.shared,counterRepository: CDCounterRepository.shared)
    
    var body: some View {
        
        NavigationStack(path: $vm.path){
            VStack{
                HStack{
                   
                    TextField(text: $vm.tagName, label: {
                        Text("Create new tag")
                    })
                    .padding()
                    .frame(height: 40)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    Button(action: {
                        
                        vm.addTag()
                        
                    }, label: {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .frame(width: 36, height: 36)
                        
                    })
                    
                }
                .padding(.horizontal,12)
                
                List{
                    
                    ForEach(vm.tags){
                        tag in
                        
                        TagTextField(tag: tag){
                            vm.getCounterByTag(tag: tag)
                            vm.path.append(tag)
                        }
                            .listRowSeparator(.hidden)
                            .environmentObject(vm)
                    }
                    .onDelete{
                        indexSet in
                        
                        if let index = indexSet.first {
                               let tag = vm.tags[index]
                               vm.deleteTag(tag: tag) 
                           }
                    }
                }
                
                .listStyle(.insetGrouped)
                
                Spacer()
                
            }
            
            
            .navigationTitle("Tags")
            .navigationDestination(for: CDTag.self, destination: { tag in
                TagSearchView(counters:$vm.counters)
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    EditButton()
                })
            })
            .onAppear{
                vm.fetchTags()
            }
        }
        
    }
}

#Preview {
    TagPage()
}
