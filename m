Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18D3C17;
	Sat,  9 Aug 2025 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754721767; cv=none; b=ATAhQ9yllcX9e0djmU83zZUrfHUlRQ2Kk+eVQ1addVJablr1BixHSvX0GDdTuYBQ0M8o72JwTKHvQ4JrlrsqwsS9dd1yKmh8EmvFzV4HjjGnUAvb3twgWv5c7xwOtzqZ29z1bQt4UD/iknURTLk0wMC+PGYH/cfr971jHFKZRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754721767; c=relaxed/simple;
	bh=LNbcXDVYF5ES8vFjHqAu2bCDOdr1stBHOjtPpscXSDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDDZfWp+srAWVlC9slBi97XvufpwFP+Z115q0s3a0Dl1MW7t2D2MvIPMRGEvwEQlVli/epyo+fauQqRzpCGmlh5R9qoRf1QMByXC99oQotELsUG30kfyg3VG1cMvpP60ahMEA1ESXvbK0wJsct9lGD5Mrp/SgD2PNb/bgPtXKlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=alQPROrH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="alQPROrH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=z3D0a21tXl+64l49xu7nh9Q51mzNAKYzGi6mCEFupzE=; t=1754721763;
	x=1755326563; b=alQPROrH5WujvhYrR0vSa2jFwFcZuaQoyvjvdiQDU5qaI4U8qloBTr+N4+XE0
	Wo64xUoVImRaAggdOjdVsH/sPskMRjnKeeu8MX2efyLkCwXjiYqjGcbeAJ1N8LesfCAWK5mO01Za3
	XnYlIyqODBBMtLUKEstenUhr8nSrCfxa+mLu2JC3GIzpdLRnFCqqIVZ3Hq7p+e5VuvgJkC/Op0+V/
	qtLBgSHN83ulCwvm7f7pLr9nHVq/+rvmbey0QDEoxVre1Lznq3IHkUeVSvdAz/OnOzJl5AQeWrEgN
	gNGTURkZV8UVApeg/FAiy8Irk6sxLJxqsjL46yEiMSWEcevGFA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ukdHt-00000000w5c-0T3l; Sat, 09 Aug 2025 08:42:41 +0200
