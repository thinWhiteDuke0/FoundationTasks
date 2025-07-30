import Foundation

class OperationTest {
    let queue = OperationQueue()

    func createOperations() {
        let opA = BlockOperation {
            print("🅰️ Operation A started on thread: \(Thread.current)")
            for _ in 0..<1_000_000 { }
            print("🅰️ Operation A finished")
        }

        let opB = BlockOperation {
            print("🅱️ Operation B started on thread: \(Thread.current)")
            for _ in 0..<1_000_000 { }
            print("🅱️ Operation B finished")
        }

        let opC = BlockOperation {
            print("🇨 Operation C started on thread: \(Thread.current)")
            for _ in 0..<1_000_000 { }
            print("🇨 Operation C finished")
        }

        let opD = BlockOperation {
            print("🇩 Operation D started on thread: \(Thread.current)")
            for _ in 0..<1_000_000 { }
            print("🇩 Operation D finished")
        }


        opA.queuePriority = .low

        
        opB.addDependency(opC)
        opD.addDependency(opB)

        queue.maxConcurrentOperationCount = 2
        queue.addOperations([opA, opB, opC, opD], waitUntilFinished: false)
    }
}

let test = OperationTest()
test.createOperations()

RunLoop.current.run(until: Date().addingTimeInterval(5))

