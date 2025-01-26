Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCA4964F;
	Sun, 26 Jan 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737916374; cv=none; b=bIeFU9Gro643+bzHe+JPAR7k+zUXTBqyJLdfghB4yAJbgKZjQEneSK5/DW5UaIuIMZjbgss1XsGfYkl7BqLupAJFeWwBHXSCO5l0/5HuJfeoRTg6rKNgY00CtTmHcYQQaE6/1KvcCIF2qr692vpUjWtjjDp/EAFyk+iaPIHJheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737916374; c=relaxed/simple;
	bh=avvpmUgfvtJfqU3jiqXqjn3bnGsODH7FeVYnh+m3mc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnN/iAfBHxt2PkFTD2lP+AI7wySH3lOX4hufiYNgzTOdHAMr08grTannSWHYBfaaiwBHwoVblN/Lls9Gco3d2wpXagoE3OzrL7cyPrbDyFhrybJ7JRb8gziNXaJ1lnbG9uXcET82534qkisbdrtnPjfxAGV5kK/tczcIu9+fcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=YV+MBKO3; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="YV+MBKO3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nHSPxgztdl/Bm2MbfCgtmcMMkDpgOnF43C/xmJ0KzcA=; t=1737916371; x=1738521171; 
	b=YV+MBKO3znWHV3xcBqv19Kti0av7z+qqhnNFud0ra8r8LdEc+o3u0O3y+8t2I0am3lE49ZiMylD
	1cNb0rj2xcR4mBrm0RwurDesdeXVwnV22dBAz4AGkvSlho3l+MQlpGPZFEyZzkindU9aRi68la0eW
	gMevdmcDsM3hwgl+rWnP2wpAF0/ZxoznNoUKemxAit5jPXE1UDH8Dr9UZ3qOLXfsasfpwmopzqa0p
	GNOyjukCSuKK6/xzAYHWTxt71QNkG5+F93kY7lhAZ+nFefONuQsYe1w9CYN13ABCt51/Oh4VqM23D
	20c7vNm8UJ3k7UqTDtS7jnkVq7kNVb81v3Wg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tc7R3-00000000hlQ-04Dw; Sun, 26 Jan 2025 19:32:41 +0100
Received: from p5dc55cec.dip0.t-ipconnect.de ([93.197.92.236] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tc7R2-00000002zwS-3KKs; Sun, 26 Jan 2025 19:32:40 +0100
Message-ID: <e0de2eabd5026b1225964a272c87605052cd156c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] oradax: fix typo in dax_dbg message
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Gardner <rob.gardner@oracle.com>, Andrew Kreimer
 <algonell@gmail.com>,  "David S . Miller"	 <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Sun, 26 Jan 2025 19:32:40 +0100
In-Reply-To: <cbabbe58-8b11-4bf8-bacb-5d4154b8a571@oracle.com>
References: <20250123201909.15469-1-algonell@gmail.com>
	 <cbabbe58-8b11-4bf8-bacb-5d4154b8a571@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rob,

On Thu, 2025-01-23 at 13:23 -0700, Rob Gardner wrote:
> That is not a typo. "Copyin" is correct as it refers to copying data in=
=20
> from user space.

If it's "copying in" data from user space, it should be spelled "copy in"
and not "copyin" unless my English grammar skills are failing me.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
