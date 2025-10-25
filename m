Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4E22129B
	for <sparclinux@vger.kernel.org>; Sat, 25 Oct 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761382608; cv=none; b=gf1vYUcxZSV5XocJpjMOCkd9PQb5bU5Q7665Kwh15ujpsh4MRNNg9G9LXjN+zinnqK+mVyctNgM888S1CIGMT8GNnNW0zeqj3EYt6Y35h249Xms6AsQt67AlEdX1gnXzrvdjSuQUao/u5KgdQphqVMWhYAfSjJiGIJRCj8E6cQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761382608; c=relaxed/simple;
	bh=TbSJGWKTg0dx8dJyx1jq7gJ+igCnfbAtVGfctOnvqCk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ZRJnJ9tBrIDZjARajqIFiJfNJ7e112+dj78fA2SXU/pgE1s8+hnB6/lq2/idsT3zHJxY6Sqw+iyiXvfb8BYCZQTp/XL1DimjsEBlSS4wyJ0wSqH18P18V2kveYgysnNPwVWJjUITlQU8+kcK35IUB/b2HMBCMJ1COdTYlRdv2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fXeIUhQX; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fXeIUhQX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FvAkmAVBCS/1rS4+zr0ynrzfT5a8pzkm7Fl8QoFlrD4=; t=1761382604; x=1761987404; 
	b=fXeIUhQX4KUqoVYPKbyK4ULcs4Ez0RwMgDaWn1EEralfoE1Q/6ngZpRrJjknnFu2zfHgZ+jTMmb
	fcoW0coEtX7nJnH8P0Sdh5brkVT4p7o0SkJ0FYzaFT0l6CP4vZxBloEyWi+KSyfQNYMjPC3/y5ZY9
	e8R17FRBrcrUbKQYgykBUaoh+2hT0qDA8q2k95Un/n+7tf+D2L/Pmw+XbiWKeXqqqZCEFeVk+Jo2e
	9XuCVTcgslRJNkwlafzSECGf0N38o6Impt7gf9K/5i8Ouq89SFKv25AGfKLhuz9XXSjL7q12a4T5O
	ri1rQPIL5S0i6p98LWQc6A+jPSNJ8znLR1bA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vCa4n-000000041WS-3J3K; Sat, 25 Oct 2025 10:56:41 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vCa4n-00000002hcQ-2MNC; Sat, 25 Oct 2025 10:56:41 +0200
Message-ID: <cf8d79b35a3df1dd79fe3475b0e78ac50754b456.camel@physik.fu-berlin.de>
Subject: Finding SPARC patches worth upstreaming in the UEK kernel
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: gentoo-sparc <gentoo-sparc@lists.gentoo.org>, sparclinux
	 <sparclinux@vger.kernel.org>
Date: Sat, 25 Oct 2025 10:56:40 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

as many of you may know, Oracle's UEK kernel for SPARC contains a number of=
 improvements
that never made it upstream into the Linux kernel. Since it would be a wast=
e to not pick
those up, I have started creating issues in the sparclinux issue tracker on=
 GitHub [1]
to collect these. Since I can't do this all on my own, I invite everyone in=
terested to
help with this effort.

To do so, just take a look at the commit history of the arch/sparc director=
y of the
UEK kernel [2] and scroll through the commits. If you spot a commit that mi=
ght be
worth upstreaming such as [3] ("sparc64: Add missing hardware capabilities =
for M7"),
create a new issue like I have done for this commit in [4].

Some notes:

- Please include links with the commit title to the commits in the UEK sour=
ces; this
  can be achieved by selecting the text of the commit message in the commit=
 overview
  in [2], then right-click and copy. This will automatically copy a URL wit=
h the commit
  title into the clipboard using the correct "[]()" template.

- Before opening an issue, please make sure that the issue doesn't exist ye=
t.

- Use GitHub labels such as "patch", "kernel", "bug" and "enhancement" to t=
ag the issue
  similar to the existing issue.

There might also be interesting commits in the drivers directory [5], so pl=
ease look there
as well. Oracle stopped working on SPARC support for Linux around 2017, so =
you will most
likely find the interesting commits starting at the end of 2017 going backw=
ards.

Adrian

> [1] https://github.com/sparclinux/issues/issues
> [2] https://github.com/sparclinux/linux-uek/commits/uek4/qu7/arch/sparc
> [3] https://github.com/sparclinux/linux-uek/commit/efcafbab1b123d615c1f26=
83c98fccc5ccee1527
> [4] https://github.com/sparclinux/issues/issues/17
> [5] https://github.com/sparclinux/linux-uek/commits/uek4/qu7/drivers

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
