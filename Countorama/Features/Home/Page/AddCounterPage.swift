import SwiftUI
struct AddCounterPage: View {
    @Binding var isShowingAddCounter:Bool;

    @EnvironmentObject var homeVM:HomeViewModel
    @StateObject var vm = AddCounterViewModel(counterRepository: .shared, countRepository: .shared,tagRepository: .shared)
            
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
                    TextField("Name", text: $vm.counterName)
                    TextField("Frequency", text: $vm.counterFrequency)
                        .textContentType(.telephoneNumber)
                    Section("Counter Configuration") {
                        
                        ColorPicker("Color", selection: $vm.counterColor)
                        
                        if !vm.tags.isEmpty {
                               Picker("Tag", selection: $vm.selectedOption) {
                                   ForEach(vm.tags, id: \.self) { option in
                                       Text(option.label)
                                           .tag(option as CDTag?) 
                                   }
                               }
                               .pickerStyle(.menu)
                           }
                       else
                        {
                            HStack{
                                Text("Tag")
                                Spacer()
                                Text("No Tags Available")
                                    .foregroundStyle(.accent)
                            }
                            .padding(.horizontal,2)
                        }
                    }
                    .fontWeight(.regular)
                    
                    
                    Section("Optional"){
                        Toggle("Set Target Date", isOn: $vm.hasTargetDate)
                        if(vm.hasTargetDate)
                        {
                            DatePicker("Target Date", selection: $vm.counterTargetDate, displayedComponents: .date)
                        }
                        
                    }.fontWeight(.regular)
                }
                
                Button(action: onConfirmSheet, label: {
                    Text("Confirm")
                        .frame(width: 260, height: 42)
                })
                .buttonStyle(.bordered)
                .tint(.accent)
                .padding(.bottom,36)
                
            }
            
        }
       
        
    }
    
    func onConfirmSheet(){
        isShowingAddCounter = false
        homeVM.addCounter(counterParam: CounterParam(name: vm.counterName, dailyFrequency: Int(vm.counterFrequency) ?? 0,tag: vm.selectedOption, targetDate: vm.counterTargetDate, color: vm.counterColor))
        
    }
}

#Preview {
    AddCounterPage(isShowingAddCounter: .constant(false))
}
