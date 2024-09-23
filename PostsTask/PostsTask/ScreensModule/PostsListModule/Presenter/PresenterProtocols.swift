//
//  PresenterProtocols.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

protocol PostsListViewToPresenterProtocol {
	var view: PostsListPresenterToViewProtocol? { get set }
	var interactor: PostsScreenPresenterToInteractor? { get set }
	var posts: [Post]? { get set }

	func viewDidLoad()
	func loadMorePosts()
	func didPullToRefresh()
	func getPostsCount() -> Int
	func getPostsAt(index: Int) -> Post?
	func clearPosts()
}

protocol PostsListPresenterToViewProtocol {
	func displayPosts(_ posts: [Post], isCached: Bool)
	func showLoadingIndicator()
	func hideLoadingIndicator()
	func clearPosts()
	func showNetworkStatus(message: String)

}
