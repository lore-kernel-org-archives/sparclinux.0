Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78A1E2307;
	Mon, 11 Aug 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900914; cv=none; b=sJosIkEwc5JpR4cHU7LnVdHxTER0yu3oyzYqyw4jFrOYMMDqRbZGzYjZJAE4RM8XIrz16AZmVrX/2RlXKL+YlnXzI8yk4TdEr4MGVXBBS58LHO1dRkODLI0m6fLH39JzjlXZ6Kh9OSgScfn2T5kHkfuGpOH45CQ/XGKVpYp01Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900914; c=relaxed/simple;
	bh=epR2qxqqJ49MGaj/vHVOQtFtuNZ8WmpjmYqA2wYyGlw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NOO4vM7kMOI45B0+1LtObH33A1XRJMYT16cYIQphjkGCYK2USKObp83unzs2a8wu+zdohlyZx77isKT4GdxaWWbIIkc2YcO4Wuak/5GXaoW3AMltaUqR+s6z/W8mcOaM9l5FDEbSh+D3C3LyfDFmSODXmCtwNE7ao3mDox839MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=By5ZpyXv; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="By5ZpyXv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0hdZ4+kNVlYXOLOS+VoW9iKK4gsclPAsXnijCvJOEGA=; t=1754900911;
	x=1755505711; b=By5ZpyXvOtzBIQ/P/Mf3zWOE5KbL9cHNq7hcBbkCS9Jdxw6oV5MHpe4St2hBl
	JoMwUIO0RFZ/g0eN11IFxcjIQhP6ds0hJgesSPkvL5jAitsyTOURyggNKzP3m/p3qWacNTZSLSZrw
	NmcJiUh1V3rf6CPSFdTjZ0kSmToxTI9ZakhBMQ5DDuLCdXqT+S8xETC6r3oEDmFONzsbzDxKDhNbd
	Llvvoewtbj9fe+/H4NPRN70QAcp8JuY3OtHMY+603n8EL7zb4OYpSkzhVO8nj66fHNy5uBlS8dVD2
	Y0Nd4++07Rtin9x0aWAy1s7JcETQKTGeWfNR8WrP4kk7hHv4zw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ulNtL-00000001BKI-3wDO; Mon, 11 Aug 2025 10:28:27 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ulNtL-000000024TR-2s5L; Mon, 11 Aug 2025 10:28:27 +0200
Message-ID: <50eae15fb7ec8c6caa70811f231d69ef6f65e862.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: David Hildenbrand <david@redhat.com>, Anthony Yznaga	
 <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org,
 davem@davemloft.net, 	andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, osalvador@suse.de
Date: Mon, 11 Aug 2025 10:28:26 +0200
In-Reply-To: <96992842-f576-4e19-afcb-7455452fe506@redhat.com>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
	 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
	 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
	 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
	 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
	 <96992842-f576-4e19-afcb-7455452fe506@redhat.com>
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

Hi David,

thanks a lot for your input!

On Mon, 2025-08-11 at 10:20 +0200, David Hildenbrand wrote:
> On 09.08.25 08:23, John Paul Adrian Glaubitz wrote:
> > Hi Anthony,
> >=20
> > On Sat, 2025-08-09 at 00:37 +0200, John Paul Adrian Glaubitz wrote:
> > > > Maybe try enabling CONFIG_DEBUG_VM_IRQSOFF, CONFIG_DEBUG_VM, and pe=
rhaps
> > > > CONFIG_DEBUG_VM_PGFLAGS. That might help detect a problem closer to=
 the
> > > > source. You can also try adding transparent_hugepage=3Dnever to the=
 kernel
> > > > boot line to see if compiling in THP support but not using it is ok=
ay.
> > >=20
> > > OK, I will try that. But not today anymore. It's half past midnight n=
ow here in Germany
> > > and I was debugging this issue almost all day long. I'm glad to have =
finally been able
> > > to track this down to THP support being enabled.
> > >=20
> > > Maybe you can try whether you can reproduce this in QEMU as well.
> >=20
> > OK, first data point: Setting CONFIG_TRANSPARENT_HUGEPAGE_NEVER=3Dy cau=
ses the backtrace during
> > boot to disappear with CONFIG_TRANSPARENT_HUGEPAGE=3Dy. However, it sti=
ll disappears later when
> > running "apt update && apt -y upgrade" again:
>=20
> Just to give some context: (m)THPs in file systems will get used=20
> independently of CONFIG_TRANSPARENT_HUGEPAGE_NEVER=3Dy.
>=20
> So CONFIG_TRANSPARENT_HUGEPAGE_NEVER=3Dy primarily only controls usage of=
=20
> (m)THPs for anonymous memory, but not in the pagecache.

Thanks, this actually explains why CONFIG_TRANSPARENT_HUGEPAGE_NEVER=3Dy do=
esn't fully mitigate
the problem.

> > [  170.472743] kernel BUG at fs/ext4/inode.c:1174!
> > [  170.532313]               \|/ ____ \|/
> >                               "@'/ .. \`@"
> >                               /_| \__/ |_\
> >                                  \__U_/
>=20
> Is this the
>=20
> BUG_ON(to > folio_size(folio));

Yes, I just looked it up in my current local kernel tree and that's indeed =
the line.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
