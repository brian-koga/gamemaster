//
//  ScoreCardViewController.swift
//  GameMaster
//
//  Created by Brian Koga on 5/8/21.
//

import UIKit

class ScoreCardViewController: UIViewController {

    @IBOutlet weak var numPlayersLabel: UILabel!
    
    @IBOutlet weak var numPlayersStepper: UIStepper!
    
    @IBOutlet weak var numRoundsLabel: UILabel!
    
    @IBOutlet weak var numRoundsStepper: UIStepper!
    
    @IBOutlet weak var gameNameTextBox: UITextField!
    
    @IBOutlet weak var gameDateLabel: UILabel!
    
    @IBOutlet weak var winnerSegmentedControl: UISegmentedControl!
    
    var gameName : String = "MyGame"
    
    var date : Date = Date()
    
    var numPlayers : Int = 5
    
    var numRounds: Int = 10
    
    let winTypes : [String] = ["Highest", "Lowest"]
    
    var winType: String = "Highest"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the the date to today's date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        date = Date()
        gameDateLabel.text = "date: " + dateFormatter.string(from: date)
        
        // set the default stepper values
        numPlayersStepper.value = Double(numPlayers)
        numRoundsStepper.value = Double(numRounds)
        
        // increase the font size of the segmented controller
        let font = UIFont.systemFont(ofSize: 30)
        winnerSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numPlayerStepChanged(_ sender: UIStepper) {
        numPlayers = Int(sender.value)
        numPlayersLabel.text = String(numPlayers)
    }
    
    @IBAction func numRoundsStepChanged(_ sender: UIStepper) {
        numRounds = Int(sender.value)
        numRoundsLabel.text = String(numRounds)
    }
    
    @IBAction func winTypeChanged(_ sender: UISegmentedControl) {
        winType = winTypes[sender.selectedSegmentIndex]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ScoreCardTableViewController {
            let vc = segue.destination as? ScoreCardTableViewController
            
            
            // pass data
            vc?.gameName = gameName
            vc?.numPlayers = numPlayers
            vc?.numRounds = numRounds
            vc?.winType = winType
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
