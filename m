From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 16 Mar 2017 12:15:31 +0000
Subject: Re: Retrieving disk info from sunvdc using udevadm
Message-Id: <CADxRZqzUX3vGLSrm3S6ToRzHn82Vty=Qmi2=URf7eVk9c6y-sQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
In-Reply-To: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, Mar 15, 2017 at 1:14 AM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Hi!
>
> Some Debian users who are installing Debian for sparc64 in an LDOM run in=
to
> the problem that the debian-installer is unable to detect the installation
> medium.
>
> Digging through the sources of the responsible debian-installer module, it
> turns out that d-i uses "udevadm info" to query information from all avai=
lable
> block devices listed in /sys/block. To detect a CD-ROM, it looks for "ID_=
CDROM=3D1"
> or "ID_TYPE=CD".
>
> Unfortunately, this fails with sunvdc with a virtual CD-ROM drive as the =
data
> retrieved by "udevadm info" is very limited as compared to a standard PC =
with
> a physical CD-ROM drive.
>
> For comparison, on a SPARC T5, I get:
>
> /sys/block # udevadm info -q env -p /sys/block/vdiskd
> DEVLINKS=3D/dev/disk/by-uuid/2017-03-14-14-05-33-00 /dev/disk/by-label/De=
bian\x209.0\x20sparc64\x201
> DEVNAME=3D/dev/vdiskd
> DEVPATH=3D/devices/channel-devices/vdc-port-3-0/block/vdiskd
> DEVTYPE=3Ddisk
> ID_FS_LABEL=DEbian_9.0_sparc64_1
> ID_FS_LABEL_ENC=DEbian\x209.0\x20sparc64\x201
> ID_FS_TYPE=3Diso9660
> ID_FS_USAGE=3Dfilesystem
> ID_FS_UUID 17-03-14-14-05-33-00
> ID_FS_UUID_ENC 17-03-14-14-05-33-00
> ID_PART_TABLE_TYPE=3Dsun
> MAJOR%4
> MINOR$
> SUBSYSTEM=3Dblock
> USEC_INITIALIZEDc4522
> /sys/block #
>
> Compare this to the output for a standard USB CD-ROM device on my laptop:
>
> glaubitz@ikarus:/sys/block$ udevadm info -q env -p /sys/block/sr0
> DEVLINKS=3D/dev/disk/by-path/pci-0000:00:14.0-usb-0:2:1.0-scsi-0:0:0:0 /d=
ev/disk/by-id/usb-TSSTcorp_CDDVDW_SE-S084D_0j468695-0:0 /dev/dvdrw /dev/dvd=
 /dev/cdrom
> /dev/cdrw
> DEVNAME=3D/dev/sr0
> DEVPATH=3D/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/host4/target4=
:0:0/4:0:0:0/block/sr0
> DEVTYPE=3Ddisk
> ID_BUS=3Dusb
> ID_CDROM=3D1
> ID_CDROM_CD=3D1
> ID_CDROM_CD_R=3D1
> ID_CDROM_CD_RW=3D1
> ID_CDROM_DVD=3D1
> ID_CDROM_DVD_PLUS_R=3D1
> ID_CDROM_DVD_PLUS_RW=3D1
> ID_CDROM_DVD_PLUS_R_DL=3D1
> ID_CDROM_DVD_R=3D1
> ID_CDROM_DVD_RAM=3D1
> ID_CDROM_DVD_RW=3D1
> ID_CDROM_MRW=3D1
> ID_CDROM_MRW_W=3D1
> ID_FOR_SEAT=3Dblock-pci-0000_00_14_0-usb-0_2_1_0-scsi-0_0_0_0
> ID_INSTANCE=3D0:0
> ID_MODEL=CDDVDW_SE-S084D
> ID_MODEL_ENC=CDDVDW\x20SE-S084D\x20
> ID_MODEL_ID=1836
> ID_PATH=3Dpci-0000:00:14.0-usb-0:2:1.0-scsi-0:0:0:0
> ID_PATH_TAG=3Dpci-0000_00_14_0-usb-0_2_1_0-scsi-0_0_0_0
> ID_REVISION=3DTS00
> ID_SERIAL=3DTSSTcorp_CDDVDW_SE-S084D_0j468695-0:0
> ID_SERIAL_SHORT=3D0j468695
> ID_TYPE=CD
> ID_USB_DRIVER=3Dusb-storage
> ID_USB_INTERFACES=3D:080250:
> ID_USB_INTERFACE_NUM=00
> ID_VENDOR=3DTSSTcorp
> ID_VENDOR_ENC=3DTSSTcorp
> ID_VENDOR_ID=0E8d
> MAJOR=11
> MINOR=3D0
> SUBSYSTEM=3Dblock
> SYSTEMD_READY=3D0
> TAGS=3D:systemd:uaccess:seat:
> USEC_INITIALIZED=16198574878
> glaubitz@ikarus:/sys/block$
>
> Would it be possible to extend sunvdc to display additional fields? In pa=
rticular, it would be very useful
> if sunvdc could indicate whether the virtual block device is a regular di=
sk or a CD-ROM drive.


