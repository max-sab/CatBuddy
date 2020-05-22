//
//  ViewController.swift
//  CatBuddy
//
//  Created by Maksym Sabadyshyn on 5/20/20.
//  Copyright © 2020 Maksym Sabadyshyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catBreedLabel: UILabel!

    private var request: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        fetchQuestion()
    }

    func configureUI(with cat: Cat) {

    }

    func fetchQuestion() {
        let catsRequest = CatsRequest(resource: CatsResource())
        request = catsRequest
        catsRequest.getData { [weak self] (cats: [Cat]?) in
            guard let cats = cats,
                let topCat = cats.first else {
                    return
            }
            self?.catBreedLabel.text = topCat.breeds.first?.name ?? "not found"
            self?.fetchAvatar(for: topCat)
        }
    }

    func fetchAvatar(for cat: Cat) {
        catImageView.image = nil
        let catImage = ImageRequest(url: URL(string: cat.image)!)
        self.request = catImage
        catImage.getData(with: { [weak self] (avatar: UIImage?) in
            guard let avatar = avatar else {
                return
            }
            self?.catImageView.image = avatar
        })
    }


}

