Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A6A2D
	for <sparclinux@vger.kernel.org>; Mon, 18 Dec 2023 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="1vvuC5xS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wvVn14Lw"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6C8915C037D;
	Mon, 18 Dec 2023 15:53:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Dec 2023 15:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702932808; x=1703019208; bh=Olk9fCVgB0
	PrHge3SPQZQxaqzhAMGMJ3FkfMHXXf9Bc=; b=1vvuC5xSs67TA7lVgrQLZ1y95E
	cL5BKY11qI61cNbWHE8rmBR3ufRHPEaP4ccUfwDeFWyqU50iIeeMMROc24/yWW+Z
	4TK0Q/FaEZD6IB9oO5Js8/Bd7XDrdddcxMnL31yCr6tVE4pmggHZlJp3aX/mw9I9
	uSO2auWB8sRxyo56uO0B5ChCCdTXmOWCWYrQ96og3e5/fFnBM0VtyoW+Buux+OCn
	+o2dQYU7R1xHoXXbpAFW8eDsPfX2wTfTt+GSf4djr2n708Whs4w0w6BNSlLWZI1J
	BzlaKMpy0lGCKIeDGFcdmyJgHgt2HSWGKybKkvGDIfiGs+e1/P7aSbNmuQCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702932808; x=1703019208; bh=Olk9fCVgB0PrHge3SPQZQxaqzhAM
	GMJ3FkfMHXXf9Bc=; b=wvVn14LwzU8iX5Ri+m8JzspCOvQXgBZ1O5296s4Em1o7
	2T5wa0Ug7eLb9mllP1+xdfKN6gER/FgEmI+aSCysvpAbh+UlB+trBGMXvPx2EWiw
	AdI9Ll6F2UMFTiLPJ/uqlkXLnF3W7wUlDjj0NBxlYVB6uwX8ZrCjpw1CNUb8kLaE
	visqn8vOBKdOgBZpc4oOJ/tGrSVRfjppndNN6Z5/CDVIu7Wb0f48bDC96MmqESBY
	dEFanpbDMy0NDjYW5t3nqHdY9Ai1FiVmxgXY2A3MbFO+mSgr5+fVW9P/QiKK71vr
	XE+MvQqn2IOHMF8nwxPNJKDSGdG4bfAU0wwkbDn3bg==
X-ME-Sender: <xms:R7GAZfRt1ZdnW6swhrhUhw2okUD4K4d3dHHbwRPkoRVgKdbMGT4-Cw>
    <xme:R7GAZQwlj6NxhoAb4hQGHdLIlWKzFfmBxRscr5ugXjkBzNpy1qg8bGSsoIpbz5hm8
    pJ4q7g4s8Km0Zde8ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:R7GAZU3mq8XKx2H2Ds0duphlar_Qb9BzGa9tXejxQkHTezU-0H36pQ>
    <xmx:R7GAZfCo-fRzkK72CDXmLECRoxzdDAbfr-R1B93uTIEiWFifxCs1ig>
    <xmx:R7GAZYhSmLUu74dXNJvKobqTBc9v7Rd2qruMGJUmexw7uXvDl6rt0g>
    <xmx:SLGAZUgKfOF1wpVvgx_owD458S0ACok5s6HlQDlDoH9E4aAJ0hqSag>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 786C9B6008F; Mon, 18 Dec 2023 15:53:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11427751-b6d8-44a9-af12-70adc10d8edb@app.fastmail.com>
In-Reply-To: <030e57e1-13a0-4c62-8302-2b0008c6e92e@gaisler.com>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
 <20230713145536.GA5300@ravnborg.org>
 <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
 <add3c37a-08ef-41e1-b717-091d9bffd66a@app.fastmail.com>
 <20231205180506.GA242352@ravnborg.org> <20231205202630.GA290248@ravnborg.org>
 <93c22029b8523c5380f126995481002246eabfa7.camel@physik.fu-berlin.de>
 <030e57e1-13a0-4c62-8302-2b0008c6e92e@gaisler.com>
Date: Mon, 18 Dec 2023 20:52:47 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Larsson" <andreas@gaisler.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Sam Ravnborg" <sam@ravnborg.org>, "David S . Miller" <davem@davemloft.net>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>, sparclinux@vger.kernel.org,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Content-Type: text/plain

On Thu, Dec 7, 2023, at 17:49, Andreas Larsson wrote:
> On 2023-12-06 10:31, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-12-05 at 21:26 +0100, Sam Ravnborg wrote:
>> 
>> No objection this time. But maybe we could sort out the maintainer question
>> first, then start with new patches.
>> 
>> I like Arnd's suggestion that Andreas Larsson takes up (co-)maintainership.
>> 
>> Can someone reach out to him?
>
> I feel honored to be suggested for such a responsibility. I could in the
> long term be available for a role as some kind of SPARC (co-)maintainer,
> with backing from my organization.

Sorry for my late reply, thanks a lot for offering to help out here.

> My SPARC experience is mainly with
> SPARC32 rather than SPARC64, so discussing a co-maintainership with a
> SPARC32 focus would feel natural as a start. I do not have much in terms
> of SPARC64 or non-LEON SPARC32 hardware available for testing.

I think that's all we need at the moment. The lack of an active
maintainer does get in the way of cross-architecture work,
especially when touching the oldest parts of the code.

The most important bit here would be someone with the authority
or Ack or Nak a patch going into another git tree. Even if you
are sometimes wrong, that is still much better than no reply.

On top of that it would be good if you can set up a git tree
for collecting patches to forward to Linus and get included
in linux-next, in place of Dave's orphaned sparc.git.
Once you have an entry in the MAINTAINERS file, you can ask
for an account to host this on git.kernel.org, but other
locations are also fine if you already have something we can
put in the MAINTAINERS entry.

Do you have a preferred place to host a tree?

> Has someone reached out to Dave? I think discussions like these might
> be better served in a thread of its own.

As far as I can tell, Dave has focused mainly on networking and
bpf development rather than sparc for a few years now.

I would suggest that I send him a proposed update to the MAINTAINERS
file with both of you listed as maintainers and ideally your git
tree location replacing his.

Dave can then reply if he has any other preferences (e.g. having
separate sparc32 and sparc64 maintainers, or becoming reviewer
instead of maintainer).

      Arnd
