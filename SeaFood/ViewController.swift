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
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    }
    
}

