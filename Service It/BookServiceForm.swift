//
//  BookServiceForm.swift
//  Service It
//
//  Created by Rifatul Islam on 18/6/23.
//

import SwiftUI
import Alamofire

struct BookingResponse : Codable {
    let message : String
    let booking_details : BookingDetails
}

struct BookingDetails : Codable {
    let booking_id : String
    let service_id: String
    let user_id : String
    let booking_date : String
    let created_at : String
    let updated_at : String
}


struct BookServiceForm: View {
    @State var serviceDate = Date()
    @State var serviceNote : String = ""
    
    @State var loginId : String
    @State var shopId : String
    
    @State var showHistory = false
    

    var body: some View {
        VStack(spacing: 20){
//            Text("Book Your Service")
//                .font(.title)
//                .bold()
//                .padding(.top, 30)
            
            TextField("Service Notes", text: $serviceNote, axis: .vertical)
                .lineLimit(3)
                .padding(.all, 10)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                })
            
//            DatePicker(selection: $serviceDate, in: ...Date.now, displayedComponents: .date) {
//                Text("Select Servicing Date")
//            }
            
            DatePicker( "Pick a date", selection: $serviceDate, in: Date()..., displayedComponents: [.date])
                        
            Button {
                bookService()
            } label: {
                Text("Book Service")
                    .bold()
                    .padding(.all, 10)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .foregroundColor(.blue)
                    .background(Color(.systemGray4))
                    .cornerRadius(5)
            }
            
            Spacer()

        }
        .padding(.horizontal)
        .navigationDestination(isPresented: $showHistory, destination: {History(user_id: self.loginId)})
        .navigationTitle("Book Service")
    }
    
    func bookService() {
        // Create Date Formatter
        let dateFormatter = DateFormatter ()
        // Set Date Format
        dateFormatter.dateFormat = "YYYY-MM-dd"
        // Convert Date to String
        let date = dateFormatter.string (from: serviceDate)
        
        print(date)
        print(loginId)
        print(shopId)
        
        
        print("Inside Book Service")
        AF.upload (multipartFormData: { multipartFormData in
            multipartFormData.append(Data(loginId.utf8), withName: "login_id")
            multipartFormData.append(Data(shopId.utf8), withName: "service_id")
            multipartFormData.append(Data(date.utf8), withName: "booking_date")
        }, to: "https://service-hub.mosnippet.xyz/book_service.php", method: .post)
        .responseDecodable(of: BookingResponse.self) { response in
            
            print("Inside Book Service Resonse")
            
            debugPrint(response)
            let status = response.response?.statusCode
            guard let data = response.data else { return }
            
            print("Inside Book Service Data Decoded")
            
            
            do {
                print("Inside Book Service Do Try")
                
                if let response_data = try? JSONDecoder().decode(BookingResponse.self, from: data) {
                    print("Inside Book Service If let")
                    
                    print("Inside IF RESPONSE")
                    print("Success Status Code : \(String(describing: status))")
                    
                    //showAlert.toggle()
                    showHistory.toggle()
                    
                }
                else {
                    print("Failed Status Code : \(String(describing: status))")
                }
            }
        }
    }
}

struct BookServiceForm_Previews: PreviewProvider {
    static var previews: some View {
        BookServiceForm(loginId: "16", shopId: "6")
    }
}
