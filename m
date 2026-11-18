Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976739;
	b=242+NB75JSRSXwzP9RHF0aMHyiOuVlMJMc0+Z7drxxtQ5XJ6Eljgy9n1FW5ooGtoTFn8
	 rdo18VUW1zZ5aZ6TJfWHkBIleeg/2Ye+ddguURfjJLKPfBov3QAxKMbRgnH7GWf/pJxLt
	 wtSwb5BH9E+AtuBysDD0o95nnoVey+wsGWWmPU1PXtPa87+yaIJGXQoeymDxcZZ+m7DVc
	 nQqc9uCtat2r+jQ2Rj4YZv3/sICmhQ96hO1YjjtZxRta5+GZ+Gs7RRKI6CYjWcgLiDDCa
	 68PfQglp/3CLoJw5801tJoH0mcCvoY18haPvkrx5M3SIqz9gRxYtyV77M/zJIpicYEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976739;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=9LEd/iw8t5Hh+C/3HS9Kzo7OZZlo3oexvOhpz2iPYZo=;
	b=CxxHgQwP1SDZmkdXqLXfICl2/WEfMZn2EJjTGOz2WGCT1BCAwt8S8PwFSnm6pa8WrsUi
	 NpqTyNLRZnQt07Pfue4wBMFXSluA4c8ULZ6dXTDR70rhUIaqB82R+Z4DWBQFwLXa3YGUj
	 lQuW9B8NKVtAPAOfOazmAsD7tiERUMJQ2kwpo8XV2a7uRrBJDAzSUkdc5Qg8RUUdr5vuA
	 BqYRBxB7Ja7riVdYPYprL4ioIFPf7D77XS7CLDXIiJDQER5Q4yru6WoPFFAMdcqGq3Yjd
	 azAd7jW7DSMMkAlOLeLFcXj6nypYMSHCSSb6lxKNzxUtIHHJKu5zLHdP+al99S957Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRefRfIQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D808606A32F;
	Wed, 18 Nov 2026 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRefRfIQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B591F000C4;
	Wed, 18 Nov 2026 04:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794976738;
	bh=9LEd/iw8t5Hh+C/3HS9Kzo7OZZlo3oexvOhpz2iPYZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRefRfIQGx6izPeu48H4wEb+8I56HJageEuBtdwB8m2uuPFlRwEaudqirO5kgL33S
	 HUckgjj87QtvHPN8YG/q70m39c+8nQ8fScjWaRNQm0P1QJ1sJcT3Kpi5i+yhSku608
	 36CtEmBh6JAedAodbIXpb7KVgA4cWRsuyrlaUAq6S10jHCf9ndyfMRSs8h35tuZnZl
	 EP9gjICgvwoiBPDwHWJoeEM5Lj8m/Dm36GtR+vVccZrg7pxKsAGmOs6Kn1TOkOU7H/
	 JHYMwGc07mAI0/5fnUt3kcVJS3AuxGwfJxRK1GU+KP49x+4mXIidj5x1nexAEXbQkP
	 2Un4Ti9Er6IRw==
Date: Tue, 17 Nov 2026 20:38:57 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: sashiko-reviews@lists.linux.dev, sparclinux@vger.kernel.org,
	Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: Read qemu,hwcap-list from the OF cpu node on
 sun4u
Message-ID: <20261118043857.GA3400@sol>
References: <20261117112914.2300417-1-stian@itx.no>
 <sashiko-outbox-218725@kernel.org>
 <8c0c3734b9ad1ba0072ce1fbcf895b544563798f.camel@itx.no>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c0c3734b9ad1ba0072ce1fbcf895b544563798f.camel@itx.no>

Hi Stian,

On Tue, Nov 17, 2026 at 01:44:14PM +0100, Stian Halseth wrote:
> Hi all,
> 
> On Tue, 2026-11-17 at 11:46 +0000, sashiko-bot@kernel.org wrote:
> > 
> > [Severity: High]
> > This problem wasn't introduced by this patch, but can hwcap_list_caps()
> > read out of bounds and loop forever [1] if the property buffer is not
> > null-terminated?
> 
> Yes, and we can fix that in v2. As it stands the parser trusts the list
> to end with a NUL, which is not guaranteed if a QEMU user supplies a
> fw_cfg file directly.
> 
> > 
> > [Severity: High]
> > Does setting HWCAP_SPARC_CRYPTO in sparc64_elf_hwcap on sun4u cause a
> > regression where the sparc64 skcipher drivers corrupt FPU state and round
> > keys across skcipher_walk_done()?
> > 
> 
> This might be a bit worse than I first thought. I was aware of the
> self-test failures, as noted in my patch notes, but it looks like this
> could also cause some data corruption. Only QEMU can hit it, since no
> real sun4u CPU has the crypto opcodes.
> 
> I have not reproduced it myself, and before spending time on that,
> I would like to get Eric's take on removing the glue code altogether.
> If not, we could fix the glue itself, for example by dropping the FP
> state before skcipher_walk_done(). IMO that would be maintaining code
> that probably should be removed. Not my call, though.
> 
> Andreas, please don't apply this patch as-is for now. I will wait for
> Eric's reply before proceeding.

The following series migrates the remaining SPARC crypto opcodes
accelerated AES modes into lib/crypto/:
https://lore.kernel.org/linux-crypto/20261118041033.50014-1-ebiggers@kernel.org/

There we have more control over the bounce buffering, and I set the size
to 128 bytes (rather than crypto/skcipher.c's PAGE_SIZE) to keep it
below the size threshold at which memcpy() uses the FPU registers.

I tested this patch with that series and the QEMU support you added, and
everything seems to work.  And Camellia is not supported in QEMU, so
that is not an issue either (and really it's time to just delete the
kernel's Camellia code anyway, as no one uses it).  So feel free to add:

    Tested-by: Eric Biggers <ebiggers@kernel.org>

We should be fine as long as my series is merged too (and I plan to take
it via libcrypto-next in 7.5).

I think this is the only case where a Linux architecture has
restrictions on when memcpy() can be called, though.  It would be worth
finding a way to remove that footgun, e.g. making memcpy() automatically
fall back to scalar code if the FPU is already in use.  It seems that
some of the SPARC memcpy() implementations already do that, in fact.

Thanks,

- Eric
