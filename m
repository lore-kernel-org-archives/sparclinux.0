From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 23 May 2012 14:32:51 +0000
Subject: Re: [RFC PATCH 0/5] first batch of leon adaptions
Message-Id: <4FBCF513.9090505@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120522200637.GA9804@merkur.ravnborg.org>
In-Reply-To: <20120522200637.GA9804@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

I havn't tested this patch series yet, however I can report that the curren=
t code commited and applied by linus is booting on LEON.

Thanks,
Daniel

PROMLIB: Sun Boot Prom Version 0 Revision 0
Linux version 3.4.0-04843-g9e14dfd (daniel@daniel) (gcc version 4.4.2 (cros=
stoo2
bootconsole [earlyprom0] enabled
ARCH: LEON
TYPE: Leon3 System-on-a-Chip
Ethernet address: 00:00:7c:cc:01:45
CACHE: 2-way associative cache, set size 4k
OF stdout device is: /a::a
PROM: Built device tree with 16716 bytes of memory.
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 29871
Kernel command line: console=3DttyS0,38400 init=3D/sbin/init
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 117120k/131048k available (3780k kernel code, 13928k reserved, 1352=
k da)
NR_IRQS:64
Console: colour dummy device 80x25
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
Calibrating delay loop... 49.35 BogoMIPS (lpj$6784)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
initlevel:0=EArly, 4 registered initcalls
initlevel:1=3Dcore, 12 registered initcalls
NET: Registered protocol family 16
initlevel:2=3Dpostcore, 7 registered initcalls
initlevel:3=3Darch, 1 registered initcalls
initlevel:4=3Dsubsys, 28 registered initcalls
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initlevel:5=3Dfs, 18 registered initcalls
Switching to clocksource timer_cs
FS-Cache: Loaded
CacheFiles: Loaded
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initlevel:6=DEvice, 169 registered initcalls
NFS: Registeringthe id_resolver key type
Key type id_resolver registered
FS-Cache: Netfs 'nfs' registered for caching
ROMFS MTD (C) 2007 Red Hat, Inc.
JFS: nTxBlock =3D 915, nTxLock =3D 7320
msgmni has been set to 228
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: GRLIB APBUART driver
ffd0d754: ttyS0 at MMIO 0x80000100 (irq =3D 5) is a GRLIB/APBUART
grlib-apbuart at 0x80000100, irq 5
ffd0d4ec: ttyS1 at MMIO 0x80000600 (irq =3D 2)GRLIB/APBUART
grlib-apbuart at 0x80000600, irq 2
brd: module loaded
loop: module loaded
greth-mdio: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
uhci_hcd: USB Universal Host Controller Interface driver
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
usbcore: registered new interface driver usbserial_generic
USB Serial support registered for generic
usbserial: USB Serial Driver core
usbcore: registered new interface driver belkin_sa
USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adap=
ter
usbcore: registered new interface driver ftdi_sio
USB Serial support registered for FTDI USB Serial Device
ftdi_sio: v1.6.0:USB FTDI Serial Converters Driver
mousedev: PS/2 mouse device common for all mice
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
initlevel:7=3Dlate, 15 registered initcalls
leon: power management initialized
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 5280k freed
Initializing random number generator... done.
Starting network...

Welcome to Buildroot
buildroot login: root
# ls -al
total 12
drwxr-xr-x    2 root     root             0 Jan :00 .
drwxr-xr-x   16 root     root             0 Jun 10  2011 ..
-rw-r--r--    1 root     root             7 Jan  1 00:00 .ash_history
-rw-r--r--    1 root     root             0 Dec  3  2010 .bash_history
-rw-r--r--    1 root     root           175 Dec  3  2010 .bash_logout
-rw-r--r--    1 root     root           161 Dec  3  2010 .bash_profile
# cat /proc/cpuinfo
cpu             : LEON
fpu             : GRFPU
promlib         : Version 0 Revision 0
prom            : 0.0
type            : leon
ncpus probed    : 1
ncpus active    : 1
CPU0Bogo        : 49.35
CPU0ClkTck      : 50000
MMU type        : LEON
contexts        : 256ache total : 2252800
nocache used    : 156672


On 05/22/2012 10:06 PM, Sam Ravnborg wrote:
> I wanted feedback on the changes in head_32.S and
> decided to send out what I considered ready for now.
>
> This set does not yet include the run-time patching
> as discussed the other day.
> I decided to postpone this until next batch as I have
> not prepared any users of it yet.
>
> But again - main point here is feedback
> on the head_32.S changes as I do not feel too
> familiar with SPARC assembler just yet.
>
> At least it boots on my ss5 box :-)
>
> I am btw. utterly confused by the handling of
> secondary cpus for leon.
> For some reason there is a direct call to
> leon_smp_cpu_startup: in trampoline_32.S.
>
> But sun4m does not need such a trick.
>
> 	Sam
>
> Sam Ravnborg (5):
>        sparc32: whitespace cleanup in head_32.S
>        sparc32: implement proper LEON support in head_32 (before highmem)
>        sparc32: implement proper LEON support in head_32 (after highmem)
>        sparc32: handle leon in cpu.c
>        sparc32: handle leon in irq_32.c
>
>   arch/sparc/include/asm/psr.h |    6 +++
>   arch/sparc/kernel/cpu.c      |   18 ++++----
>   arch/sparc/kernel/head_32.S  |   96 ++++++++++++++++++++++++++++++++---=
-------
>   arch/sparc/kernel/irq_32.c   |   22 +++++----
>   4 files changed, 100 insertions(+), 42 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

