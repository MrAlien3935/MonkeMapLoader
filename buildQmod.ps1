# Builds a .zip file for loading with BMBF
$NDKPath = Get-Content $PSScriptRoot/ndkpath.txt

$buildScript = "$NDKPath/build/ndk-build"
if (-not ($PSVersionTable.PSEdition -eq "Core")) {
    $buildScript += ".cmd"
}

& $buildScript NDK_PROJECT_PATH=$PSScriptRoot APP_BUILD_SCRIPT=$PSScriptRoot/Android.mk NDK_APPLICATION_MK=$PSScriptRoot/Application.mk -j 4
Compress-Archive -Path  "./libs/arm64-v8a/libmonkemaploader.so",`
                        "./ExtraFiles/Teleporter",`
                        "./ExtraFiles/Orb",`
                        "./ExtraFiles/Bobbie_gkz_beginnerblock.gtmap",`
                        "./mod.json" -DestinationPath "./MonkeMapLoader.zip" -Update 

& copy-item -Force "./MonkeMapLoader.zip" "./MonkeMapLoader.qmod"