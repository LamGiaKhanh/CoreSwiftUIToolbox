//
//  Stepper.swift
//  Common
//
//  Created by Phat Le on 29/04/2022.
//

import Foundation
import Combine

public protocol Stepper: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
    var steps: PassthroughSubject<Step, Never> { get }
}

public extension Stepper {
    func combine(with stepper: Stepper) {
        stepper.steps
            .receive(on: DispatchQueue.main)
            .sink { [weak self] step in
                guard let self = self else { return }
                self.steps.send(step)
            }
            .store(in: &cancellables)
    }
}
