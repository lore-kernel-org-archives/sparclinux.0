Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB381F131A;
	Thu, 14 May 2026 05:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735022; cv=none; b=pO3lIo+oSEAiH0Cn3gtNXc+7AO8/X5M1LN+YSlqeucLLx/erC9JvbhrXkSC8VgpbAPAhorGS8yLbCOBQ06AjD+fYjX7hO4roEn8sZfxyb8BkWkJVUbVU+xYMsgDHfo9++0+QzO0T9JgXg836kC1qC6fl3ypWnNC+HSWAR8Qi1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735022; c=relaxed/simple;
	bh=L8CrBeB56MxbJ6rQ29MkwLpkO0lG7FtBuRIfxVebbxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXjnbQMmBJahL6WAEjmQ9LB3wlrBKABy2fvwf1dCSQGQB3yF/9uvEfkYKlUSkhBgb7NlCEuEi+w3g6FzMCn1TOL9OMDfY+du+2Q5t9du+F3k/O1PC/oNL9TKsdQn7Lc5Sz2njeIVg2qIUVCLArtgDw7kuoqGRydS4hM+tepfiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IC1lsFX8; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IC1lsFX8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ILPBYZeLfdK0PbFUEzZrHRibCfPJ4gqK7gxxgFD+XwU=; t=1778735019;
	x=1779339819; b=IC1lsFX8YUYuuGE4Y87ma6ssLXjlOlq2OeKWtRD0H6nt4/TU0Te2uveW4THjF
	iSlOsJTCVEw5hBf3icQ17BErjq9AaIsoJ086MNDb3j0SFgt8JPuog4B9nhG9Xn1WJsCorW56ZCSRL
	5TY85fZFO2zepU27h8+cBGi95SMVSsZhry3nImOJ8ptN1LN1OJkxTsjY2EbSdm7kEUfs5GjLEMogn
	7VKra5kfN3FRq+mMXhWervNino7YN3hV+ujUAddXPdY41iZBljh6/VX6BGB0zIVihTl9SL72RRO1M
	1K8cMqEEDlsnq3tIb0yVz9z1Ant5R1gVJ6kXcIKaMW777/abWg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wNOEL-00000000SyC-2cIX; Thu, 14 May 2026 07:03:29 +0200
Received: from p5b13ad18.dip0.t-ipconnect.de ([91.19.173.24] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wNOEL-00000002uWY-18PB; Thu, 14 May 2026 07:03:29 +0200
Message-ID: <f8a58a8d567149f514f2f5f47af25905f254f72f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: Avoid unsupported LLD branch relocations
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rosen Penev <rosenp@gmail.com>, sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson	
 <andreas@gaisler.com>, Christian Brauner <brauner@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling	 <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, open list	
 <linux-kernel@vger.kernel.org>, "open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:\\b(?i:clang|llvm)\\b"	 <llvm@lists.linux.dev>
Date: Thu, 14 May 2026 07:03:28 +0200
In-Reply-To: <20260514041908.874355-1-rosenp@gmail.com>
References: <20260514041908.874355-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rosen,

On Wed, 2026-05-13 at 21:19 -0700, Rosen Penev wrote:
> LLD does not support several SPARC branch relocation types, including
> R_SPARC_WDISP16, R_SPARC_WDISP19, and R_SPARC_WDISP22. A sparc64
> allmodconfig LLVM build can therefore fail when trap table code and
> low-level assembly leave branches to global symbols for the linker.
>=20
> Use local labels for branches that stay within the same assembled
> object so the assembler can resolve them directly. Convert the
> remaining cross-object branches and tail calls to absolute set/jmpl
> sequences, which LLD handles through the usual HI22/LO10 relocations.
>=20
> Disable the unused sparc32 syscall trace entry points when compat
> support is not built, and request sys_llseek for the native syscall
> table so the LLD allmodconfig build remains self-contained.

I would rather fix LLD than making such intrusive changes to the SPARC
code in the kernel. In particular, since this touches the CPU-optimized
memory routines which had been haunted by subtle bugs for years and were
only fixed recently.

Is improving LLD in this case not possible?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
