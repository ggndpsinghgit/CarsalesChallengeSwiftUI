//  Created by Gagandeep Singh on 7/8/20.

import SwiftUI

struct SyncImageView: View {
    private let path: String
    
    init(path: String) {
        self.path = path
    }

    var body: some View {
        Group {
            if
                let url = URL(string: path),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            {
                Image(uiImage: image).resizable()
            } else {
                Image(systemName: "car")
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .foregroundColor(Color(UIColor.secondarySystemBackground))
    }
}
