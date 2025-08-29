Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789381DF256;
	Fri, 29 Aug 2025 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464075; cv=none; b=fuXhY1ywoojzytQv67T6CWAGnRUI/tft42Pyn9ucmXC6bbKqfbOKT8wltUZzv5aoGxhp/0CPiaTLC46wVE45Y7T/vqr8v87x+hZPJImIeDzXYRQHMmaBYeOrznrLkQaP6UIjCtLdQ/AkN34ZUTBwZ5GigECjElJb5BOZ0yQ3FIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464075; c=relaxed/simple;
	bh=1hTOOzENGEYnDX5Oy4cUO6xHdtNNQ4p7iMjf5PpV0VI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnbLWsLDiewYr8m54XExIw9ZCFfmlCVld8Dwc2IToBUDG/T+VNbK9XHGPoH69bAAFNJPuqNLxN+W3FNcctz9S/DAPdOXacQvbVkUkxtHF3wj1t8uBBS+39juWhiCbbu7XT/Jf1Ylf5Bsnou1SzymBhdqiFNLEKil95hfe8LWWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=kNYXc3+m; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="kNYXc3+m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=PkjYlohcCmkWw+P2Wv+vzu/gEZtdSyAoIIMdkSw9rlU=; t=1756464071;
	x=1757068871; b=kNYXc3+moy8gAzy+cGyYX9O1KsSqD2yBGvU2owPatR8SkqGf+6YBBxuaYuD/v
	+PmrnRTmcjsalcAZJtQEQ8BAAN+sX/pz6aKEc2sWQJEWQtivKiIF9+Jztppwah2DgG0b7hMZBfQlr
	f5mDdosCN9tTCSxKds3qzN7CduWZaBoORbP3K55jvWu3XiHd8eL8q4pOqPGe7IshICoqI8nW5jLJw
	mmt4g+DAL01chYMyd8avgW6O7uB/blRbXkW8eCYC9gbcSzPfXnAqtVirUVAm40YxkI0OPYvmsRDpE
	PLh5ds4l3Xhp0eIhytTfmWyTfkVAfuMvP4pmo6XjZdL2zLrdiQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1urwXV-00000000afS-0jvZ; Fri, 29 Aug 2025 12:41:01 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1urwXU-00000000ovK-3ljL; Fri, 29 Aug 2025 12:41:01 +0200
Message-ID: <b7ab1bdca349208532804d0d5e5af56817cd25c6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
  Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,  Nagarathnam
 Muthusamy <nagarathnam.muthusamy@oracle.com>, Nick Alcock
 <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,  Stephen Boyd
 <sboyd@kernel.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Date: Fri, 29 Aug 2025 12:40:59 +0200
In-Reply-To: <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
References: 
	<20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
	 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
	 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
	 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
	 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
	 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
	 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
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

Hi Thomas,

On Fri, 2025-08-29 at 12:37 +0200, Thomas Wei=C3=9Fschuh wrote:
> In the meantime I installed a full Debian, but the bug is still not
> reproducible in QEMU.

Please keep in mind that QEMU emulates sun4u (on UltraSPARC II) while
Andreas was testing on sun4v (on Niagara 4). There might be differences.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
