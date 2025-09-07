Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE4215E97;
	Sun,  7 Sep 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757267361; cv=none; b=FDxfIhMEbT900H1CwmRXN054o4atQQkcsdVzlAVYwb2vG9ZykBbM82ogvbnAgPKkltAznLcNC+9wEqTE8Nag5TicAgufMG4yQa58tK+uVzyFstKGyT8Y2w3lM8FZ1rk8BNCWFMs5XvpgAY1Aql+C9tx044BzdMRiKZyzS8qYjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757267361; c=relaxed/simple;
	bh=viQDgLLhuvbrnEKJE+gyciJe4edtIRb/Z1ju87zImSQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksl5Ye3R1tgSqTTlaurEMQVQv2GDdWHVdDN5bM6TE6mCNvEkfpgxK1yBNN8tANzxj52UisXEikHkoQIOcpTkU6eS1QAyfdAGHeAnonAVB7jJslQpagW2epb6oTWqmG06U8utEiRgLbi6mx+B6JwmN/Bym+vOcMCNx9RvQ2kh59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=qKoBqegt; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="qKoBqegt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=8LGI+mqwIUXnmQoJzUQSc6un6uZc5QbxSK+hiECwV90=; t=1757267358;
	x=1757872158; b=qKoBqegtR9zjHMMWPjcsb77jkYS4zsPjQns2j702VfJDs1pBpQl53T4dg8N3N
	Smwp/mExnN6Kh7HwjO0DdVpgGnk8Qgcn0zjU8mmF39q4IFZH0Lgu3NvOSxONhb2qbchUwYVBYjy4W
	6ez2uk0MZ32rjy7N8wUa2TdnskEUem4aTqJSTLDXmRVCmHQ6tuC7/D6y+cWJPM33LlbP3UvMjx+oa
	/L8T882PlfAnE+x5BrHVVWf+yHqFToOHmyLsqN0plmBe/YHgkq3AsbIuoczrIiw6pXlOFZ+fK1Kl0
	YMpFaWsv0AGupXLFi4LrcZqBjmeval4m+dbS5IvMyVlXB3W4SQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvJVr-00000002IJx-4Afn; Sun, 07 Sep 2025 19:49:16 +0200
