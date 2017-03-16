From: James Clarke <jrtc27@debian.org>
Date: Thu, 16 Mar 2017 12:39:17 +0000
Subject: Re: Retrieving disk info from sunvdc using udevadm
Message-Id: <092A4589-29F7-4B14-B05D-BA77AE901B12@debian.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_6BF2E998-54DB-4EB6-B831-C3902B7E863C"
List-Id: <sparclinux.vger.kernel.org>
References: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
In-Reply-To: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
To: sparclinux@vger.kernel.org


--Apple-Mail=_6BF2E998-54DB-4EB6-B831-C3902B7E863C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On 16 Mar 2017, at 12:15, Anatoly Pugachev <matorola@gmail.com> wrote:
> On Wed, Mar 15, 2017 at 1:14 AM, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> Hi!
>>=20
>> Some Debian users who are installing Debian for sparc64 in an LDOM =
run into
>> the problem that the debian-installer is unable to detect the =
installation
>> medium.
>>=20
>> Digging through the sources of the responsible debian-installer =
module, it
>> turns out that d-i uses "udevadm info" to query information from all =
available
>> block devices listed in /sys/block. To detect a CD-ROM, it looks for =
"ID_CDROM=3D1"
>> or "ID_TYPE=3Dcd".
>>=20
>> Unfortunately, this fails with sunvdc with a virtual CD-ROM drive as =
the data
>> retrieved by "udevadm info" is very limited as compared to a standard =
PC with
>> a physical CD-ROM drive.
>>=20
>> For comparison, on a SPARC T5, I get:
>>=20
>> /sys/block # udevadm info -q env -p /sys/block/vdiskd
>> DEVLINKS=3D/dev/disk/by-uuid/2017-03-14-14-05-33-00 =
/dev/disk/by-label/Debian\x209.0\x20sparc64\x201
>> DEVNAME=3D/dev/vdiskd
>> DEVPATH=3D/devices/channel-devices/vdc-port-3-0/block/vdiskd
>> DEVTYPE=3Ddisk
>> ID_FS_LABEL=3DDebian_9.0_sparc64_1
>> ID_FS_LABEL_ENC=3DDebian\x209.0\x20sparc64\x201
>> ID_FS_TYPE=3Diso9660
>> ID_FS_USAGE=3Dfilesystem
>> ID_FS_UUID=3D2017-03-14-14-05-33-00
>> ID_FS_UUID_ENC=3D2017-03-14-14-05-33-00
>> ID_PART_TABLE_TYPE=3Dsun
>> MAJOR=3D254
>> MINOR=3D24
>> SUBSYSTEM=3Dblock
>> USEC_INITIALIZED=3D634522
>> /sys/block #
>>=20
>> Compare this to the output for a standard USB CD-ROM device on my =
laptop:
>>=20
>> glaubitz@ikarus:/sys/block$ udevadm info -q env -p /sys/block/sr0
>> DEVLINKS=3D/dev/disk/by-path/pci-0000:00:14.0-usb-0:2:1.0-scsi-0:0:0:0 =
/dev/disk/by-id/usb-TSSTcorp_CDDVDW_SE-S084D_0j468695-0:0 /dev/dvdrw =
/dev/dvd /dev/cdrom
>> /dev/cdrw
>> DEVNAME=3D/dev/sr0
>> =
DEVPATH=3D/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/host4/target4:=
0:0/4:0:0:0/block/sr0
>> DEVTYPE=3Ddisk
>> ID_BUS=3Dusb
>> ID_CDROM=3D1
>> ID_CDROM_CD=3D1
>> ID_CDROM_CD_R=3D1
>> ID_CDROM_CD_RW=3D1
>> ID_CDROM_DVD=3D1
>> ID_CDROM_DVD_PLUS_R=3D1
>> ID_CDROM_DVD_PLUS_RW=3D1
>> ID_CDROM_DVD_PLUS_R_DL=3D1
>> ID_CDROM_DVD_R=3D1
>> ID_CDROM_DVD_RAM=3D1
>> ID_CDROM_DVD_RW=3D1
>> ID_CDROM_MRW=3D1
>> ID_CDROM_MRW_W=3D1
>> ID_FOR_SEAT=3Dblock-pci-0000_00_14_0-usb-0_2_1_0-scsi-0_0_0_0
>> ID_INSTANCE=3D0:0
>> ID_MODEL=3DCDDVDW_SE-S084D
>> ID_MODEL_ENC=3DCDDVDW\x20SE-S084D\x20
>> ID_MODEL_ID=3D1836
>> ID_PATH=3Dpci-0000:00:14.0-usb-0:2:1.0-scsi-0:0:0:0
>> ID_PATH_TAG=3Dpci-0000_00_14_0-usb-0_2_1_0-scsi-0_0_0_0
>> ID_REVISION=3DTS00
>> ID_SERIAL=3DTSSTcorp_CDDVDW_SE-S084D_0j468695-0:0
>> ID_SERIAL_SHORT=3D0j468695
>> ID_TYPE=3Dcd
>> ID_USB_DRIVER=3Dusb-storage
>> ID_USB_INTERFACES=3D:080250:
>> ID_USB_INTERFACE_NUM=3D00
>> ID_VENDOR=3DTSSTcorp
>> ID_VENDOR_ENC=3DTSSTcorp
>> ID_VENDOR_ID=3D0e8d
>> MAJOR=3D11
>> MINOR=3D0
>> SUBSYSTEM=3Dblock
>> SYSTEMD_READY=3D0
>> TAGS=3D:systemd:uaccess:seat:
>> USEC_INITIALIZED=3D16198574878
>> glaubitz@ikarus:/sys/block$
>>=20
>> Would it be possible to extend sunvdc to display additional fields? =
In particular, it would be very useful
>> if sunvdc could indicate whether the virtual block device is a =
regular disk or a CD-ROM drive.
>=20
>=20
> Adrian,
>=20
> wouldn't it be easier to patch d-i (userspace) to add support for
> "ID_FS_TYPE=3Diso9660" as /dev/cdrom (besides of "ID_CDROM=3D1"), =
instead
> of patching kernel (sunvdc.c) sources?

