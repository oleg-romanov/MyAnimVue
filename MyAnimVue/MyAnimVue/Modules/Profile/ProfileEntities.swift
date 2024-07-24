//
//  ProfileEntities.swift
//  MyAnimVue
//
//  Created by Олег Романов on 07.07.2024.
//

import UIKit

struct BlockModel {
    let blockName: String
    let titles: [PreviewTitleModel]
}

enum BlockName: String {
    case planned = "Буду смотреть"
    case watching = "Смотрю"
    case rewatching = "Пересматриваю"
    case completed = "Просмотрено"
    case onHold = "На паузе"
    case dropped = "Брошено"
    case other
}

struct PreviewTitleModel {
    let blockName: String
    let posterImageString: String
    let russianTitleName: String
    let englishTitleName: String
    let episodesTotal: Int
    let episodesWathed: Int
    let rating: Double
}


// MARK: - ShikiAnimeRate

struct AnimeRateShiki: Codable {
    let id: Int
    let score: Int
    let status: String
    let text: String?
    let episodes: Int
    let chapters: Int?
    let volumes: Int?
    let textHTML: String
    let rewatches: Int
    let createdAt: String
    let updatedAt: String
    let user: UserShiki
    let anime: AnimeShiki
    let manga: Manga?

    enum CodingKeys: String, CodingKey {
        case id, score, status, text, episodes, chapters, volumes
        case textHTML = "text_html"
        case rewatches
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user, anime, manga
    }
}

// MARK: - Anime

struct AnimeShiki: Codable {
    let id: Int
    let name: String
    let russian: String
    let image: AnimeImage
    let url: String
    let kind: String?
    let score: String
    let status: String
    let episodes: Int
    let episodesAired: Int?
    let airedOn: String?
    let releasedOn: String?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}

// MARK: - AnimeImage

struct AnimeImage: Codable {
    let original: String
    let preview: String
    let x96: String
    let x48: String
}

// MARK: - User

struct UserShiki: Codable {
    let id: Int
    let nickname: String
    let avatar: String
    let image: UserImage
    let lastOnlineAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, nickname, avatar, image
        case lastOnlineAt = "last_online_at"
        case url
    }
}

// MARK: - UserImage

struct UserImage: Codable {
    let x160: String
    let x148: String
    let x80: String
    let x64: String
    let x48: String
    let x32: String
    let x16: String
}

// MARK: - Manga

struct Manga: Codable {
    let id: Int
    let name: String
    let russian: String
    let image: AnimeImage
    let url: String
    let kind: String
    let score: String
    let status: String
    let volumes: Int
    let chapters: Int
    let airedOn: String
    let releasedOn: String?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, volumes, chapters
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}
