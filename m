Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C22C3745;
	Sun, 10 Aug 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754864427; cv=none; b=Q7GafIwdxu8hYaW4dbhYjlsFl6WsNqsAJIoM4xfNo+Us47KsdiYPflr9Az5BlJ/4fi6f4DW60ZhjHon1ZHQShHDnLvQUzfRCJmZ2z/W9tmMYIAXZU458gj00TL/onc7lgkd7UDGSzPiptz0J3R5aNR5SVBPU/CPJUoNpxM85xSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754864427; c=relaxed/simple;
	bh=Npiszttg3MxdsmYdIUoXlbDZtJa6G6tHOGzIGAbEFKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECtu78dZz5ZPPT7hKC2QB+Ckmd86n+pQmEY7tavwUR0mDfFoar31ICCh+m1NeONnPKOPXyYRkspU7BX/kw4S7HHLL4NjmH8UMj2M9icpKIS0ZbPsaoiTHtT8Rwd+JL16OFFNUkVP3lFMv47ncwahzWIeYObTxDhA6vueXeZlixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=c+k33BbH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="c+k33BbH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5kwrvvdUBPlIjzHfmvkp9awYUk38GQQrwActREjbtBk=; t=1754864424;
	x=1755469224; b=c+k33BbHAmUmhLJX3tYbE6WliBl+0t0FCYvmcaY4oOhL1PqI0eLQd7MnQMKUV
	azFydn4DZJyhimhDXcMcrH55ulQSODXOzg8PiKCqv9n90WGv+upHe1TcGkl2opSWKmlx80MXMKl4U
	a2x+tkXiMtdoAcsuo+rHOVC+5nPMW9TE/3ffN+QZlfzc2h6xFov9ZMUhSEg/G5Hl4G98qBUhVhXNu
	vyRkqtQeECHBq8O/mBQVUgR0IwO2QsuuuwjAjnMfgTmzpQk3HvrONcW1YVN1Dsxkf3+IlkPsFfzsH
	0sPrwHPYHuXp4oJsZyveQ+CH5+blC13G5scqnRvrRYEa/V1qsw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ulEOq-00000003Uhn-1Exc; Mon, 11 Aug 2025 00:20:20 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ulEOq-00000000QWm-0Ftm; Mon, 11 Aug 2025 00:20:20 +0200
Message-ID: <2bcb018c8b237f7ab2356f4459e14ae81a6fec8b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Mon, 11 Aug 2025 00:20:18 +0200
In-Reply-To: <b5b75976c94b7b46f86a5af4675a1a570aaf20cc.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
						 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
						 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
					 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
				 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
			 <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
		 <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
	 <b5b75976c94b7b46f86a5af4675a1a570aaf20cc.camel@physik.fu-berlin.de>
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

On Sun, 2025-08-10 at 11:52 +0200, John Paul Adrian Glaubitz wrote:
> On Sat, 2025-08-09 at 08:42 +0200, John Paul Adrian Glaubitz wrote:
> > Let me know if you have more suggestions to test. I can also provide yo=
u with full
> > access to this Netra 240 if you send me your public SSH key in a privat=
e mail.
>=20
> I have narrowed it down to a regression between v6.3 and v6.4 now.
>=20
> The bug can be reproduced with the sparc64_defconfig on a Sun Netra 240 b=
y setting
> CONFIG_TRANSPARENT_HUGEPAGE=3Dy and CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3D=
y. When testing
> on a modern systemd-based distribution, it's also necessary to enable CGr=
oup support
> as well as enable support for Sun partition tables with CONFIG_SUN_PARTIT=
ION=3Dy.
>=20
> Then it should be a matter of bisecting the commits between v6.3 and v6.4=
.
>=20
> I will do that within the next days as I'm currently a bit busy with othe=
r stuff.

OK, it turns out it's reproducible on older kernels (but not as old as 4.19=
) as well.
It's just much harder to trigger. I found a reproducer though and will try =
to find
the problematic commit next.

