@echo off

set gitProj=%1
set option=%2

if "%gitProj%" == "" (
    echo compile project contained in the web folder
) else (
    rmdir /S /Q "web/"
    mkdir "web/"
    call git clone %gitProj% web/
)

if exist "web/package.json" (

    echo React.js2Electron
    echo Generate Electron app from ReactJS Project

    echo [Downloading dependencies...]
    rmdir /S /Q "node_modules/"
    call npm install

    echo [Compiling the ReactJS project in the web/]
    cd web/

    echo [Downloading React dependencies...]
    rmdir /S /Q "node_modules/"
    call npm install
    call npm run build
    echo [Successfully compiled]

    cd ../

    rmdir /S /Q "build/"
    mkdir "build/"
    xcopy /E /F "web/build" "build/"
    rmdir /S /Q "web/build/"
    rmdir /S /Q "dist/"

    call npm run electron-build

    rmdir /S /Q "build/"

    if "%option%" == "-r" (
        rmdir /S /Q "web/"
        mkdir "web/"
    )
) else (
    echo Could not find a node project in the web folder!
)