Received: from dynamic-002-245-158-117.2.245.pool.telefonica.de ([2.245.158.117] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ukdHs-00000002YlK-1ivi; Sat, 09 Aug 2025 08:42:41 +0200
Message-ID: <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Sat, 09 Aug 2025 08:42:37 +0200
In-Reply-To: <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
				 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
				 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
			 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
		 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
	 <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Anthony,

On Sat, 2025-08-09 at 08:26 +0200, John Paul Adrian Glaubitz wrote:
> > OK, first data point: Setting CONFIG_TRANSPARENT_HUGEPAGE_NEVER=3Dy cau=
ses the backtrace during
> > boot to disappear with CONFIG_TRANSPARENT_HUGEPAGE=3Dy. However, it sti=
ll disappears later when
> > running "apt update && apt -y upgrade" again:
>=20
> That was meant to say "it appears later", of course.
>=20
> So, again. No backtrace during boot with CONFIG_TRANSPARENT_HUGEPAGE_NEVE=
R=3Dy but later when
> running apt.

Here is the full dmesg output with CONFIG_DEBUG_VM, CONFIG_DEBUG_VM_IRQSOFF=
 and CONFIG_DEBUG_VM_PGFLAGS
enabled. Caputuring the backtrace after running up was not possible as the =
machine locked up completely.

[    0.000028] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.33 2007/06/18 12:45'
[    0.000050] PROMLIB: Root node compatible:=20
[    0.000121] Linux version 6.16.0+ (glaubitz@node54) (sparc64-suse-linux-=
gcc (SUSE Linux) 11.3.0, GNU ld (GNU Binutils; SUSE Linux Enterprise 15) 2.=
43.1.20241209-150100.7.52) #36 SMP Sat Aug  9
06:19:23 UTC 2025
[    0.000201] printk: legacy bootconsole [earlyprom0] enabled
[    0.418616] ARCH: SUN4U
[    0.447856] Ethernet address: 00:03:ba:15:17:4e
[    0.502076] MM: PAGE_OFFSET is 0xfff0000000000000 (max_phys_bits =3D=3D =
42)
[    0.581235] MM: VMALLOC [0x0000000100000000 --> 0x000c000000000000]
[    0.656203] MM: VMEMMAP [0x000c000000000000 --> 0x0018000000000000]
[    0.755106] Kernel: Using 6 locked TLB entries for main kernel image.
[    0.832144] Remapping the kernel...=20
[    0.832784] done.
[    1.069989] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    1.143962] PROM: Built device tree with 138544 bytes of memory.
[    1.219257] NODE_DATA(0) allocated [mem 0x23fe72340-0x23fe73dff]
[    1.368961] Allocated 24576 bytes for kernel page tables.
[    1.433729] Zone ranges:
[    1.464003]   Normal   [mem 0x0000000000000000-0x000000023fec9fff]
[    1.537931] Movable zone start for each node
[    1.588983] Early memory node ranges
[    1.631717]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    1.706687]   node   0: [mem 0x0000000200000000-0x000000023effdfff]
[    1.781654]   node   0: [mem 0x000000023f000000-0x000000023fd9ffff]
[    1.856620]   node   0: [mem 0x000000023fdb0000-0x000000023fdc5fff]
[    1.931588]   node   0: [mem 0x000000023fdca000-0x000000023fe99fff]
[    2.006556]   node   0: [mem 0x000000023fea0000-0x000000023feaffff]
[    2.081524]   node   0: [mem 0x000000023fec4000-0x000000023fec9fff]
[    2.156494] Initmem setup node 0 [mem 0x0000000000000000-0x000000023fec9=
fff]
[    2.241080] Initmem setup node 1 as memoryless
[    2.294511] Initmem setup node 2 as memoryless
[    2.347954] Initmem setup node 3 as memoryless
[    2.401400] Initmem setup node 4 as memoryless
[    2.454845] Initmem setup node 5 as memoryless
[    2.508289] Initmem setup node 6 as memoryless
[    2.561732] Initmem setup node 7 as memoryless
[    2.615175] Initmem setup node 8 as memoryless
[    2.668617] Initmem setup node 9 as memoryless
[    2.722063] Initmem setup node 10 as memoryless
[    2.776548] Initmem setup node 11 as memoryless
[    2.831030] Initmem setup node 12 as memoryless
[    2.885514] Initmem setup node 13 as memoryless
[    2.939999] Initmem setup node 14 as memoryless
[    2.994484] Initmem setup node 15 as memoryless
[    3.048968] Initmem setup node 16 as memoryless
[    3.103453] Initmem setup node 17 as memoryless
[    3.157935] Initmem setup node 18 as memoryless
[    3.212420] Initmem setup node 19 as memoryless
[    3.266905] Initmem setup node 20 as memoryless
[    3.321388] Initmem setup node 21 as memoryless
[    3.375871] Initmem setup node 22 as memoryless
[    3.430356] Initmem setup node 23 as memoryless
[    3.484838] Initmem setup node 24 as memoryless
[    3.539324] Initmem setup node 25 as memoryless
[    3.593810] Initmem setup node 26 as memoryless
[    3.648293] Initmem setup node 27 as memoryless
[    3.702778] Initmem setup node 28 as memoryless
[    3.757261] Initmem setup node 29 as memoryless
[    3.811744] Initmem setup node 30 as memoryless
[    3.866229] Initmem setup node 31 as memoryless
[    3.960015] On node 0, zone Normal: 1 pages in unavailable ranges
[    4.032976] On node 0, zone Normal: 8 pages in unavailable ranges
[    4.105874] On node 0, zone Normal: 2 pages in unavailable ranges
[    4.178749] On node 0, zone Normal: 3 pages in unavailable ranges
[    4.251637] On node 0, zone Normal: 10 pages in unavailable ranges
[    4.325587] On node 0, zone Normal: 155 pages in unavailable ranges
[    4.400532] Booting Linux...
[    4.434948] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    4.511993] CPU CAPS: [v8plus,vis,vis2]
[    4.564722] percpu: Embedded 14 pages/cpu s74968 r8192 d31528 u4194304
[    4.643756] pcpu-alloc: s74968 r8192 d31528 u4194304 alloc=3D1*4194304
[    4.643771] pcpu-alloc: [0] 0=20
[    4.646285] Kernel command line: BOOT_IMAGE=3D/vmlinux-6.16.0+ root=3DUU=
ID=3Da8314d10-9c39-438b-9dc4-9db2e05a6530 ro
[    4.766302] Unknown kernel command line parameters "BOOT_IMAGE=3D/vmlinu=
x-6.16.0+", will be passed to user space.
[    4.887097] printk: log buffer data + meta data: 262144 + 917504 =3D 117=
9648 bytes
[    4.978119] Dentry cache hash table entries: 262144 (order: 8, 2097152 b=
ytes, linear)
[    5.073189] Inode-cache hash table entries: 131072 (order: 7, 1048576 by=
tes, linear)
[    5.165908] Sorting __ex_table...
[    5.206168] Fallback order for Node 0: 0=20
[    5.206180] Fallback order for Node 1: 0=20
[    5.206187] Fallback order for Node 2: 0=20
[    5.206192] Fallback order for Node 3: 0=20
[    5.206198] Fallback order for Node 4: 0=20
[    5.206203] Fallback order for Node 5: 0=20
[    5.206209] Fallback order for Node 6: 0=20
[    5.206214] Fallback order for Node 7: 0=20
[    5.206220] Fallback order for Node 8: 0=20
[    5.206225] Fallback order for Node 9: 0=20
[    5.206231] Fallback order for Node 10: 0=20
[    5.206237] Fallback order for Node 11: 0=20
[    5.206243] Fallback order for Node 12: 0=20
[    5.206248] Fallback order for Node 13: 0=20
[    5.206254] Fallback order for Node 14: 0=20
[    5.206259] Fallback order for Node 15: 0=20
[    5.206265] Fallback order for Node 16: 0=20
[    5.206271] Fallback order for Node 17: 0=20
[    5.206277] Fallback order for Node 18: 0=20
[    5.206282] Fallback order for Node 19: 0=20
[    5.206288] Fallback order for Node 20: 0=20
[    5.206293] Fallback order for Node 21: 0=20
[    5.206299] Fallback order for Node 22: 0=20
[    5.206304] Fallback order for Node 23: 0=20
[    5.206310] Fallback order for Node 24: 0=20
[    5.206315] Fallback order for Node 25: 0=20
[    5.206321] Fallback order for Node 26: 0=20
[    5.206326] Fallback order for Node 27: 0=20
[    5.206332] Fallback order for Node 28: 0=20
[    5.206338] Fallback order for Node 29: 0=20
[    5.206343] Fallback order for Node 30: 0=20
[    5.206348] Fallback order for Node 31: 0=20
[    5.206357] Built 1 zonelists, mobility grouping on.  Total pages: 26196=
5
[    6.844310] Policy zone: Normal
[    6.881848] mem auto-init: stack:off, heap alloc:off, heap free:off
[    7.009331] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D32
[    7.089245] rcu: Hierarchical RCU implementation.
[    7.145533] rcu: 	RCU event tracing is enabled.
[    7.199704] rcu: 	RCU restricting CPUs from NR_CPUS=3D4096 to nr_cpu_ids=
=3D1.
[    7.280912] 	Tracing variant of Tasks RCU enabled.
[    7.338203] rcu: RCU calculated value of scheduler-enlistment delay is 1=
0 jiffies.
[    7.428765] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    7.508955] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D1.
[    7.625622] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
[    7.695587] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    7.777833] clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x2=
c47f4ee7, max_idle_ns: 440795202497 ns
[    7.897497] clocksource: mult[53555555] shift[24]
[    7.953748] clockevent: mult[3126e98] shift[32]
[    8.008060] Console: colour dummy device 80x25
[    8.061290] printk: legacy console [tty0] enabled
[    8.117620] printk: legacy bootconsole [earlyprom0] disabled
[    8.335327] Calibrating delay using timer specific routine.. 24.00 BogoM=
IPS (lpj=3D120039)
[    8.335348] pid_max: default: 32768 minimum: 301
[    8.335566] Mount-cache hash table entries: 4096 (order: 2, 32768 bytes,=
 linear)
