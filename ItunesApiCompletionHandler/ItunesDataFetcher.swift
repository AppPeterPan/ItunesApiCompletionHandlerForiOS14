//
//  ItunesDataFetcher.swift
//  ItunesApiAsync
//
//  Created by Peter Pan on 2022/12/1.
//

import Foundation

import Foundation

class ItunesDataFetcher: ObservableObject {
    @Published var items = [StoreItem]()
    @Published var showError = false

    var error: Error? {
        willSet {
            DispatchQueue.main.async {
                self.showError = newValue != nil
            }
        }
    }

    enum FetchError: Error {
        case invalidURL
    }
    
    func fetchData(term: String) {
        let urlString = "https://itunes.apple.com/search?term=\(term)&media=music&country=tw"
        
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString) else {
                  error = FetchError.invalidURL
                  return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error  in
            if let data {
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.items = searchResponse.results
                        self.error = nil
                    }
                } catch  {
                    self.error = error
                }
            } else if let error {
                self.error = error
            }
        }.resume()
        
    }
}
