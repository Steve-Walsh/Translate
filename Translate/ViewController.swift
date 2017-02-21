//
//  ViewController.swift
//  Translate
//
//  Created by Robert O'Connor on 16/10/2015.
//  Copyright © 2015 WIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    
    @IBOutlet weak var ireButton: UIButton!
    @IBOutlet weak var deButton: UIButton!
    @IBOutlet weak var frButton: UIButton!
    @IBOutlet weak var itaButton: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var langSelected = "fr"
 
    let session = URLSession(configuration: URLSessionConfiguration.default)

    
    
    
    @IBOutlet weak var translateButton: UIButton!
    
    
    //var data = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translateButton.layer.cornerRadius = 4
        spinner.alpha = 0
        ireButton.alpha = 0.4
        deButton.alpha = 0.4
        itaButton.alpha = 0.4
        
    }
    
//    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func langSelection(_ sender: AnyObject) {
       // print("button pressed")
        ireButton.alpha = 0.4
        deButton.alpha = 0.4
        itaButton.alpha = 0.4
        frButton.alpha = 0.4
        
        if(sender === ireButton){
            langSelected = "ga"
            ireButton.alpha = 1
        }else if (sender === deButton){
             langSelected = "de"
            deButton.alpha = 1
        }else if (sender === itaButton){
            langSelected = "it"
            itaButton.alpha = 1
        }else{
            langSelected = "fr"
            frButton.alpha = 1
            
        }
    }
    
    
    
    @IBAction func translate(_ sender: AnyObject) {
        
        let str = textToTranslate.text
        let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
      
        
        let langStr = ("en|" + langSelected).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
        
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!)// Creating Http Request
        
        
        //var data = NSMutableData()var data = NSMutableData()
        
        spinner.alpha = 1
        view.addSubview(spinner)
        spinner.startAnimating()
        
        var result = "<Translation Error>"
        
        
        
//        let task = session.dataTask(with: request){
//            (data, response, error) in
//            
//            if let data = data{print(String(data: data, encoding: .utf8) ?? "NO DATA")}
//            
//            if let response = response {print(response)}
//            
//            guard error == nil else {
//                print("error caling get")
//                print(error)
//                return
//            }
//            
//            guard let responseData = data else{
//                print("error in data ")
//                return
//            }
//            
//            do {
//                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else{
//                        print("error in covert data to json")
//                    
//                        return
//                    }
//                result = todo["translatedText"] as! String
//                print("the result of the call is : "   + result)
//            }catch {
//                print("error")
//                return
//            }
//            
//        }
//        task.resume()
        
    
        
//        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
//            
//            self.spinner.stopAnimating()
//            self.spinner.alpha = 0
//            
//            if let httpResponse = response as? HTTPURLResponse {
//                if(httpResponse.statusCode == 200){
//                    
//                    let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
//                    
//                    if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
//                        let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
//                        
//                        result = responseData.object(forKey: "translatedText") as! String
//                    }
//                }
//                
//                self.translatedText.text = result
//            }

//        }
        
        
        
    }
}

