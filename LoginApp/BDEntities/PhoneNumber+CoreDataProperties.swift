//
//  PhoneNumber+CoreDataProperties.swift
//  
//
//  Created by Ranferi Dominguez Rios on 24/11/20.
//
//

import Foundation
import CoreData


extension PhoneNumber {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneNumber> {
        return NSFetchRequest<PhoneNumber>(entityName: "PhoneNumber")
    }

    @NSManaged public var title: String?
    @NSManaged public var number: String?
    @NSManaged public var toContact: Contact?

}
