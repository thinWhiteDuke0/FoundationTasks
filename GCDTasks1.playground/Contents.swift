import Foundation

func fetchData(from source: String, completion: @escaping () -> Void) {
    print("\(source) - Fetching data...")
    sleep(2)
    print("\(source) - Data fetched ✅")
    completion()
}

func runGCDTaskWithDispatchGroup() {
    let queue = DispatchQueue.global(qos: .userInitiated)
    let dispatchGroup = DispatchGroup()

    let sources = ["API 1", "API 2", "API 3"]

    for source in sources {
        dispatchGroup.enter()
        queue.async {
            fetchData(from: source) {
                print("\(source) - Processing complete")
                dispatchGroup.leave()
            }
        }
    }

    dispatchGroup.notify(queue: .main) {
        print("✅ All tasks completed. Updating UI...")
    }
}

runGCDTaskWithDispatchGroup()
