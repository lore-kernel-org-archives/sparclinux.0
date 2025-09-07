Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836121922FD;
	Sun,  7 Sep 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757266378; cv=none; b=en0ER9URH7CbXPIyq+OAH6XHg9+ZoBxjZ+Ivki8yjPoIugN6RTgjiAC0TSvbpLOodn6QkLcPtrzn/1o5h/bRUw7dIM6Enu+q92JScXPdYFg6/4V3Jiee68zw/BwIrQfLsbDmVpPl2el5A1ccWh/dHWde2Bm1Uz7Dx8ONCswHpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757266378; c=relaxed/simple;
	bh=lIQISI6nTxyO/HkgTWARg+NilNfgaGX3a4nT1pDxIiE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YqDGFZXJe9Iti0d860jrn4JJOZwWm1jB5P4Z2wiBQlzIB4nAa+2V8/aCgY9dm6cz5kdv/8iEtM0QV3C+AUZJqY/lp+BMuAZrtdvh6n5qtYcoYXAN8+E4LQggFnCV8Ih+4N6/MClly1O+QOmlxYyosprKAPVRsFqTeJZY6+Yiskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=FcGqzuD+; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="FcGqzuD+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=A76I4Cw/JUI8Lct9eMiRhHODRoFKwuFzpb6mJeg53+0=; b=FcGqzuD+LrE4/07WuXc3IeopF/
	SurvbqME63M10kiEQRkm3xRulbNqzE7KJmne8el2enQmQcJvtUfUnxp+Sd0yl+PAUJWy+Zp5sKQc9
	6FM5HrKc7T0QasRYCCYHTWsM2sof5Kmk/hUkXx3bnD4AoAwhs5bS8DOMkl1NyaaPwhMm8sXM8dr9e
	PFU/Cr+Ic8XJTnoEjxv7xUai3xsMML/IBnZ2n/OmrKAXADRajneaRzb9wPu2jsD1FZ1GN5BBDOB/u
	gGrF/TsecRpu8mUYde206ofv3WPY9Q6EEUGHTYPwKT0gWWvqjVxWwKE/LoGxOuyHndDWfbdZz/bSD
	Y3Bdub3A==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
Date: Sun, 7 Sep 2025 19:32:44 +0200
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 Andreas Larsson <andreas@gaisler.com>,
 sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Anthony Yznaga <anthony.yznaga@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6D1F756-419D-448A-AF35-387FDA16AC00@exactco.de>
References: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi Adrian,

> On 7. Sep 2025, at 19:02, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> Hi Michael,
>=20
> On Fri, 2025-09-05 at 00:03 +0200, Michael Karcher wrote:
>> Anthony Yznaga tracked down that a BUG_ON in ext4 code with large =
folios
>> enabled resulted from copy_from_user() returning impossibly large =
values
>> greater than the size to be copied. This lead to __copy_from_iter()
>> returning impossible values instead of the actual number of bytes it =
was
>> able to copy.
>>=20
>> The BUG_ON has been reported in
>> =
https://lore.kernel.org/r/b14f55642207e63e907965e209f6323a0df6dcee.camel@p=
hysik.fu-berlin.de
>>=20
>> The referenced commit introduced exception handlers on user-space =
memory
>> references in copy_from_user and copy_to_user. These handlers return =
from
>> the respective function and calculate the remaining bytes left to =
copy
>> using the current register contents. The exception handlers expect =
that
>> %o2 has already been masked during the bulk copy loop, but the =
masking was
>> performed after that loop. This will fix the return value of =
copy_from_user
>> and copy_to_user in the faulting case. The behaviour of memcpy stays
>> unchanged.
>>=20
>> Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to =
accurate exception reporting.")
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> # =
on Sun Netra 240
>> Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> Tested-by: Ren=C3=A9 Rebe <rene@exactcode.com> # on UltraSparc III+ =
and UltraSparc IIIi
>> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
>> ---
>> arch/sparc/lib/U3memcpy.S | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
>> index =
9248d59c734ce200f1f55e6d9913277f18715a87..bace3a18f836f1428ae0ed72b27aa1e0=
0374089e 100644
>> --- a/arch/sparc/lib/U3memcpy.S
>> +++ b/arch/sparc/lib/U3memcpy.S
>> @@ -267,6 +267,7 @@ FUNC_NAME: /* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>> faligndata %f10, %f12, %f26
>> EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
>>=20
>> + and %o2, 0x3f, %o2
>> subcc GLOBAL_SPARE, 0x80, GLOBAL_SPARE
>> add %o1, 0x40, %o1
>> bgu,pt %XCC, 1f
>> @@ -336,7 +337,6 @@ FUNC_NAME: /* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>> * Also notice how this code is careful not to perform a
>> * load past the end of the src buffer.
>> */
>> - and %o2, 0x3f, %o2
>> andcc %o2, 0x38, %g2
>> be,pn %XCC, 2f
>> subcc %g2, 0x8, %g2
>=20
> It looks like the fix isn't actually complete for UltraSPARC III.
>=20
> There still seem to be edge-cases where this bug is triggered and that
> actually happens when configuring the systemd-timesyncd package and =
it's
> reproducible in 100% of the cases:

