//
//  PersonDetailsView.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import SwiftUI

struct PersonDetailsView: View {
    @State var name: String
    @State var image: Image
    var body: some View {
        NavigationView {
            VStack {
               image
                    .resizable()
                    .scaledToFill()
                
                Text(name)
                    .font(.headline)
            }
            .navigationTitle("\(name)'s details")
        }
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(name: "placeholder", image: Image("testimage"))
    }
}
