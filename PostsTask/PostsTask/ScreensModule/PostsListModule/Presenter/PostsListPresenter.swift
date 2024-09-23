//
//  PostsListPresenter.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

class PostsListPresenter: PostsListViewToPresenterProtocol {

	var view: PostsListPresenterToViewProtocol?
	var interactor: PostsScreenPresenterToInteractor?

	private var currentPage = 1
	private var hasNextPageMore: Bool = false

	var posts: [Post]? = []

	func viewDidLoad() {
		view?.showLoadingIndicator()
		interactor?.fetchPosts(currentPage: currentPage)
	}

	func loadMorePosts() {
		guard hasNextPageMore  else { return }
		currentPage += 1
		interactor?.fetchPosts(currentPage: currentPage)
	}

	func didPullToRefresh() {
		view?.clearPosts()
		currentPage = 1
		interactor?.fetchPosts(currentPage: currentPage)
	}


	func getPostsCount() -> Int {
		posts?.count ?? 0
	}

	func getPostsAt(index: Int) -> Post? {
		guard let item = posts?[safe: index]
		else { return nil}

		return item
	}

	func clearPosts() {
		posts?.removeAll()
	}

}


extension PostsListPresenter: PostsScreenInteractorToPresenter {

	func didFetchPostsSuccessfully(posts: [Post], isCached: Bool, hasNextPageMore: Bool) {
		self.hasNextPageMore = hasNextPageMore
		view?.hideLoadingIndicator()

		self.posts?.append(contentsOf: posts)

		view?.displayPosts(posts, isCached: isCached)

		if isCached {
			view?.showNetworkStatus(message: "please connect to server to get new posts")
		}
	}

	func didFailToFetchPosts(with error: String) {
		view?.hideLoadingIndicator()

		view?.showNetworkStatus(message: "please connect to server to get new posts")
	}

	
}


public extension Array {
	subscript (safe index: Int) -> Element? {
		return self.indices ~= index ? self[index] : nil
	}
}

