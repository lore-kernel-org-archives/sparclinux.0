Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DAA1DFE1;
	Mon, 21 Jul 2025 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132374; cv=none; b=Qv4IcpgEvttw9qtRHpelCHFCMAuDnO1i/GeGxQIWnPsDiMHsVni7A3EPICU4Ll2fGooSBxJkz6Bchs36zSulnRCYjt3gTXOY31+0UvwMMVMJKjo/zOMgcHwEMjke60LFbW56TDo5PREc1BJFMiiwpvs+Kvvqw4PLfRns3mRbTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132374; c=relaxed/simple;
	bh=mB3A8zxmfQ6nbYNX8RUpetQUhDPO/McLXCRtiQvkdWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/poGKRKFhXawabNGAYdpSCJYlnXbHwZbUVq13LBU01pnS9XXeLPqwDl9xH2myOOQY5xQUFascvqdP4+kBg9cZvHMqeLfgLCgAeo19gXdWUvdpzJGYByr1HeHfVhvaZ+maVMEPZspNUzSO8ADFq82iBABFVWQ8iHTzy/qvD1CvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bsH+h4le; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xHbVLuJ5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bsH+h4le";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xHbVLuJ5"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753132364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxDTRjjVG+zW1HjAB9iJ8nK4LzuVootVYZCMMUt7C1k=;
	b=bsH+h4le8dbrz55+h9zbrstebDj3oBOswfF6gQ0c4ZaaDRsdOPpGAEIwh3H0wQZI8dTFyx
	9VVoGfIFFRrpt3QJDSD73nIeojQ+2bcZ4h4SR4UkpZe+nT7GWzjmGRjXA7guJAaTzZkXh8
	ldeJ5wUS2NVwl8CYGJt5QdtBXvdnu1BPCbtb1DAZ5xe01pZjpEB7vC1iR/azZUIZp+Ac7H
	71GtaF5PVY83CgjHsI+Wfbac/xqcFTGWaXow9CjuFbZrjTNSVFvG/VoSXGxmDdnak1so8i
	9Vz1j6tdeYyN5KVS/bn45mzTJIYTBpjAIO+UJF4cO4ABaY2KWoep+TC+FMfZ+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753132364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxDTRjjVG+zW1HjAB9iJ8nK4LzuVootVYZCMMUt7C1k=;
	b=xHbVLuJ5iknaQIkujfGqAzBoMwGktwmDz1/Ur64dzaxH692Iaf7h3sEqo41Ly/BpRs1FIT
	WfHeygiEeejH2BDg==
To: Arnd Bergmann <arnd@arndb.de>, Andreas Larsson <andreas@gaisler.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann
 <arnd@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>
Cc: Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Eric
 Biggers <ebiggers@google.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
In-Reply-To: <ba62bc7b-fa3e-4f34-a966-cc734468b8ef@app.fastmail.com>
References: <20250707144726.4008707-1-arnd@kernel.org>
 <a2cfee1a725f24f90937f070eacdedd2716ef307.camel@physik.fu-berlin.de>
 <5c479b4d-65f1-466e-a79e-43f6dfc9345c@app.fastmail.com>
 <6b77e7da8c0bd6f211685bda9f624f8db971bbe1.camel@physik.fu-berlin.de>
 <7e29bcc1-3dc7-40f8-84f0-fbe497fb01bf@gaisler.com>
 <ba62bc7b-fa3e-4f34-a966-cc734468b8ef@app.fastmail.com>
Date: Mon, 21 Jul 2025 23:12:43 +0200
Message-ID: <87ecu9tfhw.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 11 2025 at 12:31, Arnd Bergmann wrote:
> It is probably not all that hard to convert the VDSO to use the
> generic implementation if you remove the runtime patching between
> TICK and STICK mode. From the code and the documentation, it
> seems that any JPS1 compatible CPU (or newer) uses STICK,
> this would be UltraSPARC III (Cheetah), SPARC64 V (Zeus)
> and all UltraSPARC T. If you want to give it a try to do the
> conversion to the generic VDSO, I could respin my patch to only
> remove the older TICK version and the runtime patching but leave
> the STICK one. I don't think it's worth my time trying to convert
> STICK myself since I have no way of testing it.

Getting rid of the run-time patching is really trivial. The clocksource
setup initializes clocksource::archdata::vdso_clockmode already
correctly with VCLOCK_NONE, VCLOCK_TICK and VCLOCK_STICK.

So all you need is:

static inline u64 __arch_get_hw_counter(s32 clock_mode,	const struct vdso_time_data *vd)
{
	if (likely(clock_mode == VDSO_CLOCKMODE_STICK))
		return vread_stick();

        if (clock_mode == VDSO_CLOCKMODE_TICK))
		return vread_tick();

	return U64_MAX;
}

Plus a 32-bit specific version of vdso_shift_ns(), which means just
renaming the 32-bit variant of __shr64() and removing the then pointless
notrace annotation.

This should just work out of the box and the performance regression will
be minimal if even measurable.

Thanks,

        tglx

