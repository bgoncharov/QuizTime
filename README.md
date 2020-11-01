# Quiz Time game

**Stack:** Swift, UIKit. Covered with tests.

<img src="https://github.com/bgoncharov/TandemCodeChallange/blob/main/Media/preview_iphone11.gif" width="250">        <img src="https://github.com/bgoncharov/TandemCodeChallange/blob/main/Media/preview_iphonese.gif" width="250">

Simple trivia game. Every time you have only 10 questions. Every question has 4 answers with just one correct answer. You have only two attempts to find the correct one. When you press the button with the wrong answer then the border color set to red, otherwise green. If you don't find the correct answer then you'll see which answer is correct. All questions fetched from a JSON file. 

**Mandatory Part:**

- [x] A round of trivia has 10 Questions
- [x] All questions are multiple-choice questions
- [x] A user can view questions.
- [x] Questions with their multiple choice options must be displayed one at a time. Questions should not repeat in a round.
- [x] A user can select only 1 answer out of the 4 possible answers.
- [x] The correct answer must be revealed after a user has submitted their answer A user can see the score they received at the end of the round

**Extra:**

- [x] Score updates in real time
- [x] Users have just two attmpts for each qustion(shown under the buttons).

Data Fetching:

```swift
func fetchQuestions(completion: @escaping (Result<[Question], Error>) -> Void) {
        
        let urlString = Bundle.main.url(forResource: "jsonData", withExtension: "json")!

        do {
            let data = try Data(contentsOf: urlString)
            
            decodeJSON(type: [Question].self, with: data) { (result) in
                switch result {
                
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            print(error)
        }
    }
```

To decode data I use following func:

```swift
private func decodeJSON<T: Decodable>(type: T.Type, with data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let object = try JSONDecoder().decode(type.self, from: data)
            completion(.success(object))
        } catch let jsonError {
            completion(.failure(jsonError))
        }
    }
```
