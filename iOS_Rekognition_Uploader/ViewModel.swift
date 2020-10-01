//
//  viewModel.swift
//  iOS_Rekognition_Uploader
//
//  Created by Roger Navarro on 9/28/20.
//

import Foundation
import Combine
import Amplify

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

class ViewModel: ObservableObject {
  
}
