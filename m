Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E628B41E;
	Fri,  8 Aug 2025 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692643; cv=none; b=KpZqffM5V3M6tU5x1d5SGmW69VIb518CqjrN+fLS4NjkYhH7gwAz+//f13dF7W7MwY8WDJuLuHVYmmEdnvn8EfPL9Xjv2pEuu/9kuQWqKXhocgCHLy66QsBQ2gXDB3r0zvg5D8043Y9tRgsA36lHbybbfZdcJtAb//077C6F6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692643; c=relaxed/simple;
	bh=JHVmu2n/nTTH6LX4nabX1OA53QT7DxKgSG23yl+OzXY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=II5rlI3pZZl8Iw1VIFIzDcfV6sTNa4IK56DRDeenRSqGqR4d4JI0Un1wHylIyDwEMlkITLgX7KvLFRI5QU69R6HEjvOheTeSFpa+AIozNZ+cb7FMfRisfs0Booac1cNz4rB37EORfDsJNW8CPGJrKFL/hFfFVvCsSL4AWNNH6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=mkjdQ0A/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="mkjdQ0A/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=lusU9fDt0+doSISdjWA/f49G8mbzLTv949xNyjBeF9A=; t=1754692640;
	x=1755297440; b=mkjdQ0A/00dhYMnzcrOQZ/ZouwaVyNfZ3PWFtwtxaxdlhB/tpMNh23jkgxlX3
	V1J6QlQ9Scmn3tGBVi5RhzKG1kPUSjjS5NrmLa6iunwC3SjuID6zZMqLnaZD+eKZLOgBl8yitMbpQ
	CaIiAA885p1xS7N2jMUytJAz6yIeAOuTT0O2sx0VwNrtt1DWX/LGAiz+CUcJSJ03LNgY11pUqKvNN
	5knkgV0PcWpjfQn4g8jZSiq81iYlVbhTAabnIa7RN2CVwiKfV2JskKn2f0UvSZWv7XzUq1w/mj35b
	BR2UVsk2YQ5SLFgR9bOGk9QTo0UR+h96BKMQz9dZ1VTxd1qkog==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ukVi7-00000003f3G-2ulW; Sat, 09 Aug 2025 00:37:15 +0200
Received: from dynamic-002-242-002-090.2.242.pool.telefonica.de ([2.242.2.90] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ukVi7-00000001Le7-1qeS; Sat, 09 Aug 2025 00:37:15 +0200
Message-ID: <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Sat, 09 Aug 2025 00:37:14 +0200
In-Reply-To: <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
	 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
	 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
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

On Fri, 2025-08-08 at 15:15 -0700, Anthony Yznaga wrote:
> > So, I have to admit that I'm not an expert on Linux kernel memory manag=
ement and
> > don't exactly know what the difference between HugeTLB and Transparent =
Huge Pages
> > is. Could someone enlighten me?
>=20
> They both use use huge pages to reduce the number of TLB misses. HugeTLB=
=20
> has to be configured and requires changes to an application to=20
> explicitly use it. THP works in a more automated fashion where the=20
> kernel manages when and where to use huge pages without requiring=20
> changes to the application.

Thanks for the explanation! I had actually researched the difference in the=
 mean time
because I was curious about it ;-).

> >=20
> > The reason I am asking is because while this patch seems to fix HugeTLB=
 support,
> > we're still seeing TLB-related crashes on sun4u which are triggered whe=
n both
> > CONFIG_TRANSPARENT_HUGEPAGE and CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS are =
set.
> >=20
> > I previously thought that HugeTLB and THP are the same, but it seems li=
ke that's
> > not the case.
>=20
> Yes, my patch fixes HugeTLB only, and has no bearing on THP.
>=20
> >=20
> > Enabling both these options leads to the following backtrace during boo=
t:
> >=20
> > [   29.858572] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > [   29.858580] rcu:     (detected by 0, t=3D2109 jiffies, g=3D-1155, q=
=3D3 ncpus=3D1)
> > [   29.858586] rcu: All QSes seen, last rcu_sched kthread activity 2109=
 (4294939474-4294937365), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
> > [   29.858595] rcu: rcu_sched kthread starved for 2109 jiffies! g-1155 =
f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
> > [   29.858603] rcu:     Unless rcu_sched kthread gets sufficient CPU ti=
me, OOM is now expected behavior.
> > [   29.858606] rcu: RCU grace-period kthread stack dump:
> > [   29.858609] task:rcu_sched       state:R  running task     stack:0  =
   pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x07000000
