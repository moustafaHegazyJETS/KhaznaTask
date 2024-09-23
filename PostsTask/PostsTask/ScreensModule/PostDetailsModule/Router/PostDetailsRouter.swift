//
//  PostDetailsRouter.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

struct PostDetailsRouter {
	static func createModules(viewController: PostDetailsViewController, post: Post) {
		let presenter = PostDetailsPresenter()

		viewController.presenter = presenter
		viewController.presenter?.view = viewController
		viewController.presenter?.post = post
	}
}
