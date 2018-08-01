//
//  IssueListViewController.swift
//  CocoaApp
//
//  Created by Trung Kiên on 7/31/18.
//  Copyright © 2018 Trung Kiên. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
class IssueListViewController: UIViewController {
    let disposeBag = DisposeBag()
    var issueTrackerModel: IssueTrackerModel!
    var provider: RxMoyaProvider<GitHub>!
    var latestRepositoryName: Observable<String> {
        return searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.rowHeight = 60
        setupRx()
    }
    func setupRx() -> Void {
        provider = RxMoyaProvider<GitHub>()
        issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)

        issueTrackerModel
            .trackIssues()
            .bindTo(tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item.title
                
                return cell
            }
            .addDisposableTo(disposeBag)
        

        tableView
            .rx.itemSelected
            .subscribe(onNext: { indexPath in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
            })
            .addDisposableTo(disposeBag)
    
    }
}
