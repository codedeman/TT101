//
//  SearchVC.swift
//  VinidNews
//
//  Created by Apple on 12/1/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class SearchVC: UIViewController {

    @IBOutlet weak var spinerActivity: UIActivityIndicatorView!
    var newsViewModel = NewsViewModel()
    let disposeBag = DisposeBag()
    @IBOutlet weak var searchInputTxt: UITextField!

    @IBOutlet weak var resultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            blindUI()
            blindTableViewSelected()
                resultTableView.register(UINib(nibName: "NewFeed2Cell", bundle: nil), forCellReuseIdentifier: "NewFeed2Cell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        

        if CheckInternet.connectInternet(){
            
            
        }else{
            self.showOffline()
        }
    }
    
    func blindUI(){
        
        self.searchInputTxt.rx.text.throttle(1, scheduler: MainScheduler.instance).distinctUntilChanged().asObservable().bind(to: newsViewModel.searchInput).disposed(by: disposeBag)
        
        searchInputTxt.rx.text.subscribe(onNext: { (text) in
                if text!.isEmpty{
                    
                    self.spinerActivity.stopAnimating()
                    
                }else{
                    
                    self.spinerActivity.startAnimating()
                }
            
            }, onError: nil, onCompleted: nil).dispose()
        
        self.newsViewModel.searchResult.asObservable().bind(to: self.resultTableView.rx.items(cellIdentifier: "NewFeed2Cell", cellType: NewFeedCell.self)){

                   (index,news,cell) in
               DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                
                    self.spinerActivity.stopAnimating()
                    
                   cell.titleLabel.text = news.title
                   cell.descriptionLabel.text = news.subtitle
                   cell.pubdateLabel.text = news.pubdate
                   let imageString = "https://www.nytimes.com/\(news.thumnail ?? "")"
                   cell.imageUrl.loadImageUsingCache(withUrl: imageString)
               }
                   
               }.disposed(by: disposeBag)
           
       }
    @IBAction func backForwardButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    private func blindTableViewSelected()
       
        {
           
           resultTableView.rx.modelSelected(NewsModel.self).subscribe(onNext: { (data) in
               
               let pvc = NewsDetailVC()
               
               pvc.web_url = data.url
               
               self.navigationController?.present(pvc, animated: true, completion: nil)
               
            }).disposed(by: disposeBag)
                
                
        }

    
    

   

}
