Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AA29AAFD;
	Wed, 27 Aug 2025 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276478; cv=none; b=IPkjJD7WXxghY9eUAvbsfKyV4P3hAAt55W9CPIB/XmBbF7LUBF+Mdld1TumNFe2SGEOU2r6bl5HsuqkJ0FHbDZVdCanitkjygnzEEM9jSRrc2gsFSlvnVBH9g3uwjLjhtNFm/NhrYGyiTHUqdLAuoK2Q7YrjLEX9AKnLNEbsp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276478; c=relaxed/simple;
	bh=PZjWQD4BsTRO7eDMy1mLp0E4ctDh1vgzEEDVWQehuXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KnnE+4LJAGHLo3rE/BYMfZBOU0nOX29ciqOqZK44LOqXe9tRutdBQSFUDi5pdz0PbyiVxB4gOB9J+SMVSne/CH/TAu6kHpmAhVzvzo2DH20U4j4VSjUzShZGqOgedgyt5ZnWnbYmmn7/LQMbkvZvrk49NkyAC2N0hKmrGVxIRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IsCaEwqa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IsCaEwqa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0aLUAnOKy29JMuN55fsGKvv4SaweddIZcXsgdi8Fzho=; t=1756276475;
	x=1756881275; b=IsCaEwqaBDtdldhMEvhhl0RlqOjHpR9ZoE29cy5mn0nawgsHbKeIhOew33g8A
	mFxIdeH+BMXxtG64j+GqAKSiubZHj7EkO9OvwxZbD9Q4cwPFHJJ7a5gAwC9Ly3zdB43Fs+b4rcFyZ
	0M29TJ/6+iFNbz6hhkEuzPYyEcp1ROJ9fBSHm7swczXOVviEVo0BEQ4y0cCoPphTLX5RKUrETqrus
	psTaLdw1uxsVvKqLMombHyNqzc2RXzAgxZf6n7eLKqAk/bhRVjdA/jGwc6aZYB6jpmBX9pld7aONG
	GqFbCc/kieVgVEO7uVE1dHxARsISsw3E27St1gMhA3EVbyALjg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ur9jr-00000003c6n-2K2I; Wed, 27 Aug 2025 08:34:31 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ur9jr-00000003BVm-1Nu7; Wed, 27 Aug 2025 08:34:31 +0200
Message-ID: <e4c64a83895eea9eb4ae73ef4da81a901748b921.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Wed, 27 Aug 2025 08:34:30 +0200
In-Reply-To: <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
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

Hi Michael,

On Tue, 2025-08-26 at 18:03 +0200, Michael Karcher wrote:
> Based on a finding by Anthony Yznaga that the UltraSPARC III copy_from_us=
er
> returns invalid values breaking other parts of the kernel in case of a
> fault, while the generic implementation is correct.
>=20
> Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate =
exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/U3memcpy.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
> index 9248d59c734c..bace3a18f836 100644
> --- a/arch/sparc/lib/U3memcpy.S
> +++ b/arch/sparc/lib/U3memcpy.S
> @@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  	faligndata	%f10, %f12, %f26
>  	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
> =20
> +	and		%o2, 0x3f, %o2
>  	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
>  	add		%o1, 0x40, %o1
>  	bgu,pt		%XCC, 1f
> @@ -336,7 +337,6 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  	 * Also notice how this code is careful not to perform a
>  	 * load past the end of the src buffer.
>  	 */
> -	and		%o2, 0x3f, %o2
>  	andcc		%o2, 0x38, %g2
>  	be,pn		%XCC, 2f
>  	 subcc		%g2, 0x8, %g2

I patched Debian's unstable kernel yesterday and to my surprise, the kernel=
 crashed
during boot on the Sun Netra 240. Could be related to some Debian-specific =
changes
though or to issues with gcc-14:

