Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEDF1C4A13;
	Fri, 11 Jul 2025 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229930; cv=none; b=ETtGclO6GrnthLyS0Ag6cNlK3D7QhKOlP+pp+Bk/5IP0ShzZ1sGGlRnO1lSGItg1UzGhuOkZ2g3Dl3CKqRQr/cSoUlAvkQK2c0ZEYuZ+fW49YDGAzZUaco7ugPbLymTMSiotFi5sFs21LzdYN0lDTY8ltP08pDu07DfeGVXpos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229930; c=relaxed/simple;
	bh=dIQn2pv7EN6SkOG9ve2T2rjY4pjxpvg/oC0ABrkmK9M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uMYe+pLrmXgskMchYOCLe5jW3LUz3+5Mjjnn/FF6MYNFbiYRHvqfURr8JHeCQTU+YOFWGNjTEH7ztP6ZpqY4RN6xHk+hkKDd2s8gJJAD+nEMa8iQyP6rjcMhFrYqlKl8VUTclDAmwbVXjIRmr/xdJbOkwoncU2kxYmIBuSS9g4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fZEATfmY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oEFEDgOa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fZEATfmY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEFEDgOa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC03A7A01C5;
	Fri, 11 Jul 2025 06:32:06 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 06:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752229926;
	 x=1752316326; bh=07dLlqwr6Zm9+s/ZNinIfLXqKr7NYvxJ3Yp+RgA+Heg=; b=
	fZEATfmY7vvL7eElXg5Uuy6eZI4b5zQ5jR2CtaT946Uk5OevF0Gfs9UPCT/iYg8a
	YeW4nQL4NfmVYrhx1pTZ59bkBijlgDUpLe+yWsSV7OnTUhw+AEIL5WagpVftaHhV
	nw3Y6FiSgr9IXFkuzzV6juNhh5aALre2e1wmcNlsvyvINpkfw/ybGiDpM+kG5/i+
	mD8XDwPpDKNrawguR8duzQ3sDb/ref9hV8nb14HZ21lfanLRosy30r3lowXGS3CD
	ewR2Up4jK0KjJQvcDfWQT1HWofXAAxTu5wEkvW69q1y27pW9wQuIdiv4u7VCiWzo
	jtt6oznFIWLCD8BHmQ0tlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752229926; x=
	1752316326; bh=07dLlqwr6Zm9+s/ZNinIfLXqKr7NYvxJ3Yp+RgA+Heg=; b=o
	EFEDgOaXebBzfvd5ZHG8MA+itVhxi4N0s4VSEpvy9McStgSeQ5ZJyK7s2iIPsL3+
	PyH99hACuuaDQMYCG0Vcu2y/lVmufVnH778k8ylPX5r5GuNI8NBQ6lZD7rCOd8j2
	I329ZU2qfMQ/sXmYzp8yU99QARGswP8zLchhVx74NHz7whuo1oK4Wph/Ylwb0UaF
	O0STAswTNXN6osoqvneqjUh1FEQQ2OFeh6w2VBDrgMt3RUEhA1uLTl1oM7XjwHpB
	noNk44JItPJVVS8QYXNhSp+g0KAkdZhW3THsLlZnLl/iDLYqcmhu5S7BFuxwnqNA
	N/M5ie0aPUWYQSrHxS/ig==
X-ME-Sender: <xms:JuhwaHoKIHF6CkA-U8WqJbp9aZ_bXNpQtpKWrJc48k19k2SZ-NaT6Q>
    <xme:JuhwaBoufLARoGKmLivTCfDYFE6Z1E6KlBtE8rEnBYvL1oxvxMxZlZxJ_LDKnJuUU
    2lj2gL6ess32jnyvEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfedtlecutefuodetggdotefrod
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
    hssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepvggsihhgghgvrhhssehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehjshhtuhhlthiisehgohhoghhlvgdrtghomhdprhgtph
    htthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgt
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JuhwaIYjiziD3DuUx8O-oWdPHj-M318q7n_fe_EeJ0isILuf06YDsg>
    <xmx:JuhwaEwby2rYZl2kauJlfb0p5oWzyEv_Mq37mA8qHhT9d_-PmxM1HQ>
    <xmx:JuhwaMOmx6DkP2lMbmqKKxGJ6AQbS1IYf5ZLIV-CQsLU_Vdmpqq_5g>
    <xmx:JuhwaK7pj672cK8NebTY1CHgaCb7z_dDUA4jg113R2kuKANP_eNZXA>
    <xmx:JuhwaLcx8w-Jusuz4vYVZJ7nqP26aK9Sne6oD3JrsjjxSdqS6cIF4F0E>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 394E4700065; Fri, 11 Jul 2025 06:32:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T47b27644593db411
