//
//  MainViewControllerPresenter.swift
//  MVPSample
//
//  Created by Antonio Corrales on 27/6/18.
//  Copyright © 2018 DesarrolloManzana. All rights reserved.
//

import Foundation

protocol MainView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func getDataSuccess(data: [Data])
    func getDataError()
}

class MainViewControllerPresenter {
    
    weak fileprivate var mainView: MainView?
    
    func attachView(_ view:MainView){
        mainView = view
    }
    
    func detachView() {
        mainView = nil
    }
    
    func getData(){
        mainView?.startLoading()
        ApiClient.getDataFromServer { (success, data) in
            self.mainView?.finishLoading()
            if success {
                self.mainView?.getDataSuccess(data: data!)
            } else {
                self.mainView?.getDataError()
            }
        }
    }
}
