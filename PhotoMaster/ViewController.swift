//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 中嶋裕也 on 2018/04/12.
//  Copyright © 2018年 中嶋裕也. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet var photoImageview: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func onTappedAlibumButton(){
        presentPickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func onTappedTextButton(){
        if photoImageview.image != nil{
            photoImageview.image = drawText(image: photoImageview.image!)
        }else {
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedIllustButton(){
        if photoImageview.image != nil{
            photoImageview.image = drawMaskImage(image: photoImageview.image!)
        }else {
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedUploadButton(){
        if photoImageview.image != nil{
            let activityVC = UIActivityViewController(activityItems: [photoImageview.image!, "#PhotoMaster"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }else{
            print("画像がありません")
        }
    }
    
    func presentPickerController(sourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            self.dismiss(animated: true, completion: nil)
        
        
        photoImageview.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
    func drawText(image: UIImage) -> UIImage {
        let text = "LifeisTech!"
        
        let textFontAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Arial", size: 120)!,
            NSAttributedStringKey.foregroundColor: UIColor.red
        ]
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0,y:0,width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 5.0
        let textRect =  CGRect(x: 0,y:0,width: image.size.width - margin, height: image.size.height - margin)
        
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
        
        
    }
    
    func drawMaskImage(image: UIImage) -> UIImage{
        let maskImage = UIImage(named: "furo_ducky")!
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y:0 ,width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin,
                              y: image.size.height - maskImage.size.height - margin,
                              width: maskImage.size.width, height: maskImage.size.height)
        
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