[50686.808389] BUG: Bad page map in process sshd-session  pte:00000002 pmd:=
01448000
[50686.905701] addr:00000100000a0000 vm_flags:00000075 anon_vma:00000000000=
00000 mapping:fff000003c8ca4f8 index:50
[50687.038425] file:sshd-session fault:filemap_fault mmap:ext4_file_mmap [e=
xt4] read_folio:ext4_read_folio [ext4]
[50687.170246] CPU: 0 PID: 37883 Comm: sshd-session Not tainted 6.3.0-2-spa=
rc64 #1  Debian 6.3.11-1
[50687.285751] Call Trace:
[50687.317771] [<0000000000d660b0>] dump_stack+0x8/0x18
[50687.382976] [<000000000064fd1c>] print_bad_pte+0x15c/0x200
[50687.455024] [<0000000000650f84>] unmap_page_range+0x3e4/0xbe0
[50687.530513] [<0000000000651cd8>] unmap_vmas+0xf8/0x1a0
[50687.597993] [<000000000065e674>] exit_mmap+0xb4/0x360
[50687.664331] [<00000000004647dc>] __mmput+0x3c/0x120
[50687.728380] [<00000000004648f4>] mmput+0x34/0x60
[50687.788999] [<000000000046b510>] do_exit+0x250/0xa00
[50687.854194] [<000000000046bea4>] do_group_exit+0x24/0xa0
[50687.923962] [<000000000046bf3c>] sys_exit_group+0x1c/0x40
[50687.994875] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
[50688.071518] Disabling lock debugging due to kernel taint
[50689.484196] Unable to handle kernel paging request at virtual address 00=
0c000002400000
[50689.588368] tsk->{mm,active_mm}->context =3D 00000000001815a6
[50689.661677] tsk->{mm,active_mm}->pgd =3D fff000000ae60000
[50689.730374]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[50689.923679] sshd-session(37883): Oops [#1]
[50689.977420] CPU: 0 PID: 37883 Comm: sshd-session Tainted: G    B        =
      6.3.0-2-sparc64 #1  Debian 6.3.11-1
[50690.112384] TSTATE: 0000008811001607 TPC: 00000000006510cc TNPC: 0000000=
0006510d0 Y: 00000000    Tainted: G    B            =20
[50690.261089] TPC: <unmap_page_range+0x52c/0xbe0>
[50690.320650] g0: 00000000000004a8 g1: 000c000000000000 g2: 00000000000088=
00 g3: ffffffffffffffff
[50690.435029] g4: fff0000001ef1280 g5: 0000000031200000 g6: fff0000001f040=
00 g7: ffffffffffffffff
[50690.549403] o0: 000c000002400a20 o1: 00000100000a4000 o2: 00000001000482=
90 o3: 0000000000000000
[50690.663779] o4: 0000000000000001 o5: 000000000000000d sp: fff0000001f06f=
61 ret_pc: 0000010000000000
[50690.782728] RPC: <0x10000000000>
[50690.825039] l0: 0000000100048290 l1: 000c000002400a20 l2: 00000100000a60=
00 l3: fff0000000950000
[50690.939419] l4: 00000100000fc000 l5: fff000000196dc20 l6: fff0000001f079=
38 l7: 00000000010f6fd0
[50691.053798] i0: fff0000001f07aa8 i1: 0000000000002000 i2: 00000100000a40=
00 i3: fff0000008311b00
[50691.168170] i4: 0000000000100000 i5: fff0000001448290 i6: fff0000001f070=
81 i7: 0000000000651cd8
[50691.282546] I7: <unmap_vmas+0xf8/0x1a0>
[50691.332867] Call Trace:
[50691.364891] [<0000000000651cd8>] unmap_vmas+0xf8/0x1a0
[50691.432371] [<000000000065e674>] exit_mmap+0xb4/0x360
[50691.498708] [<00000000004647dc>] __mmput+0x3c/0x120
[50691.562759] [<00000000004648f4>] mmput+0x34/0x60
[50691.623376] [<000000000046b510>] do_exit+0x250/0xa00
[50691.688573] [<000000000046bea4>] do_group_exit+0x24/0xa0
[50691.758340] [<000000000046bf3c>] sys_exit_group+0x1c/0x40
[50691.829256] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
[50691.905886] Caller[0000000000651cd8]: unmap_vmas+0xf8/0x1a0
[50691.979085] Caller[000000000065e674]: exit_mmap+0xb4/0x360
[50692.051141] Caller[00000000004647dc]: __mmput+0x3c/0x120
[50692.120911] Caller[00000000004648f4]: mmput+0x34/0x60
[50692.187246] Caller[000000000046b510]: do_exit+0x250/0xa00
[50692.258160] Caller[000000000046bea4]: do_group_exit+0x24/0xa0
[50692.333645] Caller[000000000046bf3c]: sys_exit_group+0x1c/0x40
[50692.410280] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
[50692.492629] Caller[fff0000102ad4a74]: 0xfff0000102ad4a74
[50692.562397] Instruction DUMP:
[50692.562399]  ce762010=20
[50692.601281]  02f47fa8=20
[50692.632163]  c4362018=20
[50692.663044] <c45c6008>
[50692.693926]  86100011=20
[50692.724808]  8e08a001=20
[50692.755689]  8400bfff=20
[50692.786569]  8779d402=20
[50692.817451]  c458e018=20

[50692.898656] Fixing recursive fault but reboot is needed!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
