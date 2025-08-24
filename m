Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD08139D1B
	for <sparclinux@vger.kernel.org>; Sun, 24 Aug 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756069779; cv=none; b=rwb2ST+LHECMEJYiMcQhGzT4FqGJDPxjIpXwYxHUVPMQEoMEZb8m00ldFSGpm7Bw6G4j3SyLlFzu32Bphz8nrXRFp/NBy3dO90Se+cLx6CNeVGm8fBg5hkAdqdlc9qtYeK7tWU2GDdyb45yJb0IcVLRZKV2I3bLufN3QPF8QjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756069779; c=relaxed/simple;
	bh=P6f2V+P0slr9ywXt/dIdchenFPck+nbv+Z+XeHw8ELE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=F2Uqx7Ug952vqVTXZpvgjdQO948sSZX2cbrQFrkIdcx+G8o+5FdwRL4C2/qvUHHGH6KtrZb+ImcLhABXIXSecgIbvbtFZI3x/C2W+CJ80liwbg5zUZ2c4MIYfyGsH/sDQKKze1dvPSsdF3K4yEl3O2n+3OD3XFzmhb1/FEWCWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=RMnmUrmd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="RMnmUrmd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yg2Wq7EcUWAibulkLUpQlwoJpEGEFm3s2hNgdzBi+BA=; t=1756069775; x=1756674575; 
	b=RMnmUrmdbLNzKN6zgqPuQCfAsaluhMdUNbiwIgw5FLOSpOT6V1dYs+EcyL0d/ZqL8TC3wt7M5gn
	f/XlQVeHFiUvWt1hqbY77jCWuDUwhZCBOq3xxQdczAWnXr4QpuJjdZ4sU+H8kWosfGe5wEy9gntfw
	u+PdDuitMWLsZh2yBBt/YCHpQPsbPls6oVKdJfD4eKV9dQDhDmmw3jT3Y2COuJ9Kc/DT0FIf3YXld
	+eGJhFFehbFKQgZgQIpO5+Ky5yFFU2ZL82+pAgG4XgBQSz1KOXdF/Z0GFPzpdVhcqkdtVN/FjW3+g
	z2L57u/DmYBQDcDFTsdTUJg+IbUPTd9ZFXew==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uqHxu-00000003IHu-1cUL; Sun, 24 Aug 2025 23:09:26 +0200
Received: from dynamic-077-188-249-192.77.188.pool.telefonica.de ([77.188.249.192] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uqHxu-00000002AJ4-0haB; Sun, 24 Aug 2025 23:09:26 +0200
Message-ID: <a35d92d3f229811123156086766a8cd981166005.camel@physik.fu-berlin.de>
Subject: Current state of the Linux kernel on SPARC
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: sparclinux <sparclinux@vger.kernel.org>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
	gentoo-sparc@lists.gentoo.org, Michael Karcher
	 <kernel@mkarcher.dialup.fu-berlin.de>, Anthony Yznaga
	 <anthony.yznaga@oracle.com>
Date: Sun, 24 Aug 2025 23:09:25 +0200
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

since there has been a lot of recent activity around the Linux kernel on SP=
ARC
and there are also a lot of issues to be dealt with and unmerged patches, I=
 have
decided to summarize the current state of the Linux kernel on SPARC to brin=
g
anyone interested up to date.

First, let's start with the bugs. For a while it has been known that recent=
 kernel
versions can be very unstable on certain SPARC machines, this has been obse=
rved in
particular with UltraSPARC III CPUs but also on certain newer CPUs such as =
SPARC T1.

After I started bisecting the issue, I ran into multiple false positives un=
til I
identified d53d2f78cead as the culprit which makes use of a new vmalloc fla=
g called
VM_FLUSH_RESET_PERMS.

However, this particular change is actually not broken but rather just unco=
vered the
original bug. The introduction of VM_FLUSH_RESET_PERMS allowed the kernel t=
o flush
TLBs earlier after booting and more often. And since the original problem w=
as suspected
with the TLB flush management on SPARC, it was just natural that the change=
 in d53d2f78cead
turned out in the bisect.

Further investigation showed that the actual culprit are the CPU-specific i=
mplementations
of copy_{from,to}_user which can be found in arch/sparc/lib. These are brok=
en on different
CPU types to a different degree which explains perfectly fine why recent ke=
rnels are more
unstable on certain CPU types than on others.

Luckily, Michael Karcher has already made good progress in investigating an=
d fixing these
bugs so that, for example, a trial patch for the UltraSPARC III showed that=
 a simple
one-line change would fix all the stability issues currently seen on these =
CPU types.

It is expected that a series of patches will follow shortly that will addre=
ss the bugs in
the copy_{from,to}_user on all affected CPU types. In the mean time, it sho=
uld be possible
to switch the kernel to the generic code for copy_{from,to}_user that can b=
e found in the
same source directory to get a stable system on any CPU type.

Another issue that was discovered was that support for HugeTLB was broken o=
n sun4u. A patch
addressing the problem has been posted by Anthony Yznaga in [1]. Additional=
 pending patches
fix the error handling in the scan_one_device() [2] and switch sparc64 to t=
he generic vDSO
library [3].

Once the stability issues have been fixed, the focus should be on upstreami=
ng feature patches
that Oracle engineers developed but never sent in for review. These can be =
found in Oracle's
Github repository for the UEK kernel in the uek4/qu7 branch [4].

These feature patches include useful additions such as support for kexec [5=
], 5-level page
table support [6], EFI support for newer servers [7], support for SPARC M8 =
[8], fixed for
SPARC M7 [9] and even support for running the Linux kernel as a primary LDO=
M [10] and many
other improvements.

So, there is definitely a lot of work to be done on Linux for SPARC so that=
 we're going to
be busy for some more years. Hopefully, some folk from Oracle can step in a=
nd help upstreaming
some of the patches of Oracle's UEK kernel. Primary domain support in parti=
cular would be
very nice to have on Linux as this would allow creating logical domains on =
sun4v hardware
without having to install Solaris.

Cheers,
Adrian

> [1] https://lore.kernel.org/all/20250716012446.10357-1-anthony.yznaga@ora=
cle.com/
> [2] https://lore.kernel.org/all/20250718093205.3403010-1-make24@iscas.ac.=
cn/
> [3] https://lore.kernel.org/all/20250815-vdso-sparc64-generic-2-v2-0-b5ff=
80672347@linutronix.de/
> [4] https://github.com/oracle/linux-uek/tree/uek4/qu7/
> [5] https://github.com/oracle/linux-uek/commit/6fa4477f7e671b4882517a0862=
d3ee3f65ff4bde (there are multiple patches for kexec)
> [6] https://github.com/oracle/linux-uek/commit/9783abbe2d19da0d36a2b1caa4=
b15d965ee68384
> [7] https://github.com/oracle/linux-uek/commit/127ca6582a90567ded4fa6168c=
1582d2d5ac37f0
> [8] https://github.com/oracle/linux-uek/commit/5fe100ac31a6f977ebb64ce4ee=
a7b0e3de7dbe04
> [9] https://github.com/oracle/linux-uek/commit/efcafbab1b123d615c1f2683c9=
8fccc5ccee1527
> [10] https://github.com/oracle/linux-uek/commit/6c87154b63230bc5e35c5df13=
3e7ecfadf47b828

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
