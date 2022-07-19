//
//  ContentView.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Button("test") {
                        showingImagePicker = true
                    }
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
            }
            .navigationTitle("PersonList")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in loadImage() }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
