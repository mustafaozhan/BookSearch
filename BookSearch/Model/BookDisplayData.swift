//
//  BookDisplayData.swift
//  BookSearch
//
//  Created by Mustafa Ozhan on 21/07/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation
import SwiftUI

struct BookDisplayData: Identifiable {
    let id:  String
    let title: String
    let authors: [String]
    let description: String
    let thumbnail: URL?
    
    func fetchImage(completion: @escaping ((UIImage?) -> Void)) {
        guard let thumbURL = self.thumbnail else {
            return
        }
        
        _ = APIService.fetchImageData(imageUrl: thumbURL)
            .map{ UIImage(data: $0) }
            .replaceError(with: nil)
            .sink { image in
                completion(image)
        }
    }
}
