//
//  QuestionsTableViewController.swift
//  Candid
//
//  Created by Diane Korongy on 3/24/18.
//  Copyright © 2018 Diane Korongy. All rights reserved.
//

import UIKit
import SafariServices

class QuestionsTableViewController: UITableViewController
{
    var questions = [Question]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        questions = Question.downloadAllQuestions()
        self.tableView.reloadData()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Question Cell", for: indexPath) as! QuestionTableViewCell
        let question = questions[indexPath.row]
        
        cell.question = question

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let question = questions[indexPath.row]
        let safariVC = SFSafariViewController(url: question.url!)
        
        self.present(safariVC, animated: true, completion: nil)
    }
    
    // MARK: - Target / Action
    
    @IBAction func fullBlogDidTap(_ sender: AnyObject)
    {
        
    }
    
}
















