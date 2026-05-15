Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5935E1DD;
	Fri, 15 May 2026 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875051; cv=none; b=Ky9mm6CsFFMISgCawlDfS618VzTPKu/sfzz/s6jtuOJkNuESSUmWgtEjzkm9fJvB5BOuL+dpBoV/o27RxMAzYJXa/K6tzVRKeyyQYdmDXG8eFqREK9Mpfh1cDDGF2MMe7oojSEnULUiu3fdIoD7+pCzpvbVbOJuYyXQF9S5zOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875051; c=relaxed/simple;
	bh=RcxWdxyOtt3pt04+C5YwWOqopc6gNCYhI8U1a+BYkJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rxw16YDZ+kUd6z5NY3ttds0HNH7qaR/indi8GOOWKMlT3LJioSV7akvd3uCFtXff00gUNMjoqvGJquROgmv3eyBNqFkNdAWibTFtgbbRKEtQ8wm5Y8JeJP1DBh0Z4hkioInHkhQTLssrBZpLrX5smCGKZp3UPWoHDv/M/9PQjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfG+Xc92; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfG+Xc92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91C1C2BCB0;
	Fri, 15 May 2026 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875051;
	bh=RcxWdxyOtt3pt04+C5YwWOqopc6gNCYhI8U1a+BYkJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HfG+Xc928ulaLjMPWEV/pB4ilpCrrZeiWLQSrLaHrqkXohnAfxYdXspfqczhtQ6TK
	 lTREExRXGhC5AU8Sq6VVPyrAS4C/kmH1zK2hmeggpkVKPEdQ3BQYOhqoeAf4q5C/xi
	 GxwLsxNz1VJWumYwH1Y+JfqkQfbWp+sVVozDsQN3WOJUGQlYBEf0TmbflP/oLI2noh
	 y8JglzauKVTQP6m0CtPkUpgfSFbquBz8OTmRa6C+5OjSTIepE9+bi8GYWitZ9A34e9
	 e0XOACnNvO/9YaPpi5EzhyJML8E6Uf55nVroqW9qQ/OHhrxdrcaXwhu2ps+kM2xira
	 yyTzQ9m7RMgPA==
From: Thomas Gleixner <tglx@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Tony Rodriguez
 <unixpro1970@gmail.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Thorsten
 Leemhuis <regressions@leemhuis.info>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
In-Reply-To: <a0feba9667ac6760f82137cca89afac7da786f22.camel@physik.fu-berlin.de>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com> <878q9p82je.ffs@tglx>
 <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com> <87tssb6olo.ffs@tglx>
 <e45438e7-8501-4c10-95ee-07f118de8a51@gmail.com> <87qznez3tf.ffs@tglx>
 <0669f754-a313-4aa3-9923-0c374d49feb3@gmail.com> <871pfcznw0.ffs@tglx>
 <a0feba9667ac6760f82137cca89afac7da786f22.camel@physik.fu-berlin.de>
Date: Fri, 15 May 2026 21:57:27 +0200
Message-ID: <87se7sxx7c.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi!

On Fri, May 15 2026 at 19:51, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-05-15 at 17:35 +0200, Thomas Gleixner wrote:
>> > Thank you again for the debugging guidance and for the feedback on my 
>> > original patch addressing the timer starvation issue. It was a pleasure 
>> > contributing to the resolution.
>> 
>> Thank you for going through the hassle of chasing it down and providing
>> the debug data to analyze it.
>> 
>> I'm still puzzled how this went unnoticed for almost two decades:
>> 
>>    112f48716d9f ("[SPARC64]: Add clocksource/clockevents support.")
>
> My suspicion is that it was previously visible only in certain edge cases,
> in particular on machines with many cores and high load.
>
> Case in point: In the past, SPARC LDOMs with lots of virtual CPUs could
> crash in rares cases when building packages such as GCC or LLVM and running
> their testsuites.

I assume those occasional failures did not leave conclusive hints around.

> I don't know if Tony's patch fixes this long-time issue that we have observed
> in the past on Debian's buildds, but I think that the chances aren't too bad.

Good luck!

> Thanks to both of you for hunting this down!

For some stupid reasons I like such puzzles :)
