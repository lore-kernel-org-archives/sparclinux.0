Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F714A92
	for <sparclinux@vger.kernel.org>; Tue, 19 Dec 2023 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="W+bEvU29";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="na20DaJR"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DD9F45C00FE;
	Tue, 19 Dec 2023 05:32:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 19 Dec 2023 05:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702981954; x=1703068354; bh=xGPEMbNwX3
	NO97+44DWiOlOIjEKvTF1NPgBBzLvFWrY=; b=W+bEvU29JO1jDJvxS6XM2JQas4
	xDghvwbeu2fWI+NdGe0UY8vAYd1JJvijfYBE+TEjGyQ9GzVz5e57Sf9wDHxJTxy2
	PV+trN2UXdQNhtvn8HaR7IhoDbp1lhH8IdMBk+eRtIyjDPJjjIjH6XgNsbnZJmsV
	Lxgh7xKbmYJdWLJxeDokCaShATecKFJpPlg9m5LAbMWw5goyCydU7nNUg+fk8Ltg
	8L8UIfz87nTatc22WqZdXVUskCo+gUEgPNMSTe4HaNpRfpa7+aBs1Fj9NFeukg4Y
	lNto6ZYS00OAo3B8zcdRB+aUe2dKSahGoxNYrRWXCu9wrbWZjRXIaab7iryg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702981954; x=1703068354; bh=xGPEMbNwX3NO97+44DWiOlOIjEKv
	TF1NPgBBzLvFWrY=; b=na20DaJRzu4K4fIANeMjwhyJ/HE38T4i3TI8+aeB80ji
	PiCuIZpyucWkm1VcHKkP5KM9WX0gO6Yy6mSkAkNkK2S1iHGGs+fY4ZWwtgBS6ghk
	t7yDAPiH9GANqO2UpiIltewta2FxyrhKXD99B9S0E0eMAHLzDxlY05O+gH99KTod
	uLdtp8bU6wm1Mvv4G3+WYbyq3xNG9kJhcuuwWKc1ACL6tu3b0fA/x5kAR7O0pjnF
	+OCF9XOjKigW7pYBVkRy9wqxumfV49W19evutQW08+5jWJJBhyw3h5Br1TOus8pg
	OlOWAJMR43RPVsmGPcCstf4lPYGByx2kxuaNxhPhLQ==
X-ME-Sender: <xms:QnGBZbo7spTAsvQgmZmSjkmA_cqvYGrNw-CPuw5hNxg1cVSqEOdzrw>
    <xme:QnGBZVqm-hSXnuncnBOiUDaMRI8jFC0_i_ng59LT6z9jiGnjqh69tqpM9o5t_LKWo
    -BvpIzUSrvppB4rfFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjedvvddvudeludehjeeitdehheeivdejgfelleffiefgvefhhfeuudfhgeef
    feehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QnGBZYMIhn7YKYXN4_5T_zxNKv-qbQd6YvkRa-Wzb_Vq8ohLtVBDjg>
    <xmx:QnGBZe69XgKvlUhmtGyKy6d4EPUtLiDWB7O2nJ8-3mG3i-HRiz0O_A>
    <xmx:QnGBZa52ptgjkjvg0N9e7QxQTZt8xQzNYWT6WphfYQkkgLILfZAI3A>
    <xmx:QnGBZRZ7IlxMGWCMWsbKYw3cGRa99Xuw3giAyDBefE52LCFI-tUndg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E88AAB6008D; Tue, 19 Dec 2023 05:32:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1350-g1d0a93a8fb-fm-20231218.001-g1d0a93a8
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4e6d829f-e0d8-4e4b-839d-3ec1cfd8983b@app.fastmail.com>
In-Reply-To: 
 <68e7ccc8e9e2e90765b94fcc3999d99a4e98fc8e.camel@physik.fu-berlin.de>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
 <20230713145536.GA5300@ravnborg.org>
 <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
 <add3c37a-08ef-41e1-b717-091d9bffd66a@app.fastmail.com>
 <20231205180506.GA242352@ravnborg.org> <20231205202630.GA290248@ravnborg.org>
 <93c22029b8523c5380f126995481002246eabfa7.camel@physik.fu-berlin.de>
 <030e57e1-13a0-4c62-8302-2b0008c6e92e@gaisler.com>
 <11427751-b6d8-44a9-af12-70adc10d8edb@app.fastmail.com>
 <68e7ccc8e9e2e90765b94fcc3999d99a4e98fc8e.camel@physik.fu-berlin.de>
Date: Tue, 19 Dec 2023 10:32:16 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andreas Larsson" <andreas@gaisler.com>, "Sam Ravnborg" <sam@ravnborg.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>, sparclinux@vger.kernel.org,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Content-Type: text/plain

On Mon, Dec 18, 2023, at 21:02, John Paul Adrian Glaubitz wrote:
> On Mon, 2023-12-18 at 20:52 +0000, Arnd Bergmann wrote:
>
>> The most important bit here would be someone with the authority
>> or Ack or Nak a patch going into another git tree. Even if you
>> are sometimes wrong, that is still much better than no reply.
>
> Yep. And there are actually a number of very nice improvements from
> Oracle engineers for sparc64 that got never upstreamed. These include
> kexec support as well as support for hypervisor control from Linux.
>
> They can all be found in Oracle's Unbreakable Kernel Tree:
>
>> https://github.com/oracle/linux-uek/tree/uek4/qu7
>
> I have already reached out to one of the Oracle engineers and they would
> be happy to help us getting some of the patches merged upstream.

Ah, I didn't know there were so many patches that never made it in.
It does look like they were only in UEK4 (linux-4.1) but not ported
to the later kernels, so it's going to be more challenging to port
these to mainline than the set of leon3 patches that are already on
a recent baseline.

     Arnd
