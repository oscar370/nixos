{ config, pkgs, ... }:

let
  cpuidFaultEmulation = config.boot.kernelPackages.callPackage
    ({ stdenv, kernel }:
      stdenv.mkDerivation {
        pname = "cpuid_fault_emulation";
        version = "0.1";

        src = ./cpuid_fault_emulation;

        nativeBuildInputs = kernel.moduleBuildDependencies;

        hardenedLDFLAGS = [ ];

        buildPhase = ''
          runHook preBuild
          make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$PWD modules
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
          cp *.ko $out/lib/modules/${kernel.modDirVersion}/extra/
          runHook postInstall
        '';
      }) { };
in
{
  boot.extraModulePackages = [ cpuidFaultEmulation ];

  # Befor play
  # sudo modprobe -r kvm_amd kvm_intel kvm
  # sudo modprobe cpuid_fault_emulation
  #
  # After play
  # sudo modprobe -r cpuid_fault_emulation
  # sudo modprobe kvm_amd
}
