//
//  Contact+CoreDataProperties.swift
//  
//
//  Created by Ranferi Dominguez Rios on 23/11/20.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?

}
