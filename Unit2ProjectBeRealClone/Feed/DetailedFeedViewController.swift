//
//  DetailedFeedViewController.swift
//  Unit2ProjectBeRealClone
//
//  Created by Raymond Chen on 7/17/24.
//

import UIKit
import ParseSwift

class DetailedFeedViewController: UIViewController {
    var post: Post!
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentTextInput: UITextField!
    
    @IBAction func sendComment(_ sender: Any) {
        // Dismiss Keyboard
        view.endEditing(true)
        
        guard let comment = commentTextInput.text else {
            return
        }
        var newComment = Comment()
        newComment.username = post.user?.username
        newComment.user = post.user
        newComment.comment = comment
        
        post.comments?.append(newComment)
        comments.append(newComment)
        
        post.save { [weak self] result in
            
            // Switch to the main thread for any UI updates
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    print("✅ Post Saved! \(post)")
                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
    }
                              
      
    
                              
    private var comments = [Comment]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        queryComments()
    }
    
    private func queryComments() {
        // 1. Create a query to fetch Comments
        // 2. Any properties that are Parse objects are stored by reference in Parse DB and as such need to explicitly use `include_:)` to be included in query results.
        // 3. Sort the comments by descending order based on the created at date
//        let query = Comment.query()
//            .include("user")
//            .order([.descending("createdAt")])
//
//        // Fetch objects (posts) defined in query (async)
//        query.find { [weak self] result in
//            switch result {
//            case .success(let comments):
//                // Update local posts property with fetched posts
//                self?.comments = comments
//            case .failure(let error):
//                self?.showAlert(description: error.localizedDescription)
//            }
//        }
        comments = post.comments ?? []
    }
}

extension DetailedFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
                return UITableViewCell()
            }
            cell.configure(with: post)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else {
                return UITableViewCell()
            }
            cell.configure(with: comments[indexPath.row - 1])
            return cell
        }
    }
}

extension DetailedFeedViewController: UITableViewDelegate {}

