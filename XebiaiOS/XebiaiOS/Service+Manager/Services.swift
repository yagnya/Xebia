//
//  Services.swift
//  XebiaiOS
//
//  Created by Yagnyadatta Bairiganjan on 18/01/21.
//

import Foundation

class Services: NSObject{

    enum ApiStatus<value>{
        case success(value)
        case failiure(Error)
    }
    
    func getDataFromService(_ urlString: String, _ apiKey: String, completionHandle:@escaping (ApiStatus<[Movies]>) -> Void){
        guard let url = URL(string: urlString + apiKey) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request, completionHandler: {
            (data, resp , error) in
                if let err = error{
                    completionHandle(.failiure(err))
                }
                if let movieData = data {
                        let modelData = self.parseJsonToMovieModel(movieData)
                        completionHandle(.success(modelData))
                }
        }).resume()
    }
    
private func parseJsonToMovieModel(_ movieData:Data) -> [Movies]{
        let decoder = JSONDecoder()
        var movieList = [Movies]()
        do{
            let movies = try JSONSerialization.jsonObject(with: movieData, options: .mutableContainers) as? [Any]
            
            for movie in movies! {
                let codedValue = try JSONSerialization.data(withJSONObject: movie, options: .prettyPrinted)
                let parsedData = try decoder.decode(Movies.self, from: codedValue)
                movieList.append(parsedData)
            }
            return movieList
            
        }catch{
            print(error)
            fatalError("Error")
            
        }
       
    }
    
}