[    8.335605] Mountpoint-cache hash table entries: 4096 (order: 2, 32768 b=
ytes, linear)
[    8.337722] rcu: Hierarchical SRCU implementation.
[    8.337743] rcu: 	Max phase no-delay instances is 1000.
[    8.338177] smp: Bringing up secondary CPUs ...
[    8.338199] smp: Brought up 1 node, 1 CPU
[    8.338434] Memory: 2022448K/2095720K available (8391K kernel code, 8021=
K rwdata, 2168K rodata, 472K init, 1938K bss, 68552K reserved, 0K cma-reser=
ved)
[    8.338861] devtmpfs: initialized
[    8.341519] Performance events:=20
[    8.341529] Testing NMI watchdog ...=20
[    8.541542] OK.
[    8.541580] Supported PMU type is 'ultra3i'
[    8.541914] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 19112604462750000 ns
[    8.541978] posixtimers hash table entries: 512 (order: 0, 8192 bytes, l=
inear)
[    8.542061] futex hash table entries: 8 (512 bytes on 32 NUMA nodes, tot=
al 16 KiB, linear).
[    8.542730] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    8.543663] IRQ pre handler NOT supported.
[    8.543695] IRQ pre handler NOT supported.
[    8.543713] IRQ pre handler NOT supported.
[    8.543730] IRQ pre handler NOT supported.
[    8.543746] IRQ pre handler NOT supported.
[    8.543827] IRQ pre handler NOT supported.
[    8.543906] IRQ pre handler NOT supported.
[    8.543983] IRQ pre handler NOT supported.
[    8.544001] IRQ pre handler NOT supported.
[    8.544018] IRQ pre handler NOT supported.
[    8.544034] IRQ pre handler NOT supported.
[    8.544050] IRQ pre handler NOT supported.
[    8.544269] IRQ pre handler NOT supported.
[    8.545176] IRQ pre handler NOT supported.
[    8.545289] IRQ pre handler NOT supported.
[    8.545355] IRQ pre handler NOT supported.
[    8.545485] IRQ pre handler NOT supported.
[    8.545626] IRQ pre handler NOT supported.
[    8.545741] IRQ pre handler NOT supported.
[    8.545877] IRQ pre handler NOT supported.
[    8.546041] IRQ pre handler NOT supported.
[    8.546062] IRQ pre handler NOT supported.
[    8.546080] IRQ pre handler NOT supported.
[    8.546097] IRQ pre handler NOT supported.
[    8.546114] IRQ pre handler NOT supported.
[    8.546212] IRQ pre handler NOT supported.
[    8.546378] IRQ pre handler NOT supported.
[    8.546551] IRQ pre handler NOT supported.
[    8.546571] IRQ pre handler NOT supported.
[    8.546589] IRQ pre handler NOT supported.
[    8.546613] IRQ pre handler NOT supported.
[    8.546640] IRQ pre handler NOT supported.
[    8.546719] IRQ pre handler NOT supported.
[    8.546815] IRQ pre handler NOT supported.
[    8.548337] pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[    8.548363] pci@1f,700000: PCI IO [io  0x7f601000000-0x7f601ffffff] offs=
et 7f601000000
[    8.548384] pci@1f,700000: PCI MEM [mem 0x7f700000000-0x7f7ffffffff] off=
set 7f700000000
[    8.549720] PCI: Scanning PBM /pci@1f,700000
[    8.549964] schizo f0068950: PCI host bridge to bus 0000:00
[    8.549986] pci_bus 0000:00: Unknown NUMA node; performance will be redu=
ced
[    8.550007] pci_bus 0000:00: root bus resource [io  0x7f601000000-0x7f60=
1ffffff] (bus address [0x0000-0xffffff])
[    8.550030] pci_bus 0000:00: root bus resource [mem 0x7f700000000-0x7f7f=
fffffff] (bus address [0x00000000-0xffffffff])
[    8.550052] pci_bus 0000:00: root bus resource [bus 00]
[    8.550105] pci 0000:00:02.0: [14e4:1648] type 00 class 0x020000
[    8.550122] pci 0000:00:02.0: reg 0x10: [mem 0x7f700200000-0x7f7003fffff=
 64bit]
[    8.550142] pci 0000:00:02.0: reg 0x18: [mem 0x7f700000000-0x7f70000ffff=
 64bit]
[    8.550206] pci 0000:00:02.0: PME# supported from D3hot
[    8.550357] pci 0000:00:02.1: [14e4:1648] type 00 class 0x020000
[    8.550376] pci 0000:00:02.1: reg 0x10: [mem 0x7f700400000-0x7f7005fffff=
 64bit]
[    8.550395] pci 0000:00:02.1: reg 0x18: [mem 0x7f700000000-0x7f70000ffff=
 64bit]
