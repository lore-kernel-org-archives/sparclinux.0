Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378AF2E229C;
	Mon,  8 Sep 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314401; cv=none; b=HtJlMpbeAbGVORg1s8HjkrVfTAdu2tqe4WEynjLi2KFQNFjidC/GV7kX+SgBdfTuQjoJi8gVwHDwD3rhX4OhxzI0KNp9ISVrMqj27WYg0bWlUvtZUaV3mtS7jkA+fdpMMhJGyQ7Kz7KDeLH2SBrij9ZoFTa/9PGNBnI3aHLi62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314401; c=relaxed/simple;
	bh=P4zxBnESGGZYzd4vT1edfckmSc7snYnot9EWu+3dxZw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFeNYShBDfXFsa4FLmCh8KHa83m2BtxbZDX/f9WqeVvMnjsm9Cwa1VYJ+0DjN1nlnJ3THctn9t+qiSE8VNCvupXoXcC920mpwdNdywBB2h/NafpsU8MQ/KwVs7P6N0itCeDjOSd5RrG/AQNLhCvzt5WkUn/cl6TSpheNOw6u6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=YhQ6rGec; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="YhQ6rGec"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=vYsBnwgBDKLAbhmWEychLP56D9F6EzWftM/Wu56nqUc=; t=1757314399;
	x=1757919199; b=YhQ6rGecQrasMXGXA5pWtZBu7O9ImvMHw8EFwvYahDxtDfgJeXbFKY3vGtQHx
	wZ+Ls6Gpbu4jsfMaHFkrBnL2+8oy3pEV/jmUqhW3oFcGFJujD87sIrBdHUMP9MStqQw822PTucYKo
	NUKmqvAqFQ2GsiqyztrBQkXG2g5toBC6vKv76AuSm2yEhqPop+dQxQFyrXArdmAU82b2mKMcxFxEh
	YFuATohlgjyzw7Xsy7QJPZqcnz/NRD5R0lGPCmhH1tBJZPSDXvYr+ODpe6OVaD39jZ8MQnuIQqCZO
	o/tdJgEJFWKq/lX7DPP+QcRmcJ54e0aejBJg8tqYE1IyAX65iw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvVka-00000000BsW-33H6; Mon, 08 Sep 2025 08:53:16 +0200