> > [   29.858626] Call Trace:
> > [   29.858629] [<0000000000c0a234>] schedule+0x14/0x160
> > [   29.858646] [<0000000000c11194>] schedule_timeout+0x54/0xe0
> > [   29.858657] [<00000000004fbd40>] rcu_gp_fqs_loop+0x140/0x6c0
> > [   29.858669] [<000000000050003c>] rcu_gp_kthread+0x23c/0x2a0
> > [   29.858678] [<000000000049b788>] kthread+0xe8/0x120
> > [   29.858688] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
> > [   29.858700] [<0000000000000000>] 0x0
> > [   29.858705] rcu: Stack dump where RCU GP kthread last ran:
> > [   29.858710] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+=
 #32 VOLUNTARY
> > [   29.858719] TSTATE: 0000004411001603 TPC: 00000000004db400 TNPC: 000=
00000004db404 Y: 0000137d    Not tainted
> > [   29.858725] TPC: <console_flush_all+0x360/0x4c0>
> > [   29.858738] g0: 00000000004db400 g1: 0000000000000000 g2: 0000000000=
000000 g3: 00000000017fd000
> > [   29.858743] g4: fff0000000180000 g5: fff000023d194000 g6: fff0000000=
158000 g7: 000000000000000e
> > [   29.858748] o0: 00000000017fd1e0 o1: 0000000000000000 o2: 0000000000=
000000 o3: 00000000017fc5d0
> > [   29.858752] o4: 0000000000000000 o5: 000000000185d7e8 sp: fff0000000=
15a901 ret_pc: 00000000004db3f0
> > [   29.858757] RPC: <console_flush_all+0x350/0x4c0>
> > [   29.858764] l0: 00000000017fc5d0 l1: 0000000000000000 l2: 0000000000=
000000 l3: 000000000143b538
> > [   29.858769] l4: 0000000000000000 l5: 0000000000000001 l6: 0000000001=
5c20b0 l7: 0000000001536308
> > [   29.858773] i0: 0000000000000000 i1: fff000000015b2b8 i2: fff0000000=
15b2b3 i3: 0000000000000000
> > [   29.858778] i4: 00000000017fd1e0 i5: 0000000000000001 i6: fff0000000=
15aa01 i7: 00000000004db5e8
> > [   29.858782] I7: <console_unlock+0x88/0x120>
> > [   29.858790] Call Trace:
> > [   29.858793] [<00000000004db5e8>] console_unlock+0x88/0x120
> > [   29.858801] [<00000000004dc128>] vprintk_emit+0x1e8/0x280
> > [   29.858809] [<000000000042a34c>] _printk+0x20/0x30
> > [   29.858819] [<00000000004dc66c>] register_console+0x34c/0x580
> > [   29.858828] [<0000000000920358>] serial_core_register_port+0x898/0x8=
c0
> > [   29.858835] [<000000000092555c>] su_probe+0x15c/0x3e0
> > [   29.858844] [<0000000000936d88>] platform_probe+0x28/0x80
> > [   29.858851] [<0000000000934338>] really_probe+0xb8/0x340
> > [   29.858863] [<0000000000934764>] driver_probe_device+0x24/0x120
> > [   29.858872] [<0000000000934a0c>] __driver_attach+0x8c/0x1a0
> > [   29.858879] [<000000000093232c>] bus_for_each_dev+0x4c/0xa0
> > [   29.858887] [<0000000000933668>] bus_add_driver+0x148/0x220
> > [   29.858894] [<0000000000935634>] driver_register+0x74/0x120
> > [   29.858903] [<0000000001635e3c>] sunsu_init+0x180/0x1dc
> > [   29.858915] [<00000000004347b0>] do_one_initcall+0x30/0x240
> > [   29.858924] [<000000000160d014>] kernel_init_freeable+0x244/0x2b8
> >=20
> > Running the apt package manager results in a minute-long hang and this =
backtrace:
> >=20
> > [  112.800879] systemd-journald[154]: Time jumped backwards, rotating.
> > [  123.148552] kernel BUG at fs/ext4/inode.c:1174!
> > [  123.208162]               \|/ ____ \|/
> > [  123.208162]               "@'/ .. \`@"
> > [  123.208162]               /_| \__/ |_\
> > [  123.208162]                  \__U_/
> > [  123.401513] apt(881): Kernel bad sw trap 5 [#1]
> > [  123.461051] CPU: 0 UID: 0 PID: 881 Comm: apt Not tainted 6.16.0+ #32=
 VOLUNTARY
> > [  123.557129] TSTATE: 0000004411001603 TPC: 000000000075eda8 TNPC: 000=
000000075edac Y: 00000000    Not tainted
> > [  123.686379] TPC: <ext4_block_write_begin+0x408/0x480>
> > [  123.752813] g0: 0000000000000000 g1: 0000000000000001 g2: 0000000000=
000000 g3: 0000000000000000
> > [  123.867186] g4: fff0000007eb8140 g5: fff000023d194000 g6: fff000000a=
130000 g7: 0000000000000001
> > [  123.981565] o0: 0000000000000023 o1: 0000000000d74b28 o2: 0000000000=
000496 o3: 0000000000101cca
> > [  124.095948] o4: 0000000001568800 o5: 0000000000000000 sp: fff000000a=
133161 ret_pc: 000000000075eda0
> > [  124.214890] RPC: <ext4_block_write_begin+0x400/0x480>
> > [  124.281219] l0: fff00000029ce828 l1: 0000000000113cca l2: fff0000002=
9ce6c0 l3: 0000000000001000
> > [  124.395608] l4: 0000000000000002 l5: 0000000000080000 l6: 0000000000=
012000 l7: 0000000000000001
> > [  124.509978] i0: 0000000000000000 i1: 000c0000003bfa00 i2: 0000000000=
001fc0 i3: 0000000000680000
> > [  124.624351] i4: 0000000000000000 i5: 0000000000000000 i6: fff000000a=
133251 i7: 0000000000762518
> > [  124.738729] I7: <ext4_da_write_begin+0x158/0x300>
> > [  124.800487] Call Trace:
> > [  124.832506] [<0000000000762518>] ext4_da_write_begin+0x158/0x300
> > [  124.911429] [<00000000005b84ac>] generic_perform_write+0x8c/0x240
> > [  124.991491] [<000000000074ae30>] ext4_buffered_write_iter+0x50/0x120
> > [  125.074997] [<0000000000695420>] vfs_write+0x2a0/0x400
> > [  125.142468] [<00000000006956c4>] ksys_write+0x44/0xe0
> > [  125.208805] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> > [  125.285437] Disabling lock debugging due to kernel taint
> > [  125.355205] Caller[0000000000762518]: ext4_da_write_begin+0x158/0x30=
0
> > [  125.439843] Caller[00000000005b84ac]: generic_perform_write+0x8c/0x2=
40
> > [  125.525624] Caller[000000000074ae30]: ext4_buffered_write_iter+0x50/=
0x120
> > [  125.614836] Caller[0000000000695420]: vfs_write+0x2a0/0x400
> > [  125.688035] Caller[00000000006956c4]: ksys_write+0x44/0xe0
> > [  125.760093] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
> > [  125.842442] Caller[0000000000000000]: 0x0
> > [  125.895052] Instruction DUMP:
> > [  125.895055]  110035d2
> > [  125.933938]  7ff35910
> > [  125.964823]  90122328
> > [  125.995700] <91d02005>
> > [  126.026582]  80a06000
> > [  126.057466]  02480010
> > [  126.088347]  d45fa7cf
> > [  126.119224]  d85fa7cf
> > [  126.150125]  9736a000
> > [  126.181088]
> >=20
> > After applying this patch to fix HugeTLB support on sun4u, the backtrac=
e during boot changes to:
> >=20
> > [   29.860234] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > [   29.860241] rcu:     (detected by 0, t=3D2109 jiffies, g=3D-1151, q=
=3D3 ncpus=3D1)
> > [   29.860247] rcu: All QSes seen, last rcu_sched kthread activity 2109=
 (4294939474-4294937365), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
> > [   29.860256] rcu: rcu_sched kthread starved for 2109 jiffies! g-1151 =
f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
> > [   29.860263] rcu:     Unless rcu_sched kthread gets sufficient CPU ti=
me, OOM is now expected behavior.
> > [   29.860266] rcu: RCU grace-period kthread stack dump:
> > [   29.860269] task:rcu_sched       state:R  running task     stack:0  =
   pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x07000000
> > [   29.860285] Call Trace:
> > [   29.860288] [<0000000000c0a2f4>] schedule+0x14/0x160
> > [   29.860305] [<0000000000c11254>] schedule_timeout+0x54/0xe0
> > [   29.860317] [<00000000004fbe00>] rcu_gp_fqs_loop+0x140/0x6c0
> > [   29.860329] [<00000000005000fc>] rcu_gp_kthread+0x23c/0x2a0
> > [   29.860338] [<000000000049b848>] kthread+0xe8/0x120
> > [   29.860347] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
> > [   29.860359] [<0000000000000000>] 0x0
> > [   29.860364] rcu: Stack dump where RCU GP kthread last ran:
> > [   29.860368] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+=
 #33 VOLUNTARY
> > [   29.860378] TSTATE: 0000004411001603 TPC: 00000000004db4c0 TNPC: 000=
00000004db4c4 Y: 00001390    Not tainted
> > [   29.860383] TPC: <console_flush_all+0x360/0x4c0>
> > [   29.860397] g0: 00000000004db4c0 g1: 0000000000000000 g2: 0000000000=
000000 g3: 00000000017fd000
> > [   29.860401] g4: fff0000000180000 g5: fff000023d194000 g6: fff0000000=
158000 g7: 000000000000000e
> > [   29.860406] o0: 00000000017fd1e0 o1: 0000000000000000 o2: 0000000000=
000000 o3: 00000000017fc5d0
> > [   29.860411] o4: 0000000000000000 o5: 000000000185d7e8 sp: fff0000000=
15a901 ret_pc: 00000000004db4b0
> > [   29.860415] RPC: <console_flush_all+0x350/0x4c0>
> > [   29.860423] l0: 00000000017fc5d0 l1: 0000000000000000 l2: 0000000000=
000000 l3: 000000000143b538
> > [   29.860427] l4: 0000000000000000 l5: 0000000000000001 l6: 0000000001=
5c20b0 l7: 0000000001536308
> > [   29.860432] i0: 0000000000000000 i1: fff000000015b2b8 i2: fff0000000=
15b2b3 i3: 0000000000000000
> > [   29.860436] i4: 00000000017fd1e0 i5: 0000000000000001 i6: fff0000000=
15aa01 i7: 00000000004db6a8
> > [   29.860441] I7: <console_unlock+0x88/0x120>
> > [   29.860449] Call Trace:
> > [   29.860451] [<00000000004db6a8>] console_unlock+0x88/0x120
> > [   29.860459] [<00000000004dc1e8>] vprintk_emit+0x1e8/0x280
> > [   29.860467] [<000000000042a34c>] _printk+0x20/0x30
> > [   29.860477] [<00000000004dc72c>] register_console+0x34c/0x580
> > [   29.860485] [<0000000000920418>] serial_core_register_port+0x898/0x8=
c0
> > [   29.860493] [<000000000092561c>] su_probe+0x15c/0x3e0
> > [   29.860502] [<0000000000936e48>] platform_probe+0x28/0x80
> > [   29.860509] [<00000000009343f8>] really_probe+0xb8/0x340
> > [   29.860521] [<0000000000934824>] driver_probe_device+0x24/0x120
> > [   29.860529] [<0000000000934acc>] __driver_attach+0x8c/0x1a0
> > [   29.860537] [<00000000009323ec>] bus_for_each_dev+0x4c/0xa0
> > [   29.860544] [<0000000000933728>] bus_add_driver+0x148/0x220
> > [   29.860552] [<00000000009356f4>] driver_register+0x74/0x120
> > [   29.860560] [<0000000001635e3c>] sunsu_init+0x180/0x1dc
> > [   29.860572] [<00000000004347b0>] do_one_initcall+0x30/0x240
> > [   29.860581] [<000000000160d014>] kernel_init_freeable+0x244/0x2b
> >=20
> > while the backtrace produced when apt hangs is:
> >      =20
> > [  337.599490] ------------[ cut here ]------------
> > [  337.660412] WARNING: CPU: 0 PID: 895 at fs/ext4/extents_status.c:298=
 __es_find_extent_range+0x128/0x140
> > [  337.784523] Modules linked in: sg sr_mod cdrom sym53c8xx tg3 libphy =
mdio_bus
> > [  337.877302] CPU: 0 UID: 0 PID: 895 Comm: apt Not tainted 6.16.0+ #33=
 VOLUNTARY
> > [  337.877314] Call Trace:
> > [  337.877316] [<000000000047286c>] __warn+0x10c/0x120
> > [  337.877326] [<0000000000472910>] warn_slowpath_fmt+0x90/0x120
> > [  337.877332] [<0000000000748988>] __es_find_extent_range+0x128/0x140
> > [  337.877341] [<00000000007490f0>] ext4_es_find_extent_range+0x50/0x10=
0
> > [  337.877348] [<0000000000742a1c>] ext4_ext_map_blocks+0x7fc/0x22a0
> > [  337.877355] [<00000000007578d0>] ext4_map_query_blocks+0x30/0x2a0
> > [  337.877366] [<00000000007596a0>] ext4_da_get_block_prep+0x380/0x640
> > [  337.877375] [<000000000075ecf4>] ext4_block_write_begin+0x294/0x480
> > [  337.877382] [<00000000007625d8>] ext4_da_write_begin+0x158/0x300
> > [  337.877389] [<00000000005b856c>] generic_perform_write+0x8c/0x240
> > [  337.877399] [<000000000074aef0>] ext4_buffered_write_iter+0x50/0x120
> > [  337.877406] [<00000000006954e0>] vfs_write+0x2a0/0x400
> > [  337.877415] [<0000000000695784>] ksys_write+0x44/0xe0
> > [  337.877421] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> > [  337.877433] ---[ end trace 0000000000000000 ]---
> > [  339.153555] ------------[ cut here ]------------
> > [  339.214459] WARNING: CPU: 0 PID: 895 at fs/ext4/extents_status.c:298=
 __es_find_extent_range+0x128/0x140
> > [  339.338108] Modules linked in: sg sr_mod cdrom sym53c8xx tg3 libphy =
mdio_bus
> > [  339.430869] CPU: 0 UID: 0 PID: 895 Comm: apt Tainted: G        W    =
       6.16.0+ #33 VOLUNTARY
> > [  339.430880] Tainted: [W]=3DWARN
> > [  339.430883] Call Trace:
> > [  339.430886] [<000000000047286c>] __warn+0x10c/0x120
> > [  339.430894] [<0000000000472910>] warn_slowpath_fmt+0x90/0x120
> > [  339.430900] [<0000000000748988>] __es_find_extent_range+0x128/0x140
> > [  339.430907] [<00000000007490f0>] ext4_es_find_extent_range+0x50/0x10=
0
> > [  339.430915] [<0000000000742a1c>] ext4_ext_map_blocks+0x7fc/0x22a0
> > [  339.430921] [<00000000007578d0>] ext4_map_query_blocks+0x30/0x2a0
> > [  339.430931] [<00000000007597d4>] ext4_da_get_block_prep+0x4b4/0x640
> > [  339.430940] [<000000000075ecf4>] ext4_block_write_begin+0x294/0x480
> > [  339.430948] [<00000000007625d8>] ext4_da_write_begin+0x158/0x300
> > [  339.430954] [<00000000005b856c>] generic_perform_write+0x8c/0x240
> > [  339.430964] [<000000000074aef0>] ext4_buffered_write_iter+0x50/0x120
> > [  339.430971] [<00000000006954e0>] vfs_write+0x2a0/0x400
> > [  339.430979] [<0000000000695784>] ksys_write+0x44/0xe0
> > [  339.430985] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> > [  339.430996] ---[ end trace 0000000000000000 ]---
> >=20
> > So, I guess while your patch may fix HugeTLB support, there is still a =
bug on sun4u with THP
> > which needs to be addressed.
>=20
> Maybe try enabling CONFIG_DEBUG_VM_IRQSOFF, CONFIG_DEBUG_VM, and perhaps=
=20
> CONFIG_DEBUG_VM_PGFLAGS. That might help detect a problem closer to the=
=20
> source. You can also try adding transparent_hugepage=3Dnever to the kerne=
l=20
> boot line to see if compiling in THP support but not using it is okay.

OK, I will try that. But not today anymore. It's half past midnight now her=
e in Germany
and I was debugging this issue almost all day long. I'm glad to have finall=
y been able
to track this down to THP support being enabled.

Maybe you can try whether you can reproduce this in QEMU as well.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
