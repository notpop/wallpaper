# wallpaper

## 使い方
1. 表示したい動画の設定
以下ファイル内のパスを任意のものに変更してください。
wallpaper/DynamicWallpaper/AppDelegate.swift
```
let videoPath = "/Library/Application Support/com.apple.idleassetsd/Customer/4KSDR240FPS/97447D85-960C-4B2A-A101-048284D95853.mov"
```

2. Xcodeで実行すればwallpaperが起動します

## Tips
- [この辺](https://developer.apple.com/documentation/appkit/nswindow/level)とか参考にするとカスタマイズできるかも？
- 基本的にAppDelegateをいじればカスタマイズできます。
- `The app requires a more recent version of macOS. Please check the app's deployment target.`ってエラー出た時は、プロジェクトナビゲーターの「General」タブの「Minimum Deployments」とかを確認してください。または「macOS Deployment Target」辺りも確認してください。