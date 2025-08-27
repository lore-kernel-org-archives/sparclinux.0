Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E684E33EC;
	Wed, 27 Aug 2025 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276665; cv=none; b=htdt6ReraYmkYsJE0+oSsA0yPW9SuIBT3j+0C/P5+n+BmOSk8vEM7kbLn80mWqisrS7cQ938iRudYoAvdz83MyaOswkNM1Ui23pkwsNHtWfOA56qKU5uF/wUju3wH36RhaJhcLISQYxDC5pVgWRRbp/GmmrKNfLObkfdrCyPhgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276665; c=relaxed/simple;
	bh=96YCLOtNM97OUGEOGZoU8PcZd35sAMHs08pQ+f4QKmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ehOWH3HZtifhCC0bWgnCLu4JZp86q3ZWWzhBUfdGGQoB98VN6iGwrBC6gkmQcHokficAzE96vcwXRlZKDXLRQgGTOsodRFdXRatvp6AMQIdfpO/HGgmeHr1TNT+443tz1Dq6WB96fGBfY2NBabH+ZFwP2IQMvgsZfyTemsXqyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dvEfK0lS; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dvEfK0lS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6oJr1ziZYKQ2JgwAMwSy5dRdyTEXTKvzrwlvmZzfw0w=; t=1756276662;
	x=1756881462; b=dvEfK0lS5aTYaADGtR2C+JNCEHU43yfhAHvZxy9JnDvxxtJYWIzFOG4UVc9JT
	DZNoM2zo9Dgi7HkHETyNXr2TJIz4TBrC8qFbbK0M+8RlScrfVSNo3lgeRHKJ8eDX7n763CxDxJmbB
	FsSsykFyk0m0F7EOA47ckujDTgIhkv2SRAwJgjhvPLeGsUC0XifdxcsZACUlpO83hg8f9HPH1uqjX
	uC1K2MH1++4RbStmSG4js1SW4dZpa1OezYCqsAPDl+ZOHIBpML8OAqWCU+kTinLHd3D9w/CX6f6Br
	5P1UUhZuAf5+Qy/wmZ0WXu9TcuBJvsZS3TFXHjsi4/G9RzgCpQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ur9mt-00000003cmM-35UZ; Wed, 27 Aug 2025 08:37:39 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ur9mt-00000003C6q-222m; Wed, 27 Aug 2025 08:37:39 +0200
Message-ID: <69df7421d50bec1e85ba1e7649326c33ef7226b0.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 4/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara 4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Wed, 27 Aug 2025 08:37:38 +0200
In-Reply-To: <20250826160312.2070-5-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
	 <20250826160312.2070-5-kernel@mkarcher.dialup.fu-berlin.de>
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

Hello Michael,

