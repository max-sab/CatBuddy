//
//  ImageRequest.swift
//  CatBuddy
//
//  Created by Maksym Sabadyshyn on 5/21/20.
//  Copyright © 2020 Maksym Sabadyshyn. All rights reserved.
//

import Foundation
import UIKit

class ImageRequest {
    let url: URL

    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }

    func getData(with completion: @escaping (UIImage?) -> ()) {
        load(url, with: completion)
    }
}
