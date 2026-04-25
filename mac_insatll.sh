#!/bin/zsh

############### 我的 Mac 安装清单 ###################


# Formulae
formulae=(
cocoapods
rustup
# SOCKS5 代理
dante
# 多线程下载工具
# aria2
# openjdk@21
)

# Casks
casks=(
appcleaner
localsend
claude-code
visual-studio-code
# google-chrome
iina
opencode-desktop
android-studio
# 按键显示
keycastr
# 腾讯柠檬，一款清理软件
tencent-lemon
# squirrel-app
# lm-studio
# 免费 VPN
# privadovpn
)


brew_install() {
  # 用代理下载 最新 Homebrew
  # https://gh.xmly.dev/https://github.com/Homebrew/brew/releases/latest/download/Homebrew.pkg
  if ! command -v brew &>/dev/null; then
    # 下载并静默安装 Homebrew
    curl -L# -o /tmp/Homebrew.pkg "https://gh.xmly.dev/https://github.com/Homebrew/brew/releases/latest/download/Homebrew.pkg" \
      && sudo installer -pkg /tmp/Homebrew.pkg -target /
    rm -f /tmp/Homebrew.pkg
  fi

  for f in $formulae; do
    echo "正在安装 $f"
    brew install "$f"
  done

  for c in $casks; do
    echo "正在安装 $c"
    brew install --cask "$c"
  done

  # 安装 motrix-next
  # brew tap AnInsomniacy/motrix-next
  # brew install --cask motrix-next
  # # MotrixNext 没有签名，这里要处理一下
  # xattr -cr /Applications/MotrixNext.app  # remove quarantine (app is unsigned)
}

install_flutter() {
  local sdks_dir="$HOME/develop/sdks"
  local flutter_dir="$sdks_dir/flutter"
  if [ -d "$flutter_dir" ]; then
    echo "Flutter 已存在于 $flutter_dir，跳过"
    return
  fi

  mkdir -p $sdks_dir

  # 从 Flutter 发布 API 获取最新稳定版 arm64 的下载路径
  local releases_url="https://storage.googleapis.com/flutter_infra_release/releases/releases_macos.json"
  local archive_path
  archive_path=$(curl -fsSL "$releases_url" \
    | tr -d '\n ' \
    | grep -o '"archive":"stable/macos/flutter_macos_arm64[^"]*"' \
    | head -1 \
    | sed 's/"archive":"//;s/"//')

  if [ -z "$archive_path" ]; then
    echo "错误：无法获取 Flutter 最新版本号"
    return 1
  fi

  local version
  version=$(echo "$archive_path" | grep -o 'flutter_macos_arm64_[0-9].*-stable\.zip' | sed 's/flutter_macos_arm64_//;s/-stable\.zip//')

  echo "正在下载 Flutter SDK $version，有2个多G，请耐心等待 ..."

  # https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.41.7-stable.zip
  echo "命令下载 flutter SDK 太慢了，用浏览器下载吧： \n    https://storage.googleapis.com/flutter_infra_release/releases/$archive_path"
  open "https://storage.googleapis.com/flutter_infra_release/releases/$archive_path"

  # curl -fL --http2 -# -o /tmp/flutter.zip \
  #   -w "\n下载完成，平均速度: %{speed_download} bytes/s (%{size_download} bytes)\n" \
  #   "https://storage.googleapis.com/flutter_infra_release/releases/$archive_path"
  # echo "正在解压到 $sdks_dir ..."
  # unzip -q /tmp/flutter.zip -d $sdks_dir
  # rm /tmp/flutter.zip
  # echo "Flutter $version 安装完成: $flutter_dir"
}

install_flutter
# brew_install
