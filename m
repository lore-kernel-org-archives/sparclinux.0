Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="ADwflKCN";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="yR0Q/PBb"
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86FF122
	for <sparclinux@vger.kernel.org>; Sat,  9 Dec 2023 02:59:22 -0800 (PST)
X-HalOne-ID: dc579ad8-9681-11ee-b291-23968f462fbe
Received: from mailrelay2.pub.mailoutpod3-cph3.one.com (unknown [104.37.34.39])
	by mailrelay6 (Halon) with ESMTPS
	id dc579ad8-9681-11ee-b291-23968f462fbe;
	Sat, 09 Dec 2023 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=content-type:mime-version:message-id:subject:cc:to:from:date:from;
	bh=nq43OTPtsweT8Yc1FZDZXcFxqEhKq1Aa6vIacIG+aS8=;
	b=ADwflKCNbP9+Fh0s1bYq5x04b9AawG4AQvo175SK4DBpFmryVx/xF/PHobwaaITLpIOvwRkBgiBp0
	 AMjcu7oVxvWUxJdt6CUaBGkIP0/pswMm7W4gSnjjhM5i3nvi5DtUf6Dmb70bRehAE5z5PQ/N0jOsEj
	 /zLgqHFU/Ac6hoCXrQrfhAx0BqtaOOaZ4IQ7x3r4Of557UyS1RyoRKJmle0TMWWLbmiccbzuBxrRTl
	 rDJgh2M+SfIqExh7W6sosk0qm0CcxiITMfVJPlzOoTbO0XBHjct1XrxpxAgwut/s9uVCTsbmJt+Bzn
	 0B4X+TIybMnYweekLbuy4TF461oCyFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=content-type:mime-version:message-id:subject:cc:to:from:date:from;
	bh=nq43OTPtsweT8Yc1FZDZXcFxqEhKq1Aa6vIacIG+aS8=;
	b=yR0Q/PBbp2fqMOvrwdl7djOQ7jJhoQpQAxYjYbSxqdV+opAESji2sOXejgRnY50Kn3wE5jVlJSlKI
	 j76zLOrAA==
X-HalOne-ID: dac225c1-9681-11ee-9ac9-7ffa97e4e975
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2 (Halon) with ESMTPSA
	id dac225c1-9681-11ee-9ac9-7ffa97e4e975;
	Sat, 09 Dec 2023 10:58:18 +0000 (UTC)
Date: Sat, 9 Dec 2023 11:58:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	sparclinux@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: sparc maintainer future
Message-ID: <20231209105816.GA1085691@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave and Andreas.

Starting a new thread to get some visibility.

Arnd wrote:
> Regarding arch/sparc long-term, I think it would be good
> if Andreas Larsson could take over as (co-)maintainer,
> as he's currently maintaining out-of-tree support for
> leon3/4/5

> My impression from those patches is that they should
> pretty much all just get merged anyway. I would also
> suggest raising the minimum SPARC32 level to that of
> leon3 (SPARCv8e with CAS), which is what glibc requires
> anyway for futex().

Andreas wrote:
> Hi,
> I feel honored to be suggested for such a responsibility. I could in the
> long term be available for a role as some kind of SPARC (co-)maintainer,
> with backing from my organization. My SPARC experience is mainly with
> SPARC32 rather than SPARC64, so discussing a co-maintainership with a
> SPARC32 focus would feel natural as a start. I do not have much in terms
> of SPARC64 or non-LEON SPARC32 hardware available for testing.

> Has someone reached out to Dave? I think discussions like these might
> be better served in a thread of its own.

See full thread here: 
https://lore.kernel.org/sparclinux/030e57e1-13a0-4c62-8302-2b0008c6e92e@gaisler.com/T/#t

We are in the need of someone that can pick up the sparc patches that
floats around and push them towards Linus - they are often lingering
until Andrew or Arnd picks them, but having a more direct route would be
nice.

I am happy to assist with reviews for the areas I have some experience
with, as I still feel a bit love for the sparc stuff. But cannot commit
to more than that as this is all in my free time.

Thoughts?

	Sam
