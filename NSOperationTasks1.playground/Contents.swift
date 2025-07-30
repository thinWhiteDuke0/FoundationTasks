import Foundation

class OperationTester {
    let customQueue = OperationQueue()

    func runOperationOnMainQueue() {
        let operation = BlockOperation {
            print("🟡 [Main Queue] Operation \"A\" started on thread: \(Thread.current)")
            for _ in 0..<1_000_000 {

            }
            print("🟡 [Main Queue] Operation \"A\" finished")
        }

        OperationQueue.main.addOperation(operation)
    }

    func runOperationOnCustomQueue() {
        let operation = BlockOperation {
            print("🔵 [Custom Queue] Operation \"A\" started on thread: \(Thread.current)")
            for _ in 0..<1_000_000 {
                
            }
            print("🔵 [Custom Queue] Operation \"A\" finished")
        }

        customQueue.addOperation(operation)
    }
}

let tester = OperationTester()



RunLoop.current.run(until: Date().addingTimeInterval(3))
