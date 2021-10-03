//
//  ColourGetter.swift
//  APITestApp
//
//  Created by Prince Embola on 03/10/2021.
//

import Foundation

class ColourGetter: ObservableObject {
    @Published var hasLoaded:Bool = false
    @Published var colours: [Colour] = []
}

extension ColourGetter {
    
    struct Constants {
        static let colourURL = URL(string: "https://random-data-api.com/api/color/random_color")
    }
    
    func FetchColour(reload: Bool) {
        URLSession.shared.request(url: Constants.colourURL, expecting:Colour.self) {
            [weak self] result in
            switch result {
            case.success(let colour):
                DispatchQueue.main.async {
                    if reload {
                        self?.colours[0] = colour
                    } else {
                        self?.colours.append(colour)
                    }
                    self?.hasLoaded = true
                }
            case.failure(let error):
                        print(error)
            }
        }
    }
}
