import Foundation
import Domain
import CoreData

public class CoreDataStore: CoreDataStoring {
    
    private let container: NSPersistentContainer
    
    public static var `default`: CoreDataStoring = {
        return CoreDataStore(name: "Zemoga", in: .persistent)
    }()
    
    public var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    public init(name: String, in storageType: StorageType) {
        self.container = NSPersistentContainer(name: name)
        self.setupIfMemoryStorage(storageType)
        self.container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func setupIfMemoryStorage(_ storageType: StorageType) {
        if storageType  == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.container.persistentStoreDescriptions = [description]
        }
    }
}

