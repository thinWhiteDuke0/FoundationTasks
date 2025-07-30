import Foundation

struct User: Decodable {
    let email: String
}

if let url = URL(string: "https://jsonplaceholder.typicode.com/users") {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error:", error)
            return
        }

        guard let data = data else {
            print("No data received")
            return
        }

        do {
            let users = try JSONDecoder().decode([User].self, from: data)

            for user in users {
              print(user.email)
            }
        } catch {
            print("Decoding error:", error)
        }
    }

    task.resume()
}

RunLoop.main.run()
