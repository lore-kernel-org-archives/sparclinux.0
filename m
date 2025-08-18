Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273932A3F3;
	Mon, 18 Aug 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523116; cv=none; b=hU3PV9sRBOYPvM5evL8H2venOAmTaXnYthvFmIQmPxHUb4mGju1t19LtJGKbvIwmti+flH9hO3jNJiP4sh49vlg4x609zBmL26ge6lBcMVp6z25A3hDmYYgF5hXDpwxaY4DorN7WsV+uRYDOUeG72t17TT+dP1ROU21gIxM8hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523116; c=relaxed/simple;
	bh=rWW8YpUYd6/EsoJliw96tZiJtLu2qbIRcz8OzqQVO3c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pn00bW+LyDbfbexbjgUfoltEiJ3JN9dVKDalQLHIqJvdHz5HYyai569AkVADrO8sceFMfBSP6p12JO7+aqp1FuHR6p6hUuXSOnnRvf8xkkQLk4j5W338rvBlJ/Wf1oms243AxScfCtocY93Owfqo45RGl59T3D1prP+11uQu/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=W7Ol4CtE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bVPucAM2; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="W7Ol4CtE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bVPucAM2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1344FEC050C;
	Mon, 18 Aug 2025 09:18:33 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 18 Aug 2025 09:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755523113;
	 x=1755609513; bh=IBpqOSU1fv83II2ZAGZXrKuD/jPDJB0Q+bIqD3eNxmI=; b=
	W7Ol4CtE1dVyoNs5wFdzrNutFk+Ru0f+/MKOAFk4PsVt2jzYiQKuBhgSLjm0Uu9D
	bOsJjGUKJKnBjoAH8TTtoLRZbbtzG70Kq4xx2BRFkdrYIyxQhALPKvfcDE6chY7C
	WwbveC9uLrImFWsrVa/yOLbxJ/UY3rTt8pZtuL2O/uSQzIefcH+XW3pKqSYmIxLF
	vaLRsF6q/6lsBAZiB5HGaQrScbMed009rUkTA4E3ShUOl/9yB0D1OlMUsJ0qIMts
	ig5AhcX7p/T4TPFgsWN10ZhegZczygcxtU8S281Gp1gjGTjEQehCsRHmzRbMN78a
	1Id2AxNMXRIk3We7mFIBiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755523113; x=
	1755609513; bh=IBpqOSU1fv83II2ZAGZXrKuD/jPDJB0Q+bIqD3eNxmI=; b=b
	VPucAM2jm8x+hPtU1YsFPCNyjF3gXx/ogfdd3rKuYJcNCBoVChBENmjtF4WBGe1c
	XJfB9G6B7uhWZBf5/Nt8k3oVCESFXDMUWnBgeLLCxMCen07+zdCNNP0N2O/YNE7R
	AAEeoy7BLsTzlAw5zTnsI5HWnS3XRzbIpCF+VcblAjTVQDymkdDHOkzWscniUrTn
	bNEGnNOQUABl7xR2y0qkA+2U9rHGwfVHR0OFGlh/mehOlcFZtiLRkxDJDyna3xlS
	jLF0DkDJ1dXCIYhOT8deWLCBZEHp/AryIRV00vJaBLtsyGvaMUSpgpTWfO+dkGva
	gSQowJQYXryxbuqmursPg==
X-ME-Sender: <xms:KCijaPzBwoTIhr5qa0McAI07QBO7rOsl39P9Z3td7w6I_HM1PLRy-Q>
    <xme:KCijaHQceyW1E0ErZ2_pwTk8aOeuWzOaBi86twwFHrZUWCPunJeqVQMa2mppokacI
    WkFXKLOnaqnjmtmtvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegr
    nhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepjhhsthhulhhtiiesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghh
    uhhhsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepnhgrghgrrhgrthhhnhgrmh
    drmhhuthhhuhhsrghmhiesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:KCijaO7zMpRRFFnJNtF88v4kD37-_7P4t-MkG4DxODNKtIixeuKwEw>
    <xmx:KCijaPL9uOtNWCVMHYQNiL84hfaV11TR0DsrSPNCX-To4y4NTTbRZQ>
    <xmx:KCijaIXTg7lXtl2KcSMBMxxKN2Po0APXn1Ez83c5kNFn5H5psVRYlA>
    <xmx:KCijaLEVMeHD9LFkElGOa0cJ26vILfHkf10emY6TcTlx2edDYfNZ2w>
    <xmx:KSijaGwTk9hVRSaxxnWLVbMulCyZuSKkyV8AWrDgfmaH5OEZOOLW58X0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 19CEB700065; Mon, 18 Aug 2025 09:18:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABINBsmLUku7
