Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05859380FF5;
	Mon, 25 May 2026 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738498; cv=none; b=inq1kJWhVemK9Tal92rkaZSmmQm4YscgvXdy6jj8BqsBkiDE4paXLBGmFYV6Ptt3CPWh/D9TMexuG3pxh1mKCE/ZYxdtmPJJ+dsQkRRu5AT+CkjI9PUjTOfToCjkhKygxlpcOFYszf+45NwURGOJalRiWyYdfSAnZkT5balzpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738498; c=relaxed/simple;
	bh=BiltVcWa4/8LqYFT2QaOKwtiQUnWF3F7/ZZRZpwCvFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dii7mh626hofc3lb9kPMlAPNP4ujc99D9z7/23iwwyX+mlYQdMAjNxOT8isvfJwQKf+Y3PCucL5sfY6vEwt4BgIc4W1DiJIXFGwF6qWb9q/VrHj7P5OE2j5aJWBLPSAXmDK04lXbUSlr+gHXazpiH3t5WiDLKCG0VD4rJ50arP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=b7hlHYjC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="b7hlHYjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779738494;
	bh=BiltVcWa4/8LqYFT2QaOKwtiQUnWF3F7/ZZRZpwCvFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7hlHYjCAsmBi/NmcAMCg7Q8dvJ5Lfm50m9sJDapm1GMEaZJUp3s2bCt+wxj+9TsQ
	 XnGHbpG8YCPvaCj0oyKYTQ/vN7BgwPri0atKBmsDUawc5LD4egI3oCuoJMakBZJuf6
	 inerLs4md/4KejUhFvmnPKXdRxlICclwHugQOGrY=
Date: Mon, 25 May 2026 21:48:14 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sparc: Avoid -Wunused-but-set-parameter in
 clear_user_page()
Message-ID: <07713350-d55b-4be7-acf8-3853b08c0358@t-8ch.de>
References: <20260525-sparc-clear_user_page-v2-1-e7a47fbcf439@weissschuh.net>
 <20260525104439.ce06c784e4b8bf25cadaf8e9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525104439.ce06c784e4b8bf25cadaf8e9@linux-foundation.org>

On 2026-05-25 10:44:39-0700, Andrew Morton wrote:
> On Mon, 25 May 2026 10:36:21 +0200 Thomas Weißschuh <linux@weissschuh.net> wrote:
> 
> > The loop in clear_user_pages() iterates over all pages and calls
> > clear_user_page() for each of them. During the loop "vaddr" is modified.
> > However on sparc clear_user() is a macro which does not use "vaddr".
> > The compiler sees a variable which is modified but never used and emits
> > a warning for that:
> > 
> > 	include/linux/highmem.h: In function 'clear_user_pages':
> > 	include/linux/highmem.h:234:63: warning: parameter 'vaddr' set but not used [-Wunused-but-set-parameter=]
> > 		static inline void clear_user_pages(void *addr, unsigned long vaddr,
> > 
> > Other architectures use an inline function for clear_user_page() which
> > avoids the warning. This is not possible on sparc, as
> > sparc_flush_page_to_ram() is not yet declared where clear_user_page() is
> > defined. Including cacheflush_32.h will trigger recursive and lots of
> > other issues.
> > 
> > So hide the warning with a cast to (void) instead.
> > 
> > While we are here, do the same for copy_user_page().
> 
> A pleasing solution to these sorts of problems is often "don't use
> macros".  Other architectures use inlined C for these functions - will
> that work for sparc?

Probably yes. But it would require a major reshuffling of the header
files to get the dependencies right. So I went with the easy solution to
avoid a lot of churn. As I tried to explain this in the patch message.


Thomas
