//
//  CommentCell.swift
//  Unit2ProjectBeRealClone
//
//  Created by Raymond Chen on 7/17/24.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func configure(with comment: Comment) {
        userLabel.text = "User: \(comment.username ?? "Unknown User")"
        commentLabel.text = "Comment: \(comment.comment ?? "Cannot Find Comment") "
    }
}
