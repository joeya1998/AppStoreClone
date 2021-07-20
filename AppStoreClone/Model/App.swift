//
//  App.swift
//  AppStoreClone
//
//  Created by Joey Aberasturi on 7/15/21.
//

import Foundation

struct App: Codable {
    var artistId: Int
    var artistName: String
    var artistViewUrl: String
    var description: String
    var genres: [String]
    var price: Double
    var screenshotUrls: [String]
    var trackName: String
    var artworkUrl512: String
    var fileSizeBytes: String
    var version: String
    var primaryGenreName: String
    var trackContentRating: String
    var releaseNotes: String
    
    enum CodingKeys: String, CodingKey {
        case artistId = "artistId"
        case artistName = "artistName"
        case artistViewUrl = "artistViewUrl"
        case description = "description"
        case genres = "genres"
        case price = "price"
        case screenshotUrls = "screenshotUrls"
        case trackName = "trackName"
        case artworkUrl512 = "artworkUrl512"
        case fileSizeBytes = "fileSizeBytes"
        case version = "version"
        case primaryGenreName = "primaryGenreName"
        case trackContentRating = "trackContentRating"
        case releaseNotes = "releaseNotes"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.artistId = try values.decodeIfPresent(Int.self, forKey: .artistId)
            ?? 0 //Default value
        self.artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
            ?? "" //Default value
        self.artistViewUrl = try values.decodeIfPresent(String.self, forKey: .artistViewUrl)
            ?? "" //Default value
        self.description = try values.decodeIfPresent(String.self, forKey: .description)
            ?? "" //Default value
        self.genres = try values.decodeIfPresent([String].self, forKey: .genres)
        ?? [""] //Default value
        self.price = try values.decodeIfPresent(Double.self, forKey: .price)
            ?? 0 //Default value
        self.screenshotUrls = try values.decodeIfPresent([String].self, forKey: .screenshotUrls)
            ?? [""] //Default value
        self.trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
            ?? "" //Default value
        self.artworkUrl512 = try values.decodeIfPresent(String.self, forKey: .artworkUrl512)
            ?? "" //Default value
        self.fileSizeBytes = try values.decodeIfPresent(String.self, forKey: .fileSizeBytes)
            ?? "" //Default value
        self.artworkUrl512 = try values.decodeIfPresent(String.self, forKey: .artworkUrl512)
            ?? "" //Default value
        self.version = try values.decodeIfPresent(String.self, forKey: .version)
            ?? "" //Default value
        self.primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
            ?? "" //Default value
        self.trackContentRating = try values.decodeIfPresent(String.self, forKey: .trackContentRating)
            ?? "" //Default value
        self.releaseNotes = try values.decodeIfPresent(String.self, forKey: .releaseNotes)
            ?? "" //Default value
    }
}

