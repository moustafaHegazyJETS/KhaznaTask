//
//  PostsScreenInteractorProtocols.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

protocol PostsScreenInteractorToPresenter {
	func didFetchPostsSuccessfully(posts: [Post], isCached: Bool, hasNextPageMore: Bool)
	func didFailToFetchPosts(with error: String)

}

protocol PostsScreenPresenterToInteractor {
	var presenter: PostsScreenInteractorToPresenter? { get set }
	func fetchPosts(currentPage: Int)
}
