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
    @IBOutlet weak var gbButton: UIButton!
    
    @IBOutlet weak var gbTransButton: UIButton!
    @IBOutlet weak var ireTransButton: UIButton!
    @IBOutlet weak var deTransButton: UIButton!
    @IBOutlet weak var frTransButton: UIButton!
    @IBOutlet weak var itaTransButton: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var currLangSelected = "en"
    var transLangSelected = "fr"
 
    let session = URLSession(configuration: URLSessionConfiguration.default)

    
    
    
    @IBOutlet weak var translateButton: UIButton!
    
    
    //var data = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //translateButton.layer.cornerRadius = 4
        //textToTranslate.layer.cornerRadius = 5
        //translatedText.layer.cornerRadius = 5
        spinner.alpha = 0
        ireButton.alpha = 0.4
        deButton.alpha = 0.4
        itaButton.alpha = 0.4
        frButton.alpha = 0.4

        
        ireTransButton.alpha = 0.4
        gbTransButton.alpha = 0.4
        deTransButton.alpha = 0.4
        itaTransButton.alpha = 0.4
    }
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textToTranslate.text.contains("<")){
            textToTranslate.text = ""
        }
    }
    
    
    @IBAction func langSelection(_ sender: AnyObject) {
       // print("button pressed")
        ireButton.alpha = 0.4
        deButton.alpha = 0.4
        itaButton.alpha = 0.4
        frButton.alpha = 0.4
        gbButton.alpha = 0.4
        
        if(sender === ireButton){
            currLangSelected = "ga"
            if(textToTranslate.text.contains("<")){
            textToTranslate.text = "<Téacs a aistriú>"
            }
            
            ireButton.alpha = 1
        }else if (sender === deButton){
            currLangSelected = "de"
            if(textToTranslate.text.contains("<")){
            textToTranslate.text = "<Text zu übersetzen>"}
            deButton.alpha = 1
        }else if (sender === itaButton){
            currLangSelected = "it"
            if(textToTranslate.text.contains("<")){
            textToTranslate.text = "<Testo da tradurre>"}
            itaButton.alpha = 1
        }else if (sender === frButton){
            currLangSelected = "fr"
            if(textToTranslate.text.contains("<")){
            textToTranslate.text = "<Texte à traduire>"}
            frButton.alpha = 1
        }else{
            currLangSelected = "en"
            gbButton.alpha = 1
            if(textToTranslate.text.contains("<")){
            textToTranslate.text = "<Text to translate>"}
            
        }
    }
    
    
    @IBAction func transLangSelection(_ sender: AnyObject) {
        ireTransButton.alpha = 0.4
        deTransButton.alpha = 0.4
        itaTransButton.alpha = 0.4
        frTransButton.alpha = 0.4
        gbTransButton.alpha = 0.4
        
        if(sender === ireTransButton){
            transLangSelected = "ga"
            //textToTranslate.text = "<Téacs a aistriú>"
            ireTransButton.alpha = 1
        }else if (sender === deTransButton){
            transLangSelected = "de"
            //textToTranslate.text = "<Text zu übersetzen>"
            deTransButton.alpha = 1
        }else if (sender === itaTransButton){
            transLangSelected = "it"
            //textToTranslate.text = "<Testo da tradurre>"
            itaTransButton.alpha = 1
        }else if (sender === frTransButton){
            transLangSelected = "fr"
            //textToTranslate.text = "<Texte à traduire>"
            frTransButton.alpha = 1
        }else{
            transLangSelected = "en"
            gbTransButton.alpha = 1
            //textToTranslate.text = "<Text to translate>"
            
        }
    }
    
    
    
    @IBAction func translate(_ sender: AnyObject) {
        
        if ( currLangSelected == transLangSelected){
        
            let alert = UIAlertController(title: "Alert", message: "Current language and translation language are the same", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let str = textToTranslate.text
            let escapedStr = str?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let langStr = (currLangSelected + "|" + transLangSelected).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
            let urlStr:String = ("https://api.mymemory.translated.net/get?q="+escapedStr!+"&langpair="+langStr!)
        
            let url = URL(string: urlStr)
        
            let request = URLRequest(url: url!)// Creating Http Request
        
        
            
            //spinner.alpha = 1
            //view.addSubview(spinner)
            //spinner.startAnimating()
            
            
            // https://github.com/icanzilb/SwiftSpinner
            SwiftSpinner.show("Connecting to satellite...")
            
        
        
            var result = "<Translation Error>"
        
        
        
            let task = session.dataTask(with: request){
                (data, response, error) in
            
                if let data = data{print(String(data: data, encoding: .utf8) ?? "NO DATA")}
            
                if let response = response {print(response)}
            
                guard error == nil else {
                    print("error caling get")
                    print(error)
                    return
                }
            
                guard let responseData = data else{
                    print("error in data ")
                    return
                }
            
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
            
                        let jsonDict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
                        if(jsonDict.value(forKey: "responseStatus") as! NSNumber == 200){
                            let responseData: NSDictionary = jsonDict.object(forKey: "responseData") as! NSDictionary
                                result = responseData.object(forKey: "translatedText") as! String
                        }
                    }
                    DispatchQueue.main.sync {
                        //self.spinner.stopAnimating()
                        //self.spinner.alpha = 0
                        self.translatedText.text = result
                        SwiftSpinner.hide()
                    }
               
                }
            
                }
            task.resume()
        }
        
    }
}