[    8.550442] pci 0000:00:02.1: PME# supported from D3hot
[    8.550570] pci 0000:00:02.1: BAR 2 [mem 0x7f700000000-0x7f70000ffff 64b=
it]: can't claim; address conflict with 0000:00:02.0 [mem 0x7f700000000-0x7=
f70000ffff 64bit]
[    8.550774] pci@1e,600000: TOMATILLO PCI Bus Module ver[4:0]
[    8.550793] pci@1e,600000: PCI IO [io  0x7fe01000000-0x7fe01ffffff] offs=
et 7fe01000000
[    8.550811] pci@1e,600000: PCI MEM [mem 0x7ff00000000-0x7ffffffffff] off=
set 7ff00000000
[    8.552155] PCI: Scanning PBM /pci@1e,600000
[    8.552712] schizo f0071294: PCI host bridge to bus 0001:00
[    8.552731] pci_bus 0001:00: Unknown NUMA node; performance will be redu=
ced
[    8.552751] pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe0=
1ffffff] (bus address [0x0000-0xffffff])
[    8.552774] pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7fff=
fffffff] (bus address [0x00000000-0xffffffff])
[    8.552796] pci_bus 0001:00: root bus resource [bus 00]
[    8.552845] pci 0001:00:07.0: [10b9:1533] type 00 class 0x060100
[    8.552863] pci 0001:00:07.0: reg 0x10: [io  0x7fe01000000-0x7fe0100ffff=
]
[    8.552879] pci 0001:00:07.0: reg 0x14: [mem 0x7ff00000000-0x7ff000fffff=
]
[    8.552895] pci 0001:00:07.0: reg 0x18: [mem 0x7ff00000000-0x7ff000fffff=
]
[    8.553081] pci 0001:00:06.0: [10b9:7101] type 00 class 0x000000
[    8.553100] pci 0001:00:06.0: reg 0x10: [io  0x7fe01000000-0x7fe0100000f=
]
[    8.553128] pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] c=
laimed by ali7101 ACPI
[    8.553149] pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] c=
laimed by ali7101 SMB
[    8.553277] pci 0001:00:0a.0: [10b9:5237] type 00 class 0x0c0310
[    8.553295] pci 0001:00:0a.0: reg 0x10: [mem 0x7ff01000000-0x7ff01ffffff=
]
[    8.553331] pci 0001:00:0a.0: PME# supported from D3cold
[    8.553466] pci 0001:00:0d.0: [10b9:5229] type 00 class 0x0101ff
[    8.553484] pci 0001:00:0d.0: reg 0x10: [io  0x7fe01000900-0x7fe01000907=
]
[    8.553501] pci 0001:00:0d.0: reg 0x14: [io  0x7fe01000918-0x7fe0100091f=
]
[    8.553517] pci 0001:00:0d.0: reg 0x18: [io  0x7fe01000910-0x7fe01000917=
]
[    8.553532] pci 0001:00:0d.0: reg 0x1c: [io  0x7fe01000908-0x7fe0100090f=
]
[    8.553547] pci 0001:00:0d.0: reg 0x20: [io  0x7fe01000920-0x7fe0100092f=
]
[    8.553671] pci 0001:00:07.0: BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: c=
an't claim; address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100=
061f]
[    8.553699] pci 0001:00:07.0: BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: c=
an't claim; address conflict with 0001:00:07.0 [mem 0x7ff00000000-0x7ff000f=
ffff]
[    8.553939] pci@1c,600000: TOMATILLO PCI Bus Module ver[4:0]
[    8.553959] pci@1c,600000: PCI IO [io  0x7ce01000000-0x7ce01ffffff] offs=
et 7ce01000000
[    8.553976] pci@1c,600000: PCI MEM [mem 0x7cf00000000-0x7cfffffffff] off=
set 7cf00000000
[    8.555350] PCI: Scanning PBM /pci@1c,600000
[    8.555726] schizo f00798e4: PCI host bridge to bus 0002:00
[    8.555749] pci_bus 0002:00: Unknown NUMA node; performance will be redu=
ced
[    8.555769] pci_bus 0002:00: root bus resource [io  0x7ce01000000-0x7ce0=
1ffffff] (bus address [0x0000-0xffffff])
[    8.555793] pci_bus 0002:00: root bus resource [mem 0x7cf00000000-0x7cff=
fffffff] (bus address [0x00000000-0xffffffff])
[    8.555814] pci_bus 0002:00: root bus resource [bus 00]
[    8.555879] pci 0002:00:02.0: [1000:0021] type 00 class 0x010000
[    8.555897] pci 0002:00:02.0: reg 0x10: [io  0x7ce01000900-0x7ce010009ff=
]
[    8.555913] pci 0002:00:02.0: reg 0x14: [mem 0x7cf00100000-0x7cf00101fff=
 64bit]
[    8.555931] pci 0002:00:02.0: reg 0x1c: [mem 0x7cf00102000-0x7cf00103fff=
 64bit]
[    8.555977] pci 0002:00:02.0: supports D1 D2
[    8.556122] pci 0002:00:02.1: [1000:0021] type 00 class 0x010000
[    8.556141] pci 0002:00:02.1: reg 0x10: [io  0x7ce01000a00-0x7ce01000aff=
]
[    8.556157] pci 0002:00:02.1: reg 0x14: [mem 0x7cf00104000-0x7cf00105fff=
 64bit]
[    8.556175] pci 0002:00:02.1: reg 0x1c: [mem 0x7cf00106000-0x7cf00107fff=
 64bit]
[    8.556212] pci 0002:00:02.1: supports D1 D2
[    8.556525] pci@1d,700000: TOMATILLO PCI Bus Module ver[4:0]
[    8.556545] pci@1d,700000: PCI IO [io  0x7c601000000-0x7c601ffffff] offs=
et 7c601000000
[    8.556563] pci@1d,700000: PCI MEM [mem 0x7c700000000-0x7c7ffffffff] off=
set 7c700000000
[    8.557937] PCI: Scanning PBM /pci@1d,700000
[    8.558160] schizo f0081e80: PCI host bridge to bus 0003:00
[    8.558181] pci_bus 0003:00: Unknown NUMA node; performance will be redu=
ced
[    8.558201] pci_bus 0003:00: root bus resource [io  0x7c601000000-0x7c60=
1ffffff] (bus address [0x0000-0xffffff])
[    8.558223] pci_bus 0003:00: root bus resource [mem 0x7c700000000-0x7c7f=
fffffff] (bus address [0x00000000-0xffffffff])
[    8.558245] pci_bus 0003:00: root bus resource [bus 00]
[    8.558316] pci 0003:00:02.0: [14e4:1648] type 00 class 0x020000
[    8.558334] pci 0003:00:02.0: reg 0x10: [mem 0x7c700200000-0x7c7003fffff=
 64bit]
[    8.558353] pci 0003:00:02.0: reg 0x18: [mem 0x7c700000000-0x7c70000ffff=
 64bit]
[    8.558410] pci 0003:00:02.0: PME# supported from D3hot
[    8.558566] pci 0003:00:02.1: [14e4:1648] type 00 class 0x020000
[    8.558585] pci 0003:00:02.1: reg 0x10: [mem 0x7c700400000-0x7c7005fffff=
 64bit]
[    8.558604] pci 0003:00:02.1: reg 0x18: [mem 0x7c700000000-0x7c70000ffff=
 64bit]