It is probably a good time to mention that there are likely some other =
major
TLB (or so) bug on U3. For example, I could never boot any Linux kernel
(probably ever) with 8GB installed in my Sun Blade 1000 - it would NULL =
ptr
deref very early:

Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 0000000000000000
tsk->{mm,active_mm}->pgd =3D fff00001ff002000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.11-t2 #45
TSTATE: 0000009980e01602 TPC: 0000000000c5ec98 TNPC: 0000000000c5ec9c Y: =
f9e69dcb    Not tainted
TPC: <subsection_map_init+0x50/0x98>
g0: 0000000010d7d038 g1: 0000000000000000 g2: 0000000000000000 g3: =
0000000000000001
g4: 0000000000b95d80 g5: 0000000000000000 g6: 0000000000b84000 g7: =
0000000000000000
o0: 0000000000000000 o1: ffffffffffffffff o2: 0000000000000000 o3: =
0000000000ae1c40
o4: 0000000000b87ae8 o5: 0000000000000000 sp: 0000000000b871b1 ret_pc: =
0000000000c5ec90
RPC: <subsection_map_init+0x48/0x98>
l0: 0000000000020000 l1: 0000000000020000 l2: 0000000000b0d730 l3: =
0000000000000001
l4: 0000000000000000 l5: 0000000000000001 l6: 0000000001dfefbf l7: =
00000001ff8f3110
i0: 0000000000000000 i1: 00000000000ff7ff i2: 0000000000000001 i3: =
000000000001ffff
i4: 0000000000000000 i5: 0000000000000007 i6: 0000000000b87261 i7: =
0000000000c5a4c8
I7: <free_area_init+0x58c/0xc78>
Call Trace:
[<0000000000c5a4c8>] free_area_init+0x58c/0xc78
[<0000000000c509c8>] paging_init+0xd1c/0xdd0
[<0000000000c4b848>] setup_arch+0x110/0x774
[<0000000000c48664>] start_kernel+0x58/0x778
[<0000000000c4b584>] start_early_boot+0x78/0x22c
[<00000000009b5264>] tlb_fixup_done+0x4c/0x54
[<00000000002f1a28>] 0x2f1a28
Disabling lock debugging due to kernel taint
Caller[0000000000c5a4c8]: free_area_init+0x58c/0xc78
Caller[0000000000c509c8]: paging_init+0xd1c/0xdd0
Caller[0000000000c4b848]: setup_arch+0x110/0x774
Caller[0000000000c48664]: start_kernel+0x58/0x778
Caller[0000000000c4b584]: start_early_boot+0x78/0x22c
Caller[00000000009b5264]: tlb_fixup_done+0x4c/0x54

I tried to analyze this last year, but had to put it back into my TODO =
file
after a weekend on it. I have an very crude workaround hack for that in
T2 see below.

I=E2=80=99m not saying that this is related, I only want to optimize bug =
hunting qith
another heads up data point. What is strange is that IIRC this does not
bug for a user with an Ultra 45, will double check on my Ultra 25 now
that I got 8GB in it, too. Probably good time to finally tackle the root =
cause,
too:

--- linux-6.10/arch/sparc/kernel/ktlb.S	2024-07-15 00:43:32.000000000 =
+0200
+++ b/arch/sparc/kernel/ktlb.S	2024-09-24 20:18:35.373344860 +0200
@@ -144,7 +144,7 @@
 	brgez,pn	%g4, kvmap_dtlb_nonlinear
 	 nop
=20
-#ifdef CONFIG_DEBUG_PAGEALLOC
+#if 1 /* def CONFIG_DEBUG_PAGEALLOC */
 	/* Index through the base page size TSB even for linear
 	 * mappings when using page allocation debugging.
 	 */
