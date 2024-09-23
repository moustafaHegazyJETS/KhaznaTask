//
//  LocalCacheService.swift
//  PostsTask
//
//  Created by Moustafa Hegazy on 21/09/2024.
//

import Foundation
import CoreData
import UIKit

class CacheManager {
	static let shared = CacheManager()

	private init() {}

	var appDelegate: AppDelegate? {
		if Thread.isMainThread {
			return UIApplication.shared.delegate as? AppDelegate
		}

		var appDelegate: AppDelegate?
		DispatchQueue.main.sync {
			appDelegate = UIApplication.shared.delegate as? AppDelegate
		}
		return appDelegate
	}

	func saveAndUpdate(cacheId: Int, post: Post) {
		if let appDelegate = self.appDelegate {
			let context = appDelegate.persistentContainer.newBackgroundContext()

			context.automaticallyMergesChangesFromParent = true

			context.perform {
				let fetchRequest =
				NSFetchRequest<NSManagedObject>(entityName: "PostEntity")

				fetchRequest.returnsObjectsAsFaults = false
				fetchRequest.predicate = NSPredicate(format:"(cacheId == %@)", NSNumber(value: cacheId))

				let results = try? context.fetch(fetchRequest)

				if results?.count != 0 {
					guard let managedObject = results?[0] else { return }
					managedObject.setValue(post.title, forKey: "title")
					managedObject.setValue(post.body, forKey: "body")
					managedObject.setValue(post.id, forKey: "id")
					managedObject.setValue(post.userId, forKey: "userId")
					managedObject.setValue(cacheId, forKey: "cacheId")


				} else {
					guard let entityDescription = NSEntityDescription.entity(forEntityName: "PostEntity", in: context) else { return }

					let newValue = NSManagedObject(entity: entityDescription ,insertInto: context)

					newValue.setValue(post.title, forKey: "title")
					newValue.setValue(post.body, forKey: "body")
					newValue.setValue(post.id, forKey: "id")
					newValue.setValue(post.userId, forKey: "userId")
					newValue.setValue(cacheId, forKey: "cacheId")
				}

				do {
					try context.save()
				} catch {
					print(error.localizedDescription)
				}
			}

		}
	}
	
	func retrieveValues() -> [Post]? {
		if let appDelegate = self.appDelegate {

			let context = appDelegate.persistentContainer.viewContext

			let fetchRequest = NSFetchRequest<PostEntity>(entityName: "PostEntity")

			var postsArray: [Post]? = []

			do {
				let results = try context.fetch(fetchRequest)

				for result in results {
					if let title = result.title, let body = result.body {

						let post = Post(userId: Int(result.userId), id: Int(result.id), title: title, body: body)

						postsArray?.append(post)

					}
				}
				return postsArray
			} catch {
				return nil
			}
		}
		return nil
	}
}
