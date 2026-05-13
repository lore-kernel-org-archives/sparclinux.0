Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E336A03B;
	Wed, 13 May 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704119; cv=none; b=qSKGQmzyQDpiA5WXT9fWvyyP3LwpCasg5Yde/keHxLqR3ItQftEoLlk50TyQb2V9xkIDtw1wB/Cw+D0OBlJYPzgVCMu7uhQ+Oy7d8Jj0lcTJZa3uuxd2vCUZjq1BxB7r2inI3Gj0OKnidoNPsousXZXqD/cXAnesF7EPbXCwuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704119; c=relaxed/simple;
	bh=UwV7dp061yPXHpBysGQkz14b8ewpCpll2N49lOp5C14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GjAqUvW+3CzMa4PM7LLe+oSJPxuJGZEogrJZjp4CeyoD5fC9luJ04C9R4O+0+C+kbK/c4qbXBLIJVM9b9pW/4uXHsgvgAjzOeSUB7Mp9t5Wi7tDc55iByxa3rQAOD+fMSTLBV0wMWD/U7k3neTXcyClGwddrmSXx0KhTmwio2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZl4SuvK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZl4SuvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD66C2BCB7;
	Wed, 13 May 2026 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778704119;
	bh=UwV7dp061yPXHpBysGQkz14b8ewpCpll2N49lOp5C14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rZl4SuvKEyr/StDOQEbWRIwK67mELxG90TmI1mxZay4KL7suZgulrfO2ShwTomSev
	 UZX7ISaqUs27Ptppf+r+VMzHFoUD/0v+NcQt+KrJ5Oey0yMRprzl1AiTBOMskjbyDz
	 5Cligk8XXZ+QgZ9nLuvntlKAnQKPgYxF8zdyDIGaOvaucpBaYcIdXB1Vd3yK71+pc3
	 q4TzzXio6fGh488i3Z3x4LeA4oPz3BOXVYHzehDplLEvRVM3epLQHIicchXeCPYtog
	 VougUyaTXFd7PFd01iS0RapT0VsSEckTfNl2A8nigSZ5aCLnuti76HIn9+xPFmKiUz
	 J8NjYAvTYuFDA==
From: Thomas Gleixner <tglx@kernel.org>
To: Tony Rodriguez <unixpro1970@gmail.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thorsten Leemhuis
 <regressions@leemhuis.info>
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
In-Reply-To: <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com> <878q9p82je.ffs@tglx>
 <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com>
Date: Wed, 13 May 2026 22:28:35 +0200
Message-ID: <87tssb6olo.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tony!

On Tue, May 12 2026 at 14:43, Tony Rodriguez wrote:
>> Can you add 'trace_buf_size=3D50k' to the kernel command line, which
>> limits the buffer size to about 640 entries. Assuming 115200 Baud this
>> should then take about 4 seconds per CPU to dump, which still is a bunch
>> on a large machine, but definitely way more workable than the default.
>
> Done.=C2=A0 The complete trace file "s7-2-05122026-dump.tar.gz" can be=20
> obtained from my GitHub repo:
>
> https://github.com/unixpro1970/Sparc64-Kernel-Debugging-Dumps

Thanks for providing the data. So in both traces there is a clear
indication that the forced programmed min delta does not result in an
interrupt. Here are the last trace events on the affected CPUs.

No AHAVI CPU 116:

[  280.939873]   <idle>-0       116d.h.. 11612209us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[  280.980493]   <idle>-0       116d.h.. 11612213us : clockevents_program_e=
vent: Successfully programmed 9580000000 3991235
[  281.023902]   <idle>-0       116d.... 11612218us : clockevents_program_e=
vent: Successfully programmed 10112024440 536010830
[  281.089687]   <idle>-0       116dn... 11636205us : clockevents_program_e=
vent: Force programmed min delta 9600000000 10

No AHAVI CPU 100:

[  299.943989]  systemd-1       100d.h.. 27594794us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[  299.964303]  systemd-1       100d.h.. 27594796us : clockevents_program_e=
vent: Successfully programmed 25560000000 1407865
[  299.986182]  systemd-1       100d.... 27594932us : clockevents_program_e=
vent: Force programmed min delta 1 -25558727644
[  300.007707]  systemd-1       100d.h.. 27594933us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[  300.028019]  systemd-1       100d.h.. 27594934us : clockevents_program_e=
vent: Successfully programmed 25560000000 1269565
[  300.049894]  systemd-1       100d.... 27594971us : clockevents_program_e=
vent: Force programmed min delta 1 -25558767244
[  300.071415]  systemd-1       100d.... 27598043us : clockevents_program_e=
vent: Skipping 25560000000 -1838405

AHAVI CPU 6:

[ 1247.573212]   <idle>-0         6d.h.. 84194945us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1247.613828]   <idle>-0         6d.h.. 84194947us : clockevents_program_e=
vent: Successfully programmed 80140000000 3928334
[ 1247.762267]   <idle>-0         6d.h.. 84198876us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1247.844549]   <idle>-0         6d.h.. 84198878us : clockevents_program_e=
vent: Force programmed min delta 80140000000 771

