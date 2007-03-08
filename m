From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Thu, 08 Mar 2007 14:18:43 +0000
Subject: Re: Sunfire v880
Message-Id: <a728f9f90703080618m7a13e3ealf431f62fafd14025@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 3/7/07, Alex Deucher <alexdeucher@gmail.com> wrote:
> Gentoo seems to be carrying this patch:
> http://marc.theaimsgroup.com/?l=3Dlinux-sparc&m=110314220200915&w=3D2
>
> I'm going to try and see if that is indeed what fixes the issue.  If
> so perhaps it should go upstream?
>

FWIW, this patch got 2.6.17 vanilla booting for us.  I hope that
helping in tracking things down in the newer kernels.

Alex


> Thanks,
>
> Alex
>
> On 3/7/07, Alex Deucher <alexdeucher@gmail.com> wrote:
> > On 3/7/07, Alex Deucher <alexdeucher@gmail.com> wrote:
> > > On 3/6/07, David Miller <davem@davemloft.net> wrote:
> > > > From: "Alex Deucher" <alexdeucher@gmail.com>
> > > > Date: Tue, 6 Mar 2007 19:49:11 -0500
> > > >
> > > > > Had anyone had any success booting Linux on a v880?  We've been t=
rying
> > > > > to get various Debian/Ubuntu/Gentoo images up and running on it f=
or
> > > > > the last few days, but so far no luck.  Both CD-ROM and netboot
> > > > > produce the same results.  We updated the OBP to the lasted versi=
on.
> > > > > We've tried the video=3Datyfb:off trick but to no avail.  All we =
ever
> > > > > get is "Booting Linux..." and then nothing else.  We tried removi=
ng
> > > > > the video card and keyboard and mouse, no difference.  Has anyone=
 had
> > > > > any success on the v880?  Any other things we could try?
> > > >
> > > > If you boot with "-p" what further messages do you get?
> > > >
> > >
> > > "boot net:dhcp =96p":
> > >
> > > Error: Cheetah error trap taken afsr[ ]
> > > Error: TPC[ ] TNPC[ ] TSTATE[ ]
> > > Error: M_SYND(0), E_SYND(0), Privileged
> > > Error: Highest Priority Error() "Unmapped error from system"
> > >
> > > Then a bunch of D-cache, I-cache, and E-cache errors.
> > >
> > > And finally,
> > >
> > > Kernel Panic =96 not syncing: Irrecoverable deferred error trap
> > >
> > > BTW, my co-worker eventually got a gentoo CD working (2006.1 minimal =
IIRC).
> > >
> > > Alex
> > >
> >
> > here's the kernel output from the working gentoo kernel:
> >
> > boot cdrom
> > Boot device: /pci@8,700000/scsi@1/disk@6,0:f  File and args:
> > SILO Version 1.4.13
> > \^H
> >
> > ----------------------------------------------------
> > Welcome to the Gentoo/Linux SPARC64 InstallCD 2006.1
> > ----------------------------------------------------
> >
> > boot:
> > You are running the second stage SILO loader.  From here you can boot a
> > ramdisk or an already-installed Linux partition.
> >
> > Several defaults have been defined that will make things easier.
> > The target "2616" will start a 2.6.16-series kernel.
> > The target "2617" will start a 2.6.17-series kernel.
> >
> > To boot an existing Linux installation from the CDROM, boot with the co=
mmand
> > "KERNEL root=3D/dev/sdaX" where sdaX is the partition where your root
> > filesystem is. Replace "KERNEL" with the kernel entry of your choice ab=
ove.
> > If in doubt you can consult our hardware compatibility list for stabili=
ty
> > notes at http://www.gentoo.org/proj/en/base/sparc/sunhw.xml
> >
> > For video mode help, type "video" at the boot: prompt.
> > For help on miscellaneous parameters type "parameters" at the boot: pro=
mpt.
> > Type "config" at the boot: prompt to see the SILO config file used by t=
his CD.
> > boot: 2617
> > Allocated 8 Megs of memory at 0x40000000 for kernel
> > |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^=
H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^$
> > Loading initial ramdisk (645016 bytes at 0xB0FF800000 phys, 0x40C00000 =
virt)...
> > \^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^=
H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^$
> > Remapping the kernel... done.
> > bootmem_init: Scan pavail, choose_bootmap_pfn:
> > kern[b0ff000000:b0ff4d6000] avoid[b0ff800000:b0ff89e000]
> > choose_bootmap_pfn: Using 5000000 [a000000000]
> > init_bootmem(min[5000000], bootmap[5000000], max[587fd54])
> > free_bootmem(pavail:0): base[a000000000] size[100000000]
> > free_bootmem(pavail:1): base[b000000000] size[feffe000]
> > free_bootmem(pavail:2): base[b0ff000000] size[a8a000]
> > free_bootmem(pavail:3): base[b0ffa8e000] size[1a000]
> > reserve_bootmem(initrd): base[b0ff800000] size[b0ff89d798]
> > reserve_bootmem(kernel): base[b0ff000000] size[4d5ee8]
> > reserve_bootmem(bootmap): base[a000000000] size[10ffb0]
> > memory_present(0, 5000000, 5080000)
> > memory_present(0, 5800000, 587f7ff)
> > memory_present(0, 587f800, 587fd45)
> > memory_present(0, 587fd47, 587fd54)
> > Booting Linux...
> > mem_init: Calling free_all_bootmem().
> >  ^H
> >            ^H ^H ^H ^H ^H                                   $
> > PROMLIB: Root node compatible:
> > Linux version 2.6.17-gentoo-r5 (root@bender) (gcc version 3.4.6
> > (Gentoo Linux 3.4.6)) #1 SMP Fri Aug 25 09:10:34 UTC 2006
> > ARCH: SUN4U
> > Ethernet address: 00:03:ba:69:0e:32
> > Built 1 zonelists
> > Kernel command line: root=3D/dev/ram0 init=3D/linuxrc looptype=3Dsquash=
fs
> > loop=3D/image.squashfs cdroot
> > PID hash table entries: 4096 (order: 12, 32768 bytes)
> > Console: colour dummy device 80x25
> > Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
> > Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
> > Memory: 8306040k available (2536k kernel code, 1584k data, 176k init)
> > [fffff80000000000,000000b0ffaa8000]
> > Calibrating delay using timer specific routine.. 20.00 BogoMIPS (lpj@00=
8)
> > Mount-cache hash table entries: 512
> > CPU[3]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)]
> > E[sz(8388608):line_sz(512)]
> > Using max_cache_size of 8MB
> > Calibrating delay using timer specific routine.. 20.00 BogoMIPS (lpj@00=
1)
> > CPU[0]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)]
> > E[sz(8388608):line_sz(512)]
> > CPU 0: synchronized TICK with master CPU (last diff -1 cycles,maxerr 11=
 cycles)
