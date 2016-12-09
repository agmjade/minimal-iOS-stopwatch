//
//  ViewController.swift
//  Stop_Watch
//
//  Created by Jade Pasion on 10/21/15.
//  Copyright © 2015 Jade Pasion. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var laps: [String] = []
    
    var timer = NSTimer()
    var minutes: Int = 0
    var seconds: Int = 0
    var milli: Int = 0
    
    var stopwatchString: String = ""
    
    var startStopWatch: Bool = true
    var addLap: Bool = false
    
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetLapButton: UIButton!
    
    @IBAction func startStopPressed(sender: AnyObject) {
        
        if startStopWatch == true
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateTime"), userInfo: nil, repeats: true)
            startStopWatch = false
            
            startStopButton.setTitle("Stop", forState: UIControlState.Normal)
            resetLapButton.setTitle("Lap", forState: UIControlState.Normal)
            
            addLap = true
        }
        else
        {
            timer.invalidate()
            startStopWatch = true
            
            startStopButton.setTitle("Start", forState: UIControlState.Normal)
            resetLapButton.setTitle("Reset", forState: UIControlState.Normal)
            
            addLap = false
        }
    }
    
    
    @IBAction func resetLapPressed(sender: AnyObject) {
        
        if addLap == true
        {
            laps.insert(stopwatchString, atIndex: 0)
            lapsTableView.reloadData()
        }
        else
        {
            addLap = false
            
            resetLapButton.setTitle("Lap", forState: UIControlState.Normal)
            
            laps.removeAll()
            lapsTableView.reloadData()
            
            milli = 0
            seconds = 0
            minutes = 0
            
            stopwatchString = "00:00.00"
            TimeLabel.text = stopwatchString
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TimeLabel.text = "00:00.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTime() {
        
        milli += 1
        if milli == 100 {
            seconds += 1
            milli = 0
        }
        
        if seconds == 60 {
             minutes += 1
            seconds = 0
        }
        
        let milliString = milli > 9 ? "\(milli)" : " 0\(milli)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopwatchString = "\(minutesString):\(secondsString).\(milliString)"
        TimeLabel.text = stopwatchString
        
    }
 
    
    //table view methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = self.view.backgroundColor
        
        cell.textLabel!.text = "Lap \(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
}

