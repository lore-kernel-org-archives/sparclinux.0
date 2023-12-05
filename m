Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="b3u8LO3J";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="2fJCS5hg"
X-Greylist: delayed 8484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 12:26:34 PST
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A91C6
	for <sparclinux@vger.kernel.org>; Tue,  5 Dec 2023 12:26:34 -0800 (PST)
X-HalOne-ID: 941805c8-93ac-11ee-a920-2b733b0ff8f0
Received: from mailrelay6.pub.mailoutpod3-cph3.one.com (unknown [104.37.34.43])
	by mailrelay1 (Halon) with ESMTPS
	id 941805c8-93ac-11ee-a920-2b733b0ff8f0;
	Tue, 05 Dec 2023 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=s55/7YGitXtgcb/hoj5L9C6r5NfhDmerJmMwEjk+yTw=;
	b=b3u8LO3J3aQUUJ0LOzqyUIWeo9f6TSfxbMrzDTenZ3NRscknmY/PKtw9FdcLZZeNrISs/WgOebVx9
	 271SSYUA8DYAPlC4KG6iA3Poix68gM+SwOjvL6feYgTnq86LGl7EXnCPxT9KPwmTP5P5Uk+TWYKn7D
	 t2nr01QIEpphAlLL4Z8BvFTCdVDDghPrwiLXyyaXUolAf1UXeJACKwLB2Ow7DD7235zDJ4gcr3DA8w
	 5Djas9t8bvZssy3yjm+8kfKQCwB5t33UnIUODoJEXNR7Ath5isG7xdBHxImiqALzaK5315H0x3otLI
	 OB7AKAdYi8SpJWzENbpNTjt57XS0MjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=s55/7YGitXtgcb/hoj5L9C6r5NfhDmerJmMwEjk+yTw=;
	b=2fJCS5hg0f/TSeSYvYPLMYC/MvVtSoKO52QYSTN8Nj8zdUGuCRP2kQ462ppoE5zS+RraqQDknkV8h
	 hsXJzsCAQ==
X-HalOne-ID: 92b513c6-93ac-11ee-abf0-839aa246fbf6
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay6 (Halon) with ESMTPSA
	id 92b513c6-93ac-11ee-abf0-839aa246fbf6;
	Tue, 05 Dec 2023 20:26:31 +0000 (UTC)
Date: Tue, 5 Dec 2023 21:26:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Message-ID: <20231205202630.GA290248@ravnborg.org>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
 <20230713145536.GA5300@ravnborg.org>
 <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
 <add3c37a-08ef-41e1-b717-091d9bffd66a@app.fastmail.com>
 <20231205180506.GA242352@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205180506.GA242352@ravnborg.org>

On Tue, Dec 05, 2023 at 07:05:06PM +0100, Sam Ravnborg wrote:
> Hi Arnd.
> 
> On Mon, Dec 04, 2023 at 02:06:02PM +0100, Arnd Bergmann wrote:
> > I would also
> > suggest raising the minimum SPARC32 level to that of
> > leon3 (SPARCv8e with CAS), which is what glibc requires
> > anyway for futex().
> 
> Agreed, it is long time since I got any indications that people
> actually use these old machines.
> The sparc32 machines I have, have not been powered up for several years
> now, and they were only used to test new kernels on anyway.
> 
> I sent out a small patch series to do more or less what you suggested
> maybe one year ago. Back then the resistance was only from nostalgic
> people (like myself) and no real users.
> 
> If you or anyone moves forward removing the non-leon sparc32 support
> then starting new would be the best approach, I do not think it makes
> sense to dig up my old patch set.

Never mind, I digged up the old patchset and will try to prepare
something. Then we will see what reception the patch set receives this
time.

	Sam
