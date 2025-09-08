Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7F1E86E;
	Mon,  8 Sep 2025 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313028; cv=none; b=slDiqT6thG3do9s1SRhoQXbFUlV282AjBoDF98N6ivtKPYZF0JeyahUrAcPYT8VmjImrkcpS5LzXyFheAKzkNYYY7ImCGM4WGjPKTbntV2F3+fRenj7hb0mfkaTk/SDp82MRlQvCOEscY9jBSd3Efknhp8UddtLla9U1xaOedk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313028; c=relaxed/simple;
	bh=w5n66ZrzROfszoDhcsYnI4ip/cCA2IWGQNLKtWkXb6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJa30neJd1AnMnTAcp8RLHA1HarGE9cBVLUlOHueqHpdPWCIUujpGhTydbVFietSmI8Be1zFjeTATjSvxhjynmZt62+DviAmkKS4yDMCfqmHT2gsu6+ScecmH08BOqquFEa+C6UWhZr9lvdpdYKhqPz36PVeLO5lzBhNk3WGEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lG3YOYFa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lG3YOYFa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=jSehJd7YYQizt979CNgAa/MvKVO/aqIbX1THoGH2RyE=; t=1757313024;
	x=1757917824; b=lG3YOYFaOCHBAmuT4Ac8rEZCmJHCGWqJVbT84V1jvppzUdpCJYAd7s6OAWP79
	rOOk9zmNIW8cQ5MTIMs1hpHku/wOE2D0zJKADblr85EhPnMwKEGjHR4eAooHpFqn1bJbDvc3K/x3P
	WcpzQvdtNjrrtKmeN3OpCoK0Zwd2BdtmddjNofvHX0vKafas/ejM1izwgqGt2e5f1hNGL4f7dA2V4
	sIa+DXxZyr+5GIlfxbpF/aIW1pmCaA6CJ5lY8fIkLlUAPHzeOykJUckqB9KAYj76y7jeb/zJn/ueV
	kZfu2uCT2BllCK51v37FNBRdeR+kQ2L+RkgVDDYIy99M9M2EcA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvVOO-0000000069q-20Iv; Mon, 08 Sep 2025 08:30:20 +0200
