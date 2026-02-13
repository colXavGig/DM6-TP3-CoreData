import Foundation
import CoreData

@objc(Personne)
public class Personne: NSManagedObject {

}

extension Personne {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Personne> {
        return NSFetchRequest<Personne>(entityName: "Personne")
    }

    @NSManaged public var nom: String?
    @NSManaged public var age: Int16

}

extension Personne : Identifiable {

}
