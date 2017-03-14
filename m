From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 14 Mar 2017 22:14:47 +0000
Subject: Retrieving disk info from sunvdc using udevadm
Message-Id: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi!

Some Debian users who are installing Debian for sparc64 in an LDOM run into
the problem that the debian-installer is unable to detect the installation
medium.

Digging through the sources of the responsible debian-installer module, it
turns out that d-i uses "udevadm info" to query information from all availa=
ble
block devices listed in /sys/block. To detect a CD-ROM, it looks for "ID_CD=
ROM=3D1"
or "ID_TYPE=CD".

Unfortunately, this fails with sunvdc with a virtual CD-ROM drive as the da=
ta
retrieved by "udevadm info" is very limited as compared to a standard PC wi=
th
a physical CD-ROM drive.

For comparison, on a SPARC T5, I get:

/sys/block # udevadm info -q env -p /sys/block/vdiskd
DEVLINKS=3D/dev/disk/by-uuid/2017-03-14-14-05-33-00 /dev/disk/by-label/Debi=
an\x209.0\x20sparc64\x201
DEVNAME=3D/dev/vdiskd
DEVPATH=3D/devices/channel-devices/vdc-port-3-0/block/vdiskd
DEVTYPE=3Ddisk
ID_FS_LABEL=DEbian_9.0_sparc64_1
ID_FS_LABEL_ENC=DEbian\x209.0\x20sparc64\x201
ID_FS_TYPE=3Diso9660
ID_FS_USAGE=3Dfilesystem
ID_FS_UUID 17-03-14-14-05-33-00
ID_FS_UUID_ENC 17-03-14-14-05-33-00
ID_PART_TABLE_TYPE=3Dsun
MAJOR%4
MINOR$
SUBSYSTEM=3Dblock
USEC_INITIALIZEDc4522
/sys/block #

Compare this to the output for a standard USB CD-ROM device on my laptop:

glaubitz@ikarus:/sys/block$ udevadm info -q env -p /sys/block/sr0
DEVLINKS=3D/dev/disk/by-path/pci-0000:00:14.0-usb-0:2:1.0-scsi-0:0:0:0 /dev=
/disk/by-id/usb-TSSTcorp_CDDVDW_SE-S084D_0j468695-0:0 /dev/dvdrw /dev/dvd /=
dev/cdrom
/dev/cdrw
DEVNAME=3D/dev/sr0
DEVPATH=3D/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/host4/target4:0=
:0/4:0:0:0/block/sr0
DEVTYPE=3Ddisk
ID_BUS=3Dusb
ID_CDROM=3D1
ID_CDROM_CD=3D1
ID_CDROM_CD_R=3D1
ID_CDROM_CD_RW=3D1
ID_CDROM_DVD=3D1
ID_CDROM_DVD_PLUS_R=3D1
ID_CDROM_DVD_PLUS_RW=3D1
ID_CDROM_DVD_PLUS_R_DL=3D1
ID_CDROM_DVD_R=3D1
ID_CDROM_DVD_RAM=3D1
ID_CDROM_DVD_RW=3D1
ID_CDROM_MRW=3D1
ID_CDROM_MRW_W=3D1
ID_FOR_SEAT=3Dblock-pci-0000_00_14_0-usb-0_2_1_0-scsi-0_0_0_0
ID_INSTANCE=3D0:0
ID_MODEL=CDDVDW_SE-S084D
ID_MODEL_ENC=CDDVDW\x20SE-S084D\x20
ID_MODEL_ID=1836
ID_PATH=3Dpci-0000:00:14.0-usb-0:2:1.0-scsi-0:0:0:0
ID_PATH_TAG=3Dpci-0000_00_14_0-usb-0_2_1_0-scsi-0_0_0_0
ID_REVISION=3DTS00
ID_SERIAL=3DTSSTcorp_CDDVDW_SE-S084D_0j468695-0:0
ID_SERIAL_SHORT=3D0j468695
ID_TYPE=CD
ID_USB_DRIVER=3Dusb-storage
ID_USB_INTERFACES=3D:080250:
ID_USB_INTERFACE_NUM=00
ID_VENDOR=3DTSSTcorp
ID_VENDOR_ENC=3DTSSTcorp
ID_VENDOR_ID=0E8d
MAJOR=11
MINOR=3D0
SUBSYSTEM=3Dblock
SYSTEMD_READY=3D0
TAGS=3D:systemd:uaccess:seat:
USEC_INITIALIZED=16198574878
glaubitz@ikarus:/sys/block$

Would it be possible to extend sunvdc to display additional fields? In part=
icular, it would be very useful
if sunvdc could indicate whether the virtual block device is a regular disk=
 or a CD-ROM drive.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
