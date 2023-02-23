Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA15C678D5
	for <sparclinux@archiver.kernel.org>; Thu, 23 Feb 2023 13:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjBWNJv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 23 Feb 2023 08:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjBWNJs (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 23 Feb 2023 08:09:48 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716AB193C4;
        Thu, 23 Feb 2023 05:09:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DD225C0077;
        Thu, 23 Feb 2023 08:09:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Feb 2023 08:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677157777; x=1677244177; bh=7qpJ4fyuUV
        Fw9F28lxEJyIMUTjdhT7HcNbFM6c+Ezgs=; b=O2BRATUSEJKhYdO9jnSYuwhgN9
        SlLW/Ra2gZJVf503l5oUwxJjKvNEHY02+z64mvgkz72xHBv4pJI7cWKA/9R6Z0zR
        v8JsB9De7DwEny2RkbTpFYFLYquiHQeEj1cPBVeZOrtoygNGXcaO1MCSjC7+KwVY
        qe/g309dNzSDXwknjvZ75pSrFY0E9OFQLEOuf8V4VsZWmWaSsaRKQAkDVXAHp7HG
        2M3ND7tojEkRj+PibpuagYn3M9G9IftQl6+GIxqj9SOqfzAActDdAUS5PEM9iEQN
        9IAynvKfUWXJXLgGre9sqq6nA+IrTxQQPrtgdJON9tiEoWhCEcVeiffsjq9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677157777; x=1677244177; bh=7qpJ4fyuUVFw9F28lxEJyIMUTjdh
        T7HcNbFM6c+Ezgs=; b=G5/DpWO7RaCFSOAipvTQT6tl7k7vD74Sl9V9sAoir8Vi
        421dk3+9Qt/G7JjiyD34Z+c7EbFSnZiUZ3GbW77IMufmfRm+rzXrU7FLLDtFf0M7
        k0l7PxYedLyKRNSbw97Pni/MDelg0akiOQlvofYkTgic2vLnrSbQ9V9XfgUX8Q8F
        XEGAti8ogwN5evXPA4eQKbXvmVle4wssalbkSlCPadqNBM0xb2jFis7pNvhxk31r
        xNYVgZFony7lghKs6KfOWRNWeyPLyc2/n0thE5pkkxVOdfd1DFmmqrxBWBmPmNtT
        m2m6dtdVlshxInhXAv4ZUbuuVS0VtDYDIN5HtEFrbg==
X-ME-Sender: <xms:kGX3Y99c49bYP64KqS1HaQ8FF4KwsWzYCxw4I6Z8iCK1SZmexW9GKA>
    <xme:kGX3YxsByQtSUslerfyL5YlxzMdj9PH1Tb0l0eB7Xs1DwHl4OMcnCiYOmACbZjpUQ
    YZaT9BjIt_rcKFpTO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kGX3Y7AS2AGEOgv2jYveBNUysthqQ76s-TUqLVpNPfUIY6NmoPrKCw>
    <xmx:kGX3YxeB7Qil3TpiFjqS7xUCgPiAT79n-rK_-RhoqfWcWaS2elpe_w>
    <xmx:kGX3YyNlkl5s5pVBjCsvQjmOXpVLfhncNfCunbMp7ntKSebZphUxvw>
    <xmx:kWX3Y7bTiTXbUM6efQBsMXpRv04timAHWEIdHmbb6dnHOK_p1D1GLg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 24130B60086; Thu, 23 Feb 2023 08:09:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <874b8076-b0d1-4aaa-bcd8-05d523060152@app.fastmail.com>
In-Reply-To: <CAHVXubgsvjxGbgM6AcxfsHDsHT0iL2pAemGMr5t8KVLKiqC3RA@mail.gmail.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-4-alexghiti@rivosinc.com>
 <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
 <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com>
 <CAHVXubgsvjxGbgM6AcxfsHDsHT0iL2pAemGMr5t8KVLKiqC3RA@mail.gmail.com>
Date:   Thu, 23 Feb 2023 14:09:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexandre Ghiti" <alexghiti@rivosinc.com>
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chris Zankel" <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@rivosinc.com>
Subject: Re: [PATCH v3 03/24] arm: Remove COMMAND_LINE_SIZE from uapi
Content-Type: text/plain
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Feb 23, 2023, at 10:54, Alexandre Ghiti wrote:
> On Wed, Feb 15, 2023 at 2:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Wed, Feb 15, 2023, at 13:59, Russell King (Oracle) wrote:
>> > On Tue, Feb 14, 2023 at 08:49:04AM +0100, Alexandre Ghiti wrote:
>> >> From: Palmer Dabbelt <palmer@rivosinc.com>
>> >>
>> >> As far as I can tell this is not used by userspace and thus should not
>> >> be part of the user-visible API.
>> >>
>> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> >
>> > Looks good to me. What's the merge plan for this?
>>
>> The easiest way is probably if I merge it through the whole
>> series through the asm-generic tree. The timing is a bit
>> unfortunate as we're just ahead of the merge window, so unless
>> we really need this in 6.3, I'd suggest that Alexandre resend
>> the series to me in two weeks with the Acks added in and I'll
>> pick it up for 6.4.
>
> Sorry for the response delay, I was waiting to see if Palmer would
> merge my KASAN patchset in 6.3 (which he does): I have to admit that
> fixing the command line size + the KASAN patchset would allow 6.3 to
> run on syzkaller, which would be nice.
>
> If I don't see this merged in 6.3, I'll send another round as you
> suggested in 1 week now :)

Hi Alexandre,

I have no plans to still pick up the series for 6.3. The patches
all look fine to me, but it's clearly too late now. What is the
actual dependency for KASAN, do you just need a longer command
line or something else? If it's just the command line size,
I would suggest that Palmer can still pick up a oneline change
to increase it and refer to this thread in the changelog as a
reference for why it is not an actual UAPI break.

     Arnd
