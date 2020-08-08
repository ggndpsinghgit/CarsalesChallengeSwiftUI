//  Created by Gagandeep Singh on 7/8/20.

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

final class ImagesProvider: ObservableObject {
    @Published var images: Set<Value> = []
    private let imageLoader = ImageLoader(cache: TemporaryImageCache())
    private var cancellables: [AnyCancellable?] = []
    let paths: [String]
    
    init(paths: [String]) {
        self.paths = paths
        for path in paths {
            images.insert(.init(id: path, image: nil))
            objectWillChange.send()
        }
    }
    
    func load() {
        for path in paths {
            guard let url = URL(string: path) else { continue }
            let cancellable = imageLoader.load(at: url) { [weak self] result in
                self?.images.insert(.init(id: result.0, image: result.1))
            }
            cancellables.append(cancellable)
        }
    }
    
    struct Value: Identifiable, Hashable {
        let id: String
        let image: UIImage?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
