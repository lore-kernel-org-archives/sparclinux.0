Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03132D5C8A;
	Fri, 15 Aug 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261296; cv=none; b=ABrqmPcM2CWD7JHVop2RUtw1ifTuYibwqPQrp91lTm6jR49kDG2kLBOfs+HH67tF7f2VwbCBALyFvpV9Ti6HulkcIb/hZEzBesogVQuGcqdnE3shNSzsklXJtfAzxUhFzaSR4wRq3zEkB3iUBfMn8YxzlVnp/2pw8P2sQorNirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261296; c=relaxed/simple;
	bh=yVQTdqKKIXh8OV5KCTRUj6jILEAA31BIL3kkxRCUl+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7ZMgekLsWia1mEkS9aHUogJtDZgFnrrEo+tZ+h+zfwOvqxeaWSYcdo1Ju4UjUcQ6Dyi/8y0P/0LRhtrsFStlR/tUjbINhwC0N3z+B9Zeq/3rtc7mTHa3L1xnSC73BANLLxcdtUU/rgyk3/FycB0ihezkWQ+q7O6GW9QXO5yY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tMxwJ3cX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7pkqyim2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMxwJ3cX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7pkqyim2"
Date: Fri, 15 Aug 2025 14:34:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755261292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GskG3YtXcFp4rQz6v2Q+5esnkZZ0DNCNna2yVWBr4Wg=;
	b=tMxwJ3cXIXJM0e8Tprgd4zUJ9p7/loV9zXri12FoyvXGg9so3K9etgsJWsz/JBo+daaKHZ
	zSkj09yCtL6QkKwPihZLVkRzAbcWiOlmkisY/xB5Qr1DD1ffwc6eUnlGD9uSjKmN437Ycc
	GO659X26KQW0XhuSzi6eMcY+5f8qJqI/XLwhQiSMNs9h6VFa+cq1bLVmO8n2gca870nIvh
	zejX54NeVnygwwbQb7kYjaEuWqALh8VNupluHB1i2Gght6RwLjp/PsuE7IgMv7nspUnVO8
	uSFese0SUjDGCCNwbD1lm+KX4NzL6xvFuEaXN4WMDdfdSxAzyjveL0gHhFd0EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755261292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GskG3YtXcFp4rQz6v2Q+5esnkZZ0DNCNna2yVWBr4Wg=;
	b=7pkqyim2ytt3rdqiNyFfWbMA9UILVEU2w0Vksf0SgwjHyP9Zd48b/cjZ6ZC/qcqkNCx57n
	31QdpDu/EvBlo7Ag==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 12/13] sparc64: vdso: Implement clock_getres()
Message-ID: <20250815142418-d28c6551-bec1-4a65-9c52-f1afd7b630ed@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
 <bf9ec82b-af1b-4684-ada5-8529b7ceb06a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf9ec82b-af1b-4684-ada5-8529b7ceb06a@app.fastmail.com>

On Fri, Aug 15, 2025 at 02:13:46PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 15, 2025, at 12:41, Thomas Weißschuh wrote:
> > 
> > +#define VDSO_HAS_CLOCK_GETRES		1
> > +
> >  #ifdef	CONFIG_SPARC64
> 
> > +static __always_inline
> > +long clock_getres_fallback(clockid_t clock, struct __kernel_timespec 
> > *ts)
> 
> > +
> > +static __always_inline
> > +long clock_getres32_fallback(clockid_t clock, struct old_timespec32 
> > *ts)
> > +{
> 
> > +}
> > +#else /* !CONFIG_SPARC64 */
> > +
> > +static __always_inline
> > +long clock_getres_fallback(clockid_t clock, struct __kernel_timespec 
> > *ts)
> 
> > +
> > +#endif /* CONFIG_SPARC64 */
> > 
> 
> Something doesn't quite line up here: I think the check for
> CONFIG_SPARC64 needs to be for "#ifndef BUILD_VDSO32", since
> sparc32 kernels don't have a vdso at all yet.

arch/sparc/vdso/vdso32/vclock_gettime.c translates BUILD_VDSO32 into more
"standard" defines, CONFIG_SPARC64 in this case. I have a follow-up series
to get rid of this pattern in all architectures.

> On sparc64 kernels, I think you only need the
> clock_getres_fallback() for 64-bit userspace, while
> the compat path probably doesn't care about getres, neither
> the time32 nor time64 variant.

Why?


Thomas
