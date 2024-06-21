{
  fileSystems."/Lab" = {
    device = "/dev/disk/by-uuid/ae12066f-371f-4d2c-ac02-d40a8c0970b1";
    fsType = "xfs";
    options = [
	"defaults"
    ];
  };

  fileSystems."/Lab/Tools/LibVirt/images" = {
    device = "/home/me/.linked-from-lab/libvirt/images";
    fsType = "auto";
    options = [
	"defaults"
	"nofail"
	"nobootwait"
	"bind"
    ];
  };

  fileSystems."/Lab/Tools/Apps" = {
    device = "/home/me/.linked-from-lab/apps";
    fsType = "auto";
    options = [
	"defaults"
	"nofail"
	"nobootwait"
	"bind"
    ];
  };

}