[    8.558651] pci 0003:00:02.1: PME# supported from D3hot
[    8.558779] pci 0003:00:02.1: BAR 2 [mem 0x7c700000000-0x7c70000ffff 64b=
it]: can't claim; address conflict with 0003:00:02.0 [mem 0x7c700000000-0x7=
c70000ffff 64bit]
[    8.570029] HugeTLB: allocation took 0ms with hugepage_allocation_thread=
s=3D1
[    8.570056] HugeTLB: allocation took 0ms with hugepage_allocation_thread=
s=3D1
[    8.570076] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 page=
s
[    8.570090] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    8.570103] HugeTLB: registered 8.00 MiB page size, pre-allocated 0 page=
s
[    8.570116] HugeTLB: 0 KiB vmemmap can be freed for a 8.00 MiB page
[    8.570129] HugeTLB: registered 256 MiB page size, pre-allocated 0 pages
[    8.570141] HugeTLB: 0 KiB vmemmap can be freed for a 256 MiB page
[    8.570155] HugeTLB: registered 2.00 GiB page size, pre-allocated 0 page=
s
[    8.570167] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 GiB page
[    8.587788] SCSI subsystem initialized
[    8.587928] libata version 3.00 loaded.
[    8.588013] usbcore: registered new interface driver usbfs
[    8.588066] usbcore: registered new interface driver hub
[    8.588101] usbcore: registered new device driver usb
[    8.588167] pps_core: LinuxPPS API ver. 1 registered
[    8.588180] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    8.588205] PTP clock support registered
[    8.588879] vgaarb: loaded
[    8.589063] /pci@1e,600000/isa@7/rtc@0,70: RTC regs at 0x7fe01000070
[    8.589831] clocksource: Switched to clocksource stick
[    8.693105] NET: Registered PF_INET protocol family
[    8.693447] IP idents hash table entries: 32768 (order: 5, 262144 bytes,=
 linear)
[    8.695838] tcp_listen_portaddr_hash hash table entries: 1024 (order: 1,=
 16384 bytes, linear)
[    8.695906] Table-perturb hash table entries: 65536 (order: 5, 262144 by=
tes, linear)
[    8.695937] TCP established hash table entries: 16384 (order: 4, 131072 =
bytes, linear)
[    8.696219] TCP bind hash table entries: 16384 (order: 6, 524288 bytes, =
linear)
[    8.697521] TCP: Hash tables configured (established 16384 bind 16384)
[    8.697690] UDP hash table entries: 1024 (order: 3, 65536 bytes, linear)
[    8.697860] UDP-Lite hash table entries: 1024 (order: 3, 65536 bytes, li=
near)
[    8.698208] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    8.698334] pci 0001:00:0a.0: enabling device (0000 -> 0002)
[    8.698403] PCI: CLS 64 bytes, default 64
[    8.698583] Unpacking initramfs...
[    8.700064] power: Control reg at 7fe01000800
[    8.700466] chmc: UltraSPARC-IIIi memory controller at /memory-controlle=
r@0,0
[    8.701174] workingset: timestamp_bits=3D41 max_order=3D18 bucket_order=
=3D0
[    8.850311] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    8.850359] io scheduler mq-deadline registered
[    8.850372] io scheduler kyber registered
[    8.851946] f00a71fc: ttyS0 at MMIO 0x7fe010003f8 (irq =3D 15, base_baud=
 =3D 115387) is a 16550A
[    8.851981] Console: ttyS0 (SU)
[    8.852015] printk: legacy console [ttyS0] enabled
[   29.948586] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   29.948592] rcu: 	(detected by 0, t=3D2109 jiffies, g=3D-1151, q=3D3 ncp=
us=3D1)
[   29.948598] rcu: All QSes seen, last rcu_sched kthread activity 2109 (42=
94939474-4294937365), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
[   29.948607] rcu: rcu_sched kthread starved for 2109 jiffies! g-1151 f0x2=
 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[   29.948615] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM=
 is now expected behavior.
[   29.948618] rcu: RCU grace-period kthread stack dump:
[   29.948621] task:rcu_sched       state:R  running task     stack:0     p=
id:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x07000000
[   29.948637] Call Trace:
[   29.948640] [<0000000000c2bdf4>] schedule+0x14/0x160
[   29.948654] [<0000000000c32d54>] schedule_timeout+0x54/0xe0
[   29.948665] [<00000000004fe240>] rcu_gp_fqs_loop+0x140/0x6c0
[   29.948678] [<000000000050253c>] rcu_gp_kthread+0x23c/0x2a0
[   29.948686] [<000000000049dc88>] kthread+0xe8/0x120
[   29.948696] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   29.948709] [<0000000000000000>] 0x0
[   29.948714] rcu: Stack dump where RCU GP kthread last ran:
[   29.948718] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #36=
 VOLUNTARY=20
[   29.948727] TSTATE: 0000004411001603 TPC: 00000000004dd900 TNPC: 0000000=
0004dd904 Y: 00001702    Not tainted
[   29.948733] TPC: <console_flush_all+0x360/0x4c0>
[   29.948747] g0: 00000000004dd900 g1: 0000000000000000 g2: 00000000000000=
00 g3: 0000000001821000
[   29.948752] g4: fff0000000180000 g5: fff000023d170000 g6: fff00000001580=
00 g7: 000000000000000e
[   29.948757] o0: 00000000018211e0 o1: 0000000000000000 o2: 00000000000000=
00 o3: 00000000018205d0
[   29.948761] o4: 0000000000000000 o5: 00000000018817e8 sp: fff000000015a9=
01 ret_pc: 00000000004dd8f0
[   29.948766] RPC: <console_flush_all+0x350/0x4c0>
[   29.948773] l0: 00000000018205d0 l1: 0000000000000000 l2: 00000000000000=
00 l3: 000000000145f538
[   29.948778] l4: 0000000000000000 l5: 0000000000000001 l6: 00000000015e60=
b0 l7: 000000000155a308
[   29.948783] i0: 0000000000000000 i1: fff000000015b2b8 i2: fff000000015b2=
b3 i3: 0000000000000000
[   29.948787] i4: 00000000018211e0 i5: 0000000000000001 i6: fff000000015aa=
01 i7: 00000000004ddae8
[   29.948792] I7: <console_unlock+0x88/0x120>
[   29.948800] Call Trace:
[   29.948802] [<00000000004ddae8>] console_unlock+0x88/0x120
[   29.948810] [<00000000004de628>] vprintk_emit+0x1e8/0x280
[   29.948818] [<000000000042a3a0>] _printk+0x20/0x30
[   29.948828] [<00000000004deb6c>] register_console+0x34c/0x580
[   29.948837] [<00000000009416f8>] serial_core_register_port+0x898/0x8c0
[   29.948849] [<00000000009468fc>] su_probe+0x15c/0x3e0
[   29.948856] [<00000000009581e8>] platform_probe+0x28/0x80
[   29.948868] [<0000000000955798>] really_probe+0xb8/0x340
[   29.948874] [<0000000000955bc4>] driver_probe_device+0x24/0x120
[   29.948881] [<0000000000955e6c>] __driver_attach+0x8c/0x1a0
[   29.948888] [<000000000095378c>] bus_for_each_dev+0x4c/0xa0
[   29.948894] [<0000000000954ac8>] bus_add_driver+0x148/0x220
[   29.948901] [<0000000000956a94>] driver_register+0x74/0x120
[   29.948908] [<000000000165a150>] sunsu_init+0x180/0x1dc
[   29.948917] [<00000000004367b0>] do_one_initcall+0x30/0x240
[   29.948926] [<0000000001631014>] kernel_init_freeable+0x244/0x2b8
[   36.081726] Freeing initrd memory: 10872K
[   36.135456] f00a8d7c: ttyS1 at MMIO 0x7fe010002e8 (irq =3D 15, base_baud=
 =3D 115387) is a 16550A
