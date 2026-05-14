Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DF3AB26D;
	Thu, 14 May 2026 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754289; cv=none; b=SVdZn2APUXp3o98w7RC+WLlcQhj9IMRiJGSyJ147ogCrrJ+rfNwyJE64jVNnWh5WJ51Gd3LX1rNo2K7dhWyELc+RHPL0p7NHBekyVL92TlFmMRQw0AGJG6okT35Qyj4Y48vK+jdkrQVeF6eh4do8C2dwuWRDULCMgSOEKhViIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754289; c=relaxed/simple;
	bh=rPMvnGQqst3vADlA54Xt8XuwO5jj10AGcvalmTbWTm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkzOTSYPnpq5WmjQDH+lEv7vepRuH6VlOh392JUh04jmbZjS0a4CF1jjqlA+M9CaBcu3Kq/cQkQPT279K7Kkadkyti5do07cugwX2DkLVAVbEVFOKmieHTV0TeaaF6W2Zb3Xdv2S9G2W93vlkhMfbLz/GZ+pcVif11jY5CM1KHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnt3RB67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnt3RB67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B649C2BCB3;
	Thu, 14 May 2026 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778754289;
	bh=rPMvnGQqst3vADlA54Xt8XuwO5jj10AGcvalmTbWTm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mnt3RB67koobjq3JQnbggOb2GhOGHdHxxvEBt3cAaLF8tJ9asBzZJ/QQi+ARN/Otv
	 MepTBmqQRKuBM78A/fqtKrl0L+7xoyoNfDFtJm4ci3JhmzrpBPWGXQr+vb2R/ksQZ1
	 RCZuRaHjLu17RhPTPbZj/2TdWVDgstCdQfTwhWwxmPjMEqMH3icY7NyGFFyqL7bZml
	 ThHHyy6hpDXF5RrcjClZyNPkf2ZVhPmq7KiBYGTuH2bjxajhUtdY5ky3eIRmVUz7gE
	 HkVDPtUisUTZ5E+wTSpRQRKWr6M0xyodaQcTfnweznM76hC5DnISepEBL87x0Z9fA2
	 DlLz3NwCASclA==
From: Thomas Gleixner <tglx@kernel.org>
To: Tony Rodriguez <unixpro1970@gmail.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
In-Reply-To: <e45438e7-8501-4c10-95ee-07f118de8a51@gmail.com>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com> <878q9p82je.ffs@tglx>
 <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com> <87tssb6olo.ffs@tglx>
 <e45438e7-8501-4c10-95ee-07f118de8a51@gmail.com>
Date: Thu, 14 May 2026 12:24:44 +0200
Message-ID: <87qznez3tf.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 14 2026 at 00:24, Tony Rodriguez wrote:
> Initial validation of the test patches for v7.0.6 and 7.1-rc3 on the=20
> S7-2 looks promising: I have not observed panics, timer delays, or other=
=20
> timer-related issues so far. I will pause broader validation on the S7-2=
=20
> and T7-1 until I receive your recommendation or any requested revisions=20
> (see inline comments below).
>
> Note: I did see an intermittent error on the S7-2 running 7.1-rc3,=20
> usually when the system is under heavy load during a kernel build. I=E2=
=80=99m=20
> not sure whether it is a separate problem?
>
> "[676.464681] BUG: Bad rss-counter state mm:000000008d9f1cf2=20
> type:MM_FILEPAGES val:-4096 Comm:cc1 Pid:78165".

That's unrelated and an accounting issue in the MM code. Please report
it separately to the MM people.

> On 5/13/26 1:28 PM, Thomas Gleixner wrote:
>> I'm willing to bet a round of beers at the next conference that this is
>> the problem and that it will magically disappear when you change that
>> condition to:
>>
>>          return (read_cnt() - exp) >=3D 0 ? -ETIME : 0;
>
> Attempted to locate "return (read_cnt() - exp) >=3D 0 ? -ETIME : 0;" but=
=20
> could not find an exact match. After additional inspection I updated the=
=20
> following functions "tick_add_compare()" and "stick_add_compare()" in=20
> arch/sparc/kernel/time_64.c to from "> 0L" to ">=3D 0L". This appears to=
=20
> have resolved the lost-timer behavior.

I condensed the logic for illustration and rightfully assumed that you
will figure it out. :)

> --- time_64.c.orig
> +++ time_64.c
> @@ -146,7 +146,7 @@
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: "=3Dr" (new_tick));
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_tick &=3D ~TICKCMP_IRQ_BIT;
>
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0return ((long)(new_tick - (orig_tick+adj))) >=
 0L;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ((long)(new_tick - (orig_tick+adj))) >=
=3D 0L;
>  =C2=A0}
>
>  =C2=A0static unsigned long tick_add_tick(unsigned long adj)
> @@ -277,7 +277,7 @@
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: "=3Dr" (new_tick));
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_tick &=3D ~TICKCMP_IRQ_BIT;
>
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0return ((long)(new_tick - (orig_tick+adj))) >=
 0L;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ((long)(new_tick - (orig_tick+adj))) >=
=3D 0L;
>  =C2=A0}

Looks correct, but you missed the one in hbtick_add_compare() which has
the same issue.

>> --- a/kernel/time/clockevents.c
>> +++ b/kernel/time/clockevents.c
>> @@ -381,6 +381,8 @@ int clockevents_program_event(struct clo
>>   	if (dev->set_next_event(dev->min_delta_ticks, dev)) {
>>   		if (!force || clockevents_program_min_delta(dev))
>>   			return -ETIME;
>> +	} else if (delta <=3D 0) {
>> +		dev->next_event =3D ktime_add_ns(ktime_get(), dev->min_delta_ns);
>>   	}
>>   	dev->next_event_forced =3D 1;
>>   	return 0;
>>
> You mentioned this kernel/time/clockevents.c patch is optional, but I=20
> propose revising clockevents_program_event(). If the requested event=20
> time is already at or before now, record a sane next_event (now +=20
> min_delta) so core code sees a future expected time and can behave=20
> correctly. Does this seem reasonable?

The related core code only cares what the last programmed expiry value
in clock monotonic (i.e. the @expires argument) was. And the only
interesting information is whether it's in the future or not. If it's in
the past then it does not matter how much in the past it is.

Whatever we fake into it is never going to reflect anything related to
reality anyway and there is no guarantee that the code which reads it
will see a future expected time depending on the time elapsed between
faking it and reading it. So it's truly a cosmetic exercise for no real
value.

Thanks,

        tglx
