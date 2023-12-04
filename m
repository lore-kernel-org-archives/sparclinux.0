Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QXnVfZKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OhkaI++k"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0AA9
	for <sparclinux@vger.kernel.org>; Mon,  4 Dec 2023 06:14:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EE20B5C01AE;
	Mon,  4 Dec 2023 09:14:02 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 09:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701699242; x=1701785642; bh=7w
	oN8f0l0ptem1IYPykwxW4qLU9Wemr7fKMH8jTrQig=; b=QXnVfZKDueRaO5vNmb
	4aUnjRhW4w9Etxm1BqB1gCyTuNdhhlSCjZp0j8bunp0TPYJiXq+/1x8AABBBWHfq
	Ge+Na/KI7Kj5ATWPWJDnufBA/YWAVI4j7IH4rTbUk8TAkqrtGuXghAlciX1yeOgR
	gNR55ybxZaiZfbxjO4dgaVG/xVcEU+lY/mQerVwM5O5RuRncVqzfyOdfXaOVFgUo
	s1sfePf+vXa3vJHoy+J97UHJz4hHqJZxMixh0dUWK2hDlVjZv8Y3lFNobFB6uz4e
	d0T1t1eVU0TOeT4zT7xyyMeDtW4GhEUUmhV+NNovU1ahAgHZ48rukY1GYYFWrgKX
	SzkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701699242; x=1701785642; bh=7woN8f0l0ptem
	1IYPykwxW4qLU9Wemr7fKMH8jTrQig=; b=OhkaI++kzhrgJmKEffA8LJa0gKEFu
	WChl+qdOwD0YCA7kzZ/ilmSBEVbpR0WZlAgCveNvA2JdQxmvH0x4RNrit4IKljpi
	b12hFokJV4O8BKX+hzhA8pHTxefcaXRxycchb/LH64dcCcA78aQKpVw0W8Q/tl+8
	Uzb1gxnIcuGlj2uwZ+geEcXBMDgZk0XA53UiFOq5SoISvQqgKWR+fc+GYq9aOKGY
	4Y/OLlFzrfJ59W2LXxxP4V4p1TGlZnwZWmzqE4W480wdYcRze1/qlklgi4/DzQh4
	us/uaDpGptdMfkNpUTuAGkh7MGR9PX8QbQRlrN9i+fIDXkSi+WazTglMQ==
X-ME-Sender: <xms:qt5tZbt6ut6N85qwJx65z5cgAPGhqMvSYntwDgK6_h8kgggxf6Dkdw>
    <xme:qt5tZcdfBPaOC23EvcDPWRVFWiBFavs5ZsXbnpgbr0vxjQXYqnRyP8I9s_Huk1uyt
    8BhHCUKIsKD1sYI6_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qt5tZezpvYJhzBRQ905aTYQv97pOhmON6hc9zCeGgdwIHURUNX-HTg>
    <xmx:qt5tZaMNet3gWBHYS__yr8HEQaQ1erFB5XzCvffxvMrw126PJPZ3mA>
    <xmx:qt5tZb8EwB3quvJE49joBiwROYyUUm6Qcu4FWLE7VCxSPMY118ZT1w>
    <xmx:qt5tZcNpcXhXcQF7xnimkEvNuoOeJsyTCP8qX2OZPvE2vr2JfE9xAQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0E2F1B6008F; Mon,  4 Dec 2023 09:14:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c54caed-418f-49dd-ab56-788ea0e54e83@app.fastmail.com>
In-Reply-To: 
 <07aa2894b0d33cd6e0948d43d560053147e1c0cb.camel@physik.fu-berlin.de>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
 <20230713145536.GA5300@ravnborg.org>
 <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
 <add3c37a-08ef-41e1-b717-091d9bffd66a@app.fastmail.com>
 <07aa2894b0d33cd6e0948d43d560053147e1c0cb.camel@physik.fu-berlin.de>
Date: Mon, 04 Dec 2023 15:13:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>, sparclinux@vger.kernel.org,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Content-Type: text/plain

On Mon, Dec 4, 2023, at 14:37, John Paul Adrian Glaubitz wrote:
> On Mon, 2023-12-04 at 14:06 +0100, Arnd Bergmann wrote:
>
>> I would also suggest raising the minimum SPARC32 level to that of
>> leon3 (SPARCv8e with CAS), which is what glibc requires
>> anyway for futex().
>
> I thought there was user-space emulation for CAS in these cases but I might
> be wrong.

The problem with emulating CAS is that this needs to be serialized
with sys_futex(). Without Andreas's patches, sparc32 kernels don't
even have provide futex(), so it doesn't work at all. On sparc64
kernels or leon3+ with the futex patch, sparc32 userspace can work,
as long as it uses native CAS, but this would in turn break if
userspace ends up using emulated CAS.

     Arnd
