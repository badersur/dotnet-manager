#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

if ! nc -zw1 google.com 443; then
    # credit: https://unix.stackexchange.com/a/190610
    echo "Please check your network connectivity!"
    exit 1
fi

download_dir="${HOME}/Downloads"

mkdir -p "$download_dir"
cd "$download_dir"

app_dir="dotnet"
app_dir_fullpath="${download_dir}/${app_dir}"

app="${app_dir}/dotnet"

sdk_fileame="dotnet-sdk-latest-linux-x64.tar.gz"

latest_version_url="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/master/latest.version"
sdk_download_url="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/master/dotnet-sdk-latest-linux-x64.tar.gz"
sdk_hash_url="https://dotnetclichecksums.blob.core.windows.net/dotnet/Sdk/master/dotnet-sdk-latest-linux-x64.tar.gz.sha"

current_version=$($app --version 2> /dev/null | head)
latest_version=$(curl $latest_version_url 2> /dev/null | tail -n 1 | sed 's/\r$//')

bold=$(tput bold)
normal=$(tput sgr0)

function is_sdk_hash_valid() {
    if [[ -f $sdk_fileame ]]; then
        sdk_hash=$(sha512sum $sdk_fileame | cut -d " " -f 1)
    fi
    latest_sdk_hash=$(curl $sdk_hash_url 2> /dev/null | head | sed 's/\r$//')

    if [[ -n $latest_sdk_hash ]] &&
                            echo "$sdk_hash" | grep -iq "$latest_sdk_hash"; then
        return 0
    fi
    return 1
}

function extract_sdk() {
    echo "Extracting to ${bold}${app_dir_fullpath}${normal}..."
    mkdir -p "$app_dir"
    tar -xf "$sdk_fileame" -C "$app_dir"
    echo "SDK is ready to embrace your code! Let's build awesome things ;)"
}

function download_sdk() {
    rm -rf $sdk_fileame
    echo "Downloading ${sdk_fileame} ${bold}(${latest_version})${normal} to ${bold}${download_dir}${normal}..."
    if [[ -n $TRAVIS ]]; then
        wget -q -m --no-directories $sdk_download_url
    else
        wget -q -m --no-directories --show-progress $sdk_download_url
    fi
    echo "SDK downloaded!"
}

function add_sdk_to_path() {
    cp ~/.bashrc ~/.bashrc.net-manager.backup
    # shellcheck disable=SC2016,SC2089
    export_statement='export PATH="$PATH:'"$app_dir_fullpath"'"'

    if ! grep -q "$export_statement" ~/.bashrc; then
        {
            echo
            echo "# The following export statement has been added by .net-manager!"
            echo "$export_statement"
            echo
        } >> ~/.bashrc
        echo "Note: I've added ${bold}${export_statement}${normal} to the end of ~/.bashrc!"
    fi

    if ! dotnet -h &> /dev/null; then
        echo "Please reopen your terminal to use the ${bold}dotnet${normal} command."
    fi
}

if [[ "$current_version" == "$latest_version" ]]; then
    echo "You've the latest version! ${bold}(${latest_version})${normal}"
else
    if is_sdk_hash_valid; then
        echo "Older SDK found with identical server's hash value."
        extract_sdk
    else
        download_sdk
        if is_sdk_hash_valid; then
            extract_sdk
        else
            echo "Abort extracting because SDK hash isn't valid!!"
            exit 1
        fi
    fi
fi
add_sdk_to_path
