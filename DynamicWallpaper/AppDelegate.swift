import Cocoa
import AVKit

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

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
        window.delegate = self // ウィンドウデリゲートの設定

        // 動画のパス
        let videoPath = "/Library/Application Support/com.apple.idleassetsd/Customer/4KSDR240FPS/97447D85-960C-4B2A-A101-048284D95853.mov"

        // AVPlayerViewの設定
        playerView = AVPlayerView(frame: window.contentView!.bounds)
        playerView.player = AVPlayer(url: URL(fileURLWithPath: videoPath))
        playerView.player?.actionAtItemEnd = .none
        playerView.controlsStyle = .none
        playerView.videoGravity = .resizeAspectFill
        playerView.autoresizingMask = [.width, .height]

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
        
        // スリープ復帰時の通知を登録
        NotificationCenter.default.addObserver(self, selector: #selector(handleWake), name: NSWorkspace.didWakeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: NSApplication.didBecomeActiveNotification, object: nil)
    }

    @objc func playerItemDidReachEnd(notification: Notification) {
        // 動画の再生をループさせる
        playerView.player?.seek(to: CMTime.zero)
        playerView.player?.play()
    }
    
    @objc func handleWake() {
        // スリープ復帰時に動画を再生する
        if let player = playerView.player, player.timeControlStatus != .playing {
            player.play()
        }
    }

    @objc func applicationDidBecomeActive() {
        // アプリがアクティブになった時に動画を再生する
        if let player = playerView.player, player.timeControlStatus != .playing {
            player.play()
        }
    }
    
    // ウィンドウのサイズ変更時に呼ばれるメソッド
    func windowDidResize(_ notification: Notification) {
        playerView.frame = window.contentView!.bounds
    }
    
    // ウィンドウが移動されたときに呼ばれるメソッド
    func windowDidMove(_ notification: Notification) {
        playerView.frame = window.contentView!.bounds
    }
    
    // ウィンドウがスクリーン間を移動したときに呼ばれるメソッド
    func windowDidChangeScreen(_ notification: Notification) {
        adjustWindowFrame()
    }

    // ウィンドウがスクリーン間を移動したときのサイズ調整
    func adjustWindowFrame() {
        if let screenFrame = window.screen?.frame {
            window.setFrame(screenFrame, display: true)
            playerView.frame = window.contentView!.bounds
        }
    }
}
