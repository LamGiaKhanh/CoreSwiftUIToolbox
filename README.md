# CoreSwiftUIToolbox

### How to use Templates

- Copy templates in Templates folder
- Go to Finder -> CMD+Shift+G (Go to File) -> Paste path ~/Library/Developer/Xcode/Templates/File Templates/Custom Templates
- Paste templates into Custom Templates folder
- Open/Restart Xcode
- Right click on Directory Project -> New File... (or File > New > File.. on Xcode toolbar)
- Scroll to bottom
- Custom templates will shown as below: 
![Template](https://user-images.githubusercontent.com/43343766/221786216-2a5ed11c-7eda-4625-be03-e8adfcd7d842.png)
- Enjoy

### Create new module and add dependencies
Following this article: https://santoshbotre01.medium.com/modular-project-structure-with-swift-package-manager-spm-c81fb62c8619
### How to create a Navigator
1. Define steps
```swift
enum LoginStep: Step {
    case forgotPassword
    case home
}
 ```
 2. Create concrete class of navigator -> conform to `ObservableObject`
 ```swift
 class LoginNavigator: ObservableObject, Resolving {
    @Injected var loginViewModel: LoginViewModel
    @Published var forgotPasswordViewModel: ForgotPasswordViewModel!

    init() {
        // listen for steps emitted from loginViewModel
        contribute(loginViewModel)
    }

    func go(to step: Step) {
        guard let step = step as? LoginStep else { return }

        switch step {
        case .forgotPassword:
            forgotPasswordViewModel = resolve(ForgotPasswordViewModel.self)
            
            // listen for steps emitted from forgotPasswordViewModel
            contribute(forgotPasswordViewModel)
        case .home:
            // forward step to parent navigator
            forwardToParent(ContentStep.home)
        }
    }
}
 ```
 3. Make navigator view
 ```swift
 struct LoginNavigatorView: View {
    @ObservedObject var navigator: LoginNavigator

    var body: some View {
        NavigationView {
            LoginView(viewModel: navigator.loginViewModel)
                .sheet(model: $navigator.forgotPasswordViewModel) {
                    ForgotPasswordView(viewModel: $0)
                }
                .hideNavigationBar()
        }
        .navigationViewStyle(.stack)
    }
}
 ```
 ### How to create a ViewModel
 1. Implement specific instance
```swift
 class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""

    func signIn() {
        // ...
    }
}
 ```
 if you want to contribute viewmodel in navigator -> we need to additional conform `Stepper` protocol, like this:
 ```swift
protocol LoginViewModel: Stepper {
    // ...
}
 ```
 2. Declare in View
```swift
 struct LoginView: View {
    @Store var viewModel: LoginViewModel

    var body: some View {
        VStack {
            TextField("username", text: $viewModel.username)
            TextField("password", text: $viewModel.password)

            Button("Login") {
                viewModel.signIn()
            }
            Button("Forgot password") {
                // show forgot password screen
                // viewModel.steps.send(LoginStep.forgotPassword)
            }
        }
    }
}
 ```
