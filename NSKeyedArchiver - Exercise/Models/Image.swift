//
//  Image.swift
//  NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
struct AllInfo: Codable {
    let hits: [Image]
}

struct Image: Codable {
    let likes: Int
    let tags: String
    let comments: Int
    let pageURL: String
    let previewURL: String
    let webformatURL: String
    let user_id: Int
    let user: String
    let userImageURL: String
    let id: Int
    
    init(imageInfo: Image) {
        self.likes = imageInfo.likes
        self.tags = imageInfo.tags
        self.comments = imageInfo.comments
        self.pageURL = imageInfo.pageURL
        self.previewURL = imageInfo.previewURL
        self.webformatURL = imageInfo.webformatURL
        self.user_id = imageInfo.user_id
        self.user = imageInfo.user
        self.userImageURL = imageInfo.userImageURL
        self.id = imageInfo.id
    }
}

struct Favorite: Codable {
    let image_link: String
    let student_name: String
}
