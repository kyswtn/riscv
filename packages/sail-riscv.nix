{ lib, stdenv, fetchFromGitHub, cmake, ocamlPackages, zlib, z3, pkg-config }: stdenv.mkDerivation rec {
  pname = "sail-riscv";
  version = "0.6";

  src = fetchFromGitHub {
    owner = "riscv";
    repo = pname;
    rev = version;
    hash = "sha256-cO0ZOr2frMMLE9NUGDxy9+KpuyBnixw6wcNzUArxDiE=";
  };

  nativeBuildInputs = [
    z3
    cmake
    ocamlPackages.sail
    pkg-config
  ];

  buildInputs = [
    zlib
  ];

  dontUseCmakeConfigure = true;

  DOWNLOAD_GMP = "FALSE";
  buildPhase = ''
    runHook preBuild

    ./build_simulators.sh

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp build/c_emulator/riscv_sim_rv{32,64}d $out/bin

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/riscv/sail-riscv";
    description = "Sail RISC-V model";
    license = licenses.bsd2;
  };
}
