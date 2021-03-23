//
//  CreditsViewController.swift
//  Falling Valley
//
//  Created by Henry Calderon on 3/20/21.
//

import UIKit

class CreditsViewController: UIViewController{
    
    let credits: [String] = ["Sound effects obtained from https://www.zapsplat.com","Additional sound effects from https://www.zapsplat.com","Music from https://www.zapsplat.com"]
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var creditTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditTable.delegate = self
        creditTable.dataSource = self
    }
    
    @IBAction func exitPage(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreditsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCell", for: indexPath)
        cell.textLabel?.text = credits[indexPath.row]
        return cell
    }
    
    
}
