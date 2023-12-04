Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="N4P5t4Ch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GH45OG4o"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D4A7
	for <sparclinux@vger.kernel.org>; Mon,  4 Dec 2023 05:06:42 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 81D3E5C011D;
	Mon,  4 Dec 2023 08:06:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 08:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701695199; x=1701781599; bh=XUFhFEwKktNtMNrvFPXgXiIbKm38adekY7V
	AbLj7HzQ=; b=N4P5t4ChH0WBkOYNo3iZ/siu31Yt0+B3MZj+LVFUQyKzS9EYEPn
	HCPZQ7cAPAKjXFckWelID4u/8I/SqusHrX4FIukdKgGP4RhHlC3sWfVE7UXoJXgr
	NyPYHmfwcMz7Rk7ngDZN4JU/+2SdIuxdEfIj7tpO/+Mxhpj5b418IqOuZyqw8Izp
	ybwvIEZJID8J/pSI+YU7HOeYbydOIaasUcrT7GuNpY5lRG675s9+A8j4nM92u07P
	yEB7spEcETplwPVX8CAMvxFd44yG5q+DYkU6jTrR2tJk0e7ADjF6NrBn9KFE1YR/
	7nXqvrt0MeW2ZFZ319KK1gT09aTTVs0QRGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701695199; x=1701781599; bh=XUFhFEwKktNtMNrvFPXgXiIbKm38adekY7V
	AbLj7HzQ=; b=GH45OG4oBRkitDCnxqE9zkN0Yqbb4vRelfGOtFfcaEMWLXQcGiR
	Jt7pivfmxX5sOS1HNRGxai+fzsF85bwLhwldc73f56F2MXmz7e0MWV9F+tlZH0Q2
	ytSTs34ie77Ekjqc5d1OCwZfbzcBwS/5LclX6dQIUk9b7fskDiH1OR9Ls43WPB3L
	kYjciemfqfLgtnHXoQUxDt8NoGtusC/3qPUGTX/eduz8Zs1o4/eqX7UB7lUj0BJc
	B8eHx2CH4WUU+TOtgeJn4jbXLI8+O/NA0NVBzjyzPHfqj38HIIdHBAhVjFGGrwHy
	vMgTlQNsEEqsE0EgosRVBHbyCc1UpoFAzHQ==
X-ME-Sender: <xms:3s5tZcw-vViu345i1Aq9hEy_WPbwmqv6IsdQjI46g7AVGBOy6o47Vg>
    <xme:3s5tZQQhBeM1bQUcf2LwzdUjYQBN5WZmA_2267REhuqMT8GX_4gGoea1dXwL67g_p
    iBmPbe5I_D4y1Uxgv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeehteehgfejudeggedtudfgieefheevteffueegleeikeekteefgfdvvdej
    jeegieenucffohhmrghinhepghgrihhslhgvrhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3s5tZeX-6CMOv4JvP6afJmju83ZnP89e4lZzgXROeUnEBm1xj6LRtA>
    <xmx:3s5tZaixNXUIGM90C7GOwPn_WDgnK39haUhYTXeJSPo5eX7qw7Rvtw>
    <xmx:3s5tZeBYndiPbCCTM14sJZz28i-ojoawHMlGeNHnoIuqe2W7OVIkPQ>
    <xmx:385tZQ3vZ6Id5YaU3arEMsqJcu3EhRVSayquYbukeO7--j18gV9nTQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 56A5AB6008D; Mon,  4 Dec 2023 08:06:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <add3c37a-08ef-41e1-b717-091d9bffd66a@app.fastmail.com>
In-Reply-To: <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
 <20230713145536.GA5300@ravnborg.org>
 <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
Date: Mon, 04 Dec 2023 14:06:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>, sparclinux@vger.kernel.org,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023, at 12:05, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Jul 13, 2023 at 04:55:36PM +0200, Sam Ravnborg wrote:
>> On Thu, Jul 13, 2023 at 09:52:35AM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> > My build test setup compiles allmodconfig all various architectures
>> > (arm64 m68k powerpc riscv s390 sparc64 x86_64) using make -s. If th=
ere
>> > is no warning, the only output is
>> >=20
>> >           kernel: arch/sparc/boot/image is ready
>> >           kernel: arch/sparc/boot/zImage is ready
>> >=20
>> > from the sparc64 build. Copy the incantation from x86 which is sile=
nt
>> > when building with make -s and also mentions a version indication.
>> >=20
>> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>>=20
>> I hope Arnd or someone else can pick it up as davem is not active on
>> sparc for the time being.
>
> Nobody did pick this up. Would resending make sense?
>
> The patch still applies to today's next.

I've applied it to the asm-generic tree now.

Regarding arch/sparc long-term, I think it would be good
if Andreas Larsson could take over as (co-)maintainer,
as he's currently maintaining out-of-tree support for
leon3/4/5, which

My impression from those patches is that they should
pretty much all just get merged anyway. I would also
suggest raising the minimum SPARC32 level to that of
leon3 (SPARCv8e with CAS), which is what glibc requires
anyway for futex().

     Arnd

[1] https://www.gaisler.com/anonftp/linux/linux-2.6/kernel/
