Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7D21CC79
	for <sparclinux@vger.kernel.org>; Tue, 26 Aug 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224510; cv=none; b=bPspnAomOSh1SckUw+YhNmps03AGiedcPX/YEK7QHRNiXk8+LIojxmc9IlrFOaAwcF24+Jo+xRiStC1hOC2YFS4ceN8CbALzpp2ND/fOv7xNt7bn6w3H7OPBwJtdmUmwIJZVlBOvN28avTqXkU+zskCaITTDWg8olP4W+OGTcYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224510; c=relaxed/simple;
	bh=dckZRXzO6paPVaOn1ZZnfEB5cYhDlBku1m8Fp66i4dY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TVjPLZ1PHd5I/bCl4xPVJ1LxWroVFfkZVwsCHjSyNEMHhpGUO7g2+v7XbodipPwVLC3nbaNptgBpXNW+tQQujx6PFvZH413F2aZOXqBGhKNhQgw6mY38UwzhgON8IEqVAchFJts5dqT3sOLZz6IN3NhCP9rMu7QLFvTu6lNZGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Jw0gPsYo; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Jw0gPsYo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=MBSgkI7T2LaVvTRUA46AisbmMCBG+rsJcRLt/1TiMic=; t=1756224507;
	x=1756829307; b=Jw0gPsYosWTrHslVdkkB9O9z7bxv5wB4ORlxXDsozH/kiMERBukxd4QfLjcj4
	a6FP+5UA0YTr9mJtHhXfOc2o7ufol+g8qTpiiSWOVfw2htBLDGdQAUvRlKPMmSNtAnymMXapWxbVR
	BhUVIZzrbBfKy1lBYWcE2oWdGgB/sTMJ2EIF0OQSpq7ZBtuEYByQEu+Yk3wDZEL/QaZqVQOT0Fzxu
	/jkmqplHXpQWr9E8KJzKdpna688r495Ew/dHlFwc6gnBJ+WxeiiqgwByIzSIrUYfiX6Pnp6pxVLTL
	76bd785G5j7V/ow8e5ObIU9Um3mqEVDMxzKu9KIpZ8mKEy81iQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uqwDg-00000000yTr-3Hde; Tue, 26 Aug 2025 18:08:24 +0200
Received: from [185.89.37.3] (helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uqwDg-00000000cxu-2Vov; Tue, 26 Aug 2025 18:08:24 +0200
Message-ID: <2da68167156f93a5c48e4404656036d233084501.camel@physik.fu-berlin.de>
Subject: Re: Current state of the Linux kernel on SPARC
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: sparclinux <sparclinux@vger.kernel.org>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
	gentoo-sparc@lists.gentoo.org, Michael Karcher
	 <kernel@mkarcher.dialup.fu-berlin.de>, Anthony Yznaga
	 <anthony.yznaga@oracle.com>
Date: Tue, 26 Aug 2025 18:08:24 +0200
In-Reply-To: <a35d92d3f229811123156086766a8cd981166005.camel@physik.fu-berlin.de>
References: 
	<a35d92d3f229811123156086766a8cd981166005.camel@physik.fu-berlin.de>
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

Hello,

On Sun, 2025-08-24 at 23:09 +0200, John Paul Adrian Glaubitz wrote:
> First, let's start with the bugs. For a while it has been known that rece=
nt kernel
> versions can be very unstable on certain SPARC machines, this has been ob=
served in
> particular with UltraSPARC III CPUs but also on certain newer CPUs such a=
s SPARC T1.
>=20
> After I started bisecting the issue, I ran into multiple false positives =
until I
> identified d53d2f78cead as the culprit which makes use of a new vmalloc f=
lag called
> VM_FLUSH_RESET_PERMS.
>=20
> However, this particular change is actually not broken but rather just un=
covered the
> original bug. The introduction of VM_FLUSH_RESET_PERMS allowed the kernel=
 to flush
> TLBs earlier after booting and more often. And since the original problem=
 was suspected
> with the TLB flush management on SPARC, it was just natural that the chan=
ge in d53d2f78cead
> turned out in the bisect.
>=20
> Further investigation showed that the actual culprit are the CPU-specific=
 implementations
> of copy_{from,to}_user which can be found in arch/sparc/lib. These are br=
oken on different
> CPU types to a different degree which explains perfectly fine why recent =
kernels are more
> unstable on certain CPU types than on others.
>=20
> Luckily, Michael Karcher has already made good progress in investigating =
and fixing these
> bugs so that, for example, a trial patch for the UltraSPARC III showed th=
at a simple
> one-line change would fix all the stability issues currently seen on thes=
e CPU types.
>=20
> It is expected that a series of patches will follow shortly that will add=
ress the bugs in
> the copy_{from,to}_user on all affected CPU types. In the mean time, it s=
hould be possible
> to switch the kernel to the generic code for copy_{from,to}_user that can=
 be found in the
> same source directory to get a stable system on any CPU type.

A patch series to address these bugs was just posted:

https://lore.kernel.org/all/20250826160312.2070-1-kernel@mkarcher.dialup.fu=
-berlin.de/

Please test and report back!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
