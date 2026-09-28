Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F4478842;
	Mon, 28 Sep 2026 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633881; cv=none; b=fZ3mfQUxJsRRl2Kh74wdVVndWcxQ4CRSRJG2c5bfySFVRfuey1MQ6QLb6AhrY1j9UZ/eUE70GW3d38W8xQdkWK9tWizZufHWQmECvzsmkWMVyD19FMkl01DErNPPTtFo2ZQpyyIulp35iJsfFb4WPAtOUvIPyeQ9SlMqtPjgpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633881; c=relaxed/simple;
	bh=z3cD18dfRRxJBzxxLMbV7wKOYV85Yje2YDlaAf0/JiE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYRNC3IqsCTqdabVJWcDDWtfkYi328kdQRGxRDVweRYKK754Ly/O8c6Tg4suUdkGxcFp6L9fxpG/UITe05L+wWYMlKJD1Wsd2FWtp7v88KEzpOHLgliVUPz2mAnzo7+IxzpyDBcwEIiPljUAgFKO1I2IGtHF0wTaLAwC605Qla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=EARQgv6T; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="EARQgv6T"
Message-ID: <a1e1a8c88161894c8fcd4514900cf3a14232aa47.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790633870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57P7JFPpwMerIO3+pWerd46p4Ojio7Wq8LO1VeNWTLw=;
	b=EARQgv6T5ULGs2S7nheXWP05DIkXzdGB9wVbuz1ZL7Gu71Lfd5+9c0YEcQBq2V1d6eWo7R
	pWNTM74u7eYtAf0fHeT4LDshbQfZ9XwDV5baPSSzHcN2v5AbfwVXs+3DqTzei7fm0r5hNK
	7t1kPeAeeqlSKbQobZL6DXM3SJHU5FA=
Subject: Re: [PATCH v3] sparc64: Fix comparator problem with timer interrupts
From: Stian Halseth <stian@itx.no>
To: tglx@kernel.org, andreas@gaisler.com, davem@davemloft.net, 
	sparclinux@vger.kernel.org
Cc: Tony Rodriguez <unixpro1970@gmail.com>, linux-kernel@vger.kernel.org, 
 thomas.weissschuh@linutronix.de, regressions@lists.linux.dev, 
 glaubitz@physik.fu-berlin.de, linux@leemhuis.info,
 torvalds@linux-foundation.org
Date: Tue, 29 Sep 2026 00:17:49 +0200
In-Reply-To: <20260831180728.3097740-1-stian@itx.no>
References: <20260519022421.5978-1-unixpro1970@gmail.com>
	 <20260831180728.3097740-1-stian@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-SGTUVnu+6H4b+MUMUot/"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-SGTUVnu+6H4b+MUMUot/
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I just got a SPARC T7-1 and have independent reproduction and
confirmation of the fix.

Without the patch the system is not really usable. I can just bring
down a network interface and that alone triggers a hang.=20
Hung on 3 out of 3 boots unpatched:

  task:ip              state:D
   [<0000000000cfebc4>] wait_for_completion+0x64/0x180
   [<0000000000509c30>] synchronize_rcu_normal+0x150/0x280
   [<0000000010079060>] ixgbe_down+0x1a0/0x460 [ixgbe]
   [<000000001007a4c8>] ixgbe_close+0xe8/0x100 [ixgbe]
   [<0000000000af1cf8>] netif_change_flags+0x18/0x80
   [<0000000000b08618>] rtnl_newlink+0x758/0xaa0

A second caller hit the same stall under kernel build load, from
network namespace teardown rather than any driver path:

  task:kworker/u1024:0 state:D
   Workqueue: netns cleanup_net
   [<0000000000cfebc4>] wait_for_completion+0x64/0x180
   [<0000000000504ab4>] rcu_barrier+0x214/0x480
   [<0000000000af3f88>] netdev_run_todo+0x48/0x600
   [<0000000000ad99c8>] cleanup_net+0x1c8/0x360

Both are plain RCU waits:

  rcu: rcu_sched kthread timer wakeup didn't happen for 6002 jiffies!
       g193 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
  rcu:     Possible timer handling issue on cpu=3D20 timer-softirq=3D107
  rcu: rcu_sched kthread starved for 6004 jiffies! ->cpu=3D20


With the patch applied: 3 boots with a clean first ifdown on each, plus
6 consecutive interface down/up cycles within one boot, and no stall or
hung-task messages in any of them.

Tested-by: Stian Halseth <stian@itx.no>


