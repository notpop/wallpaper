# wallpaper for macOS

## 使い方
1. 表示したい動画の設定<br>
以下ファイル内のパスを任意のものに変更してください。<br>
wallpaper/DynamicWallpaper/AppDelegate.swift
```
let videoPath = "/Library/Application Support/com.apple.idleassetsd/Customer/4KSDR240FPS/97447D85-960C-4B2A-A101-048284D95853.mov"
```

2. Xcodeで実行すればwallpaperが起動します

## Tips
- [この辺](https://developer.apple.com/documentation/appkit/nswindow/level)とか参考にするとカスタマイズできるかも？
- 基本的にAppDelegateをいじればカスタマイズできます。
- `The app requires a more recent version of macOS. Please check the app's deployment target.`ってエラー出た時は、プロジェクトナビゲーターの「General」タブの「Minimum Deployments」とかを確認してください。または「macOS Deployment Target」辺りも確認してください。
- 「pathは正しいのに動かない！」という方は、プロジェクトナビゲーター > Targets > Signing & Capabilities > App Sandbox > File Access Type > Downloads Folder > Read Onlyに変更していただき、Downloadsフォルダに配置すれば、読み込めるはずです
- `Entitlements file "DynamicWallpaper.entitlements" was modified during the build, which is not supported. You can disable this error by setting 'CODE_SIGN_ALLOW_ENTITLEMENTS_MODIFICATION' to 'YES', however this may cause the built product's code signature or provisioning profile to contain incorrect entitlements.`この辺が出たら、Product > Clean Build Folder... > Runで解決するかも
- 以下手順でアプリケーション化するとより便利
1. Product > Build
2. Product > Archives > Distribute App > Custom > Next > Copy App > Export

## Contributing
問題や提案があればissueやPRをお待ちしております。

## License
このプロジェクトは自由に使用できますが、開発者は一切の責任を負いません。詳細はLICENSEファイルをご覧ください。
