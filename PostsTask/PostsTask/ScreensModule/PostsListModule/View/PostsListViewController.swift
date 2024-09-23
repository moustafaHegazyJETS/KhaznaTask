//
//  PostsListViewController.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import UIKit

class PostsListViewController: UIViewController {

	private let tableView = UITableView()
	private let refreshControl = UIRefreshControl()
	let activityView = UIActivityIndicatorView(style: .large)



	var presenter: PostsListViewToPresenterProtocol?
	private var isCachedData = false
	var isPrefetching = false


	override func viewDidLoad() {
		super.viewDidLoad()
		PostsListRouter.createModule(viewController: self)
		setupUI()
		configureTableView()
		presenter?.viewDidLoad()
		self.navigationItem.hidesBackButton = true
	}

	private func configureTableView() {
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.estimatedRowHeight = 500
		tableView.rowHeight = UITableView.automaticDimension
		tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.separatorColor = .clear
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -24),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	private func setupUI() {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
		tableView.refreshControl = refreshControl
	}

	@objc private func refreshPosts() {
		presenter?.didPullToRefresh()
	}

	func showLoadingIndicator() {
		activityView.center = self.view.center
		self.view.addSubview(activityView)
		activityView.startAnimating()
	}

	func hideLoadingIndicator() {
		DispatchQueue.main.async {
			self.activityView.stopAnimating()
		}
	}

	func clearPosts() {
		presenter?.clearPosts()
		tableView.reloadData()
	}

	func showNetworkStatus(message: String) {
		DispatchQueue.main.async {
			self.tableView.refreshControl?.endRefreshing()
			self.showToast(message: "please connect to server to get new posts", seconds: 0.5)
		}
	}
}

extension PostsListViewController: PostsListPresenterToViewProtocol {
	func displayPosts(_ posts: [Post], isCached: Bool) {
		DispatchQueue.main.async {
			self.tableView.reloadData()
			self.tableView.refreshControl?.endRefreshing()
		}
	}
}
