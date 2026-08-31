Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709E35CBD6;
	Mon, 31 Aug 2026 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202491; cv=none; b=IAad+29fL19SAQ9Wy9ObuWtHbGgCIdIQ7MeHLLR+BP9uDbC3mYSU/AoG6pApd0U+fy0G7se/zneftR1w51XLHEBepVkvAIyMhZ5sJOnVsr+jCrdn36sjnBaAHXFJs2A4s25lUeRwGP7iAuXJ8vZS0TZQ14dgp99ajwkFwv3Rz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202491; c=relaxed/simple;
	bh=SVszuBnjkh4LvSoVjClvaHKYPF5PXx1qZak6pkRAAc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PlTsSqorgE7/vEtkG7MAJBQOSEk91PwFJ65gEKJ2twqAhTQ1TUG8dFr0ub2+Ff140RwFb2CH+HhR158VgZS74PFZqnBqSQEIAXPErCTE4K0Hs3xNBsy8QS1B044aYSAZIjVAoPxsXAbH8iQgl3/t1lI7mzc6RIazILLWf5vPjq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=B6oKVLVS; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="B6oKVLVS"
Message-ID: <680606d594645568c21afcc552558882c4f59a96.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788202487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVszuBnjkh4LvSoVjClvaHKYPF5PXx1qZak6pkRAAc4=;
	b=B6oKVLVS+tO0Ge8wthaj+H1yjDdvqA6CNlyZ1DUdhifYitSDFj/yLib02CuGTSuwXCetut
	dqw8KO0KwE+f1ym5k0Hn39qY2kRBxLrhEgvGLaaulvYhBk1Ae2/FEAIReV/y9k0WsI8R++
	+SQXaI6CSGOuhfFBevkvzvt1J35351U=
Subject: Re: [PATCH v2] sparc64: increase kernel thread stack size to 32K
From: Stian Halseth <stian@itx.no>
To: Tony Rodriguez <unixpro1970@gmail.com>, andreas@gaisler.com, 
	davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, 
 glaubitz@physik.fu-berlin.de, thuth@redhat.com,
 regressions@lists.linux.dev,  nroach44@nroach44.id.au
Date: Mon, 31 Aug 2026 20:54:46 +0200
In-Reply-To: <afaa8ced-0717-4d62-8ea6-4ecdbf489694@gmail.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
	 <20260831172928.3082853-1-stian@itx.no>
	 <afaa8ced-0717-4d62-8ea6-4ecdbf489694@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tony,=20

You're welcome.=A0

I saw it was stuck, and wanted to push it along. Looks to me like a
proper fix that should be included.

PS: Don't want to take any credit, this is 100% your fix. If you rather
want to handle it yourself, let me know :)

--=20
Best regards
Stian Halseth



On Mon, 2026-08-31 at 11:25 -0700, Tony Rodriguez wrote:
>=20
> When I compile the kernel with -fstack-usage to generate .su files,
> on=20
> 7.1 kerner, the static analysis shows small stack frames for all USB=20
> core functions.
> For example:
>=20
> hub_event:=A0 =A0 =A0 2457 bytes=A0 (static)
> hub_activate:=A0 =A01892 bytes=A0 (static)
> usb_control_msg: 1248 bytes (static)
>=20
> However, my runtime stack tracing shows a dramatically different
> picture:
>=20
> STACKTRACE: hub_event():entry: 31856 bytes used
> STACKTRACE: hub_activate():entry: 31680 bytes used
> STACKTRACE: usb_control_msg():entry: 30768 bytes used
>=20
I'm not quite sure what I'm looking at. Stack usage must _increase_
with call depth, but looks like it's decreasing?

That shouldn't be possible, but maybe I'm misreading something?

It kinda looks like you're showing sp - stack_base (space left).=20

