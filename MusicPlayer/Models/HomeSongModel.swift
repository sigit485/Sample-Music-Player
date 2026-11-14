//
//  HomeSongModel.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import Foundation
import Alamofire

nonisolated struct HomeSongModel: Codable {
    let resultCount: Int
    let results: [HomeSongResult]

    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
}


struct HomeSongResult: Codable {
    let wrapperType: String?
    let kind: String?
    let trackID: Int?
    let artistName: String
    let trackName: String?
    let trackCensoredName: String?
    let trackViewURL: String?
    let previewURL: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let trackRentalPrice: Double?
    let collectionHDPrice: Double?
    let trackHDPrice: Double?
    let trackHDRentalPrice: Double?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String
    let contentAdvisoryRating: String?
    let longDescription: String?
    let hasITunesExtras: Bool?
    let shortDescription: String?
    let collectionID: Int?
    let collectionName: String?
    let collectionCensoredName: String?
    let collectionArtistID: Int?
    let collectionArtistViewURL: String?
    let collectionViewURL: String?
    let trackCount: Int?
    let trackNumber: Int?
    let discCount: Int?
    let discNumber: Int?
    let artistID: Int?
    let artistViewURL: String?
    let description: String?
    let copyright: String?
    let amgArtistID: Int?

    enum CodingKeys: String, CodingKey {
        case wrapperType = "wrapperType"
        case kind = "kind"
        case trackID = "trackId"
        case artistName = "artistName"
        case trackName = "trackName"
        case trackCensoredName = "trackCensoredName"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30 = "artworkUrl30"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case collectionPrice = "collectionPrice"
        case trackPrice = "trackPrice"
        case trackRentalPrice = "trackRentalPrice"
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate = "releaseDate"
        case collectionExplicitness = "collectionExplicitness"
        case trackExplicitness = "trackExplicitness"
        case trackTimeMillis = "trackTimeMillis"
        case country = "country"
        case currency = "currency"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case longDescription = "longDescription"
        case hasITunesExtras = "hasITunesExtras"
        case shortDescription = "shortDescription"
        case collectionID = "collectionId"
        case collectionName = "collectionName"
        case collectionCensoredName = "collectionCensoredName"
        case collectionArtistID = "collectionArtistId"
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackCount = "trackCount"
        case trackNumber = "trackNumber"
        case discCount = "discCount"
        case discNumber = "discNumber"
        case artistID = "artistId"
        case artistViewURL = "artistViewUrl"
        case description = "description"
        case copyright = "copyright"
        case amgArtistID = "amgArtistId"
    }
}

