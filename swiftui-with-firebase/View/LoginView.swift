//
//  TestView.swift
//  swiftui-with-firebase
//
//  Created by Ray on 7/9/23.
//


import SwiftUI
import Combine
import FirebaseAnalyticsSwift
import AuthenticationServices
import FirebaseAuth

private enum FocusableField: Hashable {
  case email
  case password
}

struct LogInView: View {
    @EnvironmentObject var viewModel : AuthenticationViewModel

    @Environment(\.dismiss) var dismiss
    @State private var inputText: String = ""
    @FocusState private var focus: FocusableField?
    
    private func signInWithEmailPassword() {
      Task {
        if await viewModel.signInWithEmailPassword() == true {
          dismiss()
        }
      }
    }

    var body: some View {
      VStack {
//        Image("Login")
//          .resizable()
//          .aspectRatio(contentMode: .fit)
//          .frame(minHeight: 300, maxHeight: 400)
        Text("Login")
          .font(.largeTitle)
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .leading)

        HStack {
          Image(systemName: "at")
          TextField("Email", text: $viewModel.email)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .focused($focus, equals: .email)
            .submitLabel(.next)
            .onSubmit {
              self.focus = .password
            }
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 4)

        HStack {
          Image(systemName: "lock")
          SecureField("Password", text: $viewModel.password)
            .focused($focus, equals: .password)
            .submitLabel(.go)
            .onSubmit {
              signInWithEmailPassword()
            }
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 8)

        if !viewModel.errorMessage.isEmpty {
          VStack {
            Text(viewModel.errorMessage)
              .foregroundColor(Color(UIColor.systemRed))
          }
        }

        Button(action: signInWithEmailPassword) {
          if viewModel.authenticationState != .authenticating {
            Text("Login")
              .padding(.vertical, 8)
              .frame(maxWidth: .infinity)
//              .background(.red)
          }
          else {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .white))
              .padding(.vertical, 8)
              .frame(maxWidth: .infinity)
          }
        }
        .disabled(!viewModel.isValid)
        .frame(maxWidth: .infinity)
        .buttonStyle(.borderedProminent)

        HStack {
          Text("Don't have an account yet?")
          Button(action: { viewModel.switchFlow() }) {
            Text("Sign up")
              .fontWeight(.semibold)
              .foregroundColor(.blue)
          }
        }
        .padding([.top, .bottom], 50)

      }
      .listStyle(.plain)
      .padding()
      .analyticsScreen(name: "\(Self.self)")
    }
    
//    private func sendSignInLink(toEmail: String) async {
//        await viewModel.sendSignInLink()
//    }
//
//    private func signInWithEmailLink(toEmail: String) {
//      Task {
//          print("testing sign in with email link")
//        await sendSignInLink(toEmail: toEmail)
//        dismiss()
//      }
//    }
//
//    var body: some View {
//        VStack {
//            TextField("Email", text: $viewModel.email)
//                .keyboardType(.emailAddress)
//                .textInputAutocapitalization(.never)
//                .disableAutocorrection(true)
//                .focused($focus, equals: .email)
//                .onSubmit {
//                    print("hello")
//                    signInWithEmailLink(toEmail: inputText)
//                    print("input text: \(inputText)")
//                }
//            TextField("Password", text: $viewModel.password)
//                .keyboardType(.emailAddress)
//                .textInputAutocapitalization(.never)
//                .disableAutocorrection(true)
//                .focused($focus, equals: .email)
//                .onSubmit {
//                    print("hello")
//                    signInWithEmailLink(toEmail: inputText)
//                    print("input text: \(inputText)")
//                }
//            Button("Login", action: {
//                Task {
//                    await viewModel.signInWithEmailPassword()
//                    }
//            })
//
//        }
//        .padding()
//
//
//    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
//            LogIn().environmentObject(AuthenticationViewModel())
//        }
        LogInView().environmentObject(AuthenticationViewModel())
    }
}
