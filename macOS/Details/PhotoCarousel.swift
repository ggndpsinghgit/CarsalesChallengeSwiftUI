//  Created by Gagandeep Singh on 8/8/20.

import SwiftUI

struct PhotoCarousel: View {
    let photos: [String]
    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 240, maximum: 360))]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(photos, id: \.self) { path in
                    AsyncImageView(path: path)
                        .aspectRatio(1.5, contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding()
        }
        .frame(height: 300)
    }
}

struct PhotoCarousel_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCarousel(photos: [])
    }
}
