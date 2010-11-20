From: Daniel Smolik <marvin@mydatex.cz>
Date: Sat, 20 Nov 2010 18:48:36 +0000
Subject: handover boot console problem
Message-Id: <4CE81804.3000909@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi all,
I upgrade my old E250 with RSC console to 2.6.36 an found that there is som=
e broken with handover early console.

PERCPU: Embedded 6 pages/cpu @fffff80001400000 s18432 r8192 d22528 u4194304
pcpu-alloc: s18432 r8192 d22528 u4194304 alloc=3D1*4194304
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64848
Kernel command line: root=3D/dev/sda1 ro devfs=3Dnomount elevator=CFq sym53=
c8xx.hostid=3D6
PID hash table entries: 2048 (order: 1, 16384 bytes)
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 508200k available (3184k kernel code, 1208k data, 232k init) [fffff=
80000000000,000000001feb0000]
SLUB: Genslabs=14, HWalign2, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=
=3D1
Hierarchical RCU implementation.
	CONFIG_RCU_FANOUT set to non-default value of 32
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:255
clocksource: mult[a0000000] shift[30]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
I am connected to remote RSC console. This is last message. In OBP have inp=
ut and output set to rsc.
I don't know why console is switched to tty0. With 2.6.26 console work norm=
aly.

Regards
	Dan


--=20
Mydatex s r.o.
http://www.mydatex.cz
email: smolik@mydatex.cz
mob: 604200362
tel: 226210085
