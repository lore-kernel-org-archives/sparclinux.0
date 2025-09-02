Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0292E3AEA;
	Tue,  2 Sep 2025 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794133; cv=none; b=b7jT4RHRHHa9QnNSm0l+7Ys3E9ddfF1AGdlOfEtsFI+1wA6ntM498KFYTtSZgZhNHxFsgtsBgK7M7Ku8RfJCPIVx0ooQIHG7Jk+pRBbW+bHBN6UuCLRYipvbE42UAd6YYAKBuHpaOnaJ8h4glMbH19NpYqKCW2NDWrNDJEsJdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794133; c=relaxed/simple;
	bh=/JzarLfnO10vwcVCjWPLp9g0mslhv6ZlQ4oNdQEkKrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRL/ChvZyYF41vd8BPNv4AgmlYUBeH0WIF3XIJK5gT0kESpOcXWBQ3ts4iNxi9cJh+vaLmOYY+B9Wu02sfmgwt5Tk4IKAFz/JqjACjlKXjPD8tpnEQBFGG4/1UtwduQOUP/Xe30lib29p2zVptP0x5G6qBK8TL+E+hQifh15urQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t/mnyW06; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FvUyXBp+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t/mnyW06";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FvUyXBp+"
Date: Tue, 2 Sep 2025 08:21:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756794120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXZ4NFZST9k9eCqT7GnCjhCmIr6XUYHHjmpA9MGgNoA=;
	b=t/mnyW069WDZdYSg1nT6BNAUY4fXh3FNfp/XAK3xQwLYLYj6HoeGPfCNzmZMZ7oReEoBEp
	DZDoEhPdYML98ymWgf54Z8iJIvtiZU6Bdt5SpGoajpqnnnyVjphOcDCDeKoXyty8ZNjaTO
	F19lrSSyf2xWFL5Lvgz0STFNTIKUiAaYW3fBKC9zPz5eiX+o9BeAXHXHNKenGYYvWaRd8c
	SQ+vTCmAJfiYPNujN0Gt58LHVV+X4uEibbFSzSWUXf+/OzTXjjUdZ18oavIjhigKnp5ukZ
	z1ZKEBrwe7Z1R+q0a+HJeRahyLeT37Y/5rsV/wwvHJPaFHD7IzpGXjcIyAtL4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756794120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXZ4NFZST9k9eCqT7GnCjhCmIr6XUYHHjmpA9MGgNoA=;
	b=FvUyXBp+pWllf4tyaqMG7VZrEVqzZLT81k8wrvlKRbd8zvo2jnAgChYNIaEpLHVH0yGIr9
	kVK3Ac8hgxflnnDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	"David S . Miller" <davem@davemloft.net>, Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
	Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
Message-ID: <20250902074631-2f608b5c-ae1d-46a1-9849-15c4543855af@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
 <b7ab1bdca349208532804d0d5e5af56817cd25c6.camel@physik.fu-berlin.de>
 <20250829124314-288d0445-a744-4022-93bf-7da255182411@linutronix.de>
 <6390486f-ccc7-4f77-8126-1e0b3b67bc75@app.fastmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6390486f-ccc7-4f77-8126-1e0b3b67bc75@app.fastmail.com>

On Mon, Sep 01, 2025 at 05:17:13PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 29, 2025, at 12:52, Thomas Weißschuh wrote:
> > On Fri, Aug 29, 2025 at 12:40:59PM +0200, John Paul Adrian Glaubitz wrote:
> >> On Fri, 2025-08-29 at 12:37 +0200, Thomas Weißschuh wrote:
> >> > In the meantime I installed a full Debian, but the bug is still not
> >> > reproducible in QEMU.
> >> 
> >> Please keep in mind that QEMU emulates sun4u (on UltraSPARC II) while
> >> Andreas was testing on sun4v (on Niagara 4). There might be differences.
> >
> > I am aware. Unfortuntely I don't have anything else available.
> > If anybody could test this on real sun4u that would be great.
> > Or teach me how to use sun4v QEMU without it crashing on me.
> > In the past you offered access to a physical machine.
> > Does this offer still stand? Does it also run into the bug?
> 
> It should be enough to set the cpu to a different type. As far
> as I can tell, the three different cases are all determined by the
> MMU/CPU ID, not the platform type (sun4u/sun4v).
> 
> As far as I can tell, the options are:
> 
> - JPS1 (UltraSPARCIII, SPARC64 V) and later use modern 'stick' operations
> - UltraSparc IIe (Hummingbird) uses 'hbtick' without VDSO
> - All other plain V9 implementations use 'tick'
> 
> To test all three cases, it should be enough to run qemu with e.g.
> "-cpu Sun-UltraSparc-IV", "-cpu TI-UltraSparc-IIe", and
> "-cpu TI-UltraSparc-II", respectively.

