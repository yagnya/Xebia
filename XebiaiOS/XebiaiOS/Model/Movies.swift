//
//  Movies.swift
//  XebiaiOS
//
//  Created by Yagnyadatta Bairiganjan on 19/01/21.
//

import Foundation

struct Movies: Codable{
    let movieName, description, releaseDate, collection, posterImageUrl: String?
    let daysSinceRelease: Double?
    
    init(name: String, desc: String, releaseDate: String, collection: String, imageUrl: String, daysSinceRelease: Double) {
        self.movieName = name;
        self.description = desc;
        self.releaseDate = releaseDate;
        self.collection = collection;
        self.posterImageUrl = imageUrl;
        self.daysSinceRelease = daysSinceRelease;
    }
    
    enum CodingKeys: String, CodingKey{
        case movieName = "name"
        case description = "Description"
        case releaseDate
        case collection
        case posterImageUrl = "posterUrl"
        case daysSinceRelease = "daysSinceRelease"
    }
    
}