Date: Mon, 18 Aug 2025 15:17:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Nagarathnam Muthusamy" <nagarathnam.muthusamy@oracle.com>,
 "Nick Alcock" <nick.alcock@oracle.com>, "John Stultz" <jstultz@google.com>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <b0acf633-ea94-4222-b5d8-12996b250e69@app.fastmail.com>
In-Reply-To: 
 <20250818141851-c185a57d-3081-479c-a32a-add4e5600f3e@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
 <bf9ec82b-af1b-4684-ada5-8529b7ceb06a@app.fastmail.com>
 <20250815142418-d28c6551-bec1-4a65-9c52-f1afd7b630ed@linutronix.de>
 <5309ef99-9ae7-4525-8d58-f954c13797bc@app.fastmail.com>
 <20250818073135-130dfc53-225c-48a3-b960-e982faa866bf@linutronix.de>
 <dd77ac1f-9251-4ad2-ad5b-9d2b8969a476@app.fastmail.com>
 <20250818141851-c185a57d-3081-479c-a32a-add4e5600f3e@linutronix.de>
Subject: Re: [PATCH v2 12/13] sparc64: vdso: Implement clock_getres()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025, at 15:00, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Aug 18, 2025 at 08:54:53AM +0200, Arnd Bergmann wrote:
>> On Mon, Aug 18, 2025, at 07:50, Thomas Wei=C3=9Fschuh wrote:
>> > On Fri, Aug 15, 2025 at 10:09:23PM +0200, Arnd Bergmann wrote:
>>=20
>> The glibc code has a weird mixup of the time32 and time64
>> function names, but from what I can tell, it only ever sets
>> dl_vdso_clock_getres_time64 on 64-bit architectures, where it
>> gets set to the normal clock_getres vdso symbol. On 32-bit,
>> glibc always skips vdso_clock_getres_time64() since it
>> does not exist, and then it always calls clock_getres_time64()
>> through the syscall interface, unless it runs on pre-5.6
>> kernels that fall back to the time32 vdso or syscall.
>
> Ack.
>
> So with 'time64 userspace', you mean '32-bit, time64 userspace', corre=
ct?

Yes

>> Two related points:
>>=20
>> - something we could add on all 32-bit architectures after
>>   everything uses the generic vdso implementation is
>>   vdso_gettimeofday_time64(), this can shave off a few cycles
>>   because it avoids a division that may be expensive on some
>>   architectures, making it marginally more useful than
>>   vdso_clock_getres_time64().
>
> You mean this division in __cvdso_gettimeofday_data()?
>
> 	tv->tv_usec =3D (u32)ts.tv_nsec / NSEC_PER_USEC;
>
> Switching the subseconds field to nanoseconds to avoid the division an=
d the
> seconds field to 64bit to avoid overflows brings us back to
> 'struct __kernel_timespec' again, no? What would be the advantage of t=
his over
> vdso_clock_gettime(CLOCK_REALTIME, &ts)?

I misremembered what the current code does. As you point out,
there is a division by NSEC_PER_USEC in the vdso as well, so
there is no difference between libc calling vdso_clock_gettime()
and vdso_gettimeofday() in the number of divisions.

If we wanted to optimize this bit, the division would need
to be folded into vdso_calc_ns()/mul_u64_u32_add_u64_shr(),
which is nontrivial.

>> - there is one catch on sparc64 in the way it defines
>>   __kernel_old_timeval with a 32-bit __kernel_suseconds_t,
>>   unlike all other 64-bit architectures. This is incompatible
>>   with glibc's __timeval64 definition on sparc32, so there
>>   would need to be a special case for sparc32 somewhere,
>>   either in the kernel or in glibc.
>
> This is only a problem together with vdso_gettimeofday() from above, r=
ight?

Correct. I took a look at your sparc64 gettimeofday() to make
sure it uses the correct types and that seems fine since it
gets the __kernel_old_timeval structure definition from the
the sparc64 uapi headers.

     Arnd
