From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Thu, 16 Oct 2014 12:49:13 +0000
Subject: boot crash in userspace [Re: unaligned accesses in SLAB etc.]
Message-Id: <20141016124913.GC12736@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, Oct 16, 2014 at 10:22:56AM +0300, Meelis Roos wrote:
> > compiler to narrow down what compiles into something non-working with
> > gcc-4.9
>=20
> Yes, I kept gcc-4.6 to help resolving it.

Probably unrelated, but as a datapoint:
On a Enterprise 250 vanilla 3.17.0 crashes also in userspace
with a red state exception shortly after boot. With the wheezy
kernel the system boots sucessfully.

Greetings
  Hermann

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.17.0 (hlauer@abacus) (gcc version 4.6.3 (Deb=
ian 4.6.3-14) ) #1 SMP Mon Oct 13 20:44:31 CEST 2014
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:9f:45:7e
[    0.000000] PAGE_OFFSET is 0xffffff0000000000 (max_phys_bits =3D 40)
[    0.000000] Kernel: Using 4 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 88024 bytes of memory.
[    0.000000] Top of RAM: 0x1fec0000, Total RAM: 0x1feae000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      empty
[    0.000000]   Normal   [mem 0x00000000-0x1febffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x1fdfdfff]
[    0.000000]   node   0: [mem 0x1fe00000-0x1fe99fff]
[    0.000000]   node   0: [mem 0x1feaa000-0x1febffff]
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 7 pages/cpu @ffffff001f000000 s23040 r8192 =
d26112 u4194304
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64856
[    0.000000] Kernel command line: root=3D/dev/md0 ro
[    0.000000] PID hash table entries: 2048 (order: 1, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 524288 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 262144 byte=
s)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 488256K/522936K available (4099K kernel code, 530K r=
wdata, 1272K rodata, 256K init, 6873K bss, 34680K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS%6 to nr_cpu_ids=3D1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:255

<rest available if interesting>

[....] Starting enhanced syslogd: rsyslogd=1B[?25l=1B[?1c
CPU0 RED State Exception

  CPUVersion:  0017.0011.2000.0507
  UPAConfig:   0000.06b6.34c0.803b
  LSU-Control: 0000.0000.0000.0000
  ECErrEnable: 0000.0000.0000.0007

  AFAR:        0000.01fe.0180.2800
  AFSR:        0000.0000.0000.0000

  DMMU SFAR:   0000.0000.f78e.4004
  DMMU SFSR:   0000.0000.0000.0000
  IMMU SFSR:   0000.0000.0000.0011

TL=0000.0000.0000.0005 TT=0000.0000.0000.0064
   TPC=0000.0000.0042.4c80 TnPC=0000.0000.0042.4c84 TSTATE=0000.0000.1104.1=
402
TL=0000.0000.0000.0004 TT=0000.0000.0000.0064
   TPC=0000.0000.0042.4c80 TnPC=0000.0000.0042.4c84 TSTATE=0000.0000.1104.1=
402
TL=0000.0000.0000.0003 TT=0000.0000.0000.0064
   TPC=0000.0000.0042.4c80 TnPC=0000.0000.0042.4c84 TSTATE=0000.0000.1104.1=
402
TL=0000.0000.0000.0002 TT=0000.0000.0000.0064
   TPC=0000.0000.0042.0c80 TnPC=0000.0000.0042.0c84 TSTATE=0000.0000.1104.1=
402
TL=0000.0000.0000.0001 TT=0000.0000.0000.0064
   TPC=0000.0000.0044.cac0 TnPC=0000.0000.0044.cac4 TSTATE=0000.0000.1100.1=
602=EF=BF=BD

--=20
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres=20
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
