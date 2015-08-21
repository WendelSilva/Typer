//
//  ViewController.swift
//  FastFingers
//
//  Created by Wendel Silva on 18/08/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class JogoController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var lblErro: UILabel!
    @IBOutlet weak var lblAcerto: UILabel!
    @IBOutlet weak var lblTempo: UILabel!
    
    let name = MenuController.name
    let language = MenuController.language
    
    var wordDictionary : Dictionary<String, NSArray>!
    var wordAray = [String]()
    var indexArray = 0
    
    var timer : NSTimer!
    var intervalTime : NSTimeInterval = 0.01
    var currentTime : NSTimeInterval = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //OBTER DIRETORIO DO ARQUIVO PLIST
        let fileName = "words_\(self.language).plist"
        let levelPath = "\(NSBundle.mainBundle().resourcePath!)/\(fileName)"
        
        //CARREGAR ARQUIVO PLIST
        if let dictionaryPlist = NSDictionary(contentsOfFile: levelPath) as? Dictionary<String, NSArray> {
            
            self.wordDictionary = dictionaryPlist
        }
        
        //OBTER PALAVRAS
        self.startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - FUNCTIONS
    func startGame(){
        
        //DEFINIR VARIAVEIS DO JOGO
        self.lblTempo.text! = self.currentTime.timeToStringByMinute()
        self.lblAcerto.text! = "0"
        self.lblErro.text! = "0"
        self.wordAray.removeAll(keepCapacity: false)
        
        //OBTER PALAVRAS
        let array = self.wordDictionary["words"]!
        let sizeArray = array.count
        
        for _ in 1...100 {
            self.wordAray.append(array[Util.randonNumber(sizeArray)] as! String)
        }
    }
    
    //MARK: - HANDLE TIMER
    
    func handleTimer() {
        
        self.currentTime -= self.intervalTime
        
        if(self.currentTime > 0) {
            self.lblTempo.text! = self.currentTime.timeToStringByMinute()
        } else {
            self.timer.invalidate()
            
            self.performSegueWithIdentifier("finish", sender: nil)
        }   
    }
    
    
    //MARK: - PICKERVIEW DELEGATE
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.wordAray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.wordAray[row]
    }
    
    //MARK: - TEXTFIELD DELEGATE
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text!.removeAllSpace().isEmpty){
            
            return !string.removeAllSpace().isEmpty
        }else{
            if(string == " "){
                if(self.wordAray[self.indexArray] == textField.text!){
                    self.lblAcerto.text! = String(self.lblAcerto.text!.toNumber().integerValue + 1)
                }else{
                    self.lblErro.text! = String(self.lblErro.text!.toNumber().integerValue + 1)
                }
                self.indexArray++
                self.pickerView.selectRow(self.indexArray, inComponent: 0, animated: true)
                
                textField.text! = ""
                return false
            }
            return true
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //ACRESCENTAR CRONOMETRO
        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.intervalTime, target: self, selector: Selector("handleTimer"), userInfo: nil, repeats: true)
    }
    
    //MARK: - SEGUE
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "finish"){
            
            let viewDestination = segue.destinationViewController as! FimJogoController
            
            let totalHits = self.lblAcerto.text!.toNumber()
            let totalErros = self.lblErro.text!.toNumber()
            
            viewDestination.playerName = self.name
            viewDestination.totalHits = totalHits
            viewDestination.totalErrors = totalErros
            viewDestination.totalPoints = NSNumber(integer: totalHits == 0 ? 0 : totalHits.integerValue - totalErros.integerValue)
        }
    }
}