CONFIG_STACK_TRACER on the T4-1 measures 12.6K worst-case against 32K.
Could you re-measure with stacktrace on the kernel command line?=A0
Happy to share the exact config/procedure.
>=20
> PS - I have not tested a 64K stack yet, only 32K, and this is a
> heads-up=20
> recommendation.
>=20
>=20
> Tony
>=20
> On 8/31/26 10:29 AM, Stian Halseth wrote:
> > From: Tony Rodriguez <unixpro1970@gmail.com>
> >=20
> > Kernel stacks on sparc64 are 16K and this is no longer enough:
> > several machines (SPARC T5-2 among them) panic early in boot during
> > USB hub enumeration with "corrupted stack end detected inside
> > scheduler". sparc has not been converted to THREAD_INFO_IN_TASK, so
> > thread_info sits at the bottom of the kernel stack and a marginal
> > overflow corrupts it first; CONFIG_SCHED_STACK_END_CHECK then fires
> > from __schedule long after the deep path has unwound, which is why
> > the reported backtraces look shallow.
> >=20
> > Measurements with CONFIG_STACK_TRACER on an UltraSPARC T4-1 show
> > the
> > problem is frame count, not any single large frame. The high-water
> > mark of an ordinary successful boot is 12616 of 16384 bytes (77%),
> > reached in hub_probe() with a printk console flush and then a timer
> > interrupt (which runs on the task stack, and whose scheduler tick
> > performs load balancing and IPI delivery) stacked on top. Of the 66
> > frames in that path the largest is 408 bytes, and ~85% of them are
> > 176-224 bytes - at or just above the SPARC V9 ABI minimum frame
> > (128-byte register window save area plus 48-byte argument save
> > area). An equivalent call chain on x86-64 costs roughly a third of
> > the stack, so a 16K stack on sparc64 provides far less effective
> > call depth than on other 64-bit architectures.
> >=20
> > Double THREAD_SIZE to 32K (four 8K pages). The PAGE_SHIFT
> > conditionals are dropped: sparc64 only supports 8K base pages, so
> > the other branches were dead code. Kernel stacks become order-2
> > allocations; sparc64 has no VMAP_STACK, but stacks are allocated
> > once per thread and the trade against boot-time panics is a good
> > one.
> >=20
> > Link: https://lore.kernel.org/all/20260519075809.8993-1-
> > unixpro1970@gmail.com/
> > Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
> > [stian: reduced the diff to the THREAD_* defines, measured stack
> > =A0 usage with CONFIG_STACK_TRACER and rewrote the changelog]
> > Signed-off-by: Stian Halseth <stian@itx.no>
> > ---
> > v2:
> > =A0 - drop the CONFIG_SPARC64 / PAGE_SHIFT conditional chain from v1;
> > =A0=A0=A0 thread_info_64.h is only built on sparc64 and only 8K pages a=
re
> > =A0=A0=A0 supported, so define the three constants unconditionally
> > =A0 - replace the panic backtrace in the changelog with stack tracer
> > =A0=A0=A0 measurements answering David Laight's review comments:
> > =A0=A0=A0 https://lore.kernel.org/all/20260520144104.618c75ca@pumpkin/
> > =A0 - retitled from "unify thread stack sizing and add explicit 32KB
> > =A0=A0=A0 stack"; the sizing logic for other configurations is unchange=
d
> >=20
> > Tested on an UltraSPARC T4-1, booted with the stack tracer armed
> > ("stacktrace") before and after this patch. The boot high-water
> > mark
> > is 12616 bytes on both kernels - the worst path (hub_probe with a
> > printk and a timer interrupt on top) is deterministic - i.e. 77% of
> > the 16K stack before, 38% of the 32K stack after. DEBUG_STACK_USAGE
> > agrees: the peak boot-time task shows 9208 bytes left of 16K before
> > vs 25592 bytes left of 32K after (7176 bytes used in both).
> >=20
> > =A0 arch/sparc/include/asm/thread_info_64.h | 15 +++------------
> > =A0 1 file changed, 3 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/arch/sparc/include/asm/thread_info_64.h
> > b/arch/sparc/include/asm/thread_info_64.h
> > --- a/arch/sparc/include/asm/thread_info_64.h
> > +++ b/arch/sparc/include/asm/thread_info_64.h
> > @@ -99,13 +99,8 @@
> > =A0 #define FAULT_CODE_BLKCOMMIT 0x10 /* Use blk-commit ASI in
> > copy_page */
> > =A0 #define FAULT_CODE_BAD_RA 0x20 /* Bad RA for sun4v =A0=A0 */
> > =A0=20
> > -#if PAGE_SHIFT =3D=3D 13
> > -#define THREAD_SIZE (2*PAGE_SIZE)
> > -#define THREAD_SHIFT (PAGE_SHIFT + 1)
> > -#else /* PAGE_SHIFT =3D=3D 13 */
> > -#define THREAD_SIZE PAGE_SIZE
> > -#define THREAD_SHIFT PAGE_SHIFT
> > -#endif /* PAGE_SHIFT =3D=3D 13 */
> > +#define THREAD_SIZE (4 * PAGE_SIZE)
> > +#define THREAD_SHIFT (PAGE_SHIFT + 2)
> > =A0=20
> > =A0 /*
> > =A0=A0 * macros/functions for gaining access to the thread information
> > structure
> > @@ -128,11 +123,7 @@
> > =A0 #endif
> > =A0=20
> > =A0 /* thread information allocation */
> > -#if PAGE_SHIFT =3D=3D 13
> > -#define THREAD_SIZE_ORDER 1
> > -#else /* PAGE_SHIFT =3D=3D 13 */
> > -#define THREAD_SIZE_ORDER 0
> > -#endif /* PAGE_SHIFT =3D=3D 13 */
> > +#define THREAD_SIZE_ORDER 2
> > =A0=20
> > =A0 #define __thread_flag_byte_ptr(ti) \
> > =A0=A0 ((unsigned char *)(&((ti)->flags)))
> > --
> > 2.53.0