Date: Fri, 11 Jul 2025 12:31:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Larsson" <andreas@gaisler.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Arnd Bergmann" <arnd@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Eric Biggers" <ebiggers@google.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <ba62bc7b-fa3e-4f34-a966-cc734468b8ef@app.fastmail.com>
In-Reply-To: <7e29bcc1-3dc7-40f8-84f0-fbe497fb01bf@gaisler.com>
References: <20250707144726.4008707-1-arnd@kernel.org>
 <a2cfee1a725f24f90937f070eacdedd2716ef307.camel@physik.fu-berlin.de>
 <5c479b4d-65f1-466e-a79e-43f6dfc9345c@app.fastmail.com>
 <6b77e7da8c0bd6f211685bda9f624f8db971bbe1.camel@physik.fu-berlin.de>
 <7e29bcc1-3dc7-40f8-84f0-fbe497fb01bf@gaisler.com>
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025, at 18:22, Andreas Larsson wrote:
> On 2025-07-07 18:05, John Paul Adrian Glaubitz wrote:
>> On Mon, 2025-07-07 at 17:45 +0200, Arnd Bergmann wrote:
>>> On Mon, Jul 7, 2025, at 17:22, John Paul Adrian Glaubitz wrote:
>>>>
>>>> On Mon, 2025-07-07 at 16:46 +0200, Arnd Bergmann wrote:
>>>>> Rip out the whole thing and replace it with a minimal stub as we do
>>>>> on parisc and uml. This introduces a small performance regression =
when
>>>>> using a libc that is aware of the vdso (glibc-2.29 or higher).
>>>>
>>>> Can this performance hit quantified in any way?
>>>
>>> It's trivial to test calling glibc clock_gettime() in a loop
>>> on a specific piece of hardware, the difference should largely
>>> depend on how long the timer hardware access takes compared
>>> to the syscall overhead.
>>>
>>> On machines that have neither TICK nor STICK clocksource, the
>>> simpler version should even be minimally faster, on those that
>>> have one of the two, there is an added cost for entering the
>>> syscall on every clock_gettime() as we do on architectures without
>>> vdso.
>>=20
>> OK, thanks. Since Andreas has access to a SPARC T4 as of recently, he=
 should
>> be able to test this. Please allow some time for him to review and te=
st the
>> changes, so we can be sure this doesn't cause any serious regressions.
>
> I tested this patch (running Linux in an LDOM under Solaris) and
> measuring the cost of clock_gettime(), running millions of calls. The
> calls takes around 13-15 times as long (from around 82-94 nanoseconds
> per call to around 1220 nanoseconds per call) with this patch compared
> to without, so not an insignificant performance regression in this
> environment.

Ok, thanks a lot for testing! I guess the good news is that I didn't
break functionality here.

Obviously 15x slowdown sounds like a lot, but what I don't know is
whether 1.2=C2=B5s is actually too slow. Is this CLOCK_REALTIME or some
other clock? I would expect to see a larger difference for the
COARSE version since that saves the hardware access as well.

From what I remember, the original driver for having a VDSO
clock_gettime/gettimeofday was Java applications that call it
too often. Do you know of anyone using Java on performance-critical
sparc64 servers any more, or any other type of workload that
depends on these functions being small?

It is probably not all that hard to convert the VDSO to use the
generic implementation if you remove the runtime patching between
TICK and STICK mode. From the code and the documentation, it
seems that any JPS1 compatible CPU (or newer) uses STICK,
this would be UltraSPARC III (Cheetah), SPARC64 V (Zeus)
and all UltraSPARC T. If you want to give it a try to do the
conversion to the generic VDSO, I could respin my patch to only
remove the older TICK version and the runtime patching but leave
the STICK one. I don't think it's worth my time trying to convert
STICK myself since I have no way of testing it.

Another option would be to start by adding a VDSO for LEON
CPUs using the ASR22:23 upcounter register. This should be
fairly easy to do if you copy the CSR_TIME code from riscv
and replace their __arch_get_hw_counter(), and this is probably more
relevant than the sparc64 version. Once that works, you
can extend it to use STICK on JPS1.

     Arnd
