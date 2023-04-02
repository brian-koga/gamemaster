//
//  TimerTabViewController.swift
//  GameMaster
//
//  Created by Brian Koga on 5/8/21.
//

import UIKit
import AVFoundation



class TimerTabViewController: UIViewController, RestartDelegate {
    

    @IBOutlet weak var timeSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var timerView: TimerView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var timer: Timer?
    
    var audioPlayer = AVAudioPlayer()
    
    var timeIndex : Int = 0
    let timeArray : [Int] = [15, 30, 60, 120]
    var timerTotalSeconds : Int = 15
    var timerSeconds : Int = 15
    var timerMinutes : Int = 0
    
    var radius : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set upp the sound
        let sound = Bundle.main.path(forResource: "Electronic_Chime", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        updateTimerLabel()
        
        radius = (timerView.frame.size.width - 10)/2
        
        self.timerView.delegate = self
        
        // increase the font size of the segmented controller
        let font = UIFont.systemFont(ofSize: 30)
        timeSegmentedController.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
    }
    
    
    // Handles the changing of options for the timer segmented controller
    @IBAction func timeChanged(_ sender: Any) {
        timeIndex = timeSegmentedController.selectedSegmentIndex
        resetTimer()
        
        // redraw the circle
        redrawCircle()
    }
    
    // update the label holding the timer based on the class variables timerSeconds and timerMinutes
    func updateTimerLabel() {
        var secondsString : String = ""
        if timerSeconds < 10 {
            secondsString = "0"
        }
        secondsString += String(timerSeconds)
        timerLabel.text = String(timerMinutes) + ":" + secondsString
    }
    
    // Handles the passing of a second and how that should be relected on the UI
    // Returns True if
    func passSecond() -> Bool {
        // update the variables
        timerTotalSeconds -= 1
        timerSeconds -= 1
        if timerSeconds == -1 {
            timerMinutes -= 1
            timerSeconds = 59
        }
        
        // check if at 0, play sound
        if timerTotalSeconds == 0 {
            //play sound
            audioPlayer.play()
            //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            // redraw the circle
            redrawCircle()
        }
        
        // check if at -1, return True if so
        if timerTotalSeconds == -1 {
            return true
        }
        return false
    }
    
    // Handles the starting of the timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timeSegmentedController.isEnabled = false
        
        startButton.setTitle("Pause", for: .normal)
    }
    
    
    // resets the timer to the selected value
    func resetTimer() {
        
        // stop timer if running
        timer?.invalidate()
        
        timerTotalSeconds = timeArray[timeIndex]
        timerSeconds = timerTotalSeconds % 60
        timerMinutes = timerTotalSeconds / 60
        updateTimerLabel()
        
        // change what the left button says
        startButton.setTitle("Start", for: .normal)
        
        // enable the segmenter
        timeSegmentedController.isEnabled = true
        
        // disable reset button
        resetButton.isEnabled = false
    }
    
    
    // delegate function
    func TimerAreaPressed() {
        resetTimer()
        startTimer()
    }
    
    // Handles the firing of the timer, which happens every second if the timer is active
    // calls the passSecond method, if the timer is at 0, handles the stopping of the timer and other things.
    @objc func fireTimer() {
        let timerOver : Bool = passSecond()
        // timer has reached 0
        if timerOver {
            timerLabel.text = "Time's Up!"
            // stop timer
            timer?.invalidate()
            
            // enable reset button and segmented controller
            resetButton.isEnabled = true
            timeSegmentedController.isEnabled = true
            
            
            // change what the left button says
            startButton.setTitle("Restart", for: .normal)
            
        } else {
            updateTimerLabel()
        }
    }
    
    // Handles pressing the start button (or the left button)
    @IBAction func startButtonPressed(_ sender: UIButton) {
        // start
        if sender.currentTitle == "Start" {
            startTimer()
        } else if sender.currentTitle == "Pause" {
            // timer running, button displays pause
            // pause the timer
            timer?.invalidate()
            
            // change text to resume
            sender.setTitle("Resume", for: .normal)
            
            // enable reset button
            resetButton.isEnabled = true
            
            // enable segment picker
            timeSegmentedController.isEnabled = true
        } else if sender.currentTitle == "Resume" {
            // change text to Pause
            sender.setTitle("Pause", for: .normal)
            
            // disable reset button
            resetButton.isEnabled = false
            startTimer()
        } else if sender.currentTitle == "Restart" {
            // redraw the circle
            redrawCircle()
            TimerAreaPressed()
        } else {
            //else case
        }
    }
    
    // Handles the pressing of the reset button
    // Assumes the timer is not running, because it has just been paused
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        
        // change the pause button to play
        startButton.setTitle("Start", for: .normal)
        
        // disable the timer button
        resetButton.isEnabled = false
        
        // redraw the circle
        redrawCircle()
        
        
        resetTimer()
        
    }
    
    func redrawCircle() {
        timerView.player = 0
        timerView.setNeedsDisplay()
    }
    
    /*
    
    // Handles the pressing of the timer to restart it
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        let tapPoint = sender.location(in: timerView)
        
        // Calculate it so that the center of the view is (0,0)
        let tapX : CGFloat = tapPoint.x - (timerView.frame.size.width/2)
        let tapY : CGFloat = tapPoint.y - (timerView.frame.size.height/2)
        
        // using the polar conversion of x,y to r, calculate the r
        let r : CGFloat = sqrt(pow(tapX, 2) + pow(tapY, 2))
        
        // the tap was inside the circle
        if r < radius {
            // restart the timer
            resetTimer()
            startTimer()
            
            // update the screen?
            
        }
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


protocol RestartDelegate {
    func TimerAreaPressed()
}

// class for the timerview, draws the circle
@IBDesignable

class TimerView: UIView {
    
    var radius: CGFloat = 0
    
    var delegate:RestartDelegate?
    
    var player = 0
    
    var pressState = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        // Graphics
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(5.0)
            UIColor.black.set()
            
            let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
            radius = (frame.size.width - 10)/2
            context.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
            
            //context.strokePath()
            
            if player == 0 {
                UIColor.black.set()
                context.strokePath()
            } else if player == 1 {
                UIColor.yellow.set()
                context.fillPath()
            } else if player == 2 {
                UIColor.blue.set()
                context.fillPath()
            }
            
        }
    }
    
    // Handles the pressing of the timer to restart it
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        let tapPoint = sender.location(in: self)
        
        // Calculate it so that the center of the view is (0,0)
        let tapX : CGFloat = tapPoint.x - (frame.size.width/2)
        let tapY : CGFloat = tapPoint.y - (frame.size.height/2)
        
        // using the polar conversion of x,y to r, calculate the r
        let r : CGFloat = sqrt(pow(tapX, 2) + pow(tapY, 2))
        
        // the tap was inside the circle
        if r < radius {
            
            
            if player == 0 || player == 2 {
                player = 1
                //UIColor.yellow.set()
            } else if player == 1 {
                player = 2
            }
            
            // this tells iOS it needs to update (redraw) the screen
            setNeedsDisplay()
            
            // restart the timer
            delegate?.TimerAreaPressed()
            
        }
    }
    
}