Received: from dynamic-089-012-071-066.89.12.pool.telefonica.de ([89.12.71.66] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvJVr-00000003DIg-3AeA; Sun, 07 Sep 2025 19:49:15 +0200
Message-ID: <2fe65b101b36304369866e30f64a921591ecdd8b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Andreas Larsson
	 <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anthony Yznaga
	 <anthony.yznaga@oracle.com>, =?ISO-8859-1?Q?Ren=E9?= Rebe
 <rene@exactcode.com>
Date: Sun, 07 Sep 2025 19:49:15 +0200
In-Reply-To: <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
References: 
	<20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
		 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
	 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
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

On Sun, 2025-09-07 at 19:02 +0200, John Paul Adrian Glaubitz wrote:
> Hi Michael,
>=20
> On Fri, 2025-09-05 at 00:03 +0200, Michael Karcher wrote:
> > Anthony Yznaga tracked down that a BUG_ON in ext4 code with large folio=
s
> > enabled resulted from copy_from_user() returning impossibly large value=
s
> > greater than the size to be copied. This lead to __copy_from_iter()
> > returning impossible values instead of the actual number of bytes it wa=
s
> > able to copy.
> >=20
> > The BUG_ON has been reported in
> > https://lore.kernel.org/r/b14f55642207e63e907965e209f6323a0df6dcee.came=
l@physik.fu-berlin.de
> >=20
> > The referenced commit introduced exception handlers on user-space memor=
y
> > references in copy_from_user and copy_to_user. These handlers return fr=
om
> > the respective function and calculate the remaining bytes left to copy
> > using the current register contents. The exception handlers expect that
> > %o2 has already been masked during the bulk copy loop, but the masking =
was
> > performed after that loop. This will fix the return value of copy_from_=
user
> > and copy_to_user in the faulting case. The behaviour of memcpy stays
> > unchanged.
> >=20
> > Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurat=
e exception reporting.")
> > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> # o=
n Sun Netra 240
> > Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> > Tested-by: Ren=C3=A9 Rebe <rene@exactcode.com> # on UltraSparc III+ and=
 UltraSparc IIIi
> > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> > ---
> >  arch/sparc/lib/U3memcpy.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
> > index 9248d59c734ce200f1f55e6d9913277f18715a87..bace3a18f836f1428ae0ed7=
2b27aa1e00374089e 100644
> > --- a/arch/sparc/lib/U3memcpy.S
> > +++ b/arch/sparc/lib/U3memcpy.S
> > @@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
> >  	faligndata	%f10, %f12, %f26
> >  	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
> > =20
> > +	and		%o2, 0x3f, %o2
> >  	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
> >  	add		%o1, 0x40, %o1
> >  	bgu,pt		%XCC, 1f
> > @@ -336,7 +337,6 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
> >  	 * Also notice how this code is careful not to perform a
> >  	 * load past the end of the src buffer.
> >  	 */
> > -	and		%o2, 0x3f, %o2
> >  	andcc		%o2, 0x38, %g2
> >  	be,pn		%XCC, 2f
> >  	 subcc		%g2, 0x8, %g2
>=20
> It looks like the fix isn't actually complete for UltraSPARC III.
>=20
> There still seem to be edge-cases where this bug is triggered and that
> actually happens when configuring the systemd-timesyncd package and it's
> reproducible in 100% of the cases:
>=20
> [  125.301353] systemd-sysv-generator[1042]: Please update package to inc=
lude a native systemd unit file.
> [  125.424703] systemd-sysv-generator[1042]: =E2=9A=A0 This compatibility=
 logic is deprecated, expect removal soon. =E2=9A=A0
> [  127.206268] get_swap_device: Bad swap offset entry 808000000
> [  127.354181] get_swap_device: Bad swap offset entry 808000000
> [  127.449735] get_swap_device: Bad swap offset entry 808000000
> [  127.553698] get_swap_device: Bad swap offset entry 808000000
> [  127.701748] get_swap_device: Bad swap offset entry 808000000
> [  127.821914] get_swap_device: Bad swap offset entry 808000000
> [  127.939392] Unable to handle kernel paging request at virtual address =
00000001108ca000
> [  128.043605] tsk->{mm,active_mm}->context =3D 0000000000000555
> [  128.116890] tsk->{mm,active_mm}->pgd =3D fff0000009fd0000
> [  128.185604]               \|/ ____ \|/
> [  128.185604]               "@'/ .. \`@"
> [  128.185604]               /_| \__/ |_\
> [  128.185604]                  \__U_/
> [  128.378914] systemd-tty-ask(1054): Oops [#1]
> [  128.435046] CPU: 0 UID: 0 PID: 1054 Comm: systemd-tty-ask Not tainted =
6.17.0-rc4+ #11 NONE=20
> [  128.544945] TSTATE: 0000000011001606 TPC: 00000000007a5800 TNPC: 00000=
000007a5804 Y: 00000000    Not tainted
> [  128.674196] TPC: <lookup_swap_cgroup_id+0x40/0x80>
> [  128.737194] g0: fff000023f800040 g1: 0000000010000000 g2: 00000001008c=
a000 g3: 000000000153a8b8
> [  128.851572] g4: fff0000008d1b700 g5: fff000023e336000 g6: fff00000140f=
4000 g7: fff0000101934000
> [  128.965946] o0: fff0000008e6c180 o1: 0000000000000000 o2: 000000000000=
1000 o3: 0000000000000001
> [  129.080321] o4: 00000000000001ff o5: 0000000000000555 sp: fff00000140f=
6c81 ret_pc: 0000000000000000
> [  129.199272] RPC: <0x0>
> [  129.230149] l0: 0000000000000000 l1: fff0000008e6c180 l2: 000000000000=
0000 l3: 03ffffffffffffff
> [  129.344528] l4: 0000000000000004 l5: 0000000000000000 l6: 000000000000=
0001 l7: 0000000000000014
> [  129.458902] i0: 0000000080000000 i1: fff0000101900000 i2: fff00000140f=
75d8 i3: ffffffffffffffff
> [  129.573283] i4: 0000000000001000 i5: 0000000000000000 i6: fff00000140f=
6d31 i7: 00000000007173e0
> [  129.687653] I7: <swap_pte_batch+0x40/0x160>
> [  129.742653] Call Trace:
> [  129.774671] [<00000000007173e0>] swap_pte_batch+0x40/0x160
> [  129.846733] [<0000000000719998>] unmap_page_range+0x718/0x1200
> [  129.923366] [<000000000071a4f8>] unmap_single_vma.constprop.0+0x78/0xe=
0
> [  130.010289] [<000000000071a5b0>] unmap_vmas+0x50/0x160
> [  130.077767] [<00000000007288bc>] exit_mmap+0xbc/0x460
> [  130.144108] [<000000000047aec4>] mmput+0x64/0x180
> [  130.205867] [<0000000000483b38>] do_exit+0x218/0xb80
> [  130.271067] [<0000000000484664>] do_group_exit+0x24/0xa0
> [  130.340830] [<0000000000494848>] get_signal+0x948/0x9a0
> [  130.409458] [<000000000043eb68>] do_notify_resume+0xc8/0x5c0
> [  130.483802] [<0000000000404b48>] __handle_signal+0xc/0x30
> [  130.554715] Disabling lock debugging due to kernel taint
> [  130.624483] Caller[00000000007173e0]: swap_pte_batch+0x40/0x160
> [  130.702257] Caller[0000000000719998]: unmap_page_range+0x718/0x1200
> [  130.784610] Caller[000000000071a4f8]: unmap_single_vma.constprop.0+0x7=
8/0xe0
> [  130.877252] Caller[000000000071a5b0]: unmap_vmas+0x50/0x160
> [  130.950452] Caller[00000000007288bc]: exit_mmap+0xbc/0x460
> [  131.022508] Caller[000000000047aec4]: mmput+0x64/0x180
> [  131.089986] Caller[0000000000483b38]: do_exit+0x218/0xb80
> [  131.160901] Caller[0000000000484664]: do_group_exit+0x24/0xa0
> [  131.236387] Caller[0000000000494848]: get_signal+0x948/0x9a0
> [  131.310736] Caller[000000000043eb68]: do_notify_resume+0xc8/0x5c0
> [  131.390795] Caller[0000000000404b48]: __handle_signal+0xc/0x30
> [  131.467427] Caller[fff0000101600238]: 0xfff0000101600238
> [  131.537197] Instruction DUMP:
> [  131.537201]  c458c002=20
> [  131.576079]  83287002=20
> [  131.606963]  b12e2004=20
> [  131.637839] <c2008001>
> [  131.668723]  b1304018=20
> [  131.699603]  b12e3030=20
> [  131.730486]  81cfe008=20
> [  131.761364]  91323030=20
> [  131.792249]  b0102000=20
> [  131.823130]=20
> [  131.873450] Fixing recursive fault but reboot is needed!

Michael suggested switching to the generic copy_{to,from}_user code offlist
to verify this:

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index c305486501dc..cd1a96a918b3 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -687,7 +687,7 @@ cheetah_tlb_fixup:
        stw     %g2, [%g1 + %lo(tlb_type)]
=20
        /* Patch copy/page operations to cheetah optimized versions. */
-       call    cheetah_patch_copyops
+       call    generic_patch_copyops
         nop
        call    cheetah_patch_copy_page
         nop

The kernel still crashes, even when using the generic code.

So, this particular issue is not rooted in the U3_copy_{to,from}_user code.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
