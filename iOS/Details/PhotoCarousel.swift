//  Created by Gagandeep Singh on 8/8/20.

import SwiftUI

struct PhotoCarousel: View {
    let photos: [String]
    
    var body: some View {
        TabView {
            ForEach(photos, id: \.self) { path in
                SyncImageView(path: path)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
            }
        }
        .aspectRatio(1.5, contentMode: .fit)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PhotoCarousel_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCarousel(photos: [])
    }
}
