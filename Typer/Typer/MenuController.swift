//
//  MenuController.swift
//  FastFingers
//
//  Created by Wendel Silva on 19/08/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var txtName: UITextField!
    
    static var name = ""
    static var language = "pt"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.txtName.text! = MenuController.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playGameClicked(sender: AnyObject) {
        
        if(self.txtName.text!.removeAllSpace().isEmpty){
            Util.alert(self, texto: "Nome obrigatório!")
        } else {
            MenuController.name = self.txtName.text!
            MenuController.language = self.segmentedControl.selectedSegmentIndex == 0 ? "pt" : "en"
            
            self.performSegueWithIdentifier("playGame", sender: nil)
        }
    }

}