Adrian,

wouldn't it be easier to patch d-i (userspace) to add support for
"ID_FS_TYPE=3Diso9660" as /dev/cdrom (besides of "ID_CDROM=3D1"), instead
of patching kernel (sunvdc.c) sources?

PS: running qemu on x86_64 as

$ qemu-system-sparc64  -hda hda.img  -cdrom debian-7.11.0-sparc-netinst.iso

and inside qemu :

# udevadm info -q env -p /sys/block/sr0
DEVLINKS=3D/dev/cdrom1 /dev/disk/by-id/ata-EQUMD_DVR-MO_MQ0000_3
/dev/disk/by-label/Debian\x207.11.0\x20sparc\x201
/dev/disk/by-path/platform-ffe2b5a8-pci-0000:00:05.0-scsi-1:0:0:0
/dev/dvd1
DEVNAME=3D/dev/sr0
DEVPATH=3D/devices/root/ffe2b5a8/pci0000:00/0000:00:05.0/host1/target1:0:0/=
1:0:0:0/block/sr0
DEVTYPE=3Ddisk
GENERATED=3D1
ID_ATA=3D1
ID_BUS=3Data
ID_CDROM=3D1
ID_CDROM_DVD=3D1
ID_CDROM_MEDIA=3D1
ID_CDROM_MEDIA_CD=3D1
ID_CDROM_MEDIA_SESSION_COUNT=3D1
ID_CDROM_MEDIA_TRACK_COUNT=3D1
ID_CDROM_MEDIA_TRACK_COUNT_DATA=3D1
ID_CDROM_MRW=3D1
ID_CDROM_MRW_W=3D1
ID_FS_LABEL=DEbian_7.11.0_sparc_1
ID_FS_LABEL_ENC=DEbian\x207.11.0\x20sparc\x201
ID_FS_TYPE=3Diso9660
ID_FS_USAGE=3Dfilesystem
ID_MODEL=3DEQUMD_DVR-MO
ID_MODEL_ENC=3DEQUMD\x20DVR-MO\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\=
x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20
ID_PART_TABLE_TYPE=3Dsun
ID_PATH=3Dplatform-ffe2b5a8-pci-0000:00:05.0-scsi-1:0:0:0
ID_PATH_TAG=3Dplatform-ffe2b5a8-pci-0000_00_05_0-scsi-1_0_0_0
ID_REVISION=3D.2+5
ID_SERIAL=3DEQUMD_DVR-MO_MQ0000_3
ID_SERIAL_SHORT=3DMQ0000_3
ID_TYPE=CD
MAJOR=11
MINOR=3D0
SUBSYSTEM=3Dblock
TAGS=3D:udev-acl:
UDEV_LOG=3D3
USEC_INITIALIZED9425573

dmesg cut:

[   37.995639] udevd[43]: starting version 175
[   43.839280] SCSI subsystem initialized
[   44.074912] libata version 3.00 loaded.
[   44.168027] scsi0 : pata_cmd64x
[   44.174100] scsi1 : pata_cmd64x
[   44.175483] ata1: PATA max UDMA/33 cmd 0x1fe02008080 ctl
0x1fe02008100 bmdma 0x1fe02008280 irq 7
[   44.176309] ata2: PATA max UDMA/33 cmd 0x1fe02008180 ctl
0x1fe02008200 bmdma 0x1fe02008288 irq 7
[   44.197377] pata_cmd64x: active 10 recovery 10 setup 3.
[   44.197550] pata_cmd64x: active 10 recovery 10 setup 3.
[   44.366417] ata1.01: NODEV after polling detection
[   44.368357] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[   44.368716] ata1.00: 18874368 sectors, multi 16: LBA48
[   44.369956] pata_cmd64x: active 3 recovery 1 setup 1.
[   44.378555] ata1.00: configured for UDMA/33
[   44.410389] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK
  2.5+ PQ: 0 ANSI: 5
[   44.430084] pata_cmd64x: active 10 recovery 10 setup 3.
[   44.430132] pata_cmd64x: active 10 recovery 10 setup 3.
[   44.586422] ata2.01: NODEV after polling detection
[   44.586997] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[   44.587517] pata_cmd64x: active 4 recovery 2 setup 1.
[   44.588013] ata2.00: configured for UDMA/33
[   44.592133] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM
  2.5+ PQ: 0 ANSI: 5
[   45.049560] sd 0:0:0:0: [sda] 18874368 512-byte logical blocks:
(9.66 GB/9.00 GiB)
[   45.057268] sd 0:0:0:0: [sda] Write Protect is off
[   45.057602] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   45.059324] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   45.080040] sr0: scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   45.080716] cdrom: Uniform CD-ROM driver Revision: 3.20
[   45.097015] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   45.104671]  sda: sda1 sda2 sda3
[   45.114193] sd 0:0:0:0: [sda] Attached SCSI disk
[   45.289872] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   45.298169] sr 1:0:0:0: Attached scsi generic sg1 type 5
[   46.943661] device-mapper: uevent: version 1.0.3
