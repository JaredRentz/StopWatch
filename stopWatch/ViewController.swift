//
//  ViewController.swift
//  stopWatch
//
//  Created by Jared Rentz on 1/13/16.
//  Copyright © 2016 UXOThings LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var startstopButton: UIButton!
    @IBOutlet weak var lapReset: UIButton!
    
    var timer = NSTimer()
    var minutes: Int  = 0
    var seconds: Int  = 0
    var fractions: Int  = 0
    
    var startTheStopWatch = true
    var addLap = false
    
    var stopWatchString: String = ""
    
    var laps = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopwatchLabel.text = "00:00:00"
        
        tableView.delegate = self
        tableView.dataSource = self
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel!.text = "Laps \(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func updateTime () {
        
        fractions += 1
        if fractions == 100 {
            
            seconds++
            fractions = 0
        }
        if seconds == 60 {
            minutes++
            seconds = 0
        }
// TODO:
        let fractionString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondString = seconds > 9 ? "\(seconds)": "0\(seconds)"
        let minuteString = minutes > 9 ? "\(minutes)": "0\(minutes)"
        
        stopWatchString = "\(minuteString):\(secondString):\(fractionString)"
        stopwatchLabel.text = stopWatchString
        
    }

    @IBAction func onStartStopPressed(sender: AnyObject) {
        
        if startTheStopWatch == true {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
            startstopButton.setImage(UIImage(named: "StopButton.png"), forState: .Normal)
            lapReset.setImage(UIImage(named: "LapButton.png"), forState: .Normal)
            
            
            startTheStopWatch = false
            
            addLap = true
        } else {
            timer.invalidate()
            startTheStopWatch = true
            addLap = false
            startstopButton.setImage(UIImage(named: "StartButton.png"), forState: .Normal)
            lapReset.setImage(UIImage(named: "ResetButton.png"), forState: .Normal)
        }
        
    }

    @IBAction func onLapResetButton(sender: AnyObject) {
        
        if addLap == true {
            
            laps.insert(stopWatchString, atIndex: 0)
            tableView.reloadData()
            
            
        }else {
            
            addLap = false
            
            laps.removeAll(keepCapacity: true)
            tableView.reloadData()
            startstopButton.setImage(UIImage(named: "StartButton.png"), forState: .Normal)
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopWatchString = "00:00:00"
            stopwatchLabel.text = stopWatchString
            
        }
    }
}

