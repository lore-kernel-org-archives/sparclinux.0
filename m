From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Wed, 07 Mar 2007 17:10:35 +0000
Subject: Re: Sunfire v880
Message-Id: <a728f9f90703070910u2ea6f86cp428daf124ded9fa4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Here's another log this time from 2.6.17.  seems to get a little further:

Rebooting with command: boot net:dhcp -p
Boot device: /pci@9,700000/network@1,1:dhcp  File and args: -p
|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H=
/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^$
PROMLIB: Sun IEEE Boot Prom 'OBP 4.18.2 2005/06/30 07:53'
PROMLIB: Root node compatible:
Linux version 2.6.17-2-sparc64 (Debian 2.6.17-9) (waldi@debian.org)
(gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #1 $
ARCH: SUN4U
Ethernet address: 00:03:ba:69:0e:32
Remapping the kernel... done.
Booting Linux...
CPU[0]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)]
E[sz(8388608):line_sz(512)]
Built 1 zonelists
Kernel command line: -p
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
Memory: 8306520k available (2152k kernel code, 720k data, 144k init)
[fffff80000000000,000000b0ffb0e000]
Calibrating delay using timer specific routine.. 20.00 BogoMIPS (lpj@005)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
checking if image is initramfs... it is
Freeing initrd memory: 2796k freed
NET: Registered protocol family 16
PCI: Probing for controllers.
SCHIZO0 PBMB: ver[7:0], portid 8, cregs[40004400000] pregs[40004700000]
SCHIZO0 PBMB: PCI CFG[7ffee000000] IO[7ffef000000] MEM[7fe00000000]
SCHIZO0 PBMA: ver[7:0], portid 8, cregs[40004400000] pregs[40004600000]
SCHIZO0 PBMA: PCI CFG[7ffec000000] IO[7ffed000000] MEM[7fd00000000]
SCHIZO1 PBMB: ver[7:0], portid 9, cregs[40004c00000] pregs[40004f00000]
SCHIZO1 PBMB: PCI CFG[7ffea000000] IO[7ffeb000000] MEM[7fc00000000]
SCHIZO1 PBMA: ver[7:0], portid 9, cregs[40004c00000] pregs[40004e00000]
SCHIZO1 PBMA: PCI CFG[7ffe8000000] IO[7ffe9000000] MEM[7fb00000000]
PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[1d]
PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[1f]
PCI1(PBMB): Bus running at 33MHz
PCI1(PBMA): Bus running at 66MHz
PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[1c]
PCI-IRQ: Routing bus[ 0] slot[ 5] to INO[18]
PCI0(PBMB): Bus running at 33MHz
PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[00]
PCI-IRQ: Routing bus[ 0] slot[ 2] to INO[04]
PCI0(PBMA): Bus running at 66MHz
ebus0: [flashprom] [bbc] [power] [i2c -> (fru) (fru) (fru) (fru) (fru)
(fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) (fru) $
power: Control reg at 000007fc7e30002e ... not using powerd.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 8, 2097152 bytes)
TCP established hash table entries: 1048576 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
TCP: Hash tables configured (established 1048576 bind 65536)
TCP reno registered
chmc0: US3 memory controller at 0000040000400000 [ACTIVE]
chmc1: US3 memory controller at 0000040000c00000 [ACTIVE]
chmc2: US3 memory controller at 0000040001400000 [ACTIVE]
ERROR(0): Cheetah error trap taken afsr[0010100000000000]
afar[0000040001c00000] TL1(0)
ERROR(0): TPC[424d68] TNPC[424d6c] O7[6e2c30] TSTATE[80001606]
ERROR(0): M_SYND(0),  E_SYND(0), Privileged
ERROR(0): Highest priority error (0000100000000000) "Unmapped error
from system bus"
ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000]
stag[0000000000000000]
ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000]
data2[0000000000000000] data3[0000000000000000]
ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000]
stag[0000000000000000] u[0000000000000000] l[0000000000000000]
ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000]
INSN2[0000000000000000] INSN3[0000000000000000]
ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000]
INSN6[0000000000000000] INSN7[0000000000000000]
ERROR(0): E-cache idx[0] tag[0000000000000000]
ERROR(0): E-cache data0[0000000000000000] data1[0000000000000000]
data2[0000000000000000] data3[0000000000000000]
Kernel panic - not syncing: Irrecoverable deferred error trap.

 <0>Press Stop-A (L1-A) to return to the boot prom


