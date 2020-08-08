//  Created by Gagandeep Singh on 7/8/20.

import Cocoa

protocol ImageCache {
    subscript(_ path: String) -> NSImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSString, NSImage>()
    
    subscript(_ key: String) -> NSImage? {
        get { cache.object(forKey: key as NSString) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSString) : cache.setObject(newValue!, forKey: key as NSString) }
    }
}
