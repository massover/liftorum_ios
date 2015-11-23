//
//  CommentCollectionView.swift
//  liftorum
//
//  Created by Voxy on 11/22/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

class CommentCollectionView:
    UICollectionView,
    UICollectionViewDelegate,
    UICollectionViewDataSource
{
    
    var comments = [Comment]()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return comments.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "CommentCollectionViewCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CommentCollectionViewCell
        cell.contentView.frame = cell.bounds
        cell.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        cell.backgroundColor = UIColor.grayColor()
        cell.usernameLabel.text = "username"
        cell.textLabel.text = "text"
        cell.createdAtLabel.text = "createdAt"
        return cell
    }
    
    
}