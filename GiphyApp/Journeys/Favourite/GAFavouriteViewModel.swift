//
//  GAFavouriteViewModel.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation

enum CurrentViewMode {
    case list(loadMore: Bool)
    case grid(loadMore: Bool)
}
enum GAFavViewModelEvent {
    case listData(data: [FavouriteModel])
    case gridData(data: [FavouriteModel])
    case dataFetchStarted
    case dataFetchStopped
}

protocol GAFavViewModelProtocol: AnyObject {
    func processEvent(viewEvent: GAFavViewControllerEvent)
    func setEventHandler(eventHandler: GAFavViewModelEventsProtocol)
}
protocol GAFavViewModelEventsProtocol: AnyObject {
    func viewModelEvent(event: GAFavViewModelEvent)
}

class GAFavViewModel: GAFavViewModelProtocol {
    weak var eventHandler: GAFavViewModelEventsProtocol?
    var lisDataSource: GIFModel<FavouriteModel> = GIFModel<FavouriteModel>()
    var gridDataSource: GIFModel<FavouriteModel> = GIFModel<FavouriteModel>()
    
    var useCase: GAFavUseCaseProtocol = GAFavUseCase()
    var currentMode: CurrentViewMode = .list(loadMore: false) { didSet { processChange() } }
    func setEventHandler(eventHandler: GAFavViewModelEventsProtocol) {
        self.eventHandler = eventHandler
    }
    
    func processEvent(viewEvent: GAFavViewControllerEvent) {
        switch viewEvent {
        case .loadList:
            lisDataSource.reset()
            currentMode = .list(loadMore: false)
        case .LoadGrid:
            gridDataSource.reset()
            currentMode = .grid(loadMore: false)
        case .loadMore:
            switch currentMode {
            case .list(_):
                currentMode = .list(loadMore: true)
            case .grid(_):
                currentMode = .grid(loadMore: true)
            }
        case .viewAppear:
            useCase.updateFavourites()
            lisDataSource.reset()
            gridDataSource.reset()
            switch currentMode {
            case .list(_):
                currentMode = .list(loadMore: false)
            case .grid(_):
                currentMode = .grid(loadMore: false)
            }
        }
    }
    
    func fullFillGridLoadRequest(loadMore: Bool) {
        self.eventHandler?.viewModelEvent(event: .dataFetchStarted)
        useCase.getFavourites(offset: loadMore ? gridDataSource.getNextOffset() : 0, limit: 20) {[weak self] models in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.eventHandler?.viewModelEvent(event: .dataFetchStopped)
            }
            guard !models.isEmpty else {return}
            guard let weakSelf = self else {return}
            weakSelf.gridDataSource.addNewData(model: models)
            weakSelf.eventHandler?.viewModelEvent(event: .gridData(data: weakSelf.gridDataSource.models))
        }
    }
    
    func fullFillListLoadRequest(loadMore: Bool) {
        self.eventHandler?.viewModelEvent(event: .dataFetchStarted)
        useCase.getFavourites(offset: loadMore ? lisDataSource.getNextOffset() : 0, limit: 20) {[weak self] models in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.eventHandler?.viewModelEvent(event: .dataFetchStopped)
            }
            guard !models.isEmpty else {return}
            guard let weakSelf = self else {return}
            weakSelf.lisDataSource.addNewData(model: models)
            weakSelf.eventHandler?.viewModelEvent(event: .listData(data: weakSelf.lisDataSource.models))
        }
    }
    
    func processChange() {
        switch currentMode {
        case .list(let loadMore):
            fullFillListLoadRequest(loadMore: loadMore)
        case .grid(let loadMore):
            fullFillGridLoadRequest(loadMore: loadMore)
        }
    }
}