Received: from dynamic-077-183-099-053.77.183.pool.telefonica.de ([77.183.99.53] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvVOO-00000000MLE-13jc; Mon, 08 Sep 2025 08:30:20 +0200
Message-ID: <03957ee5ee562b70f7e3278d0ce95b2f52cbc721.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Andreas Larsson
	 <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anthony Yznaga
	 <anthony.yznaga@oracle.com>, =?ISO-8859-1?Q?Ren=E9?= Rebe
 <rene@exactcode.com>
Date: Mon, 08 Sep 2025 08:30:19 +0200
In-Reply-To: <c3e1173f99e6222ab09093e1a197d6366bcf2b95.camel@physik.fu-berlin.de>
References: 
	<20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
					 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
				 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
			 <2fe65b101b36304369866e30f64a921591ecdd8b.camel@physik.fu-berlin.de>
		 <e791dbb534aac79805389a4b754901c24991de89.camel@physik.fu-berlin.de>
	 <c3e1173f99e6222ab09093e1a197d6366bcf2b95.camel@physik.fu-berlin.de>
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

Hi,

On Sun, 2025-09-07 at 23:31 +0200, John Paul Adrian Glaubitz wrote:
> Hi,
>=20
> On Sun, 2025-09-07 at 20:33 +0200, John Paul Adrian Glaubitz wrote:
> > I assume that cheetah_patch_cachetlbops has to be invoked on UltraSPARC=
 III
> > since there is other code depending on it. On the other hand, the TLB c=
ode
> > on UltraSPARC III was heavily overhauled in 2016 [1] which was also fol=
lowed
> > by a bug fix [2].
> >=20
> > Chances are there are still bugs in the code introduced in [1].
> >=20
> > > [1] https://github.com/torvalds/linux/commit/a74ad5e660a9ee1d071665e7=
e8ad822784a2dc7f
> > > [2] https://github.com/torvalds/linux/commit/d3c976c14ad8af421134c428=
b0a89ff8dd3bd8f8
>=20
> I have reverted both commits. The machine boots until it tries to start
> systemd when it locks up. So, I guess if there is a bug in the TLB code
> it needs to be diagnosed differently.

Another test with a kernel source rebased to 6.17-rc5+, with the following =
patch applied
by Anthony Yznaga and CONFIG_SMP disabled:

diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 70e658d107e0..b323db303de1 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -347,6 +347,7 @@ __cheetah_flush_tlb_kernel_range:	/* 31 insns */
  	membar		#Sync
  	stxa		%g0, [%o4] ASI_IMMU_DEMAP
  	membar		#Sync
+	flush
  	retl
  	 nop
  	nop
@@ -355,7 +356,6 @@ __cheetah_flush_tlb_kernel_range:	/* 31 insns */
  	nop
  	nop
  	nop
-	nop

  #ifdef DCACHE_ALIASING_POSSIBLE
  __cheetah_flush_dcache_page: /* 11 insns */

Still crashes:

[  139.236744] tsk->{mm,active_mm}->context =3D 00000000000000ab
[  139.310042] tsk->{mm,active_mm}->pgd =3D fff0000007db8000
[  139.378747]               \|/ ____ \|/
[  139.378747]               "@'/ .. \`@"
[  139.378747]               /_| \__/ |_\
[  139.378747]                  \__U_/
[  139.572059] systemd(1): Oops [#1]
[  139.615613] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.17.0-rc5+ #=
19 NONE=20
[  139.712832] TSTATE: 0000004411001602 TPC: 00000000005e29e4 TNPC: 0000000=
0005e29e8 Y: 00000000    Not tainted
[  139.842076] TPC: <bpf_patch_insn_data+0x204/0x2e0>
[  139.905077] g0: ffffffffffffffff g1: 0000000000000000 g2: 00000000000000=
65 g3: fff0000009618b28
[  140.019460] g4: fff00000001f9500 g5: 0000000000657300 g6: fff000000022c0=
00 g7: 0000000000000001
[  140.133837] o0: 0000000100058000 o1: 0000000000000000 o2: 00000000000000=
01 o3: 0000000000000002
[  140.248208] o4: fff00000045ec900 o5: 0000000000000002 sp: fff000000022f0=
31 ret_pc: 00000000005e2998
[  140.367158] RPC: <bpf_patch_insn_data+0x1b8/0x2e0>
[  140.430057] l0: fff0000009618000 l1: 0000000100046048 l2: 00000000000000=
01 l3: 0000000100058000
[  140.544437] l4: 0000000100046068 l5: 0000000000000005 l6: 00000000000000=
00 l7: fff000000961e128
[  140.658810] i0: 0000000100046000 i1: 0000000000000004 i2: 00000000000000=
05 i3: 0000000000000002
[  140.773189] i4: 0000000100066000 i5: fff0000009618ae8 i6: fff000000022f0=
e1 i7: 0000000000607a08
[  140.887561] I7: <bpf_check+0x1988/0x34a0>
[  140.940171] Call Trace:
[  140.972191] [<0000000000607a08>] bpf_check+0x1988/0x34a0
[  141.041963] [<00000000005d862c>] bpf_prog_load+0x8ec/0xc80
[  141.114021] [<00000000005d9be4>] __sys_bpf+0x724/0x28a0
[  141.182646] [<00000000005dc338>] sys_bpf+0x18/0x60
[  141.245551] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
[  141.322185] Disabling lock debugging due to kernel taint
[  141.391952] Caller[0000000000607a08]: bpf_check+0x1988/0x34a0
[  141.467440] Caller[00000000005d862c]: bpf_prog_load+0x8ec/0xc80
[  141.545212] Caller[00000000005d9be4]: __sys_bpf+0x724/0x28a0
[  141.619558] Caller[00000000005dc338]: sys_bpf+0x18/0x60
[  141.688179] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
[  141.770535] Caller[fff000010089b80c]: 0xfff000010089b80c
[  141.840301] Instruction DUMP:
[  141.840305]  326ffffa=20
[  141.879185]  c4004000=20
[  141.910065]  c25e2038=20
[  141.940945] <c4006108>
[  141.971827]  80a0a000=20
[  142.002709]  04400014=20
[  142.033589]  c25860f0=20
[  142.064474]  8400bfff=20
[  142.095354]  8e00606c=20
[  142.126234]=20
[  142.176560] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000009
[  142.277218] Press Stop-A (L1-A) from sun keyboard or send break
[  142.277218] twice on console to return to the boot prom
[  142.423608] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x00000009 ]---

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
