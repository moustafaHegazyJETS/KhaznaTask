//
//  PostsListRouter.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

class PostsListRouter {


	static func createModule(viewController: PostsListViewController) {
		let presenter = PostsListPresenter()

		viewController.presenter = presenter
		viewController.presenter?.view = viewController

		let interactor = PostsScreenInteractor()

		viewController.presenter?.interactor = interactor
		viewController.presenter?.interactor?.presenter = presenter
		
	}

	static func navigateToPostDetails(currentView: PostsListViewController ,post: Post) {
		let viewController = PostDetailsViewController()

		PostDetailsRouter.createModules(viewController: viewController, post: post)

		if let navigationController = currentView.navigationController {
			navigationController.pushViewController(viewController, animated: true)
		} else {
			print("NavigationController is nil, cannot push view controller.")
		}
	}

}
