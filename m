Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1E192598;
	Sat,  9 Aug 2025 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754720603; cv=none; b=TpnvhyMM+F1hVkMM2rBzg5JpalzteYr0W82fK5i1RijqNnSGJKVhPj3/6dIWWBnwVpjTg7L5HJ9MPZSAMYsvwvIeUOmVY+O9Ql2mv18hAjLd+D6VEVFepDiCbUkIv3WkCt6bXz72yVhk4c1NhJwjl7Z3Jb4rvY7N/+06nx3YiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754720603; c=relaxed/simple;
	bh=BHx7/8uet55OG22FcxOao5Xo1CfCHwZp8ZKoFibMpUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4E/y34G1nZa+idoGCPfBc53vSMemfm33PqKbzNdgPWsXQd2GAZPWbKoXD9t4O5wDHDisH2KoyW4u1UFuD6ugJpaiW7KDh2h0g/s/4URvZcSZcRsC+2Sa8C+BfCWw8Eg8ngGCV4f6sqj7utKOLxNJ7p7QMUU8l/JEL0DGQGt3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Jn+Dy62q; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Jn+Dy62q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=b20S5WXwm5Mo8EBiyIIy8kloHl8SWsqSBXbRs0LF3gs=; t=1754720600;
	x=1755325400; b=Jn+Dy62qete0AfxaYy/Vi+iGjzZ1lzdiNAqJXuHiy5vkX0lCk5y5ZDDV55dl8
	URk1LuK0XmNGFDdYySM3mLXPs6EeHNRoUoU+/KV4zF4X+/kCEzVy8TKSqwUmR6maSVmdGLckuzP3n
	UzqMDDcPUu8KoTHOjmA9yvCXGZs+n56OA5HbXRUxR2rq53UAQq3rKkK+rTi61PK/g9CneqvAIIzu5
	QvEL1euZysaKmivmfzkWv+32owrH0LwTXh+2yWqjXlwiUIfxlBroKfMep1RikGIwZA405gXy7C5TK
	/iuwciuuXsrcTln7OdNe4TFHc1kfelj3a7iDdrevwlknWo8HpQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ukcz4-00000000rgV-2rEy; Sat, 09 Aug 2025 08:23:14 +0200
Received: from dynamic-002-245-158-117.2.245.pool.telefonica.de ([2.245.158.117] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ukcz4-00000002Vit-1tvq; Sat, 09 Aug 2025 08:23:14 +0200
Message-ID: <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Sat, 09 Aug 2025 08:23:13 +0200
In-Reply-To: <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
		 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
		 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
	 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
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

On Sat, 2025-08-09 at 00:37 +0200, John Paul Adrian Glaubitz wrote:
> > Maybe try enabling CONFIG_DEBUG_VM_IRQSOFF, CONFIG_DEBUG_VM, and perhap=
s=20
> > CONFIG_DEBUG_VM_PGFLAGS. That might help detect a problem closer to the=
=20
> > source. You can also try adding transparent_hugepage=3Dnever to the ker=
nel=20
> > boot line to see if compiling in THP support but not using it is okay.
>=20
> OK, I will try that. But not today anymore. It's half past midnight now h=
ere in Germany
> and I was debugging this issue almost all day long. I'm glad to have fina=
lly been able
> to track this down to THP support being enabled.
>=20
> Maybe you can try whether you can reproduce this in QEMU as well.

OK, first data point: Setting CONFIG_TRANSPARENT_HUGEPAGE_NEVER=3Dy causes =
the backtrace during
boot to disappear with CONFIG_TRANSPARENT_HUGEPAGE=3Dy. However, it still d=
isappears later when
running "apt update && apt -y upgrade" again:

[  170.472743] kernel BUG at fs/ext4/inode.c:1174!
[  170.532313]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[  170.725707] apt(1085): Kernel bad sw trap 5 [#1]
[  170.786396] CPU: 0 UID: 0 PID: 1085 Comm: apt Not tainted 6.16.0+ #35 VO=
LUNTARY=20
[  170.883619] TSTATE: 0000004411001603 TPC: 000000000075ee68 TNPC: 0000000=
00075ee6c Y: 00000000    Not tainted
[  171.012868] TPC: <ext4_block_write_begin+0x408/0x480>
[  171.079299] g0: 0000000000000000 g1: 0000000000000001 g2: 00000000000000=
00 g3: 0000000000000000
[  171.193692] g4: fff0000007802340 g5: fff000023d194000 g6: fff0000004aa80=
00 g7: 0000000000000001
[  171.308157] o0: 0000000000000023 o1: 0000000000d74b28 o2: 00000000000004=
96 o3: 0000000000101cca
[  171.422531] o4: 0000000001568800 o5: 0000000000000000 sp: fff0000004aab1=
61 ret_pc: 000000000075ee60
[  171.541487] RPC: <ext4_block_write_begin+0x400/0x480>
[  171.607814] l0: fff000000274c6a8 l1: 0000000000113cca l2: fff000000274c5=
40 l3: 0000000000001000
[  171.722195] l4: 0000000000000002 l5: 0000000000080000 l6: 00000000000120=
00 l7: 0000000000000001
[  171.836568] i0: 0000000000000000 i1: 000c000000374400 i2: 0000000000001f=
c0 i3: 0000000000680000
[  171.950944] i4: 0000000000000000 i5: 0000000000000000 i6: fff0000004aab2=
51 i7: 00000000007625d8
[  172.065317] I7: <ext4_da_write_begin+0x158/0x300>
[  172.127075] Call Trace:
[  172.159101] [<00000000007625d8>] ext4_da_write_begin+0x158/0x300
[  172.238023] [<00000000005b856c>] generic_perform_write+0x8c/0x240
[  172.318085] [<000000000074aef0>] ext4_buffered_write_iter+0x50/0x120
[  172.401586] [<00000000006954e0>] vfs_write+0x2a0/0x400
[  172.469059] [<0000000000695784>] ksys_write+0x44/0xe0
[  172.535395] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
[  172.612029] Disabling lock debugging due to kernel taint
[  172.681796] Caller[00000000007625d8]: ext4_da_write_begin+0x158/0x300
[  172.766430] Caller[00000000005b856c]: generic_perform_write+0x8c/0x240
[  172.852213] Caller[000000000074aef0]: ext4_buffered_write_iter+0x50/0x12=
0
[  172.941429] Caller[00000000006954e0]: vfs_write+0x2a0/0x400
[  173.014627] Caller[0000000000695784]: ksys_write+0x44/0xe0
[  173.086684] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
[  173.169033] Caller[0000000000000000]: 0x0
[  173.221645] Instruction DUMP:
[  173.221648]  110035d2=20
[  173.260532]  7ff358e0=20
[  173.291414]  90122328=20
[  173.322289] <91d02005>
[  173.353172]  80a06000=20
[  173.384051]  02480010=20
[  173.414937]  d45fa7cf=20
[  173.445815]  d85fa7cf=20
[  173.476697]  9736a000

So, even just compiling in the THP support code already triggers the bug.

Will now test with the debug flags enabled.

Adrian=20

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
