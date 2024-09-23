//
//  PostsTableViewCell.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import UIKit

class PostTableViewCell: UITableViewCell {

	let postTitleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		label.textColor = .darkGray
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let postDescLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
		label.textColor = .gray
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("error loading the cell")
	}

	func setupViews() {
		let stackView = UIStackView(arrangedSubviews: [postTitleLabel, postDescLabel])


		let designView = UIView()
		designView.translatesAutoresizingMaskIntoConstraints = false
		designView.addSubview(stackView)
		designView.backgroundColor = UIColor(named: "PostBackground")
		designView.layer.cornerRadius = 7



		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .fill
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 12

		self.addSubview(designView)

		NSLayoutConstraint.activate([
			designView.topAnchor.constraint(equalTo: self.topAnchor),
			designView.leadingAnchor.constraint(
				equalTo: self.leadingAnchor, constant: 8),
			designView.trailingAnchor.constraint(
				equalTo: self.trailingAnchor, constant: -8),
			designView.bottomAnchor.constraint(
				equalTo: self.bottomAnchor, constant: -8),

			stackView.topAnchor.constraint(equalTo: designView.topAnchor,
										   constant: 8),
			stackView.leadingAnchor.constraint(
				equalTo: designView.leadingAnchor, constant: 8),
			stackView.trailingAnchor.constraint(
				equalTo: designView.trailingAnchor, constant: -8),
			stackView.bottomAnchor.constraint(
				equalTo: designView.bottomAnchor, constant: -16),

		])
	}
}

