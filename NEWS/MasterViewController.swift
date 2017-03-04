//
//  MasterViewController.swift
//  NEWS
//
//  Created by Hemant Singh on 01/03/17.
//  Copyright © 2017 Hatchitup Inc. All rights reserved.
//

import UIKit
import Kingfisher
class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var sources = Sources()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        Sources.getSources(lang: "en") { (sources) in
            self.sources = sources
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = sources.sources[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.newsSource = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.splitViewController?.preferredDisplayMode = .primaryHidden
        }
        
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sources
            .sources.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as! ChannelCell

        let source = sources.sources[indexPath.row]
        cell.nameLabel.text = source.name
        cell.descriptionLabel.text = source.descriptionField
        cell.logoImageView.kf.setImage(with: URL.init(string: (source.urlsToLogos.small)!))
        return cell
    }
}

class ChannelCell : UITableViewCell{
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
}
