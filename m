Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17729139D07;
	Tue, 26 Nov 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620012; cv=none; b=JnNq8ErSCT2K87MNLalbDeYdoqCZPme2LJcCs4uXBrOkDRDtsrewr5B43lz0oAOY1ztTZcWhkXtji/R5jc+Yol5T3xX3UO4/rY0R1ESuTu03pCPFcYjfYCBzaZwQdX4DqHMokoSPM1x1cVABcSCWITYY64Smq4xzcMv11kc/CTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620012; c=relaxed/simple;
	bh=ud+eH7yG+oOTmRuS7cdQfVegR1yQ0UWl53am1ZPomwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLvWQjn4kCViy/LMNHlFQn1+ovTkVHHJPanA07sROX3V0uDamwfy88MqL8IPmEJUmOqmMgl3k7xUqPBrdajicoPu2t+5eH4ijPexZ4xLQ+TgYP/BMZCoQxeuv00zs1TgwPWs/OyppUld8kEgTiLG5VPyZe64DkI0yrXHlR8TC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdjzgIB1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NtG0SDPr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdjzgIB1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NtG0SDPr"
Date: Tue, 26 Nov 2024 12:20:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732620002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ud+eH7yG+oOTmRuS7cdQfVegR1yQ0UWl53am1ZPomwY=;
	b=rdjzgIB1gdAAPeUW9PwasFAAz2Sn9T+MWkjh1d4XKOQ7AhmUfJOzB9Y1/oipRQKmGACI3z
	qSAaBOI26NdsPW3ZV/AsBOgq17V4d2j3fDgL2rR75e0heIrYNrEFDDJqdOoakUFa9lQ8qR
	AqjRBdxZB+zCDUZC1BGZ8Pz+ciLTeVScosCO9qCRuymps4CosDwTB9fvlYb/PK7C7gwXZ0
	74pDhn+I4MLJuMST1WQoFhf/ygOT+fM2JHLcEVks+n/lkGC0L7XEmo0mVsXipGLz0SjAEe
	KGB3dlA+gu8eEY2P2IGj8vf7wW5GkzSoSUixaom3XAyW4S85kGCHefeU/ptHcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732620002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ud+eH7yG+oOTmRuS7cdQfVegR1yQ0UWl53am1ZPomwY=;
	b=NtG0SDPrjEZ7HbAezRxXGee3gWzrdq1YN830e8xKAxI77Np1C6LEcxQ6P84QKhJQ9ew/AN
	YsDoK98yQUImMxAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
Message-ID: <20241126112000.UkTwR0Iv@linutronix.de>
References: <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>

On 2024-11-25 15:54:48 [-0500], Waiman Long wrote:
> > FWIW, the description of commit 560af5dc839 is misleading. It says
> > "Enable
> > PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what
> > the
> > commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
> > enabled. It is all or nothing.
> >=20
> I think we can relax it by
>=20
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5d9eca035d47..bfdbd3fa2d29 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
> =C2=A0config PROVE_RAW_LOCK_NESTING
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on PROVE_LOCKING
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y if ARCH_SUPPORTS_RT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable the raw_spinlock =
vs. spinlock nesting checks which ensure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 that the lock nesting ru=
les for PREEMPT_RT enabled kernels are
>=20
> Sebastian, what do you think?

All the changes Guenter proposed make sense and were limited to sparc.
So we could apply that. Limiting the option to the RT architectures
would silence the warnings. If there is no interest in getting RT on
sparc there is probably no interest in getting the lock ordering
straight.
I remember PeterZ did not like the option in the beginning but there was
no way around it especially since printk triggered it on boot.
I'm fine with both solutions (fixing sparc or limiting
PROVE_RAW_LOCK_NESTING). I leave the final judgment to the locking
people.

> Cheers,
> Longman

Sebastian
