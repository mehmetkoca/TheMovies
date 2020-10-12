//
//  StatefulViewModel.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

protocol StateChange { }

class StatefulViewModel<SC: StateChange>: BaseViewModel {
    typealias StateChangeHandler = ((SC) -> Void)
    
    private var stateChangeHandlers: [StateChangeHandler] = []
    
    final func addChangeHandler(_ handler: @escaping StateChangeHandler) {
        stateChangeHandlers.append(handler)
    }
    
    final func emit(change: SC) {
        stateChangeHandlers.forEach { (handler: StateChangeHandler) in
            handler(change)
        }
    }
}