[   36.247159] pata_ali 0001:00:0d.0: enabling device (0004 -> 0005)
[   36.328511] scsi host0: pata_ali
[   36.371269] scsi host1: pata_ali
[   36.413710] ata1: PATA max UDMA/100 cmd 0x7fe01000900 ctl 0x7fe01000918 =
bmdma 0x7fe01000920 irq 18 lpm-pol 0
[   36.542953] ata2: PATA max UDMA/100 cmd 0x7fe01000910 ctl 0x7fe01000908 =
bmdma 0x7fe01000928 irq 18 lpm-pol 0
[   36.672814] ohci-pci 0001:00:0a.0: OHCI PCI host controller
[   36.746038] ohci-pci 0001:00:0a.0: new USB bus registered, assigned bus =
number 1
[   36.843611] ohci-pci 0001:00:0a.0: irq 17, io mem 0x7ff01000000
[   36.921786] ata1.00: ATAPI: TSSTcorpCD/DVDW TS-L532U, SI02, max UDMA/33
[   37.008775] ata1.00: WARNING: ATAPI DMA disabled for reliability issues.=
  It can be enabled
[   37.118566] ata1.00: WARNING: via pata_ali.atapi_dma modparam or corresp=
onding sysfs node.
[   37.231885] hub 1-0:1.0: USB hub found
[   37.281304] hub 1-0:1.0: 2 ports detected
[   37.335395] rtc_cmos rtc_cmos: error -ENXIO: IRQ index 0 not found
[   37.417064] rtc_cmos rtc_cmos: registered as rtc0
[   37.479161] rtc_cmos rtc_cmos: setting system clock to 2025-08-09T06:59:=
27 UTC (1754722767)
[   37.589355] rtc_cmos rtc_cmos: no alarms, 114 bytes nvram
[   37.660523] scsi 0:0:0:0: CD-ROM            TSSTcorp CD/DVDW TS-L532U SI=
02 PQ: 0 ANSI: 5
[   37.768080] usbcore: registered new interface driver usbhid
[   37.841333] usbhid: USB HID core driver
[   37.892166] NET: Registered PF_INET6 protocol family
[   37.957397] usb 1-1: new low-speed USB device number 2 using ohci-pci
[   38.043046] Segment Routing with IPv6
[   38.091327] In-situ OAM (IOAM) with IPv6
[   38.142939] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   38.221312] NET: Registered PF_PACKET protocol family
[   38.299490] Demotion targets for Node 0: null
[   38.434147] input: Dell Dell QuietKey Keyboard as /devices/root/f0071294=
/pci0001:00/0001:00:0a.0/usb1/1-1/1-1:1.0/0003:413C:2106.0001/input/input0
[   38.607481] This architecture does not have kernel memory protection.
[   38.692231] Run /init as init process
[   38.740289]   with arguments:
[   38.740294]     /init
[   38.740298]   with environment:
[   38.740302]     HOME=3D/
[   38.740306]     TERM=3Dlinux
[   38.740310]     BOOT_IMAGE=3D/vmlinux-6.16.0+
[   38.749973] hid-generic 0003:413C:2106.0001: input: USB HID v1.10 Keyboa=
rd [Dell Dell QuietKey Keyboard] on usb-0001:00:0a.0-1/input0
[   39.466208] tg3 0000:00:02.0: enabling device (0000 -> 0002)
[   39.713238] sym53c8xx 0002:00:02.0: enabling device (0146 -> 0147)
[   39.938727] sym0: <1010-66> rev 0x1 at pci 0002:00:02.0 irq 24
[   40.025921] sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   40.144456] sym0: SCSI BUS has been reset.
[   40.198277] scsi host2: sym-2.2.3
[   40.241845] tg3 0000:00:02.0: VPD access failed.  This is likely a firmw=
are bug on this device.  Contact the card vendor for a firmware update
[   40.461860] sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer cd/rw xa/f=
orm2 cdda tray
[   40.566055] cdrom: Uniform CD-ROM driver Revision: 3.20
[   40.634772] tg3 0000:00:02.0: VPD access failed.  This is likely a firmw=
are bug on this device.  Contact the card vendor for a firmware update
[   40.805443] tg3 0000:00:02.0 eth0: Tigon3 [partno(none) rev 2100] (PCI:6=
6MHz:64-bit) MAC address 00:03:ba:15:17:4e
[   40.941647] tg3 0000:00:02.0 eth0: attached PHY is 5704 (10/100/1000Base=
-T Ethernet) (WireSpeed[1], EEE[0])
[   41.069812] tg3 0000:00:02.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[0] TSOcap[1]
[   41.172840] tg3 0000:00:02.0 eth0: dma_rwctrl[763f0000] dma_mask[64-bit]
[   41.261810] tg3 0000:00:02.1: enabling device (0000 -> 0002)
[   41.336305] tg3 0000:00:02.1: BAR 2: can't reserve [mem size 0x00010000 =
64bit]
[   41.431350] tg3 0000:00:02.1: Cannot obtain PCI resources, aborting
[   41.513806] tg3 0000:00:02.1: probe with driver tg3 failed with error -1=
6
[   41.603169] tg3 0003:00:02.0: enabling device (0000 -> 0002)
[   41.709976] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   41.829722] tg3 0003:00:02.0: VPD access failed.  This is likely a firmw=
are bug on this device.  Contact the card vendor for a firmware update
[   42.129720] tg3 0003:00:02.0: VPD access failed.  This is likely a firmw=
are bug on this device.  Contact the card vendor for a firmware update
[   42.300455] tg3 0003:00:02.0 eth1: Tigon3 [partno(none) rev 2100] (PCI:6=
6MHz:64-bit) MAC address 00:03:ba:15:17:50
[   42.436627] tg3 0003:00:02.0 eth1: attached PHY is 5704 (10/100/1000Base=
-T Ethernet) (WireSpeed[1], EEE[0])
[   42.564810] tg3 0003:00:02.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[0] TSOcap[1]
[   42.667830] tg3 0003:00:02.0 eth1: dma_rwctrl[763f0000] dma_mask[64-bit]
[   42.756452] tg3 0003:00:02.1: enabling device (0000 -> 0002)
[   42.830943] tg3 0003:00:02.1: BAR 2: can't reserve [mem size 0x00010000 =
64bit]
[   42.925914] tg3 0003:00:02.1: Cannot obtain PCI resources, aborting
[   43.008384] tg3 0003:00:02.1: probe with driver tg3 failed with error -1=
6
[   43.107054] tg3 0003:00:02.0 enP3p0s2f0: renamed from eth1
[   43.187131] tg3 0000:00:02.0 enp0s2f0: renamed from eth0
[   43.731423] scsi 2:0:0:0: Direct-Access     HITACHI  HUS15143BSUN146G PA=
04 PQ: 0 ANSI: 3
[   43.837936] scsi target2:0:0: tagged command queuing enabled, command qu=
eue depth 16.
[   43.959710] scsi target2:0:0: Beginning Domain Validation
[   44.038800] scsi target2:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, =
offset 31)
[   44.143551] scsi 2:0:0:0: Power-on or device reset occurred
[   44.225556] scsi target2:0:0: Ending Domain Validation
[   44.297767] scsi 2:0:1:0: Direct-Access     FUJITSU  MAX3147NCSUN146G 15=
03 PQ: 0 ANSI: 4
[   44.404246] sd 2:0:0:0: [sda] 286739329 512-byte logical blocks: (147 GB=
/137 GiB)
[   44.502640] scsi target2:0:1: tagged command queuing enabled, command qu=
eue depth 16.
[   44.607368] sd 2:0:0:0: [sda] Write Protect is off
[   44.670341] sd 2:0:0:0: [sda] Mode Sense: e3 00 10 08
[   44.670365] scsi target2:0:1: Beginning Domain Validation
[   44.745399] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[   44.861450] scsi target2:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, =
offset 31)
[   44.967471] scsi 2:0:1:0: Power-on or device reset occurred
[   45.087828]  sda: sda1 sda2 sda3 sda4
[   45.141451] sd 2:0:0:0: [sda] Attached SCSI disk
[   45.204383] scsi target2:0:1: Ending Domain Validation
[   45.854271] sd 2:0:1:0: [sdb] 286739329 512-byte logical blocks: (147 GB=
/137 GiB)
[   46.444081] sd 2:0:1:0: [sdb] Write Protect is off
[   46.506999] sd 2:0:1:0: [sdb] Mode Sense: c7 00 00 08
[   47.623729] sd 2:0:1:0: [sdb] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[   49.098634] sym53c8xx 0002:00:02.1: enabling device (0146 -> 0147)
[   49.180576] sym1: <1010-66> rev 0x1 at pci 0002:00:02.1 irq 25
[   49.260335] sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   49.378843] sym1: SCSI BUS has been reset.
[   49.432604] scsi host3: sym-2.2.3
[   49.494560]  sdb: sdb1
[   49.526080] sd 2:0:1:0: [sdb] Attached SCSI disk
[   57.944587] EXT4-fs (sda2): mounted filesystem a8314d10-9c39-438b-9dc4-9=
db2e05a6530 ro with ordered data mode. Quota mode: disabled.
[   59.548859] systemd[1]: Failed to find module 'autofs4'
[   59.739711] systemd[1]: systemd 257.7-1 running in system mode (+PAM +AU=
DIT +SELINUX +APPARMOR +IMA +IPE +SMACK -SECCOMP +GCRYPT -GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC
+KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P1=
1KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -BTF -XKBCO=
MMON -UTMP +SYSVINIT +LIBARCHIVE)
[   60.181448] systemd[1]: Detected architecture sparc64.
[   60.401210] systemd[1]: Hostname set to <raverin>.
[   61.662210] systemd-sysv-generator[140]: SysV service '/etc/init.d/build=
d' lacks a native systemd unit file, automatically generating a unit file f=
or compatibility.
[   61.855664] systemd-sysv-generator[140]: Please update package to includ=
e a native systemd unit file.
[   61.977034] systemd-sysv-generator[140]: =E2=9A=A0=EF=B8=8F This compati=
bility logic is deprecated, expect removal soon. =E2=9A=A0=EF=B8=8F
[   63.339369] systemd[1]: Queued start job for default target graphical.ta=
rget.
[   63.500708] systemd[1]: Created slice system-getty.slice - Slice /system=
/getty.
[   63.712026] systemd[1]: Created slice system-modprobe.slice - Slice /sys=
tem/modprobe.
[   63.931887] systemd[1]: Created slice system-serial\x2dgetty.slice - Sli=
ce /system/serial-getty.
[   64.181824] systemd[1]: Created slice system-systemd\x2dfsck.slice - Sli=
ce /system/systemd-fsck.
[   64.431259] systemd[1]: Created slice user.slice - User and Session Slic=
e.
[   64.619959] systemd[1]: Started systemd-ask-password-console.path - Disp=
atch Password Requests to Console Directory Watch.
[   64.879850] systemd[1]: Started systemd-ask-password-wall.path - Forward=
 Password Requests to Wall Directory Watch.
