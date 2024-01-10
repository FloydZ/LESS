with import <nixpkgs> {};
let
  python-with-my-packages = pkgs.python3.withPackages (p: with p; [
  ]);
in
gccStdenv.mkDerivation {
  name = "LESS";
  src = ./.;
  buildInputs = [ 
    python-with-my-packages
    gnumake 
    cmake 
    clang_16
    clang-tools_16
    ripgrep
    openssl
    libxslt
  ] ++ (lib.optionals pkgs.stdenv.isLinux ([
	flamegraph
	gdb
    linuxKernel.packages.linux_6_5.perf
	pprof
	valgrind
	massif-visualizer
  ]));
}
