//
//  IPAddressTableViewController.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 3/6/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit
import MMLanScan

class IPAddressTableViewController: UITableViewController, MMLANScannerDelegate {

    var lanScanner : MMLANScanner!
    var connectedDevices : [MMDevice]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lanScanner = MMLANScanner(delegate:self)
        self.connectedDevices = [MMDevice]()
        
        self.title = "scanning..."
    }
    override func viewWillAppear(_ animated: Bool) {
        lanScanner.start()
    }
    override func viewWillDisappear(_ animated: Bool) {
        lanScanner.stop()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectedDevices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ipAddress", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = connectedDevices[indexPath.row].ipAddress
        
        return cell
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! TXOSCViewController
        let cell = sender as! UITableViewCell
        vc.setipAddressTextField((cell.textLabel?.text)!)
    }
    

    //
    
    func lanScanDidFindNewDevice(_ device: MMDevice!){
        print("new device found at : \(String(describing: device.ipAddress))")

        connectedDevices?.append(device)
        self.tableView.reloadData()
    }
    func lanScanDidFinishScanning(with status: MMLanScannerStatus){
        title = "scanning done"
        
    }
    func lanScanProgressPinged(_ pingedHosts: Float, from overallHosts: Int){
        title = "scanning \(Int(pingedHosts / Float(overallHosts)*100))%"
    }
    func lanScanDidFailedToScan(){
        title = "scanning failed"
        
    }

}
