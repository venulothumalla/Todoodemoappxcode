//import SwiftUI
//
//struct ToDoTask: Identifiable {
//    var id = UUID()
//    var title: String
//    var isCompleted: Bool
//}
//
//struct ContentView: View {
//    @State private var tasks: [ToDoTask] = []
//    @State private var newTaskTitle: String = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack {
//                    TextField("Enter new task", text: $newTaskTitle)
//                        .font(.system(size: 22))
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .shadow(radius: 5)
//                        .textFieldStyle(PlainTextFieldStyle())
//                        .frame(height: 50)
//                    
//                    Button(action: addTask) {
//                        Image(systemName: "plus.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 60, height: 60)
//                            .foregroundColor(.blue)
//                            .padding()
//                            .background(Circle().fill(Color.white))
//                            .shadow(radius: 100)
//                    }
//                    .disabled(newTaskTitle.isEmpty)
//                }
//                .padding()
//                
//                List {
//                    ForEach($tasks) { $task in
//                        HStack {
//                            Text(task.title)
//                                .font(.system(size: 24))
//                                .strikethrough(task.isCompleted, color: .gray)
//                                .foregroundColor(task.isCompleted ? .gray : .primary)
//                            
//                            Spacer()
//                            
//                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
//                                .font(.system(size: 30))
//                                .foregroundColor(task.isCompleted ? .green : .gray)
//                                .onTapGesture {
//                                    task.isCompleted.toggle()
//                                }
//                        }
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(12)
//                        .shadow(radius: 10)
//                    }
//                    .onDelete(perform: deleteTask)
//                    .listRowSeparator(.hidden)
//                }
//                .listStyle(PlainListStyle())
//                .padding(.top, 20)
//                
//                Spacer()
//            }
//            .background(
//                Color.gray.opacity(0.1)
//                    .edgesIgnoringSafeArea(.all)
//            )
//            .navigationTitle("Fit Coders")
//            .navigationBarItems(trailing: EditButton())
//        }
//    }
//    
//    private func addTask() {
//        let newTask = ToDoTask(title: newTaskTitle, isCompleted: false)
//        tasks.append(newTask)
//        newTaskTitle = ""
//    }
//    
//    private func deleteTask(at offsets: IndexSet) {
//        tasks.remove(atOffsets: offsets)
//    }
//    
//}

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager  // ✅ Uses EnvironmentObject

    var body: some View {
        if authManager.isLoggedIn {
            ToDoView().environmentObject(authManager)  // ✅ No need to pass authManager manually
        } else {
            LoginView().environmentObject(authManager)  // ✅ No need to pass authManager manually
        }
    }
}

#Preview{
    ContentView ()
}
