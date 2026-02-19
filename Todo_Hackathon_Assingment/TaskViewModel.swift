//
//  TaskViewModel.swift
//  Todo_Hackathon_Assingment
//
//  Created by Vishal Pawar on 19/02/26.
//

import Foundation

@MainActor
class TaskViewModel : ObservableObject{
    @Published private(set) var tasks = [TasksDataEntity]()
    
    private let repository = TaskRepository()
    
    init(){
        loadTasks()
    }
    
    func loadTasks(){
        self.tasks = repository.fetchTodayTask()
    }
    
    func addTask(title : String){
        guard !title.isEmpty else { return}
        repository.addTask(title: title)
        loadTasks()
    }
    
    func completedToggle(_ task : TasksDataEntity){
        repository.completeToggle(task: task)
        objectWillChange.send()
    }
    
    func deleteTask(_ offsets: IndexSet){
//        repository.completeToggle(task: task)
//        loadTasks()
        
        offsets.forEach { index in
                let task = tasks[index]
                tasks.remove(at: index)
                repository.deleteTask(task: task)
            }
    }
}
