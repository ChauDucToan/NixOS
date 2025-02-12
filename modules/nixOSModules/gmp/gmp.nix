{pkgs ? import <nixpkgs> {}, ...}:
pkgs.stdenv.mkDerivation rec {
   # Core Attributes
   pname = "gmp";
   system = "x86_64-linux";
   version = "6.3.0";
   src = pkgs.fetchurl {
       url = "https://gmplib.org/download/gmp/gmp-${version}.tar.xz";
       sha256 = "1648ad1mr7c1r8lkkqshrv1jfjgfdb30plsadxhni7mq041bihm3";
   };  
   
   # Building
   buildInputs = with pkgs; [ gnum4 ];
   nativeBuildInputs = with pkgs; [ autoconf automake libtool ];

   configurePhase = ''
       ./configure --prefix=$out --enable-shared --enable-static --with-doc
   '';

   buildPhase = "make";

   installPhase = ''
       make install
       mkdir -p $out/doc
   '';

   outputs = [ "out" "dev" "doc" ];
}
