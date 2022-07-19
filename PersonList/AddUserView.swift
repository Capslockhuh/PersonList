//
//  AddUserView.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import SwiftUI

struct AddUserView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var name = ""
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showingImagePicker = false
    
    @StateObject var people = People()
    
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
            }
            .navigationTitle("Add a new person")
            .onChange(of: inputImage) { _ in loadImage() }
            .toolbar {
                Button("Save") {
                    guard let inputImage = inputImage else { return }
                    guard let jpegData = inputImage.jpegData(compressionQuality: 0.8) else { return }
                    // Assign the entered values to a person instance or use a placeholder image
                    let person = Person(id: UUID(), name: name, jpegData: jpegData)
                    // Append it to the array of people
                    people.peopleList.append(person)
                    // Save all the other stuff to the disk
                    people.save()
                    // Dismiss the sheet
                    dismiss()
                }
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
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