On Tue, 2025-08-26 at 18:03 +0200, Michael Karcher wrote:
> Fixes: 957077048009 ("sparc64: Convert NG4copy_{from,to}_user to accurate=
 exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/NG4memcpy.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
> index 7ad58ebe0d00..df0ec1bd1948 100644
> --- a/arch/sparc/lib/NG4memcpy.S
> +++ b/arch/sparc/lib/NG4memcpy.S
> @@ -281,7 +281,7 @@ FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
>  	subcc		%o5, 0x20, %o5
>  	EX_ST(STORE(stx, %g1, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
>  	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
> -	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus=
_24)
> +	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus=
_16)
>  	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
>  	bne,pt		%icc, 1b
>  	 add		%o0, 0x20, %o0

Applied this patch to Debian's kernel from unstable, got the following back=
trace during boot:

[   11.109771] Unable to handle kernel paging request at virtual address ff=
f80000c0000000
[   11.109824] tsk->{mm,active_mm}->context =3D 0000000000000139
[   11.109842] tsk->{mm,active_mm}->pgd =3D fff800001bb6c000
[   11.109859]               \|/ ____ \|/
[   11.109859]               "@'/ .. \`@"
[   11.109859]               /_| \__/ |_\
[   11.109859]                  \__U_/
[   11.109885] cryptomgr_test(411): Oops [#1]
[   11.109908] CPU: 0 UID: 0 PID: 411 Comm: cryptomgr_test Not tainted 6.16=
.3+1-sparc64-smp #1 NONE  Debian 6.16.3-1+sparc64=20
[   11.109939] TSTATE: 0000008811001601 TPC: 000000001026a048 TNPC: 0000000=
01026a04c Y: 00001000    Not tainted
[   11.109963] TPC: <sha512_sparc64_transform+0x48/0x160 [sha512_sparc64]>
[   11.109990] g0: 0000000000000000 g1: 0000000000000000 g2: 00000000000000=
00 g3: 0000000000000000
[   11.110010] g4: fff800001bcd7080 g5: fff800059cef6000 g6: fff8000018e680=
00 g7: 000000001026a000
[   11.110031] o0: fff8000018ada7e8 o1: fff80000c0000000 o2: fffffffffeb1cc=
80 o3: 00000000f70e5800
[   11.110052] o4: 0000000068581400 o5: 0000000000000000 sp: fff8000018e6af=
41 ret_pc: 000000001026a5c8
[   11.110072] RPC: <sha512_sparc64_update+0x48/0x60 [sha512_sparc64]>
[   11.110093] l0: 000000000000000a l1: 0000000000000000 l2: 00000000000000=
00 l3: 0000000000000000
[   11.110113] l4: 0000000000000000 l5: ffffffffffffffff l6: 00000000000000=
00 l7: fff8000014263c00
[   11.110133] i0: 0000000000000000 i1: fff8000018e64000 i2: 00000000000000=
00 i3: 00000000ffc00b31
[   11.110152] i4: 0000000068581511 i5: 0000000064f98fa7 i6: fff8000018e6af=
f1 i7: 0000000000980a1c
[   11.110173] I7: <crypto_shash_finup+0x17c/0x220>
[   11.110205] Call Trace:
[   11.110218] [<0000000000980a1c>] crypto_shash_finup+0x17c/0x220
[   11.110240] [<0000000000989104>] test_shash_vec_cfg+0x2a4/0x580
[   11.110270] [<000000000098d688>] __alg_test_hash.isra.0+0x1a8/0x360
[   11.110291] [<000000000098d920>] alg_test_hash+0xe0/0x140
[   11.110312] [<000000000098bf9c>] alg_test+0x17c/0x7a0
[   11.110332] [<0000000000987b98>] cryptomgr_test+0x18/0x60
[   11.110352] [<00000000004ac704>] kthread+0x104/0x280
[   11.110382] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   11.110410] [<0000000000000000>] 0x0
[   11.110427] Disabling lock debugging due to kernel taint
[   11.110442] Caller[0000000000980a1c]: crypto_shash_finup+0x17c/0x220
[   11.110464] Caller[0000000000989104]: test_shash_vec_cfg+0x2a4/0x580
[   11.110485] Caller[000000000098d688]: __alg_test_hash.isra.0+0x1a8/0x360
[   11.110506] Caller[000000000098d920]: alg_test_hash+0xe0/0x140
[   11.110526] Caller[000000000098bf9c]: alg_test+0x17c/0x7a0
[   11.110545] Caller[0000000000987b98]: cryptomgr_test+0x18/0x60
[   11.110565] Caller[00000000004ac704]: kthread+0x104/0x280
[   11.110585] Caller[00000000004060c8]: ret_from_fork+0x1c/0x2c
[   11.110606] Caller[0000000000000000]: 0x0
[   11.110622] Instruction DUMP:
[   11.110626]  d91a2030=20
[   11.110640]  12600020=20
[   11.110653]  dd1a2038=20
[   11.110666] <e11a6000>
[   11.110678]  e51a6008=20
[   11.110691]  e91a6010=20
[   11.110704]  ed1a6018=20
[   11.110716]  f11a6020=20
[   11.110728]  f51a6028=20
[   11.110741]=20
[   11.144051] Unable to handle kernel paging request at virtual address ff=
f80000c0000000
[   11.144098] tsk->{mm,active_mm}->context =3D 0000000000000144
[   11.144113] tsk->{mm,active_mm}->pgd =3D fff800001c2d0000
[   11.144127]               \|/ ____ \|/
[   11.144127]               "@'/ .. \`@"
[   11.144127]               /_| \__/ |_\
[   11.144127]                  \__U_/
[   11.144150] cryptomgr_test(412): Oops [#2]
[   11.144171] CPU: 1 UID: 0 PID: 412 Comm: cryptomgr_test Tainted: G      =
D             6.16.3+1-sparc64-smp #1 NONE  Debian 6.16.3-1+sparc64=20
[   11.144202] Tainted: [D]=3DDIE
[   11.144215] TSTATE: 0000008811001601 TPC: 000000001026a048 TNPC: 0000000=
01026a04c Y: 00001000    Tainted: G      D           =20
[   11.144237] TPC: <sha512_sparc64_transform+0x48/0x160 [sha512_sparc64]>
[   11.144260] g0: 0000000000000000 g1: 0000000000000000 g2: 00000000000000=
00 g3: 0000000000000000
[   11.144278] g4: fff800001494ec40 g5: fff800059cf16000 g6: fff800001bcb40=
00 g7: 000000001026a000
[   11.144296] o0: fff8000018fbd328 o1: fff80000c0000000 o2: fffffffffeac02=
80 o3: 000000005f1d3400
[   11.144314] o4: 000000002b3e6c00 o5: 0000000000000000 sp: fff800001bcb6f=
41 ret_pc: 000000001026a5c8
[   11.144333] RPC: <sha512_sparc64_update+0x48/0x60 [sha512_sparc64]>
[   11.144352] l0: 000000000000000a l1: 0000000000000000 l2: 00000000000000=
00 l3: 0000000000000000
[   11.144370] l4: 0000000000000000 l5: ffffffffffffffff l6: 00000000000000=
00 l7: 00000000007c4ee0
[   11.144388] i0: 0000000000000000 i1: fff8000016014000 i2: 00000000000000=
00 i3: 00000000ade682d1
[   11.144406] i4: 000000002b3e6c1f i5: 00000000fb41bd6b i6: fff800001bcb6f=
f1 i7: 0000000000980a1c
[   11.144424] I7: <crypto_shash_finup+0x17c/0x220>
[   11.144448] Call Trace:
[   11.144460] [<0000000000980a1c>] crypto_shash_finup+0x17c/0x220
[   11.144480] [<0000000000989104>] test_shash_vec_cfg+0x2a4/0x580
[   11.144504] [<000000000098d688>] __alg_test_hash.isra.0+0x1a8/0x360
[   11.144523] [<000000000098d920>] alg_test_hash+0xe0/0x140
[   11.144542] [<000000000098bf9c>] alg_test+0x17c/0x7a0
[   11.144560] [<0000000000987b98>] cryptomgr_test+0x18/0x60
[   11.144579] [<00000000004ac704>] kthread+0x104/0x280
[   11.144601] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[   11.144624] [<0000000000000000>] 0x0
[   11.144640] Caller[0000000000980a1c]: crypto_shash_finup+0x17c/0x220
[   11.144658] Caller[0000000000989104]: test_shash_vec_cfg+0x2a4/0x580
[   11.144677] Caller[000000000098d688]: __alg_test_hash.isra.0+0x1a8/0x360
[   11.144695] Caller[000000000098d920]: alg_test_hash+0xe0/0x140
[   11.144714] Caller[000000000098bf9c]: alg_test+0x17c/0x7a0
[   11.144731] Caller[0000000000987b98]: cryptomgr_test+0x18/0x60
[   11.144749] Caller[00000000004ac704]: kthread+0x104/0x280
[   11.144767] Caller[00000000004060c8]: ret_from_fork+0x1c/0x2c
[   11.144785] Caller[0000000000000000]: 0x0
[   11.144800] Instruction DUMP:
[   11.144804]  d91a2030=20
[   11.144816]  12600020=20
[   11.144828]  dd1a2038=20
[   11.144839] <e11a6000>
[   11.144851]  e51a6008=20
[   11.144862]  e91a6010=20
[   11.144874]  ed1a6018=20
[   11.144885]  f11a6020=20
[   11.144896]  f51a6028=20
[   11.144908]

However, I made the observation that the Debian kernel started to cause bac=
ktraces
even without the patch with newer kernels:

[    1.764073] ------------[ cut here ]------------
[    1.764113] WARNING: CPU: 23 PID: 194 at lib/kobject.c:734 kobject_put+0=
x64/0x240
[    1.764150] kobject: '(null)' ((____ptrval____)): is not initialized, ye=
t kobject_put() is being called.
[    1.764169] Modules linked in:
[    1.764190] CPU: 23 UID: 0 PID: 194 Comm: kworker/u256:16 Not tainted 6.=
12.38+deb13-sparc64-smp #1  Debian 6.12.38-1
[    1.764203] Workqueue: async async_run_entry_fn
[    1.764218] Call Trace:
[    1.764221] [<0000000000f11864>] dump_stack+0x8/0x18
[    1.764234] [<000000000046e15c>] __warn+0xdc/0x140
[    1.764244] [<000000000046e2d8>] warn_slowpath_fmt+0x118/0x140
[    1.764251] [<0000000000ec8024>] kobject_put+0x64/0x240
[    1.764260] [<000000000072d98c>] sysfs_slab_release+0xc/0x20
[    1.764273] [<00000000006dc91c>] kmem_cache_destroy+0xdc/0x1a0
[    1.764286] [<00000000009593c4>] bioset_exit+0x144/0x1e0
[    1.764299] [<000000000097a8d4>] disk_release+0x54/0x120
[    1.764311] [<0000000000b94a0c>] device_release+0x2c/0xa0
[    1.764322] [<0000000000ec8088>] kobject_put+0xc8/0x240
[    1.764330] [<0000000000b94c74>] put_device+0x14/0x40
[    1.764337] [<000000000097ac58>] put_disk+0x18/0x40
[    1.764346] [<000000000140c2c8>] floppy_async_init+0xbec/0xd10
[    1.764357] [<00000000004a0cc8>] async_run_entry_fn+0x28/0x160
[    1.764364] [<000000000049091c>] process_one_work+0x15c/0x3c0
[    1.764375] [<0000000000490f24>] worker_thread+0x164/0x3e0
[    1.764384] ---[ end trace 0000000000000000 ]---
[    1.764546] ------------[ cut here ]------------
[    1.764557] WARNING: CPU: 23 PID: 194 at lib/refcount.c:28 refcount_warn=
_saturate+0x18c/0x1a0
[    1.764581] refcount_t: underflow; use-after-free.
[    1.764592] Modules linked in:
[    1.764608] CPU: 23 UID: 0 PID: 194 Comm: kworker/u256:16 Tainted: G    =
    W          6.12.38+deb13-sparc64-smp #1  Debian 6.12.38-1
[    1.764618] Tainted: [W]=3DWARN
[    1.764621] Workqueue: async async_run_entry_fn
[    1.764629] Call Trace:
[    1.764631] [<0000000000f11864>] dump_stack+0x8/0x18
[    1.764639] [<000000000046e15c>] __warn+0xdc/0x140
[    1.764646] [<000000000046e2d8>] warn_slowpath_fmt+0x118/0x140
[    1.764652] [<00000000009d4d2c>] refcount_warn_saturate+0x18c/0x1a0
[    1.764659] [<0000000000ec8134>] kobject_put+0x174/0x240
[    1.764667] [<000000000072d98c>] sysfs_slab_release+0xc/0x20
[    1.764676] [<00000000006dc91c>] kmem_cache_destroy+0xdc/0x1a0
[    1.764684] [<00000000009593c4>] bioset_exit+0x144/0x1e0
[    1.764691] [<000000000097a8d4>] disk_release+0x54/0x120
[    1.764699] [<0000000000b94a0c>] device_release+0x2c/0xa0
[    1.764707] [<0000000000ec8088>] kobject_put+0xc8/0x240
[    1.764714] [<0000000000b94c74>] put_device+0x14/0x40
[    1.764721] [<000000000097ac58>] put_disk+0x18/0x40
[    1.764729] [<000000000140c2c8>] floppy_async_init+0xbec/0xd10
[    1.764737] [<00000000004a0cc8>] async_run_entry_fn+0x28/0x160
[    1.764744] [<000000000049091c>] process_one_work+0x15c/0x3c0
[    1.764752] ---[ end trace 0000000000000000 ]---

Upstream kernels don't show this problem. This is either related to the com=
piler version
being used or some Debian-specific patches or configuration options.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
