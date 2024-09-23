//
//  PostsListViewController+UITableViewDelegates.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 23/09/2024.
//

import Foundation
import UIKit

extension PostsListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let count = presenter?.getPostsCount() else { return 0 }
		return count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell
		else { return UITableViewCell() }
		cell.selectionStyle = .none

		guard let presenter = presenter else { return UITableViewCell() }

		cell.postTitleLabel.text = presenter.posts?[indexPath.row].title
		cell.postDescLabel.text = presenter.posts?[indexPath.row].body

		if indexPath.row == presenter.getPostsCount() - 1 {
			presenter.loadMorePosts()
		}
		return cell
	}
}

extension PostsListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let presenter = presenter else { return }
		guard let post = presenter.getPostsAt(index: indexPath.row) else { return }

		PostsListRouter.navigateToPostDetails(currentView: self, post: post)
	}
}


extension UIViewController {
	func showToast(message : String, seconds: Double){
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		alert.view.backgroundColor = .black
		alert.view.alpha = 0.5
		alert.view.layer.cornerRadius = 15
		self.present(alert, animated: true)
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
			alert.dismiss(animated: true)
		}
	}
}
