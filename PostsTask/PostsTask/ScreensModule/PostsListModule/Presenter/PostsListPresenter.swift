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
//	var router: PostsListPresenterToRouter?

	private var currentPage = 1
	private var isFetching = false
	private var hasMoreData: Bool = false  // Track if more data is available

	var posts: [Post]? = []

	func viewDidLoad() {
		view?.showLoadingIndicator()
		interactor?.fetchPosts(currentPage: currentPage)
	}

	func loadMorePosts() {
		// Load more posts when user scrolls to the bottom
		guard !isFetching && hasMoreData  else { return } // check dh 3shan lw already by3ml loading
		currentPage += 1
		interactor?.fetchPosts(currentPage: currentPage)
	}

	func didPullToRefresh() {
		// Refresh posts with latest data
//		currentPage = 1
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

	func loadPostAt(index: Int) {
//		interactor?.fetchPostAt(index: index + 10)
	}

	func clearPosts() {
		posts?.removeAll()
	}

}


extension PostsListPresenter: PostsScreenInteractorToPresenter {
	func didFetchPost(post: Post) {
		view?.hideLoadingIndicator()
		posts?.append(post)
//		view?.displayPosts(posts ?? [], isCached: false)
	}


	func didFetchPostsSuccessfully(posts: [Post], isCached: Bool, hasMore: Bool) {
		isFetching = false
		self.hasMoreData = hasMore  // Update hasMoreData flag based on response
		view?.hideLoadingIndicator()

		print("Posts received in presenter: \(posts.count)")
		self.posts?.append(contentsOf: posts)//append(contentsOf: posts)
		view?.displayPosts(posts, isCached: isCached)
		// in case no internet show error
//		if isCached {
//			// Handle the error
//			view?.showError(message: "Failed to load posts. Please check your connection.")
//		}
	}

	func didFailToFetchPosts(with error: String) {
		isFetching = false
		view?.hideLoadingIndicator()

		// Handle the error
//		view?.showError(message: "Failed to load posts. Please check your connection.")
	}

	
}


public extension Array {
	subscript (safe index: Int) -> Element? {
		return self.indices ~= index ? self[index] : nil
	}
}

