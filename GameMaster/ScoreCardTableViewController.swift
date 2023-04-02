//
//  ScoreCardTableViewController.swift
//  GameMaster
//
//  Created by Brian Koga on 5/14/21.
//

import UIKit

class ScoreCardTableViewController: UITableViewController {
    
    var numRounds : Int = 0
    var numPlayers : Int = 0
    let winTypes : [String] = ["Highest", "Lowest"]
    var winType: String = "Highest"
    var gameName : String = "MyGame"
    
    // control elements, different file?
    
    // keeps track of the score, is an array of arrays of ints, the outer array should be size (numPLayers) the inner array should be size (numRounds)
    var scores : [[Int]] = []
    
    // total scores corresponds to the order of the outer array of scores
    var totalScores : [Int] = []
    
    // names of the players, indexes correspond to totalScores and the outer array of scores
    var names : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numPlayers = 5
        
        //setup names array
        for i in 0..<numPlayers {
            names.append("Player" + String(i+1))
            // populate scores with right number of zeroes
            scores.append([])
            for _ in 0..<numRounds {
                scores[i].append(0)
            }
            // populate totalScores
            totalScores.append(0)
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numRounds + 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoundCell", for: indexPath) as! RoundCell
        
        let indexRow = indexPath.row
        
        let width = cell.frame.size.width
        let columnWidth = width/CGFloat(numPlayers+1)
        
        cell.roundColumnLabel.frame.size.width = columnWidth
        cell.player1ScoreTxt.frame.size.width = columnWidth
        cell.player2ScoreTxt.frame.size.width = columnWidth
        cell.player2ScoreTxt.setNeedsDisplay()
        cell.player3ScoreTxt.frame.size.width = columnWidth
        cell.player4ScoreTxt.frame.size.width = columnWidth
        cell.player5ScoreTxt.frame.size.width = columnWidth
        
        cell.setNeedsDisplay()
        
        if indexRow == 0 {
            cell.roundColumnLabel.text = ""
            cell.player1ScoreTxt.text = "Player1"
            cell.player2ScoreTxt.text = "Player2"
            cell.player3ScoreTxt.text = "Player3"
            cell.player4ScoreTxt.text = "Player4"
            cell.player5ScoreTxt.text = "Player5"
        } else if indexRow == numRounds+1 {
            // total row
            //cell.roundColumnLabel.attributedText = attrlist attributedText(withString: String(format: "Total"), boldString: "Total")
            cell.roundColumnLabel.text = "Total"
            cell.player1ScoreTxt.text = String(totalScores[0])
            cell.player2ScoreTxt.text = String(totalScores[1])
            cell.player3ScoreTxt.text = String(totalScores[2])
            cell.player4ScoreTxt.text = String(totalScores[3])
            cell.player5ScoreTxt.text = String(totalScores[4])
        } else {
            cell.roundColumnLabel.text = "Round" + String(indexRow)
            cell.player1ScoreTxt.text = String(scores[0][indexRow-1])
            cell.player2ScoreTxt.text = String(scores[1][indexRow-1])
            cell.player3ScoreTxt.text = String(scores[2][indexRow-1])
            cell.player4ScoreTxt.text = String(scores[3][indexRow-1])
            cell.player5ScoreTxt.text = String(scores[4][indexRow-1])
        }
        
        
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
