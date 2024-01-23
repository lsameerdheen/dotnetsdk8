# Sample Dockerfile
# Indicates that the windowsservercore image will be used as the base image.
FROM  mcr.microsoft.com/dotnet/framework/runtime:4.8.1 as baseimage
# Metadata indicating an image maintainer.
LABEL maintainer="ameerdeen@gmail.com"
SHELL ["cmd", "/S", "/C"]
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]
#RUN powershell -ExecutionPolicy Bypass -File "c:/workspace/Start.ps1" 
ENV ChocolateyUseWindowsCompression="false"
RUN Echo $env:ChocolateyUseWindowsCompression
RUN mkdir "c:/install"
COPY . c:/install
RUN powershell -NoProfile -ExecutionPolicy Bypass -File "c:/install/chocolatey_install.ps1" 
RUN powershell -ExecutionPolicy Bypass 
# SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RUN powershell dism.exe /online /enable-feature /all /featurename:iis-webserver /NoRestart
RUN powershell choco feature enable -n=allowGlobalConfirmation
RUN powershell choco install  -y --ignore-package-exit-codes=3010 dotnet-sdk  
