//
//  PostDetailsPreseterProtocols.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation

protocol PostDetailsPresenterToView {
	func showPostDetails(title: String, body: String)
}

protocol PostDetailsViewToPresenter {
	var view: PostDetailsPresenterToView? { get set }
	var post: Post? { get set }
	func viewDidLoad()
}