AHAVI CPU 61:

[ 1258.222440]   <idle>-0        61d.h.. 84234905us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1258.516354]   <idle>-0        61dnh.. 84234910us : clockevents_program_e=
vent: Successfully programmed 84176000000 3999995280
[ 1258.648636]   <idle>-0        61dn... 84234914us : clockevents_program_e=
vent: Successfully programmed 80180000000 3991863
[ 1258.868940]   <idle>-0        61d.h.. 84238906us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1258.993594]   <idle>-0        61d.h.. 84238908us : clockevents_program_e=
vent: Force programmed min delta 80180000000 612

So there is only one case (CPU116) where another event in the past
programming (delta < 0) is skipped due to the force bit being set. But
that skip happens ~3ms after the min delta was programmed, which should
have resulted in an interrupt which never happened.

The original code is not really different vs. that min delta
programming, except that it does not have the next_event_forced
logic. But as you can see above this logic is not really making a
difference.

So I went through the differences line by line again and I found a very
subtle difference, but I can't seen how that would magically cure the
actual problem of the non-firing interrupt. The missing update of
dev->next_event in the force reprogram case of (delta <=3D 0) is
completely irrelevant as both events are in the past so it does not
matter at all. Nevertheless see the pointless and purely cosmetic delta
patch below.

But coming back to the trace data. There are tons of instances where the
forced programmed min delta results in an interrupt right afterwards:

[ 1258.868940]   <idle>-0        61d.h.. 84238906us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1258.889262]   <idle>-0        60d.h.. 84238906us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1258.909570]   <idle>-0        63d.h.. 84238906us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1258.929877]   <idle>-0        70d.h.. 84238906us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1258.950197]   <idle>-0        60d.h.. 84238907us : clockevents_program_e=
vent: Force programmed min delta 80180000000 552
[ 1258.971896]   <idle>-0        63d.h.. 84238908us : clockevents_program_e=
vent: Force programmed min delta 80180000000 627
[ 1258.993594]   <idle>-0        61d.h.. 84238908us : clockevents_program_e=
vent: Force programmed min delta 80180000000 612
[ 1259.015292]   <idle>-0        70d.h.. 84238908us : clockevents_program_e=
vent: Force programmed min delta 80180000000 313
[ 1259.036992]   <idle>-0        60d.h.. 84238910us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1259.057313]   <idle>-0        63d.h.. 84238910us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280
[ 1259.077620]   <idle>-0        70d.h.. 84238912us : timer_interrupt: Invo=
king handler hrtimer_interrupt+0x0/0x280

So all four involved CPUs force program min delta from the timer
interrupt context, but only three of them actually get an interrupt
afterwards. CPU61 fails to deliver one and as a result it goes stale.

As the set_next_event() callback returns 0 (success) in all cases -
otherwise we wouldn't see the trace entry - this all points to a problem
with that rearming logic:

        exp =3D read_cnt() + delta_ticks;
        write_cmp(exp);
        return (read_cnt() - exp) > 0 ? -ETIME : 0;

Your machine uses 'stick', which runs according to the conversion
factors in dmesg at 1GHz, but the CPU runs at 4.27GHz AFAIK. So you can
clearly run into a situation like this:

        TICK_CNT        CPU
        T1              exp =3D read_cnt() + D
                        ...                     // Some delay
        T1 + D
                        write_cmp(T1 + D)
                        now =3D read_cnt()	// Reads T1 + D
        T1 + D + 1
                        ---> returns success and the interrupt is never fir=
ing
Why?

Just to be clear: I never saw the VHDL code of that CPU, but that
pattern is way too familiar.

Those equal comparators, which were designed by AI (Absence of
Intelligence) before AI got popular, generally work this way:

  The comparator is only evaluated on the clock edge which increments
  the counter, but not when the comparator value is written. So a write
  of the same value does not result in an interrupt.

That's an "optimization" which spares quite a few gates and is obviously
nowhere documented. So software has to deal with the consequences by
using a crystal ball, which is trivial to get wrong and can go unnoticed
for a long time until it roars it's ugly head at some point for whatever
reasons.

I'm willing to bet a round of beers at the next conference that this is
the problem and that it will magically disappear when you change that
condition to:

        return (read_cnt() - exp) >=3D 0 ? -ETIME : 0;

unless they managed to add some extra propagation delay to that
comparator write like the HPET folks did at some point without telling
anyone. I doubt the SPARC janitor who implemented it did so because
that would have made the failure way more likely.

I have truly no idea why the original code did not expose this problem,
though it might have been just papered over by sheer luck and timing.

Thanks,

        tglx
---
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -381,6 +381,8 @@ int clockevents_program_event(struct clo
 	if (dev->set_next_event(dev->min_delta_ticks, dev)) {
 		if (!force || clockevents_program_min_delta(dev))
 			return -ETIME;
+	} else if (delta <=3D 0) {
+		dev->next_event =3D ktime_add_ns(ktime_get(), dev->min_delta_ns);
 	}
 	dev->next_event_forced =3D 1;
 	return 0;

