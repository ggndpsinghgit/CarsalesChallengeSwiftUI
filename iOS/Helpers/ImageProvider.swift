//  Created by Gagandeep Singh on 8/8/20.

import SwiftUI
import Combine

class ImageProvider: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private let loader = ImageLoader(cache: TemporaryImageCache())
    
    func load(at path: String) {
        guard let url = URL(string: path) else { return }
        cancellable = loader.load(at: url) { result in
            self.image = result.1
        }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
