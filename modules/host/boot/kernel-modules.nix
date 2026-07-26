{ config, pkgs, ... }:

let
  cpuidFaultModule = config.boot.kernelPackages.buildLinuxModule {
    name = "cpuid_fault_emulation";
    src = /mnt/d/Backup/cpuid_fault_emulation;
  };
in
{
  boot.extraModulePackages = [ cpuidFaultModule ];
  boot.blacklistedKernelModules = [
    "kvm_amd"
    "kvm"
  ];
  boot.kernelModules = [ "cpuid_fault_emulation" ];
}
