{ pkgs ? import <nixpkgs> {} }:

# get dependencies packages from nixpkgs through inherit
let
  inherit (pkgs) lib stdenv makeWrapper jdk mesa libglvnd xorg glfw wayland dbus fontconfig freetype alsa-lib;
in
stdenv.mkDerivation rec {
  pname = "legacylauncher";
  version = "legacy"; # Using "legacy" as the version since the filename implies it.

  # This assumes 'LegacyLauncher.jar' is in the same directory as this .nix file.
  src = ./LegacyLauncher.jar;

  # 2. Build Tools (Stuff needed to package it)
  nativeBuildInputs = [
    makeWrapper # This tool creates a script to run the .jar easily
  ];

  # 3. Runtime Dependencies (Stuff the app needs to run)
  # These libraries ensure the Java application can run, render graphics,
  # play sound, and integrate with the desktop environment.
  buildInputs = [
    jdk           # Java Development Kit (provides Java Runtime Environment)
    mesa          # 3D Graphics library (OpenGL)
    libglvnd      # OpenGL dispatch library
    xorg.libX11   # Core X11 library (for graphical interface on X11)
    xorg.libXext  # X11 extensions
    xorg.libXcursor # X11 cursor management
    xorg.libXrandr # X11 screenRandR configuration
    xorg.libXinerama # X11 Xinerama library for multi-monitor support
    glfw          # Library for OpenGL context creation, windowing, and input
    wayland       # Display server protocol libraries (for Wayland-based desktops)
    dbus          # Message bus system for inter-process communication
    fontconfig    # Library for font configuration and customization
    freetype      # Software font engine
    alsa-lib      # Advanced Linux Sound Architecture library (for audio)
  ];
  # Note on xdg-desktop-portal: For enhanced desktop integration (like native file dialogs)
  # on Linux, especially with sandboxed environments or modern desktops, having an
  # xdg-desktop-portal implementation installed on your system is beneficial.
  # It's usually not a direct buildInput for the application package itself but a system service.

  # 4. The "Install" Step (Putting it all together)
  # Since it's a pre-built .jar, we don't really "build" anything.
  # We just need to copy the .jar and create a wrapper script.
  installPhase = ''
    runHook preInstall # Standard Nix hook

    # Create directories in the output path ($out)
    mkdir -p $out/bin
    mkdir -p $out/share/java

    # Copy the .jar file to a standard location
    cp $src $out/share/java/${pname}.jar

    # Create a handy script in $out/bin so you can just run `legacylauncher`
    # It tells the system: "Run the 'java' command (from the jdk dependency)
    # with the argument '-jar' followed by the path to our .jar file."
    # The '--add-flags "\$@"' part passes any arguments you give on the
    # command line straight through to the Java application.
    # We also build the RPATH for the libraries needed by GLFW and other native libs.
    makeWrapper ${jdk}/bin/java $out/bin/${pname} \
      --set JAVA_HOME ${jdk} \
      --set DRI_PRIME 1 \
      --prefix PATH : "${lib.makeBinPath [ jdk ]}" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
      --add-flags "-jar $out/share/java/${pname}.jar" \
      --add-flags "\$@"

    runHook postInstall # Standard Nix hook
  '';

  # Tell Nix not to try and unpack the .jar file like it's a source archive
  dontUnpack = true;

  # 5. Metadata (Info about the package)
  meta = with lib; {
    description = "Legacy Java Launcher for Minecraft";
    homepage = "https://llaun.ch/"; # Official website

    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ "Oslamelon" ]; # Put your GH username here!
  };
}
