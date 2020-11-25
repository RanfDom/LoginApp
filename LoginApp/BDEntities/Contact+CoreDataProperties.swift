//
//  Contact+CoreDataProperties.swift
//  
//
//  Created by Ranferi Dominguez Rios on 24/11/20.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: NSSet?

}

// MARK: Generated accessors for phoneNumber
extension Contact {

    @objc(addPhoneNumberObject:)
    @NSManaged public func addToPhoneNumber(_ value: PhoneNumber)

    @objc(removePhoneNumberObject:)
    @NSManaged public func removeFromPhoneNumber(_ value: PhoneNumber)

    @objc(addPhoneNumber:)
    @NSManaged public func addToPhoneNumber(_ values: NSSet)

    @objc(removePhoneNumber:)
    @NSManaged public func removeFromPhoneNumber(_ values: NSSet)

}
