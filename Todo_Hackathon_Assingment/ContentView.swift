import SwiftUI

struct ContentView: View {
    @StateObject var vm = TaskViewModel()
    @State private var newTask = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack(spacing : 12){
                    
                    Image(systemName: "square.and.pencil")
                            .foregroundStyle(.secondary)
                    
                    TextField("Add new task",text: $newTask)
                        .textFieldStyle(.roundedBorder)
                    
                    Button{
                        vm.addTask(title: newTask)
                        newTask = ""
                    }label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 34, height: 34)
                            .background(Circle().fill(Color.accentColor))
                        
                    }
                    
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black.opacity(0.05))
                )
                .padding(.horizontal)
                .padding(.top, 8)
                
                if vm.tasks.isEmpty{
                    Spacer()
                    Text("No Tasks for today!!!")
                    Spacer()
                }else{
                    List{
                        ForEach(vm.tasks,id: \.objectID){ task in
                            
                            HStack{
                                Text(task.title ?? "")
                                    .font(.system(size: 15,weight: .medium))
                                    .strikethrough(task.isCompleted)
                                    .foregroundStyle(task.isCompleted ? .secondary : .primary)
                                 Spacer()
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            vm.completedToggle(task)
                                        }
                                        
                                    }
                                    .font(.title3)
                                    .foregroundStyle(task.isCompleted ? .green : .gray)
                                    
                                
                            }
                            .padding()
                            .frame(height: 60)
                            .background(RoundedRectangle(cornerRadius: 14, style: .continuous).fill(Color(.secondarySystemBackground)))
                            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.black.opacity(0.05)))
                        }
                        .onDelete(perform: vm.deleteTask)


                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGroupedBackground))
                }
            }
        }
        
    }
}

