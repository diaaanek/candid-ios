//
//  InterviewTypeTableViewController.swift
//  Candid
//
//  Created by Diane Korongy on 3/24/18.
//  Copyright © 2018 Developers Academy. All rights reserved.
//

import UIKit
import expanding_collection

class InterviewTypeTableViewController: ExpandingTableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    

}



extension InterviewTypeTableViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -100 , let navigationController = navigationController {
                  popTransitionAnimation()
                }
            }

        }


