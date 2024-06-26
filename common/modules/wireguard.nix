{ pkgs, ... }: {
  networking.wg-quick.interfaces = let
  in {
    wgaws.configFile = "/etc/wireguard/wgaws.conf";
    wgproton.configFile = "/etc/wireguard/wgproton.conf";
  };
}

