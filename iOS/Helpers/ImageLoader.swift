//  Created by Gagandeep Singh on 7/8/20.

import SwiftUI
import Combine

class ImageLoader {
    private var cache: ImageCache
    
    init(cache: ImageCache) {
        self.cache = cache
    }
    
    func load(at url: URL, completion: @escaping ((String, UIImage?)) -> Void) -> AnyCancellable? {
        if let image = cache[url.absoluteString] {
            completion((url.absoluteString, image))
            return nil
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { image in
                completion((url.absoluteString, image))
            })
    }
    
    private func cache(_ image: UIImage?, url: URL) {
        image.map { cache[url.absoluteString] = $0 }
    }
}