[   65.129871] systemd[1]: Starting of proc-sys-fs-binfmt_misc.automount - =
Arbitrary Executable File Formats File System Automount Point unsupported.
[   65.429785] systemd[1]: Expecting device dev-disk-by\x2duuid-2b14ad4b\x2=
d10c7\x2d4337\x2da4bd\x2d38cb86a8e79b.device - /dev/disk/by-uuid/2b14ad4b-1=
0c7-4337-a4bd-38cb86a8e79b...
[   65.749684] systemd[1]: Expecting device dev-disk-by\x2duuid-e4125eef\x2=
d3d62\x2d4226\x2d8d9a\x2d9838b6d2c426.device - /dev/disk/by-uuid/e4125eef-3=
d62-4226-8d9a-9838b6d2c426...
[   66.069682] systemd[1]: Expecting device dev-ttyS0.device - /dev/ttyS0..=
.
[   66.239724] systemd[1]: Reached target cryptsetup.target - Local Encrypt=
ed Volumes.
[   66.439752] systemd[1]: Reached target integritysetup.target - Local Int=
egrity Protected Volumes.
[   66.669765] systemd[1]: Reached target paths.target - Path Units.
[   66.849722] systemd[1]: Reached target remote-fs.target - Remote File Sy=
stems.
[   67.039734] systemd[1]: Reached target slices.target - Slice Units.
[   67.219807] systemd[1]: Reached target veritysetup.target - Local Verity=
 Protected Volumes.
