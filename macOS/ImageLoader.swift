//  Created by Gagandeep Singh on 7/8/20.

import SwiftUI
import Combine

class ImageProvider: ObservableObject {
    @Published var image: NSImage?
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

class ImageLoader {
    private var cache: ImageCache
    
    init(cache: ImageCache) {
        self.cache = cache
    }
    
    func load(at url: URL, completion: @escaping ((String, NSImage?)) -> Void) -> AnyCancellable? {
        if let image = cache[url.absoluteString] {
            completion((url.absoluteString, image))
            return nil
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { NSImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { image in
                completion((url.absoluteString, image))
            })
    }
    
    private func cache(_ image: NSImage?, url: URL) {
        image.map { cache[url.absoluteString] = $0 }
    }
}
