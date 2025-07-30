import Foundation


let operationQueue = OperationQueue()


let operationB = BlockOperation {
    print("Operation B started")
    for _ in 0..<1_000_000 {

    }
    print("Operation B finished")
}


let operationA = BlockOperation {
    print("Operation A started")
    operationB.cancel()
    for _ in 0..<1_000_000 {

    }
    print("Operation A finished")
}


operationB.addDependency(operationA)


operationQueue.addOperations([operationA, operationB], waitUntilFinished: true)
