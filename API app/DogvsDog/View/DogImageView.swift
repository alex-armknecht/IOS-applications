//
//  DogImageView.swift
//  DogvsDog
//
//  Created by zan on 3/11/22.
//

import SwiftUI

struct DogImageView: View {

    var dog: Dog
    
    var body: some View {
        AsyncImage(url: URL(string: dog.url))
            { image in image
                    .resizable()
                    .frame(maxWidth: 200, maxHeight: 200)
                    .cornerRadius(50)
            }
            placeholder: {
            Rectangle()
                    .fill(Color.white)
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
            }
    }
}

