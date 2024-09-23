//
//  SplashScreen.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation
import UIKit

class SplashScreenViewController: UIViewController {

	let splashLogoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "SplashLogo")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupLogoAnimation()
	}

	func setupUI() {
		view.backgroundColor = .white
		view.addSubview(splashLogoImageView)
		NSLayoutConstraint.activate([
			splashLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			splashLogoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			splashLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			splashLogoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8)
		])
	}

	func setupLogoAnimation() {
		UIView.animate(withDuration: 4, delay: 0, options: .curveEaseOut, animations: {
			self.splashLogoImageView.frame.size.width += 100
			self.splashLogoImageView.frame.size.height += 100
		}) {[weak self] _ in

			guard let self = self else { return }
			SplashScreenRouter.navigateToListScreen(viewController: self)
		}
	}
}
