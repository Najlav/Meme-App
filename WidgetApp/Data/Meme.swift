//
//  Meme.swift
//  WidgetApp
//
//  Created by Najla on 12/09/2022.
//

import Foundation

struct Meme: Codable{
    let postLink: URL
    let subreddit: String
    let title: String
    let url: URL
    let nsfw: Bool
    let spoiler: Bool
    let author: String
    let ups:Int
    let preview: [URL]
}
