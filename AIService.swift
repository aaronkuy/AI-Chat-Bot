import Foundation

//AI API implementation. 
    struct AIService {
//Allocate the API key
        static let apiKey = "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"
//Reply container of OpenAI
        struct Choice: Codable {
//Text reply, role: user/assistant and content: the text
            struct Message: Codable {
                let role: String
                let content: String
            }
//Each Choice contains exact one Message 
            let message: Message
        }
//JSON-Object mailed back to the program 
        struct APIResponse: Codable {
            let choices: [Choice]
        }
//AI reply is getting returned 
        static func sendPrompt(_ prompt: String) async throws -> String {
            let url = URL(string: "https://api.openai.com/v1/chat/completions")!

            let body: [String: Any] = [
                "model": "gpt-3.5-turbo",
//Text messages as a list, 'promt' is the text. User's content sending to OpenAI
                "messages": [
                    ["role": "user", "content": prompt]
                ]
            ]
//Converts Swift dictionary into JSON-Bytes, allocated to 'data'
            let data = try JSONSerialization.data(withJSONObject: body)
//HTTP request allocated to 'request', creating envelope 
            var request = URLRequest(url: url)
//Data getting send
            request.httpMethod = "POST"
//Here is getting the JSON inserted
            request.httpBody = data
//JSON is getting mailed 
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//API key for the access 
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//URLSession is the apple internet module, mail the request package, if true 
//allocate the reply to 'responseData'
            let (responseData, _) = try await URLSession.shared.data(for: request)

//Convert the responseData back to as APIResponse describes it, thus it is a Swift Object
//Save it to the constant 'apiResponse' 
            let apiResponse = try JSONDecoder().decode(APIResponse.self, from: responseData)
//'?' security check if the first reply even exist, else return the following string
            return apiResponse.choices.first?.message.content ?? "No response"
        }
    }


     

        


      
    



