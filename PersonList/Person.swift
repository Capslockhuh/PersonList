//
//  Person.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Comparable {
    let id: UUID
    var name: String
    var image: Image
    
    static func <(lhs: Person, rhs: Person) -> Bool {
            lhs.name < rhs.name
        }
    
    static let example = Person(id: UUID(), name: "Test", image: Image("testimage"))
}

class People: ObservableObject {
    var peopleList = [Person]()
}
