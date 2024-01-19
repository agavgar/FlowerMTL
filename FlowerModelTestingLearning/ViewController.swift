//
//  ViewController.swift
//  FlowerModelTestingLearning
//
//  Created by Alejandro Alberto Gavira García on 17/1/24.
//
/// Flower logo design by: freepik
/// App logo design: Alejandro Alberto Gavira García

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var cameraViewImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Models
    private let imagePicker = UIImagePickerController()
    private let wikipediaURL = "https://en.wikipedia.org/w/api.php"
    private var flowerImageUrl: String?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
    }
    
    //MARK: - ImagePickerFunctions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let convertedCIImage = CIImage(image: userPickedImage) else {
                fatalError("Can't convert to CIImage")
            }
            detect(image: convertedCIImage)
            
            
        }
        
        imagePicker.dismiss(animated: true)
    }
    
    func detect(image: CIImage){
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Cannot import model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not classify image")
            }
            
            self.requestInfo(flowerName: classification.identifier)
            self.navigationItem.title = classification.identifier.capitalized
            
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }catch{
            print(error)
        }
        
        
    }
    
    //MARK: - NetworkModel & APIClient
    func requestInfo(flowerName: String){
        
        
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
        ]
        
        AF.request(wikipediaURL, method: .get, parameters: parameters).response { response in
            
            switch response.result {
            case .success(let data):
                
                guard let allData = data else {
                    fatalError("Can't retrieve Data")
                }
                
                let flowerJSON: JSON = JSON(allData)
                print(flowerJSON)
                
                let pageID = flowerJSON["query"]["pageids"][0].stringValue

                let description = flowerJSON["query"]["pages"][pageID]["extract"].stringValue
                print(description)
                
                self.requestImage(pageid: pageID, flowerName: flowerName) { flowerImageURL in
                            DispatchQueue.main.async {
                                self.descriptionLabel.text = description
                                if let url = URL(string: flowerImageURL) {
                                    self.cameraViewImage.sd_setImage(with: url)
                                }
                            }
                        }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func requestImage(pageid: String, flowerName: String, completion: @escaping (String) -> Void) {
        
        let parameters: [String: String] = [
            "format": "json",
            "action": "query",
            "prop": "pageimages",
            "titles": flowerName,
            "pithumbsize": "500",
            "indexpageids": "",
            "redirects": "1"
        ]
        
        AF.request(wikipediaURL, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .success(let data):
                
                guard let allData = data else {
                    print("Can't retrieve data")
                    completion("")
                    return
                }
                
                let flowerJSON = JSON(allData)
                let flowerImage = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                
                completion(flowerImage)

            case .failure(let error):
                print(error)
                completion("")
            }
        }
    }
    
    //MARK: - ActionButtons
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .camera
        present(imagePicker,animated: true)
        
    }
    
    
    @IBAction func albumPressed(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true)
        
    }
    
    
}

