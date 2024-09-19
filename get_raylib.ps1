Invoke-WebRequest "https://github.com/raysan5/raylib/releases/download/5.0/raylib-5.0_win64_msvc16.zip" -OutFile "raylib.zip"
Expand-Archive -LiteralPath "raylib.zip" -DestinationPath ".\"
Move-Item -Path .\raylib-5.0_win64_msvc16\include  -Destination .\
Move-Item -Path .\raylib-5.0_win64_msvc16\lib  -Destination .\

Remove-Item raylib.zip
Remove-Item -Path raylib-5.0_win64_msvc16 -Recurse -Force
