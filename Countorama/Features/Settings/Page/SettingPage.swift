//
//  SettingPage.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct SettingPage: View {
    
    @State var allowSwitchTheme = false
    @State var allowLocalNotication = false
    @State var allowHapticFeedback = false
    @State var allowAudioFeedback = false
    @State var allowConfettiFeedback = false
    
    var body: some View {
        NavigationView{
            Form{
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 100)
                    .foregroundStyle(Color(.systemGray6))
                    .overlay{
                        HStack(alignment:.top){
                            Image(systemName: "hand.thumbsup")
                                .font(.title2)
                            
                            VStack(alignment:.leading){
                                Text("Leave a feedback")
                                    .bold()
                                    .font(.title3)
                                Text("fill the feedback forum to request features or report the bugs")
                                
                                    .font(.body)
                            }
                        }
                        
                    }
                
                
                Section{
                    
                    Button(action: {}, label: {
                        Label("Import", systemImage: "arrow.down.circle.dotted")
                    })
                    
                    Button(action: {}, label: {
                        HStack(spacing:16){
                            Image(systemName: "arrow.down.circle.dotted")
                                .rotationEffect(.degrees(180))
                                .imageScale(.large)
                            Text("Export")
                        }
                    })
                    
                }
                
                Section("Common"){
                    Toggle(isOn: $allowSwitchTheme, label: {
                        Label("Switch Theme", systemImage: "switch.2")
                    })
                    
                    
                    //Language Picker
                    
                    Toggle(isOn: $allowHapticFeedback, label: {
                        Label("Haptic Feedback", systemImage: "lightspectrum.horizontal")
                    })
                    
                    Toggle(isOn: $allowAudioFeedback, label: {
                        Label("Audio Feedback", systemImage: "music.note.list")
                    })
                    
                    Toggle(isOn: $allowConfettiFeedback, label: {
                        Label("Confetti Feedback", systemImage: "party.popper")
                    })
                    
                    VStack(alignment:.center){
                        HStack{
                            Spacer()
                            Toggle(isOn: $allowLocalNotication, label: {
                                Label("Allow Local Notication", systemImage: "bell.badge")
                            })
                            .toggleStyle(.button)
                            Spacer()
                           
                        }
                        Text("Disable all counter local notification")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                      
                    }
                    
                }.toggleStyle(SwitchToggleStyle(tint: .accent))
                
                
                
                Section("Legal"){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Label("Clear All Counters", systemImage: "xmark.circle")
                    })
                    Link(destination: /*@START_MENU_TOKEN@*/URL(string: "https://www.apple.com")!/*@END_MENU_TOKEN@*/, label: {
                        Label("Data Privacy Terms", systemImage: "shield")
                    })
                    Link(destination: /*@START_MENU_TOKEN@*/URL(string: "https://www.apple.com")!/*@END_MENU_TOKEN@*/, label: {
                        Label("Terms and Conditions", systemImage: "person.badge.key.fill")
                    })
                    //Language Picker
                    
                }.toggleStyle(SwitchToggleStyle(tint: .accent))
                
            }
            .navigationTitle("Settings")
        }
        
    }
}

#Preview {
    SettingPage()
}
