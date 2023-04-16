import UIKit

// определим структуры json
struct Person: Decodable {
    let name: String
    let age: Int
    let isDeveloper: Bool
}
struct DataResponse: Decodable {
    let data: [Person]
}
struct ResultResponse: Decodable {
    let result: [Person]
}

// определяем протокол для ChainOfResponsibility

protocol JsonHandler {
    var next: JsonHandler? {get set}
    func decodeJson(_ data: Data)
}

// определяем звенья цепи

class DataResponseDecode: JsonHandler{
    var next: JsonHandler?
    
    func decodeJson(_ data: Data) {
        do {
            
           
            let response = try JSONDecoder().decode(DataResponse.self, from: data)
            print("it is dataResponse")
            print(response.data)
        } catch {
            print("Error decoding DataResponse: \(error.localizedDescription)")
            guard let next = next else {
                print("no valid json")
                return}
            next.decodeJson(data)
        }
    }
}

class ResultResponseDecode: JsonHandler{
    var next: JsonHandler?
    
    func decodeJson(_ data: Data) {
        do {
            
            let response = try JSONDecoder().decode(ResultResponse.self, from: data)
            print("it is ResultResponse")
            print(response.result)
        } catch {
            print("Error decoding DataResponse: \(error.localizedDescription)")
            guard let next = next else {
                print("no valid json")
                return}
            next.decodeJson(data)
        }
    }
}

class ResponseDecode: JsonHandler{
    var next: JsonHandler?
    
    func decodeJson(_ data: Data) {
        do {
            
            let response = try JSONDecoder().decode([Person].self, from: data)
            print("it is Response")
            print(response)
        } catch {
            print("Error decoding DataResponse: \(error.localizedDescription)")
            guard let next = next else {
                print("no valid json")
                return}
            next.decodeJson(data)
        }
    }
}




func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")
let data4 = data(from: "4")

// Составляем цепь ChainOfResponsibility

let dataResponseDecode = DataResponseDecode()
let resultResponseDecode = ResultResponseDecode()
let responseDecode = ResponseDecode()

dataResponseDecode.next = resultResponseDecode
resultResponseDecode.next = responseDecode
responseDecode.next = nil

// парсим data1
dataResponseDecode.decodeJson(data1)
// парсим data2
dataResponseDecode.decodeJson(data2)
// парсим data3
dataResponseDecode.decodeJson(data3)

// парсим data4
dataResponseDecode.decodeJson(data4)



