//
//  SearchMovieService.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation
final class SearchMovieService {
    //MARK: Singleton parameter
    public static let shared = SearchMovieService()
    
    //MARK: Parameters
    let headers = [
        "X-RapidAPI-Key": "c29bc93c2amsh02e3c782185c0a4p143b18jsn62915c0bcc77",
        "X-RapidAPI-Host": "imdb188.p.rapidapi.com"
    ]
    
    //MARK: Init
    private init(){}
    
    //Gets the list of movies
    func getMovies(query: String, completion: @escaping (Response) -> Void) {
        let newQuery = query.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        var request = URLRequest(url: URL(string: "https://imdb188.p.rapidapi.com/api/v1/searchIMDB?query=\(newQuery)")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            guard let data else { return }
            let model = try! JSONDecoder().decode(Response.self, from: data)
            
            DispatchQueue.main.async {
                var newModel = model
                newModel.data = model.data?.filter({ item in
                    return item.qid == "movie" || item.qid == "tvSeries"
                    })
                completion(newModel)
            }
        }.resume()
    
    }
    //Gets the movie poster image
    func getImage(urlToImage: String, _ completion: @escaping ((Data) -> Void))  {
        guard let imageURL = URL(string: urlToImage) else { return }
        
        let imageRequest = URLRequest(url: imageURL)
        URLSession.shared.dataTask(with: imageRequest) { data, response, error in
            guard let data = data else { return }
            completion(data)
            
        }.resume()
    }
}
