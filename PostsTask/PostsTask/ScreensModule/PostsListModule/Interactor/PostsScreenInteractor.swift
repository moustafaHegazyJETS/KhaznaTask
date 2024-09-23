//
//  PostsScreenInteractor.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation


class PostsScreenInteractor: PostsScreenPresenterToInteractor {

	var presenter: PostsScreenInteractorToPresenter?

	let postsListService = PostsListService()

	func cachePosts(posts: [Post]) {
		posts.indices.forEach { index in
			CacheManager.shared.saveAndUpdate(cacheId: index, post: posts[index])
		}
	}

	func fetchPosts(currentPage: Int) {
		postsListService.fetchPosts(page: currentPage) { [weak self] result in
			switch result {

			case .success(let posts):
				let isNextPage = posts.count == 10

				self?.cachePosts(posts: posts)

				self?.presenter?.didFetchPostsSuccessfully(posts: posts, isCached: false, hasNextPageMore: isNextPage)

			case .failure(let error):
				if let cachedPosts = CacheManager.shared.retrieveValues() {
					self?.presenter?.didFetchPostsSuccessfully(posts: cachedPosts, isCached: true, hasNextPageMore: false)
				} else {
					self?.presenter?.didFailToFetchPosts(with: error.localizedDescription)
				}
			}
		}
	}

}
