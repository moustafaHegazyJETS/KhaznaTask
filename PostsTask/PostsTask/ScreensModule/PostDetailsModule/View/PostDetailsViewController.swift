//
//  PostDetailsScreen.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import UIKit

class PostDetailsViewController: UIViewController, PostDetailsPresenterToView {

	var presenter: PostDetailsViewToPresenter?

	let postTitleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.textColor = .black
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let postDescLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = .darkGray
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let heartButton: UIButton = {
		let button = UIButton(type: .system)
		let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .default)
		let heartImage = UIImage(systemName: "heart", withConfiguration: symbolConfiguration)
		button.setImage(heartImage, for: .normal)
		button.tintColor = .lightGray
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	var isLiked = false

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		presenter?.viewDidLoad()
		view.backgroundColor = .white
		heartButton.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
	}

	func setupViews() {
		let barButton = UIBarButtonItem(customView: heartButton)
		self.navigationItem.rightBarButtonItem = barButton
		view.addSubview(postTitleLabel)
		view.addSubview(postDescLabel)

		NSLayoutConstraint.activate([
			postTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
			postTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			postTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

			postDescLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 16),
			postDescLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			postDescLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
		])
	}

	@objc func handleLikeButton() {
		isLiked.toggle()
		animateLikeButton(isLiked: isLiked)
	}

	func animateLikeButton(isLiked: Bool) {
		UIView.animate(withDuration: 0.3) {
			if isLiked {
				let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .default)
				self.heartButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: symbolConfiguration), for: .normal)
				self.heartButton.tintColor = .systemRed
			} else {
				let symbolConfiguration = UIImage.SymbolConfiguration(
					pointSize: 20, weight: .light,
					scale: .default)

				self.heartButton.setImage(UIImage(systemName: "heart", withConfiguration: symbolConfiguration), for: .normal)
				self.heartButton.tintColor = .lightGray
			}
			self.heartButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
		} completion: { _ in
			UIView.animate(withDuration: 0.1) {
				self.heartButton.transform = .identity
			}
		}
	}

	func showPostDetails(title: String, body: String) {
		postTitleLabel.text = title
		postDescLabel.text = body
	}
}



