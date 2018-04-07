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
    
    
    //MARK: Outlet
    @IBOutlet var emptySearchResult: UIView!
    
    
    //MARK: Properties
    let searchService = SearchService()
    var githubList = [Base]()
    let userProvider = MoyaProvider<NetworkService>()
    var searchController: UISearchController!
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = emptySearchResult
        tableView.backgroundView?.isHidden = true
        setUpSearchBar()
        
        //The search bar from the first view controller is visible in the 2nd view controller
        //after the push a new view controller to the navigation stack, this solved the problem
        self.definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: Methods
    func setUpSearchBar() {
        // Adding and configuration a search bar
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search users or repositories..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
    }
    

    func updateSearchResults(for searchController: UISearchController) {
        //Detecting when user stopped typing, to prevent the continuous calling to api
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
    }
 

    @objc func reload(_ searchBar: UISearchBar) {
         if let searchText = searchController.searchBar.text, searchText.count > 1 {
        searchService.loadUsersAndRepos(name: searchText) { [weak self]
            responce in

            self?.githubList = responce.sorted(by: {$0.id < $1.id})
            
            //if no results found, show background view with message
            let isNotFound = self?.githubList.count == 0
            self?.tableView.separatorStyle =  isNotFound ? .none : .singleLine
            self?.emptySearchResult.isHidden = !isNotFound
            
            self?.tableView?.reloadData()
        }
    }
}
    
    override func numberOfSections(in tableView: UITableView) -> Int {
          return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return githubList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "UserCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
     
        cell.textLabel?.text = githubList[indexPath.row].name
        cell.detailTextLabel?.text = githubList[indexPath.row].isUser ? "user" : "repository"
        
        return cell
}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if githubList[indexPath.row].isUser == true {
            performSegue(withIdentifier: "toDatailVC", sender: indexPath)
        } else { return }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDatailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! UserDetailViewController
                destinationController.user = githubList[indexPath.row].name
            }
        }
    }
}
