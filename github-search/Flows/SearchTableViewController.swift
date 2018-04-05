//
//  SearchTableViewController.swift
//  github-search
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit
import Moya

class SearchTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

   
    let searchService = SearchService()
    var temp = [Base]()
    let userProvider = MoyaProvider<NetworkService>()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.hidesBarsWhenKeyboardAppears = true
//        navigationController?.isNavigationBarHidden = true
        setUpSearchBar()
        
        //the search bar from the first view controller is visible in the 2nd view controller after the push a new view controller to the navigation stack, this solved the problem
        self.definesPresentationContext = true

    }
    
    func setUpSearchBar() {
        // Adding a search bar
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search users or repositories..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {

        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
    }
 

    @objc func reload(_ searchBar: UISearchBar) {
         if let searchText = searchController.searchBar.text, searchText.count > 2 {
            print ("request send")
        searchService.loadUsersAndRepos(name: searchText) { [weak self]
            responce in
            print(responce)
            self?.temp = responce.sorted(by: {$0.id < $1.id})
            self?.tableView?.reloadData()
        }
    }
}
    override func numberOfSections(in tableView: UITableView) -> Int {
        
          return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return temp.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "UserCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = temp[indexPath.row].name
        print(temp[indexPath.row].id)
        if temp[indexPath.row].isUser == true {
               cell.detailTextLabel?.text = "user"
        } else {
             cell.detailTextLabel?.text = "repository"
        }
        return cell
}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if temp[indexPath.row].isUser == true {
            performSegue(withIdentifier: "toDatailVC", sender: indexPath)
        } else {
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDatailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! UserDetailViewController
                destinationController.user = temp[indexPath.row].name
            }
        }
    }
}
