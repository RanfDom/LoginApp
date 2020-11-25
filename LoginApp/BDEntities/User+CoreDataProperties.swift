//
//  User+CoreDataProperties.swift
//  
//
//  Created by Ranferi Dominguez Rios on 24/11/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var pwd: String?

}