Received: from dynamic-077-183-099-053.77.183.pool.telefonica.de ([77.183.99.53] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvVka-00000000P9A-28ro; Mon, 08 Sep 2025 08:53:16 +0200
Message-ID: <a9eec6f5a51c82cd2a20a96d614cfd3095ddce88.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Andreas Larsson
	 <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anthony Yznaga
	 <anthony.yznaga@oracle.com>, =?ISO-8859-1?Q?Ren=E9?= Rebe
 <rene@exactcode.com>
Date: Mon, 08 Sep 2025 08:53:14 +0200
In-Reply-To: <603f6661d99fc6c936f5a75e29f30d50650b9da8.camel@physik.fu-berlin.de>
References: 
	<20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
							 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
						 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
					 <2fe65b101b36304369866e30f64a921591ecdd8b.camel@physik.fu-berlin.de>
				 <e791dbb534aac79805389a4b754901c24991de89.camel@physik.fu-berlin.de>
			 <c3e1173f99e6222ab09093e1a197d6366bcf2b95.camel@physik.fu-berlin.de>
		 <03957ee5ee562b70f7e3278d0ce95b2f52cbc721.camel@physik.fu-berlin.de>
	 <603f6661d99fc6c936f5a75e29f30d50650b9da8.camel@physik.fu-berlin.de>
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

On Mon, 2025-09-08 at 08:47 +0200, John Paul Adrian Glaubitz wrote:
> Hi,
>=20
> On Mon, 2025-09-08 at 08:30 +0200, John Paul Adrian Glaubitz wrote:
> > Hi,
> >=20
> > On Sun, 2025-09-07 at 23:31 +0200, John Paul Adrian Glaubitz wrote:
> > > Hi,
> > >=20
> > > On Sun, 2025-09-07 at 20:33 +0200, John Paul Adrian Glaubitz wrote:
> > > > I assume that cheetah_patch_cachetlbops has to be invoked on UltraS=
PARC III
> > > > since there is other code depending on it. On the other hand, the T=
LB code
> > > > on UltraSPARC III was heavily overhauled in 2016 [1] which was also=
 followed
> > > > by a bug fix [2].
> > > >=20
> > > > Chances are there are still bugs in the code introduced in [1].
> > > >=20
> > > > > [1] https://github.com/torvalds/linux/commit/a74ad5e660a9ee1d0716=
65e7e8ad822784a2dc7f
> > > > > [2] https://github.com/torvalds/linux/commit/d3c976c14ad8af421134=
c428b0a89ff8dd3bd8f8
> > >=20
> > > I have reverted both commits. The machine boots until it tries to sta=
rt
> > > systemd when it locks up. So, I guess if there is a bug in the TLB co=
de
> > > it needs to be diagnosed differently.
> >=20
> > Another test with a kernel source rebased to 6.17-rc5+, with the follow=
ing patch applied
> > by Anthony Yznaga and CONFIG_SMP disabled:
> >=20
> > diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
> > index 70e658d107e0..b323db303de1 100644
> > --- a/arch/sparc/mm/ultra.S
> > +++ b/arch/sparc/mm/ultra.S
> > @@ -347,6 +347,7 @@ __cheetah_flush_tlb_kernel_range:	/* 31 insns */
> >   	membar		#Sync
> >   	stxa		%g0, [%o4] ASI_IMMU_DEMAP
> >   	membar		#Sync
> > +	flush
> >   	retl
> >   	 nop
> >   	nop
> > @@ -355,7 +356,6 @@ __cheetah_flush_tlb_kernel_range:	/* 31 insns */
> >   	nop
> >   	nop
> >   	nop
> > -	nop
> >=20
> >   #ifdef DCACHE_ALIASING_POSSIBLE
> >   __cheetah_flush_dcache_page: /* 11 insns */
> >=20
> > Still crashes:
> >=20
> > [  139.236744] tsk->{mm,active_mm}->context =3D 00000000000000ab
> > [  139.310042] tsk->{mm,active_mm}->pgd =3D fff0000007db8000
> > [  139.378747]               \|/ ____ \|/
> > [  139.378747]               "@'/ .. \`@"
> > [  139.378747]               /_| \__/ |_\
> > [  139.378747]                  \__U_/
> > [  139.572059] systemd(1): Oops [#1]
> > [  139.615613] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.17.0-rc=
5+ #19 NONE=20
> > [  139.712832] TSTATE: 0000004411001602 TPC: 00000000005e29e4 TNPC: 000=
00000005e29e8 Y: 00000000    Not tainted
> > [  139.842076] TPC: <bpf_patch_insn_data+0x204/0x2e0>
> > [  139.905077] g0: ffffffffffffffff g1: 0000000000000000 g2: 0000000000=
000065 g3: fff0000009618b28
> > [  140.019460] g4: fff00000001f9500 g5: 0000000000657300 g6: fff0000000=
22c000 g7: 0000000000000001
> > [  140.133837] o0: 0000000100058000 o1: 0000000000000000 o2: 0000000000=
000001 o3: 0000000000000002
> > [  140.248208] o4: fff00000045ec900 o5: 0000000000000002 sp: fff0000000=
22f031 ret_pc: 00000000005e2998
> > [  140.367158] RPC: <bpf_patch_insn_data+0x1b8/0x2e0>
> > [  140.430057] l0: fff0000009618000 l1: 0000000100046048 l2: 0000000000=
000001 l3: 0000000100058000
> > [  140.544437] l4: 0000000100046068 l5: 0000000000000005 l6: 0000000000=
000000 l7: fff000000961e128
> > [  140.658810] i0: 0000000100046000 i1: 0000000000000004 i2: 0000000000=
000005 i3: 0000000000000002
> > [  140.773189] i4: 0000000100066000 i5: fff0000009618ae8 i6: fff0000000=
22f0e1 i7: 0000000000607a08
> > [  140.887561] I7: <bpf_check+0x1988/0x34a0>
> > [  140.940171] Call Trace:
> > [  140.972191] [<0000000000607a08>] bpf_check+0x1988/0x34a0
> > [  141.041963] [<00000000005d862c>] bpf_prog_load+0x8ec/0xc80
> > [  141.114021] [<00000000005d9be4>] __sys_bpf+0x724/0x28a0
> > [  141.182646] [<00000000005dc338>] sys_bpf+0x18/0x60
> > [  141.245551] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> > [  141.322185] Disabling lock debugging due to kernel taint
> > [  141.391952] Caller[0000000000607a08]: bpf_check+0x1988/0x34a0
> > [  141.467440] Caller[00000000005d862c]: bpf_prog_load+0x8ec/0xc80
> > [  141.545212] Caller[00000000005d9be4]: __sys_bpf+0x724/0x28a0
> > [  141.619558] Caller[00000000005dc338]: sys_bpf+0x18/0x60
> > [  141.688179] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
> > [  141.770535] Caller[fff000010089b80c]: 0xfff000010089b80c
> > [  141.840301] Instruction DUMP:
> > [  141.840305]  326ffffa=20
> > [  141.879185]  c4004000=20
> > [  141.910065]  c25e2038=20
> > [  141.940945] <c4006108>
> > [  141.971827]  80a0a000=20
> > [  142.002709]  04400014=20
> > [  142.033589]  c25860f0=20
> > [  142.064474]  8400bfff=20
> > [  142.095354]  8e00606c=20
> > [  142.126234]=20
> > [  142.176560] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000009
> > [  142.277218] Press Stop-A (L1-A) from sun keyboard or send break
> > [  142.277218] twice on console to return to the boot prom
> > [  142.423608] ---[ end Kernel panic - not syncing: Attempted to kill i=
nit! exitcode=3D0x00000009 ]---
>=20
> Disabling support for Transparent Huge Pages (CONFIG_THP) avoids the cras=
h.

Sorry, the option is called CONFIG_TRANSPARENT_HUGEPAGE, of course.

My suspicion is that it's related the flushing of D-Cache handling which is=
 enabled
for small pages only:

https://elixir.bootlin.com/linux/v6.16.5/source/arch/sparc/mm/ultra.S#L1016

and:

https://elixir.bootlin.com/linux/v6.16.5/source/arch/sparc/include/asm/page=
_64.h#L9

Interestingly, while running the reproducer with CONFIG_TRANSPARENT_HUGEPAG=
E disabled,
I'm also getting this kernel warning, but the kernel does not crash:

[  108.733686] CPU[0]: Cheetah+ D-cache parity error at TPC[00000000005d78b=
4]
[  108.824096] TPC<bpf_prog_load+0x394/0xc80>

Could it be that we need to enable the code guarded by DCACHE_ALIASING_POSS=
IBLE
unconditionally?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
