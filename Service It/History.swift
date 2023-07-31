//
//  History.swift
//  Service It
//
//  Created by Rifatul Islam on 14/6/23.
//

import SwiftUI

struct HistoryResponse: Codable, Hashable {
    let booking_id : String
    let user_id : String
    let booking_date : String
    let details : HistoryDetails
}

struct HistoryDetails: Codable, Hashable {
    let service_id : String
    let service_type_id : String
    let service_name : String
    let service_details : String
    let price : String
    let required_time : String
    let shop_id : String

}


struct History: View {
    @State var user_id : String
    
    @State var historyResponse : [HistoryResponse] = []
    
    var body: some View {
        ScrollView{
            ForEach(historyResponse, id: \.self) { i in
                VStack (alignment: .leading){
                    Text(i.details.service_name)
                        .bold()
                        .font(.title3)
                        .padding()
                    
                                    
                    Text(i.details.service_details)
                        .padding(.horizontal)
                    
                    Divider()

                    
                    HStack{
                        Text("Date \(i.booking_date)")
                            .font(.footnote)
                        
                        Spacer()
                        
                        Text("$\(i.details.price)")
                            .font(.footnote)
                    }
                    .padding()

                }
                .frame(width: UIScreen.main.bounds.width - 40)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.top, 20)
            }
        }
        .navigationTitle("History")
        .onAppear{
            getHistory()
        }
    }
    
    private func getHistory(){
        var request = URLRequest(url: URL(string: "https://service-hub.mosnippet.xyz/booking_history.php?user_id=\(user_id)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if httpResponse.statusCode == 200 {
                print("Success")
            }
            
            guard let data = data else {
                print("Data Error")
                print(String(describing: error))
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
            
            do {
                print("Inside Do")

                self.historyResponse = try JSONDecoder().decode([HistoryResponse].self, from: data)
                print("report decoded")
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History(user_id: "16")
    }
}
