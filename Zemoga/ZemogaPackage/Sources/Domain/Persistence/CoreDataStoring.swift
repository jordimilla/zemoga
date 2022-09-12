import CoreData

public enum StorageType {
    case persistent, inMemory
}

extension NSManagedObject {
    public class var entityName: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

public protocol EntityCreating {
    var viewContext: NSManagedObjectContext { get }
    func createEntity<T: NSManagedObject>() -> T
}

extension EntityCreating {
    public func createEntity<T: NSManagedObject>() -> T {
        T(context: viewContext)
    }
}

public protocol CoreDataFetchResultsPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publicher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultsPublisher<T>
}

extension CoreDataFetchResultsPublishing {
    public func publicher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultsPublisher<T> {
        return CoreDataFetchResultsPublisher(request: request, context: viewContext)
    }
}

public protocol CoreDataDeleteModelPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publicher(delete request: NSFetchRequest<NSFetchRequestResult>) -> CoreDataDeleteModelPublisher
}

extension CoreDataDeleteModelPublishing {
    public func publicher(delete request: NSFetchRequest<NSFetchRequestResult>) -> CoreDataDeleteModelPublisher {
        return CoreDataDeleteModelPublisher(delete: request, context: viewContext)
    }
}

public protocol CoreDataSaveModelPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publicher(save action: @escaping Action) -> CoreDataSaveModelPublisher
}

extension CoreDataSaveModelPublishing {
    public func publicher(save action: @escaping Action) -> CoreDataSaveModelPublisher {
        return CoreDataSaveModelPublisher(action: action, context: viewContext)
    }
}

public protocol CoreDataStoring: EntityCreating, CoreDataFetchResultsPublishing, CoreDataDeleteModelPublishing, CoreDataSaveModelPublishing {
    var viewContext: NSManagedObjectContext { get }
}

