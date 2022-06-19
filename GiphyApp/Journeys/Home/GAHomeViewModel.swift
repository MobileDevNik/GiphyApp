//
//  GAHomeViewModel.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation

enum CurrentMode {
    case search(query: String, loadMore: Bool)
    case trending(loadMore: Bool)
    case existingTrending
}
enum GAHomeViewModelEvent {
    case dataSource(dataSource: [GIF])
    case searchFailure
    case trendingFailure
    case dataFetchStarted
    case dataFetchStopped
}

protocol GAHomeViewModelProtocol: AnyObject {
    func processEvent(viewEvent: GAHomeViewControllerEvent)
    func setEventHandler(eventHandler: GAHomeViewModelEventsProtocol)
}
protocol GAHomeViewModelEventsProtocol: AnyObject {
    func viewModelEvent(event: GAHomeViewModelEvent)
}

class GAHomeViewModel: GAHomeViewModelProtocol {
    weak var eventHandler: GAHomeViewModelEventsProtocol?
    var trendingDataSource: GIFModel<GIF> = GIFModel<GIF>()
    var searchDataSource: GIFModel<GIF> = GIFModel<GIF>()

    let useCase = GAHomeUseCase()
    var currentMode: CurrentMode = .trending(loadMore: false) { didSet { processChange() } }
    func setEventHandler(eventHandler: GAHomeViewModelEventsProtocol) {
        self.eventHandler = eventHandler
    }
    
    func processEvent(viewEvent: GAHomeViewControllerEvent) {
        switch viewEvent {
        case .userSearching(let query):
            searchDataSource.reset()
            currentMode = .search(query: query, loadMore: false)
        case .userSearchEnd:
            currentMode = .existingTrending
        case .userSelectedGIF:
            print("selected GIF")
        case .viewLoaded:
            currentMode = .trending(loadMore: false)
        case .loadMoreData:
            switch currentMode {
            case .search(let query, _):
                currentMode = .search(query: query, loadMore: true)
            default:
                currentMode = .trending(loadMore: true)
            }
        case .viewAppear:
            print("Viewappear")
        }
    }
    
    func fullFillSearchQueryRequest(query: String, loadMore: Bool) {
        self.eventHandler?.viewModelEvent(event: .dataFetchStarted)
        useCase.findGIFs(searchQuery: query, offset: loadMore ? self.searchDataSource.getNextOffset() : 0, limit: 20) {[weak self] result in
            self?.eventHandler?.viewModelEvent(event: .dataFetchStopped)
            guard let weakSelf = self else {return}
            switch result {
            case .success(let allGIF):
                DispatchQueue.main.async {
                    weakSelf.searchDataSource.addNewData(model: allGIF.data)
                    weakSelf.eventHandler?.viewModelEvent(event: .dataSource(dataSource: weakSelf.searchDataSource.models))
                }
            case .failure(_):
                DispatchQueue.main.async {
                    weakSelf.eventHandler?.viewModelEvent(event: .searchFailure)
                }
            }
        }
    }
    
    func fullFillTrendingRequest(loadMore: Bool) {
        self.eventHandler?.viewModelEvent(event: .dataFetchStarted)
        useCase.getDefaultGIFs(offset: loadMore ? self.trendingDataSource.getNextOffset() : 0, limit: 20) {[weak self] result in
            self?.eventHandler?.viewModelEvent(event: .dataFetchStopped)
            guard let weakSelf = self else {return}
            switch result {
            case .success(let allGIF):
                DispatchQueue.main.async {
                    weakSelf.trendingDataSource.addNewData(model: allGIF.data)
                    weakSelf.eventHandler?.viewModelEvent(event: .dataSource(dataSource: weakSelf.trendingDataSource.models))
                }
            case .failure(_):
                DispatchQueue.main.async {
                    weakSelf.eventHandler?.viewModelEvent(event: .trendingFailure)
                }
            }
        }
    }
    
    func processChange() {
        switch currentMode {
        case .search(let query, let loadMore):
            fullFillSearchQueryRequest(query: query, loadMore: loadMore)
        case .trending(let loadMore):
            fullFillTrendingRequest(loadMore: loadMore)
        case .existingTrending:
            self.eventHandler?.viewModelEvent(event: .dataSource(dataSource: trendingDataSource.models))
        }
    }
}