[   67.440141] systemd[1]: Listening on syslog.socket - Syslog Socket.
[   67.630027] systemd[1]: Listening on systemd-creds.socket - Credential E=
ncryption/Decryption.
[   67.860026] systemd[1]: Listening on systemd-initctl.socket - initctl Co=
mpatibility Named Pipe.
[   68.089958] systemd[1]: Listening on systemd-journald-dev-log.socket - J=
ournal Socket (/dev/log).
[   68.320053] systemd[1]: Listening on systemd-journald.socket - Journal S=
ockets.
[   68.530037] systemd[1]: Listening on systemd-udevd-control.socket - udev=
 Control Socket.
[   68.749899] systemd[1]: Listening on systemd-udevd-kernel.socket - udev =
Kernel Socket.
[   68.980819] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File S=
ystem...
[   69.190098] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue =
File System...
[   69.450117] systemd[1]: Mounting run-lock.mount - Legacy Locks Directory=
 /run/lock...
[   69.710169] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug F=
ile System...
[   69.970187] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace=
 File System...
[   70.230328] systemd[1]: Starting kmod-static-nodes.service - Create List=
 of Static Device Nodes...
[   70.530332] systemd[1]: Starting modprobe@configfs.service - Load Kernel=
 Module configfs...
[   70.820323] systemd[1]: Starting modprobe@drm.service - Load Kernel Modu=
le drm...
[   71.080361] systemd[1]: Starting modprobe@efi_pstore.service - Load Kern=
el Module efi_pstore...
[   71.370306] systemd[1]: Starting modprobe@fuse.service - Load Kernel Mod=
ule fuse...
[   71.620104] systemd[1]: systemd-fsck-root.service - File System Check on=
 Root Device was skipped because of an unmet condition check (ConditionPath=
Exists=3D!/run/initramfs/fsck-root).
[   71.833050] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hi=
bernate Storage Info was skipped because of an unmet condition check
(ConditionPathExists=3D/sys/firmware/efi/efivars/HibernateLocation-8cf2644b=
-4b0b-428f-9387-6d876050dc67).
[   72.118962] systemd[1]: systemd-journald.service: unit configures an IP =
firewall, but the local system does not support BPF/cgroup firewalling.
[   72.288335] systemd[1]: systemd-journald.service: (This warning is only =
shown for the first unit using IP firewalling.)
[   72.441273] systemd[1]: Starting systemd-journald.service - Journal Serv=
ice...
[   72.684614] systemd-journald[154]: Collecting audit messages is disabled=
.
[   72.810526] systemd[1]: Starting systemd-modules-load.service - Load Ker=
nel Modules...
[   73.200343] systemd[1]: Starting systemd-remount-fs.service - Remount Ro=
ot and Kernel File Systems...
[   73.446942] EXT4-fs (sda2): re-mounted a8314d10-9c39-438b-9dc4-9db2e05a6=
530 r/w.
[   73.590318] systemd[1]: Starting systemd-udev-load-credentials.service -=
 Load udev Rules from Credentials...
[   73.890315] systemd[1]: Starting systemd-udev-trigger.service - Coldplug=
 All udev Devices...
[   74.240333] systemd[1]: Started systemd-journald.service - Journal Servi=
ce.
[   76.472443] systemd-journald[154]: Received client request to flush runt=
ime journal.
[   78.349606] random: crng init done
[   79.504029] sr 0:0:0:0: Attached scsi generic sg0 type 5
[   80.133697] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   80.275546] sd 2:0:1:0: Attached scsi generic sg2 type 0
[   81.376870] Adding 1000096k swap on /dev/sda4.  Priority:-2 extents:1 ac=
ross:1000096k=20
[   83.194980] tg3 0000:00:02.0: Direct firmware load for tigon/tg3_tso.bin=
 failed with error -2
[   83.329895] tg3 0000:00:02.0 enp0s2f0: Failed to load firmware "tigon/tg=
3_tso.bin"
[   83.429513] tg3 0000:00:02.0 enp0s2f0: TSO capability disabled
[   84.815494] tg3 0000:00:02.0 enp0s2f0: No firmware running
[   90.434186] tg3 0000:00:02.0 enp0s2f0: Link is up at 1000 Mbps, full dup=
lex
[   90.525821] tg3 0000:00:02.0 enp0s2f0: Flow control is off for TX and of=
f for RX
[  113.710728] systemd-journald[154]: Time jumped backwards, rotating.

Let me know if you have more suggestions to test. I can also provide you wi=
th full access to this Netra 240
if you send me your public SSH key in a private mail.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
