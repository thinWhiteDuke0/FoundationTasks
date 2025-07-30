import Foundation

let semaphore = DispatchSemaphore(value: 2) // Only allow 2 threads at a time

func performTask(id: Int) {
    semaphore.wait() // Request permission
    print("Task \(id) started")
    sleep(1)
    print("Task \(id) finished")
    semaphore.signal() // Release permission
}

func runConcurrentTasks() {
    let threads = (1...5).map { id in
        Thread {
            performTask(id: id)
        }
    }

    threads.forEach { $0.start() }
}

runConcurrentTasks()
