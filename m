Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF32E88AE
	for <sparclinux@vger.kernel.org>; Sun,  4 Jan 2026 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529847; cv=none; b=T5X38+7l4TgGUp5hIPeaa7gL6Hv44rI0H3VL76GHz4zi4xjuaWZcXFbmAfMBY5AwWi4BGyNS920E6b9DyAg5segpRppUrgdSip1dBS9EJnWNOm3it+1yD+aKIhXhnIqsQ7S/3x2urUQCoNFu+mNnLc08oL798N9AXh1TZUQNrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529847; c=relaxed/simple;
	bh=8Z7DyaX2NofNZ29WpKkBq31DPpOe/xdetm9jTspJHo0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=JXOZflCDqRIS7WQ6vdajKwpf4x9opZA2QiZyQ048loE56br8MWaLiyVYTagKg/dJfm/EpjZgOMfp3HHCGhpBkzEzN0L+38o6jmDOY9JE4HSX7EcLw7tG/q1IdZRx1yYeJKUEX0HSiQ4ov1wwEdzrlNIxpv0i0HoAVwHP2XlTz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=l5XAwHWk; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="l5XAwHWk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jxu3fNPoJg9OMUESUXDeX+LSjNjxjfI2AhXfa8tRwf0=; t=1767529844; x=1768134644; 
	b=l5XAwHWk5BJMZtpSBDZH+3BU+VuNVTAuBjNrUwReupcQB0EgCoqUVicDengin/tLIt5lhzmWBkw
	YLVMDddxA8jbnC4n7L2tjLx2/q95P9pgEkhvXUkX/jHr+gwKYxUJUSmZQHuyth9VQuG+TR5RaeEyg
	qbL02EppV6CwlIiNgv+9iM7Ux1U/nKQioW9vW+3heQT9kmn6mwzzrwrEFUcXsFf0vljJ6pnLk+JtY
	TZrRi+L7WP29euqYm3O1LyH8ehqC3cmkmGhN8DyDas7VF8C8H/herb/+qHrNihEC8OLonx2gcygyD
	D6Pe2n4izREsSO5kWHbIFEOHM5jmblgHCqKg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vcNFl-00000003lO6-1K3s; Sun, 04 Jan 2026 13:30:37 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vcNFl-00000002mtT-0TPU; Sun, 04 Jan 2026 13:30:37 +0100
Message-ID: <cfe80c9b88601c65e1cc91104da23f7644fed48c.camel@physik.fu-berlin.de>
Subject: Updated firefox package available for sparc64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Sun, 04 Jan 2026 13:30:36 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

I have successfully built and uploaded the latest version of the firefox pa=
ckage
for sparc64. The package has been verified to work fine (see screenshot in =
[1]).

This package was built with the help of QuickJS instead of NodeJS, the form=
er being
available on all architectures in Debian. See this discussion [2] in the sp=
arclinux
tracker for more.

All patches required to build the firefox package for sparc64 can be found =
in [3].

Cheers,
Adrian

> [1] https://github.com/sparclinux/issues/issues/59#issuecomment-370559561=
3
> [2] https://github.com/sparclinux/issues/issues/59
> [3] https://people.debian.org/~glaubitz/firefox-sparc64/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
