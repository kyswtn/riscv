{ lib
, stdenv
, fetchFromGitHub
, dtc
,
}:

stdenv.mkDerivation {
  pname = "spike";
  version = "master-2025-03-20";

  src = fetchFromGitHub {
    owner = "riscv-software-src";
    repo = "riscv-isa-sim";
    rev = "f6d41bca17ba2c9807d1499264f7bf7f20bb51a0";
    sha256 = "sha256-K+4LCItMhEDCj7MhkJPmhcIqR7wUQpWZPPkE0cLG8jY=";
  };

  nativeBuildInputs = [ dtc ];

  meta = with lib; {
    homepage = "https://github.com/riscv/riscv-isa-sim";
    description = "Spike, a RISC-V ISA Simulator ";
    license = licenses.bsd3;
  };
}