Patching d-i might make sense, since it will ensure other architectures =
don't
have similar issues, but I believe the problem is in udev itself, =
specifically
60-cdrom_id.rules[1] which needs to whitelist "vdisk*" as possible CDs.
Certainly if you invoke /lib/udev/cdrom_id manually it is able to =
distinguish
between CDs and non-CDs.

Regards,
James

[1] =
https://github.com/systemd/systemd/blob/master/rules/60-cdrom_id.rules


--Apple-Mail=_6BF2E998-54DB-4EB6-B831-C3902B7E863C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYyoeAAAoJELGTdwwYahx9AfoP/2iTYd3FlcdtuR+sfCeMDZZh
kp226aiGxngfturBOrvluAdsDNtXWJwe3ClDdfTSq8jIQ8WEApe1Ak9A1WWw93eo
C1CLZs+sGleSjkODkAJIey3TessC+gs3Z4860YEvy5bb5aMzUhSq9j4fGHQN6yln
0DZM3Kq7hE6ztCjPLin2SiDKqGN8Vba7lLvKo7zZM+N0vKTa+yVoT1wxxy31opzr
CUbvsOvJNSxO78SsW9gHM7ZCLoGJdiN62m1OgqPb+0K5mdqGGIcGbIkmV+9wX54o
TqFc7oOepudKq7Dc2dwhHEDSEUu3gWD5hdViA2/8y+qtwypF+XQkEZsCKfm78OJI
BzSoMtq/D9jt78g/rnMPsKHDJgyye436GwcrZYGCcUJw1bMd5Yh1vHd47gBuQVwj
eS6ocCrqL9CEoQt54CrqfnVDqFHzH7WUVAfZltHQtBE8eXBERQwi41BOOiwW27Qw
aqFg1wbweO0RGJNR43eJdgtr2ZAFtg1KenMhZ2SSOGBTc/e6qu8uSULk9O2R+dYe
SNQrEj9GcVKoJeQK8HS1OM+oVuAFHlrHkIFPKzpKDcB/VgSbuwrLQlNes1gzL5hr
VCOL47C53rE+aVeQhAcXi4pJK/w4rHpm5G9JEsQGPk18JR0kRe/0LKJQmQqRvJbY
K8BbZUVgkXIThJ7Juvwd
=BD77
-----END PGP SIGNATURE-----

--Apple-Mail=_6BF2E998-54DB-4EB6-B831-C3902B7E863C--
