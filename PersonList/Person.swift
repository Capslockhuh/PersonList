//
//  Person.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import Foundation
import SwiftUI
import MapKit

struct Person: Identifiable, Comparable, Codable {
    let id: UUID
    var name: String
    let jpegData: Data
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    var image: Image? {
        let uiImage = UIImage(data: jpegData)
        
        guard let uiImage = uiImage else { return nil }
        
        return Image(uiImage: uiImage)
    }
    
    var coordinate: CLLocationCoordinate2D? {
            guard let latitude = latitude else { return nil }
            guard let longitude = longitude else { return nil }
            
            return .init(latitude: latitude, longitude: longitude)
        }

    
    static func <(lhs: Person, rhs: Person) -> Bool {
            lhs.name < rhs.name
        }
    
}

class People: ObservableObject {
    @Published var peopleList = [Person]()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("savedPeople")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            peopleList = try JSONDecoder().decode([Person].self, from: data).sorted()
        } catch {
            peopleList = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(peopleList)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Saving data has failed.")
        }
    }
}
