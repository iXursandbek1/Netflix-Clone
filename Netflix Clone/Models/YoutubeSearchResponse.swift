//
//  File.swift
//  Netflix Clone
//
//  Created by Xursandbek Qambaraliyev on 16/08/23.
//

import Foundation

// MARK: - YoutubeSearchResponse
struct YoutubeSearchResponse: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    let items: [VideoElement]
}

// MARK: - VideoElement
struct VideoElement: Codable {
    let kind, etag: String
    let id: IdVideoElement
}

// MARK: - IdVideoElement
struct IdVideoElement: Codable {
    let kind: String
    let videoID, channelID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
        case channelID = "channelId"
    }
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