--- linux-6.10/arch/sparc/mm/init_64.c	2024-07-15 00:43:32.000000000 =
+0200
+++ b/arch/sparc/mm/init_64.c	2024-09-24 20:35:22.566682546 +0200
@@ -1891,11 +1891,22 @@
 static void __init kernel_physical_mapping_init(void)
 {
 	unsigned long i, mem_alloced =3D 0UL;
+	unsigned long phys_mem =3D 0UL;
 	bool use_huge =3D true;
=20
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	use_huge =3D false;
 #endif
+
+	if (tlb_type =3D=3D cheetah_plus) {
+		for (i =3D 0; i < pall_ents; i++)
+			phys_mem +=3D pall[i].reg_size;
+		printk("phys_mem: %ld\n", phys_mem);
+
+		if (phys_mem > 4294967296)
+			use_huge =3D false;
+	}
+
 	for (i =3D 0; i < pall_ents; i++) {
 		unsigned long phys_start, phys_end;
=20

> [  125.301353] systemd-sysv-generator[1042]: Please update package to =
include a native systemd unit file.
> [  125.424703] systemd-sysv-generator[1042]: =E2=9A=A0 This =
compatibility logic is deprecated, expect removal soon. =E2=9A=A0
> [  127.206268] get_swap_device: Bad swap offset entry 808000000
> [  127.354181] get_swap_device: Bad swap offset entry 808000000
> [  127.449735] get_swap_device: Bad swap offset entry 808000000
> [  127.553698] get_swap_device: Bad swap offset entry 808000000
> [  127.701748] get_swap_device: Bad swap offset entry 808000000
> [  127.821914] get_swap_device: Bad swap offset entry 808000000
> [  127.939392] Unable to handle kernel paging request at virtual =
address 00000001108ca000
> [  128.043605] tsk->{mm,active_mm}->context =3D 0000000000000555
> [  128.116890] tsk->{mm,active_mm}->pgd =3D fff0000009fd0000
> [  128.185604]               \|/ ____ \|/
> [  128.185604]               "@'/ .. \`@"
> [  128.185604]               /_| \__/ |_\
> [  128.185604]                  \__U_/
> [  128.378914] systemd-tty-ask(1054): Oops [#1]
> [  128.435046] CPU: 0 UID: 0 PID: 1054 Comm: systemd-tty-ask Not =
tainted 6.17.0-rc4+ #11 NONE=20
> [  128.544945] TSTATE: 0000000011001606 TPC: 00000000007a5800 TNPC: =
00000000007a5804 Y: 00000000    Not tainted
> [  128.674196] TPC: <lookup_swap_cgroup_id+0x40/0x80>
> [  128.737194] g0: fff000023f800040 g1: 0000000010000000 g2: =
00000001008ca000 g3: 000000000153a8b8
> [  128.851572] g4: fff0000008d1b700 g5: fff000023e336000 g6: =
fff00000140f4000 g7: fff0000101934000
> [  128.965946] o0: fff0000008e6c180 o1: 0000000000000000 o2: =
0000000000001000 o3: 0000000000000001
> [  129.080321] o4: 00000000000001ff o5: 0000000000000555 sp: =
fff00000140f6c81 ret_pc: 0000000000000000
> [  129.199272] RPC: <0x0>
> [  129.230149] l0: 0000000000000000 l1: fff0000008e6c180 l2: =
0000000000000000 l3: 03ffffffffffffff
> [  129.344528] l4: 0000000000000004 l5: 0000000000000000 l6: =
0000000000000001 l7: 0000000000000014
> [  129.458902] i0: 0000000080000000 i1: fff0000101900000 i2: =
fff00000140f75d8 i3: ffffffffffffffff
> [  129.573283] i4: 0000000000001000 i5: 0000000000000000 i6: =
fff00000140f6d31 i7: 00000000007173e0
> [  129.687653] I7: <swap_pte_batch+0x40/0x160>
> [  129.742653] Call Trace:
> [  129.774671] [<00000000007173e0>] swap_pte_batch+0x40/0x160
> [  129.846733] [<0000000000719998>] unmap_page_range+0x718/0x1200
> [  129.923366] [<000000000071a4f8>] =
unmap_single_vma.constprop.0+0x78/0xe0
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
> [  130.784610] Caller[000000000071a4f8]: =
unmap_single_vma.constprop.0+0x78/0xe0
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
>=20
> Adrian
>=20
> --=20
> .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--=20
https://exactco.de - https://t2linux.com - https://rene.rebe.de

