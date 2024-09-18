# Testing zig

## Windows installation:

```ps1
$zig_ver = "windows-x86_64-0.13.0"
$zig_link = "https://ziglang.org/download/0.13.0/zig-$zig_ver.zip"
$zig_download = "windows_build\cache\zig-$zig_ver.zip"
$zig_unpack = windows_build\tools\zig

Invoke-WebRequest $zig_link -OutFile $zig_download
Expand-Archive -LiteralPath $zig_download -DestinationPath $zig_unpack
```

Setting up PATH on Windows:
```ps1
$usr_path = [Environment]::GetEnvironmentVariable("Path", "User")
[Environment]::SetEnvironmentVariable(
    "Path",
     $usr_path + ";C:\path_to_this_folder",
    "User"
)
```
