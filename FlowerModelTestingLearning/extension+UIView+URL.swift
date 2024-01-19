//
//  extension+UIView+URL.swift
//  FlowerModelTestingLearning
//
//  Created by Alejandro Alberto Gavira García on 19/1/24.
//

import UIKit

extension UIImageView {
    func setImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
