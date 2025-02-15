# This module build a dotNet packages
{buildDotNetModule, dotnetCorePackages, ... }: 
buildDotNetModule rec {
    pname = "myApp";
    version = "1.0";

    projectFile = ../../../build + "/${pname}/${pname}.csproj";
    dotnet-sdk = dotnetCorePackages.sdk_8_0;
    dotnet-runtime = dotnetCorePackages.runtime_8_0;
    nugetDeps = ./deps.nix;
}
