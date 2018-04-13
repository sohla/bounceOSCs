//
//  SensorsTableViewController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 4/6/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit

protocol CaseCountable: RawRepresentable {}
extension CaseCountable where RawValue == Int {
    static var count: RawValue {
        var i: RawValue = 0
        while let _ = Self(rawValue: i) { i += 1 }
        return i
    }
}
//enum SensorTypes : Int , CaseCountable{
//    case Motion
//    case Audio
//}
//
//
//enum MotionTypes : Int , CaseCountable{
//    case Accel
//    case Gyro
//    case Gravity
//    
//}

class SensorsTableViewController: UITableViewController {

    let sections = ["Motion","Audio","Touch"]
    let rows = [["Gyroscope","RotationMatrix","Accelerometer","RotationRate","Quaternion"], ["Amp","Pitch"], ["Button","Slider"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rows[section].count
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var h: CGFloat = 77.0
        if(indexPath.section == 2 && indexPath.row == 1) {h = 140.0}
        return h
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(withIdentifier: "motionHeaderCell") as! MotionHeaderTableViewCell

        header.titleLabel.text = sections[section]
        
        return header
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //TouchTableViewCell
        if( rows[indexPath.section][indexPath.row] == "Button" ){

            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell
            // Configure the cell...
            cell.titleLabel?.text = rows[indexPath.section][indexPath.row]
            
            return cell
        }else if( rows[indexPath.section][indexPath.row] == "Slider" ){
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "sliderCell", for: indexPath) as! SliderTableViewCell
                // Configure the cell...
                cell.titleLabel?.text = rows[indexPath.section][indexPath.row]
                
                return cell

        }else{

            let cell = tableView.dequeueReusableCell(withIdentifier: "sensorCell", for: indexPath) as! SensorTableViewCell
            // Configure the cell...
            cell.titleLabel?.text = rows[indexPath.section][indexPath.row]
            cell.load(rows[indexPath.section][indexPath.row])
            
            return cell

        }
        

    }

//    func onOffSwitchDidChange(_ cell: SensorTableViewCell, state: Bool) {
//        print(cell.titleLabel.text ?? "-", state)
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
