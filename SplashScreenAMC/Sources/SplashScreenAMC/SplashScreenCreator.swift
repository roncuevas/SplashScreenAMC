import SwiftUI
import Lottie

public struct SplashScreenCreator: View {
    private var animationCompleted: Binding<Bool>
    private var fileName: String
    private var animationSpeed: CGFloat
    private var loopMode: LottieLoopMode
    private var contentMode: UIView.ContentMode
    
    public init(fileName: String,
                animationSpeed: CGFloat = 1.0,
                animationCompleted: Binding<Bool> = .constant(false),
                loopMode: LottieLoopMode = .playOnce,
                contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.fileName = fileName
        self.animationSpeed = animationSpeed
        self.animationCompleted = animationCompleted
        self.loopMode = loopMode
        self.contentMode = contentMode
    }
    
    public var body: some View {
        LottieView(animationFinished: animationCompleted,
                   name: fileName,
                   animationSpeed: animationSpeed,
                   loopMode: loopMode,
                   contentMode: contentMode)
    }
}

private struct LottieView: UIViewRepresentable {
    @Binding var animationFinished: Bool
    var name: String
    var animationSpeed: CGFloat
    var loopMode: LottieLoopMode
    var contentMode: UIView.ContentMode
    var animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = contentMode
        animationView.animationSpeed = animationSpeed
        animationView.loopMode = loopMode
        animationView.play { _ in
            withAnimation {
                animationFinished = true
            }
        }
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}