[   30.683477] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   30.683485] rcu:     (detected by 0, t=3D5262 jiffies, g=3D-955, q=3D12 =
ncpus=3D1)
[   30.683492] rcu: All QSes seen, last rcu_sched kthread activity 5262 (42=
94897854-4294892592), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
[   30.683503] rcu: rcu_sched kthread starved for 5262 jiffies! g-955 f0x2 =
RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[   30.683511] rcu:     Unless rcu_sched kthread gets sufficient CPU time, =
OOM is now expected behavior.
[   30.683515] rcu: RCU grace-period kthread stack dump:
[   30.683518] task:rcu_sched       state:R  running task     stack:0     p=
id:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x07000000
[   30.683536] Call Trace:
[   30.683540] [<0000000000f80a5c>] schedule+0x1c/0x180
[   30.683562] [<0000000000f870b0>] schedule_timeout+0x70/0x100
[   30.683572] [<000000000052b4c8>] rcu_gp_fqs_loop+0x108/0x5e0
[   30.683582] [<0000000000530ae0>] rcu_gp_kthread+0x180/0x200
[   30.683591] [<00000000004ac704>] kthread+0x104/0x280
[   30.683605] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   30.683618] [<0000000000000000>] 0x0
[   30.683626] rcu: Stack dump where RCU GP kthread last ran:
[   30.683632] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.3+1-sp=
arc64-smp #1 NONE  Debian 6.16.3-1+sparc64=20
[   30.683642] TSTATE: 0000004411001602 TPC: 000000000050bbf0 TNPC: 0000000=
00050bbf4 Y: 0000004a    Not tainted
[   30.683648] TPC: <console_flush_all+0x3d0/0x540>
[   30.683662] g0: 000000000050bbf0 g1: 0000000000000000 g2: 00000000000000=
00 g3: 0000000001544800
[   30.683668] g4: fff000000022ad00 g5: fff000023e2f6000 g6: fff00000002640=
00 g7: 000000000000000e
[   30.683673] o0: 0000000001544958 o1: 0000000001543d48 o2: 00000000000000=
4f o3: 00000000015b3080
[   30.683678] o4: 00000000015b3080 o5: 00000000015b3080 sp: fff00000002663=
f1 ret_pc: 000000000050bbe0
[   30.683683] RPC: <console_flush_all+0x3c0/0x540>
[   30.683692] l0: 0000000001544958 l1: 0000000000000000 l2: 0000000001543d=
48 l3: 00000000012e3ef8
[   30.683697] l4: 00000000013fb770 l5: 0000000000000000 l6: 000000000137a8=
00 l7: 000000000000004f
[   30.683702] i0: 0000000000000000 i1: fff0000000266db8 i2: fff0000000266d=
b3 i3: 00000000012f65f0
[   30.683707] i4: 0000000000000000 i5: 00000000012f65f0 i6: fff00000002665=
01 i7: 000000000050bdf8
[   30.683712] I7: <console_unlock+0x98/0x140>
[   30.683721] Call Trace:
[   30.683724] [<000000000050bdf8>] console_unlock+0x98/0x140
[   30.683733] [<000000000050cbec>] vprintk_emit+0x2cc/0x360
[   30.683742] [<000000000050cc9c>] vprintk_default+0x1c/0x40
[   30.683752] [<000000000050dbd0>] vprintk+0x10/0x20
[   30.683761] [<000000000042b3a8>] _printk+0x24/0x34
[   30.683772] [<000000000050d1c8>] register_console+0x3a8/0x600
[   30.683781] [<0000000000bd07c0>] serial_core_register_port+0x680/0x8a0
[   30.683790] [<0000000000bd12f0>] serial_ctrl_register_port+0x10/0x20
[   30.683798] [<0000000000bd1370>] uart_add_one_port+0x10/0x20
[   30.683806] [<0000000000bd8bb4>] su_probe+0x174/0x400
[   30.683816] [<0000000000c044cc>] platform_probe+0x4c/0xc0
[   30.683825] [<0000000000c00e28>] really_probe+0xc8/0x400
[   30.683839] [<0000000000c011ec>] __driver_probe_device+0x8c/0x160
[   30.683848] [<0000000000c013a8>] driver_probe_device+0x28/0x100
[   30.683857] [<0000000000c0165c>] __driver_attach+0xbc/0x1e0
[   30.683865] [<0000000000bfe7dc>] bus_for_each_dev+0x5c/0xc0
[   32.641998] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0=
:1]
[   32.642006] Modules linked in:
[   32.642012] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.3+1-sp=
arc64-smp #1 NONE  Debian 6.16.3-1+sparc64=20
[   32.642020] TSTATE: 0000004411001602 TPC: 000000000050bbf0 TNPC: 0000000=
00050bbf4 Y: 00000052    Not tainted
[   32.642026] TPC: <console_flush_all+0x3d0/0x540>
[   32.642035] g0: 00000000015b1f48 g1: 0000000000000000 g2: 00000000000000=
00 g3: 0000000001544800
[   32.642040] g4: fff000000022ad00 g5: fff000023e2f6000 g6: fff00000002640=
00 g7: 000000000000000e
[   32.642045] o0: 0000000001544958 o1: 0000000001543d48 o2: 00000000000000=
54 o3: 00000000015b3080
[   32.642050] o4: 00000000015b3080 o5: 00000000015b3080 sp: fff00000002663=
f1 ret_pc: 000000000050bbe0
[   32.642054] RPC: <console_flush_all+0x3c0/0x540>
[   32.642062] l0: 0000000001544958 l1: 0000000000000000 l2: 0000000001543d=
48 l3: 00000000012e3ef8
[   32.642067] l4: 00000000013fb770 l5: 0000000000000000 l6: 000000000137a8=
00 l7: 0000000000000054
[   32.642072] i0: 0000000000000000 i1: fff0000000266db8 i2: fff0000000266d=
b3 i3: 00000000012f65f0
[   32.642077] i4: 0000000000000000 i5: 00000000012f65f0 i6: fff00000002665=
01 i7: 000000000050bdf8
[   32.642081] I7: <console_unlock+0x98/0x140>
[   32.642089] Call Trace:
[   32.642092] [<000000000050bdf8>] console_unlock+0x98/0x140
[   32.642101] [<000000000050cbec>] vprintk_emit+0x2cc/0x360
[   32.642110] [<000000000050cc9c>] vprintk_default+0x1c/0x40
[   32.642118] [<000000000050dbd0>] vprintk+0x10/0x20
[   32.642127] [<000000000042b3a8>] _printk+0x24/0x34
[   32.642135] [<000000000050d1c8>] register_console+0x3a8/0x600
[   32.642144] [<0000000000bd07c0>] serial_core_register_port+0x680/0x8a0
[   32.642151] [<0000000000bd12f0>] serial_ctrl_register_port+0x10/0x20
[   32.642158] [<0000000000bd1370>] uart_add_one_port+0x10/0x20
[   32.642165] [<0000000000bd8bb4>] su_probe+0x174/0x400
[   32.642173] [<0000000000c044cc>] platform_probe+0x4c/0xc0
[   32.642180] [<0000000000c00e28>] really_probe+0xc8/0x400
[   32.642189] [<0000000000c011ec>] __driver_probe_device+0x8c/0x160
[   32.642198] [<0000000000c013a8>] driver_probe_device+0x28/0x100
[   32.642206] [<0000000000c0165c>] __driver_attach+0xbc/0x1e0
[   32.642215] [<0000000000bfe7dc>] bus_for_each_dev+0x5c/0xc0

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
