# dotnet-manager (dnm) [![Build Status](https://travis-ci.org/badersur/dotnet-manager.svg?branch=master)](https://travis-ci.org/badersur/dotnet-manager)

A shell script to download and update [the latest Servicing Release][servicing] of [.NET Core 2.0 SDK for Linux][sdk].
Please note that there's [an offical script][script] with several options but
[it doesn't satisfy my needs][comment].

Pass `pre` to the script to install the [latest **preview release**][pre] (i.e. `./dnm.sh pre` or
`curl https://raw.githubusercontent.com/badersur/dotnet-manager/master/dnm.sh | bash -s -- pre`).


## Usage

There're 2 options:

1. Open the terminal and run the script:
    ```bash
    curl https://raw.githubusercontent.com/badersur/dotnet-manager/master/dnm.sh | bash
    ```

2. Clone/Download the repo and run the script:

    1. Open the terminal.

    2. Clone the repo using [git](https://git-scm.com/downloads) or 
    [download it](https://github.com/badersur/dotnet-manager/archive/master.zip):
        ```bash
        git clone https://github.com/badersur/dotnet-manager
        ```

    3. Change your current directory to repo's directory:
        ```bash
        cd dotnet-manager
        ```

    4. Execute the script `dnm.sh`:
        ```bash
        ./dnm.sh
        ```


## Issues & PRs?

Yes, please! You're more than welcome :)


## Thanks

1. [The Bad Tutorials](https://www.youtube.com/channel/UCEpe5DhhS0HYFBaCVsU2Iwg) for the awesome
 [Shell Scripting Tutorials](https://www.youtube.com/playlist?list=PL7B7FA4E693D8E790)

2. [ShellCheck](https://github.com/koalaman/shellcheck/)

3. [vscode-shellcheck](https://github.com/timonwong/vscode-shellcheck)

4. Stack Exchange Network ;)


## License

MIT © [Bader Nasser Al-Hashmi](https://github.com/BaderSur)

[servicing]: https://github.com/dotnet/core/blob/master/daily-builds-servicing.md

[sdk]: https://dotnetcli.blob.core.windows.net/dotnet/Sdk/release/2.0.0/dotnet-sdk-latest-linux-x64.tar.gz

[script]: https://github.com/dotnet/cli/blob/master/scripts/obtain/dotnet-install.sh

[comment]: https://github.com/dotnet/cli/issues/7361#issuecomment-320956280

[pre]: https://dotnetcli.blob.core.windows.net/dotnet/Sdk/master/dotnet-sdk-latest-linux-x64.tar.gz
