//
//  AddUserView.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import SwiftUI
import MapKit

struct AddUserView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var name = ""
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showingImagePicker = false
    
    @StateObject var people = People()
    
    let locationFetcher = LocationFetcher()
    
    @State private var personLocation = CLLocationCoordinate2D()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ZStack {
                        Rectangle()
                            .fill(.secondary)
                            .onTapGesture {
                                showingImagePicker = true
                            }
                            .accessibilityAddTraits(.isButton)
                        Text("Tap to select a picture")
                            .font(.subheadline)
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                } header: {
                    Text("Image")
                }
                
                Section {
                    TextField("Person's name", text: $name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    Button("Add a location") {
                                       self.locationFetcher.start()
                                   }
                                   
                                   Button("Read location") {
                                       if let location = self.locationFetcher.lastKnownLocation {
                                           print("Your location is \(location)")
                                           personLocation = location
                                       } else {
                                           print("Failed to read location.")
                                       }
                                   }
                } header: {
                    Text("Location")
                }
                
            }
            .navigationTitle("Add a new person")
            .onChange(of: inputImage) { _ in loadImage() }
            .toolbar {
                Button("Save") {
                    guard let inputImage = inputImage else { return }
                    guard let jpegData = inputImage.jpegData(compressionQuality: 0.8) else { return }
                    // Assign the entered values to a person instance or use a placeholder image
                    let person = Person(id: UUID(), name: name, jpegData: jpegData, latitude: personLocation.latitude, longitude: personLocation.longitude)
                    // Append it to the array of people
                    people.peopleList.append(person)
                    // Save all the other stuff to the disk
                    people.save()
                    // Dismiss the sheet
                    dismiss()
                }
                .disabled(isValid())
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        image = Image(uiImage: inputImage)
    }
    
    func isValid() -> Bool {
        if name.isEmpty || image == nil {
            return true
        } else {
            return false
        }
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
