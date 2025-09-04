Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36A288C36
	for <sparclinux@vger.kernel.org>; Thu,  4 Sep 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971032; cv=none; b=LCfK9J49HhpWJTfGotzNPRMkyuaWTlMxd/63sBp6u43plfG3/glMaTm/JKxns8c785PteCTTnSz3/FQ3dz3T2fZvjPKhx9dBZso1tfFczCNW5oeggcUMpJEWc7gvy8ivv807jsLfXOJPhKlPl79uNYYkgFDNabDAtn9xEAgpARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971032; c=relaxed/simple;
	bh=SHRixf4AjJ3X5iq9PdcG4C2Rf5BqmTruSdbDbTLWggk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=D8NM1jn7KMqAIcm4kKQK2hMwbtBtyKJ5iqf9dsNKbu93HE5iumxcmW/sS6Tx/TnWqpDIjNQWPR+tBKvFHqY9PI6yboeIal1fmMq0T1Rv4skk/p2nxB9GlkxBesh2NS3AevlAMDUlYmfVRHoG8KzLC2d4ofd/nxPGSUHeqQLWIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Mx4T+ZFq; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Mx4T+ZFq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SntRt8TdzPP0A5FGWAsV+uMvpZcov+1KapfkzQmJIVI=; t=1756971028; x=1757575828; 
	b=Mx4T+ZFqJBCWQMlzPLPocYccN2ngAs2yR3hhnVHvEwhsMZmQwnJ51m5Kn+bQQ0+NDzu6FbWlTfW
	vyUS8Oq+QQTx4on+Jquy6wMdzVosLeNCVzZe4XbO2yrD/T1z36fC3lS8bqJ0FB+YuaTj90pu4wp+w
	KEjesVGEjp2fAY5eWYU8l7B2xtVqf/+RPTm66IYpczmxfXU+cNgR3MKV+2aUNT/GGqEkoV+5Zkxyk
	pLfiHv2SxZ2Kp2CglAJvVsy65emzOSMk8YNQhJhxLNy3E5oS+PuKjA0AgwXrtG8cqc27+NyNPvDmR
	szaNypUdVJjF6JIsLjbFyBySos341Rhj+Ivg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uu4QG-00000000YUx-1hgs; Thu, 04 Sep 2025 09:30:20 +0200
Received: from p5dd48348.dip0.t-ipconnect.de ([93.212.131.72] helo=[192.168.46.214])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uu4QG-000000033oj-0oXG; Thu, 04 Sep 2025 09:30:20 +0200
Message-ID: <cac3f07a57c4d620f05a8aacc4fa7ca92727c92e.camel@physik.fu-berlin.de>
Subject: Testers with a SPARC T1 (T1000 or T2000) needed
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: sparclinux <sparclinux@vger.kernel.org>
Cc: gentoo-sparc@lists.gentoo.org, "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>, port-sparc64@netbsd.org
Date: Thu, 04 Sep 2025 09:30:19 +0200
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

we're looking for someone who owns a SPARC machine with a SPARC T1 CPU who
can test a kernel patch fixing memory corruption issues on these machines.

For Debian users, the patched can be tested with the help of this Debian
kernel package which already contains the patch in question:

https://people.debian.org/~glaubitz/sparc64/linux-image-6.12.3-sparc64-smp_=
6.12.3-1+sparc64_sparc64.deb

If the machine has not a running Linux installation, a test ISO with T2DE
Linux can be found here:

https://dl.t2sde.org/binary/2025/incoming/t2-25.9-sparc64-base-wayland-glib=
c-gcc-ultrasparc3.iso

For anyone building their own kernel, the patch can be found here:

https://lore.kernel.org/all/20250826160312.2070-4-kernel@mkarcher.dialup.fu=
-berlin.de/

In case of a successful test, please reply to the patch mail titled:

"[PATCH 3/4] sparc: fix accurate exception reporting in copy_{from_to}_user=
 for Niagara"

with a "Tested-by: Your Name <your.mail@domain.com>" (filling in your detai=
ls, of course ;)).

If you're not subscribed to the the sparclinux Linux kernel mailing list, y=
ou can reply
to the message by downloading the mbox file following this link:

https://lore.kernel.org/all/20250826160312.2070-2-kernel@mkarcher.dialup.fu=
-berlin.de/

Import this file into Thunderbird or any email client of choice, then reply=
 from there.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