On 3/7/07, Alex Deucher <alexdeucher@gmail.com> wrote:
> On 3/7/07, Alex Deucher <alexdeucher@gmail.com> wrote:
> > On 3/6/07, David Miller <davem@davemloft.net> wrote:
> > > From: "Alex Deucher" <alexdeucher@gmail.com>
> > > Date: Tue, 6 Mar 2007 19:49:11 -0500
> > >
> > > > Had anyone had any success booting Linux on a v880?  We've been try=
ing
> > > > to get various Debian/Ubuntu/Gentoo images up and running on it for
> > > > the last few days, but so far no luck.  Both CD-ROM and netboot
> > > > produce the same results.  We updated the OBP to the lasted version.
> > > > We've tried the video=3Datyfb:off trick but to no avail.  All we ev=
er
> > > > get is "Booting Linux..." and then nothing else.  We tried removing
> > > > the video card and keyboard and mouse, no difference.  Has anyone h=
ad
> > > > any success on the v880?  Any other things we could try?
> > >
> > > If you boot with "-p" what further messages do you get?
> > >
> >
> > "boot net:dhcp =96p":
> >
> > Error: Cheetah error trap taken afsr[ ]
> > Error: TPC[ ] TNPC[ ] TSTATE[ ]
> > Error: M_SYND(0), E_SYND(0), Privileged
> > Error: Highest Priority Error() "Unmapped error from system"
> >
> > Then a bunch of D-cache, I-cache, and E-cache errors.
> >
> > And finally,
> >
> > Kernel Panic =96 not syncing: Irrecoverable deferred error trap
> >
> > BTW, my co-worker eventually got a gentoo CD working (2006.1 minimal II=
RC).
> >
> > Alex
> >
>
> Here's a more complete log:
>
> boot net:dhcp =96p with
> http://people.debian.org/~stappers/d-i/images/daily/sparc64/netboot/2.6/
>
> net boot^H ^H^H ^H^H ^H^H ^H^H ^H^H ^H^H ^H^H ^Hboot net:h^H ^Hdhcp -p
> Boot device: /pci@9,700000/network@1,1:dhcp  File and args: -p
> |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|=
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^$
> PROMLIB: Sun IEEE Boot Prom 'OBP 4.18.2 2005/06/30 07:53'
> PROMLIB: Root node compatible:
> Linux version 2.6.18-4-sparc64 (Debian 2.6.18.dfsg.1-11)
> (waldi@debian.org) (gcc version 4.1.2 20061115 (prerelease) (Debian
> 4.1.1-$
> ARCH: SUN4U
> Ethernet address: 00:03:ba:69:0e:32
> Remapping the kernel... done.
> PROM: Built device tree with 123317 bytes of memory.
> Booting Linux...
> CPU[0]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)]
> E[sz(8388608):line_sz(512)]
> Built 1 zonelists.  Total pages: 1046894
> Kernel command line: -p
> Kernel unaligned access at TPC[43abd8] do_sparc64_fault+0x18/0x5a8
> Kernel unaligned access at TPC[43abd8] do_sparc64_fault+0x18/0x5a8
> Kernel unaligned access at TPC[43abd8] do_sparc64_fault+0x18/0x5a8
> Kernel unaligned access at TPC[43abd8] do_sparc64_fault+0x18/0x5a8
> Kernel unaligned access at TPC[43abd8] do_sparc64_fault+0x18/0x5a8
> Unable to handle kernel paging request at virtual address 66727540302c6000
> spitfire_data_access_exception: SFSR[0000000000800809]
> SFAR[8143e008835182b0], going.
>               \|/ ____ \|/
>               "@'/ .. \`@"
>               /_| \__/ |_\
>                  \__U_/
> ^A(16777216): Dax [#1]
> TSTATE: 0000004400f09603 TPC: 000000000043aad4 TNPC: 000000000043aad8
> Y: 00000000    Not tainted
> TPC: <unhandled_fault+0x4c/0xe0>
> g0: 0000000000000000 g1: 8143e00883518000 g2: 00000000006899e0 g3:
> 0000000000000419
> g4: 0000000000404c6c g5: 0000000000000000 g6: 0000000000681e40 g7:
> 0000000000000000
> o0: 000000000000004e o1: 66727540302c6000 o2: 66727540302c6163 o3:
> 0000000000400000
> o4: 0000000000000002 o5: 0000000000000000 sp: 0000000000681321 ret_pc:
> 000000000043aac0
> RPC: <unhandled_fault+0x38/0xe0>
> l0: 66727540302c6000 l1: 0000000000684350 l2: 0000000000404c6c l3:
> 0000000000000010
> l4: 0000000000000002 l5: 66727540302c6000 l6: 0000000000681e40 l7:
> 0000000080009003
> i0: 66727540302c6000 i1: 0000000000404c6c i2: 0000000000681cc0 i3:
> 00000000c48aa000
> i4: 0000000000000002 i5: 0000000000000080 i6: 0000000000681401 i7:
> 0000000000404c74
> I7: <sparc64_realfault_common+0x18/0x20>
> Instruction DUMP: c25e60d0  22c04002  c25e60d8 <c45862b0> 03000fc7
> 11001909  821063ff  90122240  400036d8
> BUG: warning at kernel/exit.c:854/do_exit()
> Call Trace:
> Kernel panic - not syncing: Aiee, killing interrupt handler!
>  <0>Press Stop-A (L1-A) to return to the boot prom
>
