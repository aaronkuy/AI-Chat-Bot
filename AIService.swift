import Foundation


    struct AIService {

        static let apiKey = "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"

        struct Choice: Codable {
            struct Message: Codable {
                let role: String
                let content: String
            }
            let message: Message
        }

        struct APIResponse: Codable {
            let choices: [Choice]
        }

        static func sendPrompt(_ prompt: String) async throws -> String {
            let url = URL(string: "https://api.openai.com/v1/chat/completions")!

            let body: [String: Any] = [
                "model": "gpt-3.5-turbo",
                "messages": [
                    ["role": "user", "content": prompt]
                ]
            ]

            let data = try JSONSerialization.data(withJSONObject: body)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

            let (responseData, _) = try await URLSession.shared.data(for: request)

            // JSON parsen
            let apiResponse = try JSONDecoder().decode(APIResponse.self, from: responseData)
            return apiResponse.choices.first?.message.content ?? "No response"
        }
    }


     

        


      
    



