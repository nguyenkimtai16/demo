//
//  ViewController.swift
//  TestiOSApp
//
//  Created by tai Nguyen on 24/11/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var subscriptions = Set<AnyCancellable>()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func plusAction(_ sender: UIButton) {
        
//        let publisher = Just("Combine Swift")
//        let subscribtion = publisher.sink { value in
//          print(value)
//        }
        
//        let subject = PassthroughSubject<String, Never>()
//        let publisher = subject.eraseToAnyPublisher()
//
//        let subscriber = publisher.sink(receiveValue: { value in
//            print("subscript 1: " + value)
//        })
//
//        subject.send("Combine") //The Subscriber will print "Combine"
//        subject.send("Swift")   //The Subscriber will print "Swift"
//
//        let subscriber2 = publisher.sink(receiveValue: { value in
//            print("subscript 2: " + value)
//        })
//        //Subscriber1 and Subscriber2 will recive this event
//        subject.send("Event3")
        
//        let publisher: ABCPublisher<Int, Error> = Publishers.Sequence(sequence: [1,2,3,5,6])
        
        // ** Filter **
//        _ = Publishers.Sequence(sequence: [1,2,2,3,3,4,7])
////            .map { $0 * 10 }
////            .flatMap {Just($0) }
////            .filter{ $0.isMultiple(of: 2) }
////            .removeDuplicates()
//            .dropFirst(5)
//            .sink(receiveValue: {
//                print($0)
//            })
        
//        var selectedFilter = PassthroughSubject<String, Never>()
//        let searchText = PassthroughSubject<String, Never>()
//
//        let publisher = Publishers.CombineLatest(selectedFilter,searchText).map {
//            selectedFilter, searchText in
//            "\(selectedFilter) \(searchText)"
//        }
//
//        _ = publisher.sink { value in
//            print(value)
//        }
        
        struct WebSiteData: Codable {
            var rawHTML: String
        }


        let myURL = URL(string: "https://www.example.com")


        URLSession.shared.dataTaskPublisher(for: myURL!)
            .retry(3)
            .map({ (page) -> WebSiteData in
                return WebSiteData(rawHTML: String(decoding: page.data, as: UTF8.self))
            })
            .catch { error in
                return Just(WebSiteData(rawHTML: "<HTML>Unable to load page - timed out.</HTML>"))
        }
        .sink(receiveCompletion: { print ("completion: \($0)") },
              receiveValue: { print ("value: \($0)") }
         )
        .store(in: &cancellables)
        
//        cancellable.cancel()
        
        // Encode
//        struct Article: Codable {
//            let title: String
//            let author: String
//            let pubDate: Date
//        }
//        let dataProvider = PassthroughSubject<Article, Never>()
//        let cancellable = dataProvider
//            .encode(encoder: JSONEncoder())
//            .sink(receiveCompletion: { print ("Completion: \($0)") },
//                  receiveValue: {  data in
//                    guard let stringRepresentation = String(data: data, encoding: .utf8) else { return }
//                    print("Data received \(data) string representation: \(stringRepresentation)")
//            })
//        dataProvider.send(Article(title: "My First Article", author: "Gita Kumar", pubDate: Date()))
        
//        let publisher = ["H", "e", "l", "l", "o", " ", nil, "W", "o", nil, "r", "l", "!"].publisher
//        let subscriber = Subscribers.Sink<String, Never>(receiveCompletion: { completion in
//          print(completion)
//        }) { value in
//          print(value)
//        }
//        publisher
//          .filter { $0 != nil }
//          .map { $0! }
//          .reduce("", +)
//          .subscribe(subscriber)
        
//        let popOverViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserPopOverUIViewController")
//        popOverViewController.modalPresentationStyle = .popover
//        
//        popOverViewController.preferredContentSize = .init(width: 240, height: 220)
//        
//        guard let presentationVC = popOverViewController.popoverPresentationController else { return }
//        presentationVC.delegate = self
//        presentationVC.sourceView = sender
//        presentationVC.permittedArrowDirections = .unknown
//        presentationVC.sourceRect = CGRect(x: Int(sender.bounds.midX),
//                                           y: Int(sender.bounds.maxY),
//                                           width: 0,
//                                           height: 0)
//        present(popOverViewController, animated: true)
        
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }

        func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {

        }

        func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
            return true
        }
}


final class IntSubscriber: Subscriber {
  
  typealias Input = Int
  typealias Failure = Never
  
  func receive(subscription: Subscription) {
    subscription.request(.max(3))
  }
  
  func receive(_ input: Int) -> Subscribers.Demand {
    print("Received value", input)
      return .none
//    return .unlimited
  }
  
  func receive(completion: Subscribers.Completion<Never>) {
    print("Received completion", completion)
  }
}
