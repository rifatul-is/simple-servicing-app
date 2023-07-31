//
//  Login.swift
//  Service It
//
//  Created by Rifatul Islam on 12/6/23.
//

import SwiftUI
import Alamofire

struct LoginFail : Codable {
    let success : Bool
    let message : String
}

struct LoginData : Codable {
    let success : Bool
    let message : String
    let user : UserInfo
}

struct UserInfo: Codable {
    let id : String
    let name : String
    let email : String
}

struct Login: View {
    
    @State var userInfo = LoginData(success: false, message: "", user: UserInfo(id: "100", name: "", email: ""))
    
    @State var email : String = ""
    @State var password : String = ""
    
    @State var authSuccess : Bool = false
    @State var showMsg : Bool = false
    
    var body: some View {
        NavigationStack{
            
            VStack {
                Text("Sign In To Account")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email", text: $email)
                    .padding(.all, 10)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    })
                    .frame(width: UIScreen.main.bounds.width - 40)
                
                SecureField("Password", text: $password)
                    .padding(.all, 10)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    })
                    .frame(width: UIScreen.main.bounds.width - 40)
                
                if showMsg {
                    Text("Please enter correct Email and Password")
                        .padding(.top)
                        .foregroundColor(.red)
                }
                
//                NavigationLink(destination: TabScreen(user_id: self.userInfo.user.id), isActive: $authSuccess, label: {})

                
                Button{
                    loginUser()
                } label: {
                    Text("Sign In")
                        .padding(.all, 10)
                        .frame(width: 100)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.vertical)

                
                Spacer()
                
                NavigationLink{
                    Register()
                } label: {
                    HStack {
                        Text("Dont Have An Account ?")
                            .foregroundColor(.black)
                        
                        Text("Create One")
                            .foregroundColor(.blue)
                            .bold()
                    }
                    .padding(.vertical)
                }
            }
            .navigationDestination(isPresented: $authSuccess, destination: {
                TabScreen(user_id: userInfo.user.id)
            })
        }
    }
    
    func loginUser() {
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(email.utf8), withName: "email")
            multipartFormData.append(Data(password.utf8), withName: "password")
        }, to: "https://thor-to-baire.mosnippet.xyz/login.php")
        .responseDecodable(of: LoginData.self) { response in
            debugPrint(response)
            let status = response.response?.statusCode
            guard let data = response.data else { return }
            
            do {
                
                if let response = try? JSONDecoder().decode(LoginData.self, from: data) {
                    self.userInfo = response
                    print("Inside IF RESPONSE")
                    print("Success Status Code : \(String(describing: status))")
                    if userInfo.success {
                        debugPrint("IN If")
                        debugPrint(userInfo.user.id)
                        debugPrint(response.user.id)
                        authSuccess.toggle()
                    }
                    else {
                        debugPrint("IN ELSE")
                        showMsg.toggle()
                    }
                    print(response.user.name)
                }
                    
                else {
                    showMsg.toggle()
                    print("Failed Status Code : \(String(describing: status))")
                }
            }
            catch {
                print("error caught")
                showMsg.toggle()
            }

        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
