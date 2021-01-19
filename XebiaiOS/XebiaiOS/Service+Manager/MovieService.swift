//
//  MovieService.swift
//  XebiaiOS
//
//  Created by Yagnyadatta Bairiganjan on 18/01/21.
//

import Foundation

struct MovieManager {
    static var sharedManager = MovieManager()
    let baseUrl  = "https://run.mocky.io/v3/"
    let apiKey = "8779d60d-ccb0-4d00-a285-f91930fd360c"
    let rowHeight = 200
    var selectedMovie:Movies?
}

class MovieService {
    
    let services = Services()
    let moviemanager = MovieManager()
   
    func fetchMovieDataFromService(completion: @escaping ([Movies]) -> Void){
        services.getDataFromService(moviemanager.baseUrl, moviemanager.apiKey, completionHandle: {
            response in
            switch response{
            case .success(let movieList):
                completion(movieList)
            case .failiure(let error):
                print(error)
            }
        })
        
        
    }
    
    
}
