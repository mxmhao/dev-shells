# macOS 常用环境变量
# 配置终端内容颜色
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadeche
# 配置终端用户名和主机名颜色
autoload -U colors && colors
PROMPT="%{$fg_bold[cyan]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m %{$fg_bold[green]%}%1~ %{$reset_color%}%#"

# 安卓
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# 阿里云 brew 源
# export HOMEBREW_PIP_INDEX_URL=http://mirrors.aliyun.com/pypi/simple #ckbrew
# export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"
# export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"
# 清华 brew 源
# export HOMEBREW_PIP_INDEX_URL="https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple"
# export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
# export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
# export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
eval $(/opt/homebrew/bin/brew shellenv) #ckbrew

# flutter
export FLUTTER_HOME=~/dev/sdks/flutter
export PATH=$PATH:$FLUTTER_HOME/bin
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# rust
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# cangjie
source ~/dev/sdks/cangjie/envsetup.sh