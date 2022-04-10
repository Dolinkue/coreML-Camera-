//
//  ViewController.swift
//  SeaFood
//
//  Created by Nicolas Dolinkue on 09/04/2022.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagepicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagepicker.delegate = self
        // con esto llamamos a la camara para que la pueda usar el usuario
        imagepicker.sourceType = .camera
        imagepicker.allowsEditing = false
    }

    // agregamos delegate method para cuando el user elija la foto la pasa a la ML, viene de UImagepickercontroller. es decir elegimos el metodo que le avisa a la app que ya eligio la foto y que hacer con ella
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
      if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
          
          // para usar coreML, convertimas la imagen que eligio en CIImage
          guard let ciimage = CIImage(image: userPickedImage) else{
              fatalError()
          }
          
          detect(image: ciimage)
          
          
        }
        
        imagepicker.dismiss(animated: true)
        
    }
    
    //para implementar coreML
    func detect (image: CIImage) {
        
        // cargamos el modelo de CoreML en esta constante
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError()
        }
        //aca consultamos al coreML, y pedimos que clasifique la imagen que le pasamos
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError()
            }
            
            if let firtResult = results.first {
                
                if firtResult.identifier.contains("") {
                    self.navigationItem.title = firtResult.identifier
                } else {
                    self.navigationItem.title = "not found"
                }
            }
        }
        // aca pasamos la imagen que seleciono
        let handler = VNImageRequestHandler(ciImage: image)
        // hacemos la perform de la request para saber que es la imagen
        try! handler.perform([request])
    }
    
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagepicker, animated: true)
        
        
    }
    
}

