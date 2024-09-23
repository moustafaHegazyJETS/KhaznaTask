//
//  PostsListService.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation


struct PostsListService {
	func fetchPosts(page: Int, completion: @escaping (Result<[Post], Error>) -> Void)  {

		var components = URLComponents()
		components.scheme = URLComponentData.scheme.rawValue
		components.host = URLComponentData.host.rawValue
		components.path = URLComponentData.path.rawValue
		components.queryItems = [
			URLQueryItem(name: URLComponentData.queryName.rawValue, value: "\(page)")
		]

		let url = components.url?.absoluteString ?? ""

		APIService.sharedService.request(url: url, completion: completion)
	}
}

enum URLComponentData: String {
	case scheme = "https"
	case host = "jsonplaceholder.typicode.com"
	case path = "/posts"
	case queryName = "_page"
}