> > Calibrating delay using timer specific routine.. 20.00 BogoMIPS (lpj@00=
1)
> > CPU[1]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)]
> > E[sz(8388608):line_sz(512)]
> > CPU 1: synchronized TICK with master CPU (last diff 0 cycles,maxerr 10 =
cycles)
> > Calibrating delay using timer specific routine.. 20.00 BogoMIPS (lpj@00=
1)
> > CPU[2]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)]
> > E[sz(8388608):line_sz(512)]
> > CPU 2: synchronized TICK with master CPU (last diff -1 cycles,maxerr 10=
 cycles)
> > Brought up 4 CPUs
> > Total of 4 processors activated (80.00 BogoMIPS).
> > migration_costd942
> > checking if image is initramfs... it is
> > Freeing initrd memory: 629k freed
> > NET: Registered protocol family 16
> > PCI: Probing for controllers.
> > SCHIZO0 PBMB: ver[7:0], portid 8, cregs[40004400000] pregs[40004700000]
> > SCHIZO0 PBMB: PCI CFG[7ffee000000] IO[7ffef000000] MEM[7fe00000000]
> > SCHIZO0 PBMA: ver[7:0], portid 8, cregs[40004400000] pregs[40004600000]
> > SCHIZO0 PBMA: PCI CFG[7ffec000000] IO[7ffed000000] MEM[7fd00000000]
> > SCHIZO1 PBMB: ver[7:0], portid 9, cregs[40004c00000] pregs[40004f00000]
> > SCHIZO1 PBMB: PCI CFG[7ffea000000] IO[7ffeb000000] MEM[7fc00000000]
> > SCHIZO1 PBMA: ver[7:0], portid 9, cregs[40004c00000] pregs[40004e00000]
> > SCHIZO1 PBMA: PCI CFG[7ffe8000000] IO[7ffe9000000] MEM[7fb00000000]
> > PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[1d]
> > PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[1f]
> > PCI1(PBMB): Bus running at 33MHz
> > PCI1(PBMA): Bus running at 66MHz
> > PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[1c]
> > PCI-IRQ: Routing bus[ 0] slot[ 5] to INO[18]
> > PCI0(PBMB): Bus running at 33MHz
> > PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[00]
> > PCI-IRQ: Routing bus[ 0] slot[ 2] to INO[04]
> > PCI0(PBMA): Bus running at 66MHz
> > ebus0: [flashprom] [bbc] [power] [i2c -> (fru) (fru) (fru) (fru) (fru)
> > (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) $
> > power: Control reg at 000007fc7e30002e ... not using powerd.
> > SCSI subsystem initialized
> > NET: Registered protocol family 2
> > IP route cache hash table entries: 262144 (order: 8, 2097152 bytes)
> > TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
> > TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
> > TCP: Hash tables configured (established 524288 bind 65536)
> > TCP reno registered
> > chmc0: US3 memory controller at 0000040000400000 [ACTIVE]
> > chmc1: US3 memory controller at 0000040000c00000 [ACTIVE]
> > chmc2: US3 memory controller at 0000040001400000 [ACTIVE]
> > chmc3: US3 memory controller at 0000040001c00000 [ACTIVE]
> > Total HugeTLB memory allocated, 0
> > squashfs: version 3.0 (2006/03/15) Phillip Lougher
> > Initializing Cryptographic API
> > io scheduler noop registered
> > io scheduler anticipatory registered (default)
> > io scheduler deadline registered
> > io scheduler cfq registered
> > Console: switching to mono PROM 80x34
> > Real Time Clock Driver v1.12ac
> > ttyS0 at MMIO 0x7fc7e400000 (irq =3D 8675776) is a SAB82532 V3.2
> > Console: ttyS0 (SAB82532)
> > ttyS1 at MMIO 0x7fc7e400040 (irq =3D 8675776) is a SAB82532 V3.2
> > mice: PS/2 mouse device common for all mice
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> > loop: loaded (max 8 devices)
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebu=
s=3Dxx
> > QLogic Fibre Channel HBA Driver
> > qla2200 0000:00:02.0: Found an ISP2200, irq 8672768, iobase 0x000007fd0=
0400000
> > qla2200 0000:00:02.0: Configuring PCI space...
> > qla2200 0000:00:02.0: Configure NVRAM parameters...
> > qla2200 0000:00:02.0: Inconsistent NVRAM detected: checksum=3D0x0 id=3D=
=FF
> > version=3D0xff.
> > qla2200 0000:00:02.0: Falling back to functioning (yet invalid --
> > WWPN) defaults.
> > qla2200 0000:00:02.0: Verifying loaded RISC code...
> > qla2200 0000:00:02.0: LIP reset occured (f7ef).
> > qla2200 0000:00:02.0: Waiting for LIP to complete...
> > qla2200 0000:00:02.0: LIP occured (f7ef).
> > qla2200 0000:00:02.0: LOOP UP detected (1 Gbps).
> > qla2200 0000:00:02.0: Topology - (Loop), Host Loop address 0x7
> > scsi0 : qla2xxx
> > qla2200 0000:00:02.0:
> >  QLogic Fibre Channel HBA Driver: 8.01.04-k-fw
> >   QLogic QLA22xx -
> >   ISP2200: PCI (66 MHz) @ 0000:00:02.0 hdma-, host#=3D0, fw=3D2.02.08 TP
> > sym0: <875> rev 0x4 at pci 0001:00:01.0 irq 8,21c
> >   Vendor: FUJITSU   Model: MAP3735F SUN72G   Rev: 1201
> >   Type:   Direct-Access                      ANSI SCSI revision: 04
> >   Vendor: FUJITSU   Model: MAP3735F SUN72G   Rev: 1201
> >   Type:   Direct-Access     sym0: No NVRAM, ID 7, Fast-20, SE, parity
> > checking
> > sym0: SCSI BUS has been reset.
> > scsi1 : sym-2.2.3
> >                  ANSI SCSI revision: 04
> >   Vendor: FUJITSU   Model: MAP3735F SUN72G   Rev: 1201
> >   Type:   Direct-Access                      ANSI SCSI revision: 04
> >   Vendor: FUJITSU   Model: MAP3735F SUN72G   Rev: 1201
> >   Type:   Direct-Access                      ANSI SCSI revision: 04
> >   Vendor: FUJITSU   Model: MAP3735F SUN72G   Rev: 1201
> >   Type:   Direct-Access                      ANSI SCSI revision: 04
> >   Vendor: FUJITSU   Model: MAP3735F SUN72G   Rev: 1201
> >   Type:   Direct-Access                      ANSI SCSI revision: 04
> >   Vendor: SUNW      Model: SUNWGS INT FCBPL  Rev: 922A
> >   Type:   Enclosure                          ANSI SCSI revision: 03
> >   Vendor: SEAGATE   Model: ST314680FSUN146G  Rev: 0307
> >   Type:   Direct-Access                      ANSI SCSI revision: 03
> >   Vendor: SEAGATE   Model: ST314680FSUN146G  Rev: 0307
> >   Type:   Direct-Access                      ANSI SCSI revision: 03
> >   Vendor: SEAGATE   Model: ST314680FSUN146G  Rev: 0307
> >   Type:   Direct-Access                      ANSI SCSI revision: 03
> >   Vendor: SEAGATE   Model: ST314680FSUN146G  Rev: 0307
> >   Type:   Direct-Access                      ANSI SCSI revision: 03
> >   Vendor: SEAGATE   Model: ST314680FSUN146G  Rev: 0307
> >   Type:   Direct-Access                      ANSI SCSI revision: 03
> >   Vendor: SEAGATE   Model: ST314680FSUN146G  Rev: 0307
> >   Type:   Direct-Access                      ANSI SCSI revision: 03
> >   Vendor: TOSHIBA   Model: DVD-ROM SD-M1711  Rev: 1005
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> >  target1:0:6: Beginning Domain Validation
> >  target1:0:6: asynchronous
> >  target1:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
> >  target1:0:6: Domain Validation skipping write tests
> >  target1:0:6: Ending Domain Validation
> > megasas: 00.00.02.04 Fri Feb 03 14:31:44 PST 2006
> > SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
> > sda: Write Protect is off
> > SCSI device sda: drive cache: write through
> > SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
> > sda: Write Protect is off
> > SCSI device sda: drive cache: write through
> >  sda: sda1 sda2 sda3 sda8
> > sd 0:0:0:0: Attached scsi disk sda
> > SCSI device sdb: 143374738 512-byte hdwr sectors (73408 MB)
> > sdb: Write Protect is off
> > SCSI device sdb: drive cache: write through
> > SCSI device sdb: 143374738 512-byte hdwr sectors (73408 MB)
> > sdb: Write Protect is off
> > SCSI device sdb: drive cache: write through
> >  sdb: sdb1 sdb2 sdb3 sdb7
> > sd 0:0:1:0: Attached scsi disk sdb
> > SCSI device sdc: 143374738 512-byte hdwr sectors (73408 MB)
> > sdc: Write Protect is off
> > SCSI device sdc: drive cache: write through
> > SCSI device sdc: 143374738 512-byte hdwr sectors (73408 MB)
> > sdc: Write Protect is off
> > SCSI device sdc: drive cache: write through
> >  sdc: sdc1 sdc2 sdc3 sdc7
> > sd 0:0:2:0: Attached scsi disk sdc
> > SCSI device sdd: 143374738 512-byte hdwr sectors (73408 MB)
> > sdd: Write Protect is off
> > SCSI device sdd: drive cache: write through
> > SCSI device sdd: 143374738 512-byte hdwr sectors (73408 MB)
> > sdd: Write Protect is off
> > SCSI device sdd: drive cache: write through
> >  sdd: sdd1 sdd2 sdd3 sdd7
> > sd 0:0:3:0: Attached scsi disk sdd
> > SCSI device sde: 143374738 512-byte hdwr sectors (73408 MB)
> > sde: Write Protect is off
> > SCSI device sde: drive cache: write through
> > SCSI device sde: 143374738 512-byte hdwr sectors (73408 MB)
> > sde: Write Protect is off
> > SCSI device sde: drive cache: write through
> >  sde: sde1 sde2 sde3 sde7
> > sd 0:0:4:0: Attached scsi disk sde
> > SCSI device sdf: 143374738 512-byte hdwr sectors (73408 MB)
> > sdf: Write Protect is off
> > SCSI device sdf: drive cache: write through
> > SCSI device sdf: 143374738 512-byte hdwr sectors (73408 MB)
> > sdf: Write Protect is off
> > SCSI device sdf: drive cache: write through
> >  sdf: sdf1 sdf2 sdf3 sdf7
> > sd 0:0:5:0: Attached scsi disk sdf
> > SCSI device sdg: 286739329 512-byte hdwr sectors (146811 MB)
> > sdg: Write Protect is off
> > SCSI device sdg: drive cache: write through w/ FUA
> > SCSI device sdg: 286739329 512-byte hdwr sectors (146811 MB)
> > sdg: Write Protect is off
> > SCSI device sdg: drive cache: write through w/ FUA
> >  sdg: sdg1 sdg2 sdg3 sdg7
> > sd 0:0:7:0: Attached scsi disk sdg
> > SCSI device sdh: 286739329 512-byte hdwr sectors (146811 MB)
> > sdh: Write Protect is off
> > SCSI device sdh: drive cache: write through w/ FUA
> > SCSI device sdh: 286739329 512-byte hdwr sectors (146811 MB)
> > sdh: Write Protect is off
> > SCSI device sdh: drive cache: write through w/ FUA
> >  sdh: sdh1 sdh2 sdh3 sdh7
> > sd 0:0:8:0: Attached scsi disk sdh
> > SCSI device sdi: 286739329 512-byte hdwr sectors (146811 MB)
> > sdi: Write Protect is off
> > SCSI device sdi: drive cache: write through w/ FUA
> > SCSI device sdi: 286739329 512-byte hdwr sectors (146811 MB)
> > sdi: Write Protect is off
> > SCSI device sdi: drive cache: write through w/ FUA
> >  sdi: sdi1 sdi2 sdi3 sdi7
> > sd 0:0:9:0: Attached scsi disk sdi
> > SCSI device sdj: 286739329 512-byte hdwr sectors (146811 MB)
> > sdj: Write Protect is off
> > SCSI device sdj: drive cache: write through w/ FUA
> > SCSI device sdj: 286739329 512-byte hdwr sectors (146811 MB)
> > sdj: Write Protect is off
> > SCSI device sdj: drive cache: write through w/ FUA
> >  sdj: sdj1 sdj2 sdj3 sdj7
> > sd 0:0:10:0: Attached scsi disk sdj
> > SCSI device sdk: 286739329 512-byte hdwr sectors (146811 MB)
> > sdk: Write Protect is off
> > SCSI device sdk: drive cache: write through w/ FUA
> > SCSI device sdk: 286739329 512-byte hdwr sectors (146811 MB)
> > sdk: Write Protect is off
> > SCSI device sdk: drive cache: write through w/ FUA
> >  sdk: sdk1 sdk2 sdk3 sdk7
> > sd 0:0:11:0: Attached scsi disk sdk
> > SCSI device sdl: 286739329 512-byte hdwr sectors (146811 MB)
> > sdl: Write Protect is off
> > SCSI device sdl: drive cache: write through w/ FUA
> > SCSI device sdl: 286739329 512-byte hdwr sectors (146811 MB)
> > sdl: Write Protect is off
> > SCSI device sdl: drive cache: write through w/ FUA
> >  sdl: sdl1 sdl2 sdl3 sdl7
> > sd 0:0:12:0: Attached scsi disk sdl
> > sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
> > Uniform CD-ROM driver Revision: 3.20
> > Fusion MPT base driver 3.03.09
> > Copyright (c) 1999-2005 LSI Logic Corporation
> > Fusion MPT SPI Host driver 3.03.09
> > Fusion MPT FC Host driver 3.03.09
> > Fusion MPT SAS Host driver 3.03.09
> > Fusion MPT misc device (ioctl) driver 3.03.09
> > mptctl: Registered with Fusion MPT base driver
> > mptctl: /dev/mptctl @ (major,minor=10,220)
> > TCP bic registered
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17=FE>> Loading modules
> > >> Activating mdev
> > >> Making tmpfs for /newroot
> > >> Attempting to mount CD:- /dev/sr0
> > >> CD medium found on /dev/sr0
> > >> Determining root device...
> > >> Determining looptype ...
> > >> Mounting squashfs filesystem
> > >> Copying read-write image contents to tmpfs
> > >> No cdupdate.sh script found, skipping...
> > >> Booting (initramfs)...
> > INIT=FAW^=D6=CD=A5=BD=B9^=C12.86 booting
> >
>
