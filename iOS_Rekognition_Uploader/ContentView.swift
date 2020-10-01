//
//  ContentView.swift
//  iOS_Rekognition_Uploader
//
//  Created by Roger Navarro on 9/27/20.
//

import SwiftUI
import Combine
import Amplify

struct ContentView: View {
  
  @State var imageStringURL: String = ""
  @ObservedObject var viewModel = ViewModel()
//  @ObservedObject var imageLoader:ImageLoader = ImageLoader(urlString: "https://cdni.llbean.net/is/image/wim/296437_116_41?hei=1092&wid=950&resMode=sharp2&defaultImage=llbstage/A0211793_2")
  @State var image:UIImage = UIImage()
  @State var showImagePicker: Bool = false
  
  var body: some View {
    
    VStack {
      Button("Upload Image", action: {
              self.showImagePicker.toggle()
      })
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width:200, height:200)
    }
    .sheet(isPresented: $showImagePicker, content: {
      ImagePicker.shared.view
    })
    .onReceive(ImagePicker.shared.$image, perform: { image in //shows image in ImageView
      if let image = image {
        self.image = image
      }
    })
    .onReceive(ImagePicker.shared.$imageUrl, perform: { imageURL in //calls Detect Labels Function
      if let imageURL = imageURL {
        self.detectLabels(imageURL: imageURL)
      }
    })
    
  }
  
  func detectLabels(imageURL: URL) {
    _ = Amplify.Predictions.identify(type: .detectLabels(.labels), image: imageURL, options: PredictionsIdentifyRequest.Options(), listener: { (event) in

        switch event {
        case .success(let result):
            let data = result as! IdentifyLabelsResult
          print(data.labels)
//            self.setNewLabels(result: data)
        case .failure(let error):
            print(error)
        default:
            print("")
        }
    })
    
    //Using Combine -> Not working :(
//    _ = Amplify.Predictions.identify(type: .detectLabels(.labels), image: imageURL, options: PredictionsIdentifyRequest.Options())
//      .resultPublisher
//      .sink {
//        if case let .failure(error) = $0 {
//          print(error)
//        }
//        print("heeeeey!!!!!!!")
//      }
//      receiveValue: { result in
//        let data = result as! IdentifyLabelsResult
//        print(data.labels)
//        // Use the labels in your app as you like or display them
//      }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
