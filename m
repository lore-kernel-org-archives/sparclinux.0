Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4B21A928;
	Tue,  8 Jul 2025 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956861; cv=none; b=tjtaOZQInFP8Mu+gSqx20T7RhInb94/Inw6xTXf1tb+Of+Zlzf0FHj1abN+tBYHey6xex+8aPc2uwU/hOgwUET2/gGuqkErSpIwhkrqEeDM8QQtaCC6rd5yuCr7LYHXM3aKcNtonyXInHAD+zaylEBm0se0EIzCVaZsQxZ3EY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956861; c=relaxed/simple;
	bh=iC99aHzsm81Fzc5rCbCTGz00yL4L/MsTYfjqrMegN5k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ffbv97DBHyQwgQo6jNiZKfAsh1PE8B8Q2Osilzd6MevAGMXkpjKJBQeTgHQYy47wAGDwstwQ7b08f+gTNuPPm5selVxxEPoTBqIkXuqGiObYP2wY1ohM/zltW5ZjuBlB62PCAY+9IfnAhd/ZNmqkfidMv6FPylMqtw5E+OJaewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BL8+9E3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHJOfVNs; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BL8+9E3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHJOfVNs"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD24B14009FB;
	Tue,  8 Jul 2025 02:40:57 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 02:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751956857;
	 x=1752043257; bh=awNxr4pVMgO6oqVHKDSuRS+ZhlklP+zk9Y3ggKpEeHY=; b=
	BL8+9E3jMQie4CU1Jii7+uXcAkMkQudd4T5Q7czZR8y3pdaZq99+Jj8ovzrYFMUd
	E5p5aEpNv7eTFqKXP+NsPhCRr9BLCxTUlRWWyfb/BqtVwFyNmOVZPQGQ1iXtc4t9
	ykr9i968DqrZoBSwg9x8VlLXMIjWpa+7udgE9c6v6vb27SUlpa86q9pxiEV43dx6
	kUvMqCcBnJiuYLab/NdrNhU54qHJRIRI/XRCs1ZAYkEbNWROErKpql3wFwg22AVc
	dFz6FzkVpsH0EoRQKlS0XQP3zSIpERHmBedfdZDfF5vexu2KqDiz3pdDHIyOYLXa
	E1o5fYoL2kLRikQGuaWyQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751956857; x=
	1752043257; bh=awNxr4pVMgO6oqVHKDSuRS+ZhlklP+zk9Y3ggKpEeHY=; b=E
	HJOfVNsv2m9MMxzpl4OwvZz2ijXygcxYjh63f2rKW21/X285fT7b3FP9rf9Gy3vS
	FMAJDRZkWBvKfNkfKQcT5blmtrvMPGUQMcDsrtacDuTKoc8qaZWj7bOCEk82xevr
	6nA3aR1O2MHRKh4yAC8x4krpdxVMKERrqLFVKmpvZAzTaw6HKfmHYXJyGWLCVe6l
	TOLcHwadFoiazdJn1T8MummaI28V2bNoheAm1zC1wcXXhZ6EW7D2AB6cenggF1tt
	BTJX8txHoab6cKvFr33ZuSOWjbz2J/EQ0k7uK/Iu+sQrCPe3/KfTrTJ/leTpjQB6
	Ys9KX59g+VNWSBDgtQvAQ==
X-ME-Sender: <xms:eb1saCuk5bP1d3A7jjlBgWuoxYlhEQ_IadTb3GfMyRKpULixDz-C3g>
    <xme:eb1saHek39PU-5z_C62j5Wj2lK7i1J_tkglhLUAxKuZqLiwp_Ak_vx6TEUSL_8Cr8
    wfOzr13XPTXVWYfhJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtph
    htthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvrg
    hssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdp
    rhgtphhtthhopegvsghighhgvghrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjh
    hsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eb1saPdsKDrTwTQqYPK3UKcN7WdHDXcyI_Nj7-yY4RH4QnaSkv1_Ew>
    <xmx:eb1saPcBkMch0pKhJGJOeacyVBgNx2AHC-jvIVGjISp4Ci-krBJ4Nw>
    <xmx:eb1saN9b8fhlfv4x-EWfN_WqF3e98gFBGifFJnRjkrH5LELq6ymohg>
    <xmx:eb1saHOXgTXV13DOioJXkzUVRbI5HpR7dPJqRjJhvNm-ZmaTVXFMWg>
    <xmx:eb1saF3wVDPTYyiYGB3u-50nRD5PtbSJTRhbHXY8QMfTm5d3yF4-hIUn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 387BF700065; Tue,  8 Jul 2025 02:40:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T47b27644593db411
Date: Tue, 08 Jul 2025 08:40:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Eric Biggers" <ebiggers@google.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Helge Deller" <deller@gmx.de>
Message-Id: <59e6bb77-1f11-4e30-9bbd-51bf077d9840@app.fastmail.com>
In-Reply-To: 
 <20250708073204-b67226e4-b140-4a1a-ae98-47769c1b2f98@linutronix.de>
References: <20250707144726.4008707-1-arnd@kernel.org>
 <20250708073204-b67226e4-b140-4a1a-ae98-47769c1b2f98@linutronix.de>
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025, at 07:39, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Jul 07, 2025 at 04:46:37PM +0200, Arnd Bergmann wrote:
>>=20
>>   sparc-linux-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note=
.GNU-stack section implies executable stack
>>   sparc-linux-ld: NOTE: This behaviour is deprecated and will be remo=
ved in a future version of the linker
>
> IMO this should be in its own patch.

Fair enough, I considered splitting up my patch further already but
tried to keep it simple. This one does make sense to split out though.

>> Most of the removed code only exists on sparc in order to dynamically
>> patch the vdso based on the presence of the tick vs vtick based
>> clocksource.
>>=20
>> Rip out the whole thing and replace it with a minimal stub as we do
>> on parisc and uml. This introduces a small performance regression when
>> using a libc that is aware of the vdso (glibc-2.29 or higher).
>>=20
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks, this makes things easier.
>
> Reviewed-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Tested-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>
> But why do we even need the stubs? Removing the time functions from the
> vDSO completely should also work, no?
> For parisc there was no reasoning why stubs were used. On uml the stub=
s are
> necessary to prevent the libc from calling into the host vsyscall [0],=
 but
> that looks irrelevant for SPARC.
>
> [0] f1c2bb8b9964 ("um: implement a x86_64 vDSO")

I was wondering about this myself, I thought this might have been
for runtime environments that just assume the vDSO is there, possibly
some non-C libraries, or future glibc versions that may error
out when the vdso is absent instead of falling back to the syscall.

The 5f55e098b8d0 ("parisc: Add 64-bit gettimeofday() and
clock_gettime() vDSO functions") commit and the corresponding
glibc patch one don't have any explanation unfortunately, but
maybe Helge can explain why this is needed.

The arch/x86/um/vdso/um_vdso.c version for 32-bit seems to still
be missing the clock_gettime64() entry, any idea what the
resulting behavior is for time64 userspace?

      Arnd
