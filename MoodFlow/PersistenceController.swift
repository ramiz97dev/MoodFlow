import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {

        container = NSPersistentContainer(name: "Model")

        container.loadPersistentStores { _, error in

            if let error = error {

                fatalError("Core Data Fehler: \(error)")
            }
        }
    }
}
