//  Created by Gagandeep Singh on 7/8/20.

import SwiftUI

struct AsyncImageView: View {
    @ObservedObject private var provider: ImageProvider
    private let path: String
    
    init(path: String) {
        provider = ImageProvider()
        self.path = path
    }

    var body: some View {
        Group {
            if let image = provider.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "car")
                    .resizable()
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .foregroundColor(Color(UIColor.secondarySystemBackground))
        .onAppear {
            provider.load(at: path)
        }
        .onDisappear(perform: provider.cancel)
    }
}
