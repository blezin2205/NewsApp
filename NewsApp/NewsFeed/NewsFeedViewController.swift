//
//  NewsFeedViewController.swift
//  NewsApp
//
//  Created by Blezin on 24.10.2020.
//  Copyright (c) 2020 Blezin'sDev. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsfeedCodeCellDelegate {
   
    
   
    

  var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    private var feedViewModel = FeedViewModel.init(cells: [])

    @IBOutlet weak var table: UITableView!
    // MARK: Object lifecycle

  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
    table.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
    
    table.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
    interactor?.makeRequest(request: .getNewsFeed)
    table.separatorStyle = .none
    table.backgroundColor = .clear
    view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
  }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {

    switch viewModel {
 
    case .displayNewsFeed(feedViewModel: let feedViewModel):
        self.feedViewModel = feedViewModel
        table.reloadData()
    }
  
}
    
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else {return}
        let cellViewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
       }
    
    
}


extension NewsFeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as! NewsfeedCodeCell

        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         let cellViewModel = feedViewModel.cells[indexPath.row]
         return cellViewModel.sizes.totalHeight
    }
    
    
}
