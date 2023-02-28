//
//  Publisher++.swift
//  Common
//
//  Created by Phat Le on 29/04/2022.
//

import Combine

public extension Publisher {
    func ignore() -> AnyCancellable {
        return sink { result in
            //
        } receiveValue: { value in
            //
        }
    }
}

// PromiseKit-like
public extension Publisher {
    
    func then<T: Publisher>(_ closure: @escaping (Output) -> T) -> Publishers.FlatMap<T, Self>
    where T.Failure == Self.Failure {
        flatMap(closure)
    }
    
    func asVoid() -> Future<Void, Error> {
        return Future<Void, Error> { promise in
            let box = Box()
            let cancellable = self.sink { completion in
                if case .failure(let error) = completion {
                    promise(.failure(error))
                } else if case .finished = completion {
                    box.cancellable = nil
                }
            } receiveValue: { value in
                promise(.success(()))
            }
            box.cancellable = cancellable
        }
    }
    
    @discardableResult
    func done(_ handler: @escaping (Output) -> Void) -> Self {
        let box = Box()
        let cancellable = self.sink(receiveCompletion: {compl in
            if case .finished = compl {
                box.cancellable = nil
            }
        }, receiveValue: {
            handler($0)
        })
        box.cancellable = cancellable
        return self
    }
    
    @discardableResult
    func `catch`(_ handler: @escaping (Failure) -> Void) -> Self {
        let box = Box()
        let cancellable = self.sink(receiveCompletion: { compl in
            if case .failure(let failure) = compl {
                handler(failure)
            } else if case .finished = compl {
                box.cancellable = nil
            }
        }, receiveValue: { _ in })
        box.cancellable = cancellable
        return self
    }
    
    @discardableResult
    func finally(_ handler: @escaping () -> Void) -> Self {
        let box = Box()
        let cancellable = self.sink(receiveCompletion: { compl in
            if case .finished = compl {
                handler()
                box.cancellable = nil
            }
        }, receiveValue: { _ in })
        box.cancellable = cancellable
        return self
    }
}

fileprivate class Box {
    var cancellable: AnyCancellable?
}

// Zip many (as Future.wait)
extension Publishers {
    struct ZipMany<Element, F: Error>: Publisher {
        typealias Output = [Element]
        typealias Failure = F

        private let upstreams: [AnyPublisher<Element, F>]

        init(_ upstreams: [AnyPublisher<Element, F>]) {
            self.upstreams = upstreams
        }

        func receive<S: Subscriber>(subscriber: S) where Self.Failure == S.Failure, Self.Output == S.Input {
            let initial = Just<[Element]>([])
                .setFailureType(to: F.self)
                .eraseToAnyPublisher()

            let zipped = upstreams.reduce(into: initial) { result, upstream in
                result = result.zip(upstream) { elements, element in
                    elements + [element]
                }
                .eraseToAnyPublisher()
            }

            zipped.subscribe(subscriber)
        }
    }
}
