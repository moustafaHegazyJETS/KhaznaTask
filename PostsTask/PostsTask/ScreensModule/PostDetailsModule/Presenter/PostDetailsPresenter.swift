//
//  PostDetailsPresenter.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

class PostDetailsPresenter: PostDetailsViewToPresenter {

	var view: PostDetailsPresenterToView?

	var post: Post?

	func viewDidLoad() {
		guard let post = post else { return }
		view?.showPostDetails(title: post.title, body: post.body)
	}
}
