import Cocoa
import AVKit

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var playerView: AVPlayerView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // メインスクリーンのフレームを取得
        let screenFrame = NSScreen.main!.frame

        // ウィンドウの作成
        window = NSWindow(contentRect: screenFrame,
                          styleMask: [.borderless, .fullSizeContentView],
                          backing: .buffered,
                          defer: false)
        window.level = .normal
        window.makeKeyAndOrderFront(nil)
        window.isOpaque = false
        window.backgroundColor = NSColor.clear

        // 任意で変えてね！！
        // 動画のパス
        let videoPath = "/Library/Application Support/com.apple.idleassetsd/Customer/4KSDR240FPS/97447D85-960C-4B2A-A101-048284D95853.mov"

        // AVPlayerViewの設定
        playerView = AVPlayerView(frame: window.contentView!.bounds)
        playerView.player = AVPlayer(url: URL(fileURLWithPath: videoPath))
        playerView.player?.actionAtItemEnd = .none
        playerView.controlsStyle = .none
        playerView.videoGravity = .resizeAspectFill

        window.contentView?.addSubview(playerView)

        // ループ再生
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: playerView.player?.currentItem)

        playerView.player?.play()

        // メニューバーとドックを隠す設定
        let presOptions: NSApplication.PresentationOptions = [.hideDock, .hideMenuBar]
        window.collectionBehavior.insert(.fullScreenPrimary)
        NSApp.setActivationPolicy(.regular)
        NSApp.presentationOptions = presOptions
    }

    @objc func playerItemDidReachEnd(notification: Notification) {
        playerView.player?.seek(to: CMTime.zero)
        playerView.player?.play()
    }
}
