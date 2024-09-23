//
//  PostsModel.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

struct Post: Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}