Sun-UltraSparc-IV and TI-UltraSparc-IIe don't boot for me with either my
Debian-derived config nor sparc64_defconfig, for details see below.
But looking at Andreas' reports, the issue is not in the tick reading but my
asm implementation of __arch_get_vdso_u_time_data().


Sun-UltraSparc-IV dies in the second instruction of cheetah_generic_boot:

	OpenBIOS for Sparc64
	Configuration device id QEMU version 1 machine id 0
	kernel phys 404000 virt 40004000 size 0x1358650
	initrd phys 175a000 virt 40c00000 size 0x1727675
	kernel cmdline root=UUID=ac350b43-e843-40ad-bd55-ec4c2eaeb468
	CPUs: 1 x SUNW,UltraSPARC-IV
	UUID: 00000000-0000-0000-0000-000000000000
	Welcome to OpenBIOS v1.1 built on Sep 24 2024 19:56
	  Type 'help' for detailed information
	[sparc64] Kernel already loaded
	Unhandled Exception 0x0000000000000032
	PC = 0x0000000040004654 NPC = 0x0000000040004658
	Stopping execution

QEMU debugging:

	   533: Data Access Error (v=0032)
	pc: 0000000040004654  npc: 0000000040004658
	%g0-3: 0000000000000000 0018310005070000 0000000000000076 0000000000000048
	%g4-7: 0000000000000075 00000000ffe81000 0000000000000000 0000000000000018
	%o0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
	%o4-7: 00000000ffd0d904 00000000ffecb5e0 00000000ffecafc1 0000000040004398 
	%l0-3: 0000000040004190 0000000000000036 0000000000000000 0000000000400000 
	%l4-7: 00000000003fffff 00000000fef84930 0000000000000000 00000000ffd0d904 
	%i0-3: 0000000000000000 0000000000000000 0000000000000000 00000000ffeb5400 
	%i4-7: 00000000ffd85800 0000000000000000 00000000ffecb071 00000000ffd0e8c8 
	pstate: 00000016 ccr: 00 (icc: ---- xcc: ----) asi: 00 tl: 0 pil: 0 gl: 2
	tbr: 00000000ffd00000 hpstate: 0000000000000000 htba: 0000000000000000
	cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 7 cwp: 5
	fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000

Disassembly:

	0000000000404650 <cheetah_generic_boot>:
	;       mov     TSB_EXTENSION_P, %g3
	  404650: 86 10 20 48   mov     72, %g3
	;       stxa    %g0, [%g3] ASI_DMMU
	  404654: c0 f0 cb 00   stxa %g0, [%g3] 88
	;       stxa    %g0, [%g3] ASI_IMMU
	  404658: c0 f0 ca 00   stxa %g0, [%g3] 80
	;       membar  #Sync
	  40465c: 81 43 e0 40   membar #Sync
	;       mov     TSB_EXTENSION_S, %g3
	  404660: 86 10 20 50   mov     80, %g3
	;       stxa    %g0, [%g3] ASI_DMMU
	  404664: c0 f0 cb 00   stxa %g0, [%g3] 88
	;       membar  #Sync
	  404668: 81 43 e0 40   membar #Sync
	;       mov     TSB_EXTENSION_N, %g3
	  40466c: 86 10 20 58   mov     88, %g3
	;       stxa    %g0, [%g3] ASI_DMMU
	  404670: c0 f0 cb 00   stxa %g0, [%g3] 88
	;       stxa    %g0, [%g3] ASI_IMMU
	  404674: c0 f0 ca 00   stxa %g0, [%g3] 80
	;       membar  #Sync
	  404678: 81 43 e0 40   membar #Sync
	;       ba,a,pt %xcc, jump_to_sun4u_init
	  40467c: 30 68 00 04   ba,a %xcc, 4


