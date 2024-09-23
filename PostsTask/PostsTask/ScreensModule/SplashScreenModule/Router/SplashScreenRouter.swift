//
//  SplashScreenRouter.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

class SplashScreenRouter {

	static func navigateToListScreen(viewController: SplashScreenViewController) {
		let postsVC = PostsListViewController()
		viewController.navigationController?.pushViewController(postsVC, animated: false)
	}
}
