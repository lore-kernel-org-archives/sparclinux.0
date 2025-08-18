Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE026B2D7;
	Mon, 18 Aug 2025 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500135; cv=none; b=hc6cF794vikVUJXQvv2latxVFUnhmjFPeh9gjRyz8omu2j9r/unJyA+/Lq72t6LIfCvUIZishW9hTEET/B5ZnIM6X1hrYnr4DeJci60g1E0oxPm0Myx8gPEQr3UskQie+71IpHufHJgMEClRdIPvgPOJexiRl1K8YCQb1yKUmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500135; c=relaxed/simple;
	bh=By7usdss+rkiOW/yppLdzLOCtns31NFLt1Vz4bboPrc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CDhqTOMq5QCDeAFnbodd66Ul0LtDjYrMZcQcmIK8DkfL7vRiiNyOYz/Xq/R522fPlJ89zuL1ATqle1jU7Y4sv6j8mQfWiogk5zGxJRSWT1IkBuhceyY0Qh9FeiAGnulv+R+qg/M4Tv54SIoFUg/js7yGQdnykHOD6idrsi0Ukk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LwP9Xe7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egQfyrqB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LwP9Xe7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egQfyrqB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E66081400057;
	Mon, 18 Aug 2025 02:55:31 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 18 Aug 2025 02:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755500131;
	 x=1755586531; bh=WYIB1OF4/OZwEatf3qB7hEfLyA9RGtN/aMwO/wJhfno=; b=
	LwP9Xe7W+Lzy38MUHEgh04p9cOmh9mgrqtvUBwaNarAa2gRU+6JFs9a/9mgi3Yny
	eMUb8/sRMCb++S1/M7EZpNkyzfrTJuPbiXpCmLfAKBByP1cRVBGUCvjRds/XcwqM
	gyPbHd9feikeXKXOIos83reu3vZPkYZd2FoL8mwJ+vNeL0Cs2UIclHF55dhBm7rH
	umS8XqQxm5SIu2Ag3cYhfdpf3YZQ5qbDEBevtvGkLI+KW0qNOP+JNXnckyxAHzTA
	7ngjOMLH4DFqa+2dco04+N7dVSDHqG5nVubdSG6xWJFJLGuyXBnkZCcncqssiSJ6
	SmrP+lETCpC1YBXfK9wYEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755500131; x=
	1755586531; bh=WYIB1OF4/OZwEatf3qB7hEfLyA9RGtN/aMwO/wJhfno=; b=e
	gQfyrqBHXiUs+GzNOYFT3vZJuzpYPJJFyzJxbPTuIO4pWQh4vRVTEy8/2nucfFZq
	WwG62U4e3C/rLXpyIhL50AVeR+APFUGCWWS9QfyVeC1x+QAbEkCt1liY79WYT+6R
	3znFj+ovFGRctDiI/cSGe9/FYXC5zLLt7URIbzeee+1RcdlGna8DuR7i6JSlJuY4
	I+mDljp0iS8/iIjfL6H5k+RbIiqtj6OdJukfk4OYTcIRaqcuVnBaUFwhK2BczRna
	GlBKClWATi7KRc1/0X/DLPF1soDwfQZKVRP0b5nQf5JIf4wIMuEx+fseUOFHEquY
	vfafodIsH+GgoaxBMNmsw==
X-ME-Sender: <xms:Ys6iaM0YUSXegmnuXs0bhJWoybv20cXM-kSx4_MIZ4VgkvYeSPBBEQ>
    <xme:Ys6iaHHZwaoctjn-K4NMuMWFwB0bGVqX-IYah_ASwKCMPP9hS-cdm7PoSnqbY77wd
    cxhXJVaQKojF9gYWbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheduleehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Ys6iaHeR6RHZ1NvsbCo46ccqtM89lAijCLF3Z91aAstwYa-tNukFgQ>
    <xmx:Ys6iaEcnT4yT5Rfc7qI2jiLXDqKTD0uWXJSSygjGuMfysP8n0kzzhw>
    <xmx:Ys6iaLbK8dJRWcpolPWcrIfzB0Ix2jLSHnSrWeFkJQK_x8DK3xYc9w>
    <xmx:Ys6iaI5bReBF-OCAcyKqWpwd1HToChNEkvZFZ5EUlZWebkVL3gpkeA>
    <xmx:Y86iaDHgMnILPYEzx1rm_-lRtDBWUUrX2bY1iByhv9KKovwJnr1Y8Eb->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 95D99700065; Mon, 18 Aug 2025 02:55:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABINBsmLUku7
