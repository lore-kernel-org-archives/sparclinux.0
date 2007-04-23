From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 23 Apr 2007 08:42:55 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <462C718F.2060708@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Thu, 19 Apr 2007 14:19:48 +0200
>=20
>> 	Thanks. Patch applied. Now, kernel says :
>> ...
>> /dev/md1: clean, 220181/1251712 files...
>> esp: esp0: Reconnect, tag type changed 22 --> 20
>> esp: esp0: Aborting command [fbc5f3c0:2a]
>> esp: esp0: Queued command [fbc5f3c0:2a]
>> esp: esp0: Queued command [fbc5f4e0:2a]
>> esp: esp0: Dumping command log
>>
>> followd by a lot of insane messages ;-)
>=20
> OK, I read over the SCSI standard docs a bit and my
> assertion check here is wrong.
>=20
> Regardless of what type of TAG type we sent to the target, when it
> reconnects after a disconnect it always gives SIMPLE_QUEUE_TAG (0x20)
> as the tag type.
>=20
> This is explained clearly in section 6.6.17 of the SCSI-2 standard,
> for example.
>=20
> Georg Chini gave the important clue, MD and RAID.  Those make ordered
> tags go out to the device.  Normally only simple tags are used so the
> tag the target gives back on reconnect always matched up by
> coincidence :-)
>=20
> Please test with this patch, thanks!
>=20
> diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
> index a3550b3..fa49348 100644
> --- a/drivers/scsi/esp.c
> +++ b/drivers/scsi/esp.c
> @@ -1435,13 +1435,6 @@ static struct esp_cmd_entry *esp_reconnect_with_ta=
g(struct esp *esp,
>  		       esp->host->unique_id, esp->command_block[1]);
>  		return NULL;
>  	}
> -	if (ent->tag[0] !=3D esp->command_block[0]) {
> -		printk(KERN_ERR PFX "esp%d: Reconnect, tag type changed "
> -		       "%02x --> %02x.\n",
> -		       esp->host->unique_id, ent->tag[0],
> -		       esp->command_block[0]);
> -		return NULL;
> -	}
> =20
>  	return ent;
>  }

	Hello David,

	I have patched drivers/scsi/esp.c file with your patch and it works=20
better on a SS20 that uses raid, but when this workstation tries to=20
start SMART, driver returns :

esp: esp0: Aborting command [fb850200:2a]
followed by a lot of insane messages ;-)

My dmesg :
<lot of poke_cypress error>
migration_cost@000
NET: Registered protocol family 16
SCSI subsystem initialized
IOMMU: impl 1 vers 3 table 0xf0e40000[262144 B] map [65536 b]
sbus0: Clock 25.0 MHz
dma0: Revision 2
dma1: Revision 2
dma2: HME DVMA gate array
ioremap: done with statics, switching to malloc
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 5, 196608 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler cfq registered (default)
Console: switching to colour frame buffer device 160x64
/obio/cgfourteen@2,0: cgfourteen at 0:fc000000, 8MB
ffd60050: ttyS0 at MMIO 0xf1100000 (irq =3D 44) is a zs
ffd60050: ttyS1 at MMIO 0xf1100004 (irq =3D 44) is a zs
ffd60130: Keyboard at MMIO f1000000 (irq =3D 44) is a zs
ffd60130: Mouse at MMIO f1000004 (irq =3D 44) is a zs
scsi0 : esp
esp: esp0 found at=20
/iommu@f,e0000000/sbus@f,e0001000/espdma@f,400000/esp@f,800000,=20
regs[fd159000:fd00f000] irq[36]
esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LC       0006 PQ: 0 ANSI: 3
  target0:0:1: Beginning Domain Validation
  target0:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
  target0:0:1: Domain Validation skipping write tests
  target0:0:1: Ending Domain Validation
scsi 0:0:3:0: Direct-Access     SEAGATE  ST336607LC       0007 PQ: 0 ANSI: 3
  target0:0:3: Beginning Domain Validation
  target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
  target0:0:3: Domain Validation skipping write tests
  target0:0:3: Ending Domain Validation
scsi 0:0:6:0: CD-ROM            TOSHIBA  XM-4101TASUNSLCD 3424 PQ: 0 ANSI: 2
  target0:0:6: Beginning Domain Validation
  target0:0:6: FAST-5 SCSI 4.2 MB/s ST (236 ns, offset 15)
  target0:0:6: Domain Validation skipping write tests
  target0:0:6: Ending Domain Validation
scsi1 : esp
esp: esp1 found at /iommu@f,e0000000/sbus@f,e0001000/SUNW,fas@2,8800000,=20
regs[fd15a000:fd011000] irq[53]
esp: esp1 is a FASHME, 40 MHz (ccf=3D0), SCSI ID 7
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: ab 00 10 08
SCSI device sda: write cache: enabled, read cache: enabled, supports DPO=20
and FUA
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: ab 00 10 08
SCSI device sda: write cache: enabled, read cache: enabled, supports DPO=20
and FUA
  sda: sda1 sda2 sda3 sda4 sda8
sd 0:0:1:0: Attached scsi disk sda
SCSI device sdb: 71687372 512-byte hdwr sectors (36704 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO=20
and FUA
SCSI device sdb: 71687372 512-byte hdwr sectors (36704 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO=20
and FUA
  sdb: sdb1 sdb2 sdb3 sdb4 sdb8
sd 0:0:3:0: Attached scsi disk sdb
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
input: Sun Type 5 keyboard as /class/input/input0
md: raid1 personality registered for level 1
TCP cubic registered
input: Sun Mouse as /class/input/input1
NET: Registered protocol family 1
TCP cubic registered
input: Sun Mouse as /class/input/input1
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb8 ...
md:  adding sdb8 ...
md: sdb4 has different UUID to sdb8
md: sdb2 has different UUID to sdb8
md: sdb1 has different UUID to sdb8
md:  adding sda8 ...
md: sda4 has different UUID to sdb8
md: sda2 has different UUID to sdb8
md: sda1 has different UUID to sdb8
md: created md2
md: bind<sda8>
md: bind<sdb8>
md: running: <sdb8><sda8>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdb4 ...
md:  adding sdb4 ...
md: sdb2 has different UUID to sdb4
md: sdb1 has different UUID to sdb4
md:  adding sda4 ...
md: sda2 has different UUID to sdb4
md: sda1 has different UUID to sdb4
md: created md1
md: bind<sda4>
md: bind<sdb4>
md: running: <sdb4><sda4>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md3
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 0:0:6:0: Attached scsi CD-ROM sr0
sd 0:0:1:0: Attached scsi generic sg0 type 0
sd 0:0:3:0: Attached scsi generic sg1 type 0
sr 0:0:6:0: Attached scsi generic sg2 type 5
Adding 781112k swap on /dev/md3.  Priority:-1 extents:1 across:781112k
EXT3 FS on md1, internal journal
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:77:46:36
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:=20
dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.

	I don't have any error in logfiles.

	Regards,

	JKB
