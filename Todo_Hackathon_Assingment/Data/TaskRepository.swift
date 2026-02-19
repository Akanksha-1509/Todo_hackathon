//
//  TaskRepository.swift
//  Todo_Hackathon_Assingment
//
//  Created by Vishal Pawar on 19/02/26.
//

import Foundation
import CoreData


class TaskRepository{
    private let context = CoreDataStack.shared.context
    
    
    func fetchTodayTask() -> [TasksDataEntity]{
        let request : NSFetchRequest<TasksDataEntity> = TasksDataEntity.fetchRequest()
        
        let dayStart = Calendar.current.startOfDay(for: Date())
        let tommorow = Calendar.current.date(byAdding: .day, value: 1, to: dayStart)!
                                             
        request.predicate = NSPredicate(format: "createdAt >= %@ AND createdAt < %@",dayStart as NSDate,tommorow as NSDate
        )
        
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        return (try? context.fetch(request)) ?? []
                                        
    }
    
    func addTask(title : String){
        let task = TasksDataEntity(context: context)
        task.id = UUID()
        task.title = title
        task.isCompleted = false
        task.createdAt = Date()
        
        CoreDataStack.shared.save()
    }
    
    func completeToggle(task : TasksDataEntity){
        task.isCompleted.toggle()
        CoreDataStack.shared.save()
    }
    
    func deleteTask(task : TasksDataEntity){
        context.delete(task)
        CoreDataStack.shared.save()
    }
}