Date: Mon, 18 Aug 2025 08:54:53 +0200
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
Message-Id: <dd77ac1f-9251-4ad2-ad5b-9d2b8969a476@app.fastmail.com>
In-Reply-To: 
 <20250818073135-130dfc53-225c-48a3-b960-e982faa866bf@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
 <bf9ec82b-af1b-4684-ada5-8529b7ceb06a@app.fastmail.com>
 <20250815142418-d28c6551-bec1-4a65-9c52-f1afd7b630ed@linutronix.de>
 <5309ef99-9ae7-4525-8d58-f954c13797bc@app.fastmail.com>
 <20250818073135-130dfc53-225c-48a3-b960-e982faa866bf@linutronix.de>
Subject: Re: [PATCH v2 12/13] sparc64: vdso: Implement clock_getres()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025, at 07:50, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Aug 15, 2025 at 10:09:23PM +0200, Arnd Bergmann wrote:
>> On Fri, Aug 15, 2025, at 14:34, Thomas Wei=C3=9Fschuh wrote:
>> > On Fri, Aug 15, 2025 at 02:13:46PM +0200, Arnd Bergmann wrote:
>> >> On Fri, Aug 15, 2025, at 12:41, Thomas Wei=C3=9Fschuh wrote:
>
>> On 32-bit, we decided against adding a clock_getres_time64()
>> syscall when we added clock_gettime64() because of this.
>
> My assumption was that clock_getres_time64() wouldn't make sense in the
> first place, as no clock would have a resolution this big.

While the type conversion is trivial, the general approach has
been to use the new types consistently, so this would be an odd
place to make an exception and require an explicit conversion
from __kernel_old_timespec32 back to __kernel_timespec or the
libc timespec.

>> For time64 userspace, this means that glibc always calls
>> the system call instead of the vdso, and old time32
>> userspace wouldn't use the clock_getres() vdso because
>> there was no vdso implementation when it was compiled.
>
> Is this paragraph meant to be specific for SPARC? Glibc does use the
> clock_getres() vdso fastpath on time64 architectures. But on SPARC no
> application would ever use clock_getres() through the vdso today,
> as it doesn't exist yet.

The glibc code has a weird mixup of the time32 and time64
function names, but from what I can tell, it only ever sets
dl_vdso_clock_getres_time64 on 64-bit architectures, where it
gets set to the normal clock_getres vdso symbol. On 32-bit,
glibc always skips vdso_clock_getres_time64() since it
does not exist, and then it always calls clock_getres_time64()
through the syscall interface, unless it runs on pre-5.6
kernels that fall back to the time32 vdso or syscall.

From the kernel's perspective there is no such thing as a
'time64 architecture', all 32-bit architectures (except x32)
implement the time64 syscalls, most 32-bit architectures also
have the old syscalls, and all 64-bit architectures (plus x32)
only have the old syscalls.

glibc introduced a different view of the same thing, the
internal names on some 32-bit architectures (rv32, arc) get
redirected so they look more like x32. However, those
architectures don't use vdso.

> In any case, I have no strong opinions about this patch and am happy t=
o drop it or support only SPARC64. Most likely nobody will bother to upd=
ate glibc anyways.

Agreed, I think the only real concern is maintainability here, so
if you think it helps to have __vdso_clock_getres(), please keep
that for sparc64, but let's leave it out for 32-bit altogether.

Two related points:

- something we could add on all 32-bit architectures after
  everything uses the generic vdso implementation is
  vdso_gettimeofday_time64(), this can shave off a few cycles
  because it avoids a division that may be expensive on some
  architectures, making it marginally more useful than
  vdso_clock_getres_time64().

- there is one catch on sparc64 in the way it defines
  __kernel_old_timeval with a 32-bit __kernel_suseconds_t,
  unlike all other 64-bit architectures. This is incompatible
  with glibc's __timeval64 definition on sparc32, so there
  would need to be a special case for sparc32 somewhere,
  either in the kernel or in glibc.

       Arnd
