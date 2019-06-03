//
//  CollectionBoarding.swift
//  Euko
//
//  Created by Victor Lucas on 03/06/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class CollectionBoarding: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let images:[UIImage] = [UIImage(named: "onboarding_1")!,
                            UIImage(named: "onboarding_2")!,
                            UIImage(named: "onboarding_3")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension CollectionBoarding: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingcell", for: indexPath) as UICollectionViewCell
        cell.frame = self.collectionView.bounds

        var imageView: UIImageView = UIImageView(frame: cell.bounds)
        imageView.image = self.images[indexPath.row]
        cell.addSubview(imageView)
        return cell
    }
}
