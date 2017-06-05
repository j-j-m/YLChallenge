//
//  GithubSearchCollectionViewController.swift
//  YLChallenge
//
//  Created by Jacob Martin on 6/3/17.
//  Copyright © 2017 Jacob Martin. All rights reserved.
//

import UIKit



class GithubSearchCollectionViewController: UICollectionViewController {
    
    struct Constants {
        struct Segue {
            static let userDetail = "UserDetailSegue"
        }
        
        struct Cell {
            static let follower = "FollowerCollectionViewCell"
        }
        
        struct Identifier {
            static let cell = "FollowerCell"
        }
        
        
    }
    
    var followers = [Follower]()
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 10.0, right: 30.0)
    fileprivate let itemsPerRow = 3
    
    var searchTerm = ""
    var page = 1 // to keep track of the currently fetched page
    
    var searching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView!.register(UINib(nibName:Constants.Cell.follower, bundle: nil), forCellWithReuseIdentifier: Constants.Identifier.cell)
        
        
        setupSearchBar(focused: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        if let navBar = navigationController?.navigationBar {
            navBar.barStyle = UIBarStyle.black
            navBar.isTranslucent = false
            navBar.tintColor = .white
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
        }
    }
    
    func setupStandardNav() {
        navigationItem.titleView = nil
        navigationItem.title = "Home"
        let searchItem : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search,
                                                           target: self,
                                                           action: #selector(GithubSearchCollectionViewController.setupSearchBar))
        navigationItem.rightBarButtonItem = searchItem
        
        searching = false
    }
    
    func setupSearchBar(focused: Bool = false) {
        navigationItem.rightBarButtonItem = nil
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Github"
        searchBar.backgroundColor = .black
        searchBar.tintColor = .white
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        if let textField = searchBar.value(forKey: "_searchField") as? UITextField {
            textField.backgroundColor = .lightGray
            textField.textColor = .white
            textField.keyboardAppearance = .dark
            textField.returnKeyType = .default
            
            if focused {
                textField.becomeFirstResponder()
            }
        }
    
        searching = true
        
        self.navigationItem.titleView = searchBar
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier == Constants.Segue.userDetail {
            if let vc = segue.destination as? UserTableViewController, let f = sender as? Follower {
                vc.follower = f
            }
        }
        
    }
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // divide follower count by elements in row. add remainder
        return followers.count/itemsPerRow + (followers.count % itemsPerRow > 0 ? 1 : 0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // calculate number of items in section by counting remaining elements at section
        let remaining = (followers.count - section*3)
        let sectionSize = remaining >= itemsPerRow ? itemsPerRow : remaining
        print(sectionSize)
        return sectionSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.cell, for: indexPath) as! FollowerCollectionViewCell
        let paddingSpace = sectionInsets.left
        let cellDim = collectionView.bounds.width/CGFloat(itemsPerRow) - paddingSpace*2
        
        cell.imageView.cornerRadius = cellDim / 2
        
        
        let follower = self.follower(at: indexPath)
        cell.setFollower(follower)
        if let url = follower.avatarURL {
            WebService.shared.retrieveAvatarFromUrl(url) { image in
                DispatchQueue.main.async {
                    cell.image = image
                }
            }
        }
        
        
        return cell
    }
    
    func follower(at indexPath: IndexPath) -> Follower {
        let i = indexPath.section*Int(itemsPerRow) + indexPath.item
        return followers[i]
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let sectionCount = numberOfSections(in: self.collectionView!) - 1
//        if indexPath.section == sectionCount {
//            WebService.shared.getFollowers(user: searchTerm, atPage: page) { followers in
//                DispatchQueue.main.async {
//                    self.followers = followers
//                    self.collectionView?.reloadData()
//                    self.page += 1
//                }
//            }
//        }
//    }
    
    
    //this didnt behave well... tapping return works for now
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if searching {
//            dismissKeyboard()
//            setupStandardNav()
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        //FIXME: - there is a more view specific way to this... 
        //but to get visuals up to snuff this suffices
        
        dismissKeyboard()

        let follower = self.follower(at: indexPath)
        performSegue(withIdentifier: Constants.Segue.userDetail, sender: follower)
    }
    
    
    
}

extension GithubSearchCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        let paddingSpace = sectionInsets.left

      
        
        let cellDim = collectionView.bounds.width/CGFloat(itemsPerRow) - paddingSpace*2
        
        return CGSize(width: cellDim, height: cellDim * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


// MARK: UISearchBarDelegate

extension GithubSearchCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setupStandardNav()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        setupStandardNav()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        if let searchText = searchBar.text {
//            search(searchText)
//        }
    }
    
    func search(_ term:String) {
            self.searchTerm = term
        
            WebService.shared.getFollowers(user: term, atPage: page) { followers in
                DispatchQueue.main.async {
                    self.followers = followers
                    self.collectionView?.reloadData()
                }
            }
    }
}
