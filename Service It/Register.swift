//
//  Register.swift
//  Service It
//
//  Created by Rifatul Islam on 12/6/23.
//

import SwiftUI
import Alamofire

struct RegisterFail : Codable {
    let success : Bool
    let message : String
}

struct RegisterData : Codable{
    let success : Bool
    let message : String
    let user : RegisterUserInfo
}

struct RegisterUserInfo: Codable {
    let id : String
    let name : String
    let email : String
    let password : String
}

struct Register: View {
    @State var name : String = ""
    @State var email : String = ""
    @State var password : String = ""
    
    @State var authSuccess : Bool = false
    @State var showMsg : Bool = false
    
    @State var registerData = RegisterData(success: false, message: "message", user: RegisterUserInfo(id: "", name: "", email: "", password: ""))
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
            
            TextField("Name", text: $name)
                .padding(.all, 10)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray5), lineWidth: 2)
                })
                .frame(width: UIScreen.main.bounds.width - 40)
            
            TextField("Email", text: $email)
                .padding(.all, 10)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray5), lineWidth: 2)
                })
                .frame(width: UIScreen.main.bounds.width - 40)
            
            SecureField("Password", text: $password)
                .padding(.all, 10)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray5), lineWidth: 2)
                })
                .frame(width: UIScreen.main.bounds.width - 40)
            
//            if authSuccess {
//                Text("Sign Up Successfull\nSign in with your new account to get access.")
//                    .padding(.top)
//                    .foregroundColor(.green)
//            }
            
            if showMsg {
                Text("Please enter correct Email and Password")
                    .padding(.top)
                    .foregroundColor(.red)
            }
            
            //NavigationLink(destination: TabScreen(), isActive: $authSuccess, label: {})

            
            Button{
                registerUser()
                authSuccess = false
                showMsg = false
            } label: {
                Text("Sign Up")
                    .padding(.all, 10)
                    .frame(width: 200)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            Spacer()
            
            NavigationLink{
                Login()
            } label: {
                HStack {
                    Text("Already Have An Account !")
                        .foregroundColor(.black)
                    
                    Text("Sign In")
                        .foregroundColor(.blue)
                        .bold()
                }
                .padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $authSuccess, destination: {
            TabScreen(user_id: registerData.user.id)
        })

    }
    
    func registerUser() {
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(name.utf8), withName: "name")
            multipartFormData.append(Data(email.utf8), withName: "email")
            multipartFormData.append(Data(password.utf8), withName: "password")
        }, to: "https://thor-to-baire.mosnippet.xyz/register.php")
        .responseDecodable(of: RegisterData.self) { response in
            debugPrint(response)
            let status = response.response?.statusCode
            guard let data = response.data else { return }
            
            do {
                
                if let response = try? JSONDecoder().decode(RegisterData.self, from: data) {
                    print("Inside IF RESPONSE")
                    print("Success Status Code : \(String(describing: status))")
                    if response.success {
                        self.registerData = response
                        debugPrint("1 IN If")
                        authSuccess.toggle()
                    }
                    else {
                        debugPrint("1 IN ELSE")
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

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
