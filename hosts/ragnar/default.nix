{...}: {
#    fileSystems."/mnt/Codes" = {
 #       device = "/dev/disk/by-uuid/ac7b7e8d-c21b-401b-a6c9-cc35dc44218e";
  #      fsType = "ext4";
   #     options = [ "defaults" "exec" ];
   # };

  imports = [
    ./hardware.nix
    ./host-packages.nix
  ];
}
