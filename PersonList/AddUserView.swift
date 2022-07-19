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
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: CGFloat(10), height: CGFloat(10)))
                            .fill(.secondary)
                        Text("Tap to select a picture")
                            .onTapGesture {
                                ImagePicker(image: $inputImage)
                            }
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
            .onChange(of: inputImage) { _ in loadImage() }
            .toolbar {
                Button("Save") {
                    let person = Person(id: UUID(), name: name, image: image ?? Image("testimage"))
                    dismiss()
                }
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