On Mon, 2026-08-31 at 20:07 +0200, Stian Halseth wrote:
> From: Tony Rodriguez <unixpro1970@gmail.com>
>=20
> The tick/stick/hbtick add_compare() implementations program the
> comparator and then check whether the write took effect in time:
>=20
> 	exp =3D read_cnt() + delta_ticks;
> 	write_cmp(exp);
> 	return (read_cnt() - exp) > 0;
>=20
> A nonzero return value means the expiry time was already reached
> before the comparator write could take effect, so the interrupt may
> never fire, and the caller retries with a new expiry:
>=20
> 	return tick.add_compare(delta_ticks) ? -ETIME : 0;
>=20
> The check only fails the write when the counter has advanced past the
> expiry time, but not when it is equal to it. In the equal case it is
> unknown whether the comparator write took effect before or after the
> counter reached the expiry value, so the compare match - and with it
> the timer interrupt - may have been missed. add_compare() then
> reports success, the caller does not retry, and the CPU is left with
> no pending timer interrupt.
>=20
> This results in stalled hrtimers and RCU stalls / hangs under load,
> observed on SPARC S7-2 and T7-1 systems:
>=20
> =A0=A0=A0 rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> =A0=A0=A0 rcu: rcu_sched kthread timer wakeup didn't happen for 5259
> jiffies!
> =A0=A0=A0 rcu:=A0=A0=A0=A0 Possible timer handling issue on cpu=3D100 tim=
er-
> softirq=3D15
>=20
> Treat counter =3D=3D expiry as failure as well, so the caller retries
> with a new expiry time. After this change S7-2 and T7-1 systems no
> longer hang.
>=20
> Diagnosed-by: Thomas Gleixner <tglx@kernel.org>
> Link: https://lore.kernel.org/all/87tssb6olo.ffs@tglx/
> Link: https://lore.kernel.org/all/871pfcznw0.ffs@tglx/
> Link:
> https://lore.kernel.org/all/20260519022421.5978-1-unixpro1970@gmail.com/
> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
> [stian: rewrote the changelog per review of v2, retested]
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> v3:
> =A0- rewrite the changelog: describe the write/readback ordering and
> the
> =A0=A0 direction of the equal-compare case per Thomas Gleixner's review
> =A0=A0 https://lore.kernel.org/all/878q9fxywc.ffs@tglx/
> =A0=A0 (the code change is identical to v2)
> =A0- add the Link: tags to the original debugging discussion
> =A0- picked up with Tony's agreement after v2 stalled
> =A0=A0
> https://lore.kernel.org/all/10382506-3f57-4b33-8356-34f23fb5f153@gmail.co=
m/
>=20
> Tested on an UltraSPARC T4-1 (sun4v, stick variant): 9.1M hrtimer
> reprograms in 90s across 32 threads with 10-500us expiries, no
> stalls, no lost wakeups (worst oversleep 657us).
>=20
> =A0arch/sparc/kernel/time_64.c | 6 +++---
> =A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/sparc/kernel/time_64.c
> b/arch/sparc/kernel/time_64.c
> --- a/arch/sparc/kernel/time_64.c
> +++ b/arch/sparc/kernel/time_64.c
> @@ -146,7 +146,7 @@
> =A0			=A0=A0=A0=A0 : "=3Dr" (new_tick));
> =A0	new_tick &=3D ~TICKCMP_IRQ_BIT;
> =A0
> -	return ((long)(new_tick - (orig_tick+adj))) > 0L;
> +	return ((long)(new_tick - (orig_tick+adj))) >=3D 0L;
> =A0}
> =A0
> =A0static unsigned long tick_add_tick(unsigned long adj)
> @@ -277,7 +277,7 @@
> =A0			=A0=A0=A0=A0 : "=3Dr" (new_tick));
> =A0	new_tick &=3D ~TICKCMP_IRQ_BIT;
> =A0
> -	return ((long)(new_tick - (orig_tick+adj))) > 0L;
> +	return ((long)(new_tick - (orig_tick+adj))) >=3D 0L;
> =A0}
> =A0
> =A0static unsigned long stick_get_frequency(void)
> @@ -411,7 +411,7 @@
> =A0
> =A0	val2 =3D __hbird_read_stick() & ~TICKCMP_IRQ_BIT;
> =A0
> -	return ((long)(val2 - val)) > 0L;
> +	return ((long)(val2 - val)) >=3D 0L;
> =A0}
> =A0
> =A0static unsigned long hbtick_get_frequency(void)
> --
> 2.53.0

--=-SGTUVnu+6H4b+MUMUot/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarrnjQAKCRDoeAEuJe36
VqZvAQDk5SX53KefiP3+481kGr9gFkYSS9HS41YB1+91UXUUuwEA2CPwV+rv7hG+
Ogwcp9C1kq7hE3cQ+cUBuRVXM79CAQc=
=M+os
-----END PGP SIGNATURE-----

--=-SGTUVnu+6H4b+MUMUot/--