TI-UltraSparc-IIe dies in a division by zero in init_tick_ops:

	OpenBIOS for Sparc64
	Configuration device id QEMU version 1 machine id 0
	kernel phys 404000 virt 40004000 size 0x1358650
	initrd phys 175a000 virt 40c00000 size 0x1727675
	kernel cmdline root=UUID=ac350b43-e843-40ad-bd55-ec4c2eaeb468
	CPUs: 1 x SUNW,UltraSPARC-IIe
	UUID: 00000000-0000-0000-0000-000000000000
	Welcome to OpenBIOS v1.1 built on Sep 24 2024 19:56
	  Type 'help' for detailed information
	[sparc64] Kernel already loaded

	Unhandled Exception 0x0000000000000028
	PC = 0x00000000015f4444 NPC = 0x00000000015f4448
	Stopping execution

QEMU debugging:

	   892: Division By Zero (v=0028)
	pc: 00000000015f4444  npc: 00000000015f4448
	%g0-3: 0000000000000000 00000000ffffffff 000000ee6b280000 0000000000441400
	%g4-7: 0000000001456280 0000000000000000 0000000001434000 0000000000000000
	%o0-3: 0000000000000000 0000000000000000 ffffffffffffffff 00000000012c2d08 
	%o4-7: 0000000000000000 0000000001757c00 0000000001437491 00000000015f4418 
	%l0-3: 0000000001757c00 00000000ffe80dc8 00000000ffd84c00 00000000ffecb7bb 
	%l4-7: 0000000000000000 00000000ffeb5400 000000000000ffff 0000000000000000 
	%i0-3: 0000000001444c98 000000000000000d 0000000001757c00 0000000000000000 
	%i4-7: 0000000000000000 000000ee6b280000 0000000001437541 00000000015f4610 
	pstate: 00000016 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 80 tl: 0 pil: 0 gl: 2
	tbr: 00000000ffd00000 hpstate: 0000000000000000 htba: 0000000000000000
	cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 7 cwp: 0
	fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000

Disassembly:

	00000000015f4410 <init_tick_ops>:
	; {
	 15f4410: 9d e3 bf 50   save %sp, -176, %sp
	;       freq = ops->get_frequency();
	 15f4414: c2 5e 20 40   ldx [%i0+64], %g1
	 15f4418: 9f c0 40 00   call %g1
	 15f441c: 01 00 00 00   nop
	;       do_div(tmp, freq);
	 15f4420: 82 10 3f ff   mov     -1, %g1
	;       tmp += freq/2; /* round for do_div */
	 15f4424: 05 1d cd 65   sethi 1953125, %g2
	;       tick = ops->get_tick();
	 15f4428: c6 5e 20 10   ldx [%i0+16], %g3
	;       do_div(tmp, freq);
	 15f442c: 83 30 70 20   srlx %g1, 32, %g1
	;       tmp += freq/2; /* round for do_div */
	 15f4430: 85 28 b0 09   sllx %g2, 9, %g2
	 15f4434: bb 32 20 01   srl %o0, 1, %i5
	;       do_div(tmp, freq);
	 15f4438: 8e 0a 00 01   and %o0, %g1, %g7
	;       tmp += freq/2; /* round for do_div */
	 15f443c: ba 07 40 02   add %i5, %g2, %i5
	;       freq = ops->get_frequency();
	 15f4440: b8 10 00 08   mov     %o0, %i4
	;       do_div(tmp, freq);
	 15f4444: ba 6f 40 07   udivx %i5, %g7, %i5
	...
