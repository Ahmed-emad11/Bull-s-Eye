//
//  ViewController.swift
//  Bull's Eye
//
//  Created by Ahmed Emad on 10/06/2024.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue = 0
    var score = 0
    var round = 0
  //  var defference = 0

    func startNewRound(){
        round += 1
        targetValue = Int .random(in: 1...100)
        let currentValue: Int = 50
        slider.value = Float(currentValue)
        updateLable()
    }
    func updateLable(){
        targetLable.text = String(targetValue) // "\(target value)"
        scoreLable.text = String(score)
        roundLable.text = String(round)
        
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
        
        let transition = CATransition()
          transition.type = CATransitionType.fade
          transition.duration = 1
          transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
          view.layer.add(transition, forKey: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
            
    }
    @IBAction func showAlert(){
        let defference = abs(targetValue - currentValue)
        var point = 100 - defference
        
        let title: String //var title:String = ""
        if defference == 0 /* || defference == 1*/ {
            title = "prefect!"
            point += 100
        }else if defference < 5 {
            title = "you almost had it!"
            if defference == 1  {
                point += 50
            }
        }else if defference < 10 {
            title = "pretty good!"
        } else {
            title = "Not even close..."
        }
        score += point
        
        
        let message = "You scored \(point) points"
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default) {_ in self.startNewRound()}
           // handler: { _ in self.startNewRound()})
        
        alert.addAction(action)
        // to make the alert is visible
        present(alert, animated: true, completion: nil)
        
        // to start new round
       // self.startNewRound()
    }
    @IBAction func startOver(){
        self.startNewGame()
    }
    @IBOutlet var roundLable: UILabel!
    @IBOutlet var scoreLable: UILabel!
    @IBOutlet var targetLable: UILabel!
    @IBOutlet var slider: UISlider!
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
}

