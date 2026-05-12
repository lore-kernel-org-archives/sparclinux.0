Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEC4921A0;
	Tue, 12 May 2026 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573865; cv=none; b=pNrWI3rpUQclB8DvB6B7HimLWwlOEigXcFyQ+0sOE3N1xVMpLuBxaNM4V14CZHBzGRtCslHAuvG6pBY7F/MLLOFTfcXJS4+XLVOuHN76kWuoTxqG86clw6nvx3MrYPo6geo8xsyffXXfj7qYxk3Vm8M+SwzFP1JwuUtu/pNwnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573865; c=relaxed/simple;
	bh=wYyyzgZZXOeKgdcWpmGuhU1Q+C6chQuc5I0CN1aHGkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F7qggq+htHNQhDMPOf91yKATtGPZCVTrtyLiJcdl4OaWUwbjcuO+Tx6/43LrsvJwEXQeGE7CFPXyFs1KVnQrVLIISOmoCK3bx0Qp9VMhDNd8n33imx2SndvsWZ4fSKSuCdxAQmZ6HrHPB8ftvMTq3+CBsyriNrdSEeQh2XKpNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ8JYoOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ8JYoOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30857C2BCB8;
	Tue, 12 May 2026 08:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778573864;
	bh=wYyyzgZZXOeKgdcWpmGuhU1Q+C6chQuc5I0CN1aHGkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HZ8JYoOJ9CknhyGiIdFqvEqaOqo8AH0OI/1gPlqApCPcaMVPCbrExPNNRfwDzntNb
	 ZzFiTU5/poR3gAdVdKrVO1WhuvW68otRIIvk8RRhZ3wUTJX634xrSkk+o6xLwddsnG
	 xiiBY9piemhiRVAb3uLoILLASIS+v4eieQmoKrmKIMIHs1wHT6NeiBluqIc4nfBqPr
	 tyeZr2CxZbYHdexcWrVSP3ZDJ/JEUC3BMXqRv1PGn0BjlH3upJfsc6zOLGku/MldKN
	 R+zz3PoEZOj5o9FioGfuXeSNzWAVSYEBaEX3gdRaDcXxEr/Wc5VAPH2TDtLuey4ghI
	 qsiRv1qlxvJlg==
From: Thomas Gleixner <tglx@kernel.org>
To: Tony Rodriguez <unixpro1970@gmail.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thorsten Leemhuis
 <regressions@leemhuis.info>
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
In-Reply-To: <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com>
Date: Tue, 12 May 2026 10:17:41 +0200
Message-ID: <878q9p82je.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 11 2026 at 22:03, Tony Rodriguez wrote:
>> Can you apply the debug patch below, which will disable tracing once it
>> hits the hung task detector and then retrieve the trace?=20
> As requested, I applied your debug patch to v7.1=E2=80=91rc3 and captured=
 the
> trace output.  On the SPARC64 S7=E2=80=912 system the machine becomes
> unresponsive and produces many thousands of lines of trace data that
> do not appear to terminate.

Yes, it takes a while to spill out over serial.

> Posting the full output inline or as an attachment may be impractical,
> so I=E2=80=99ve included the key sections below.

Kinda.

> If you prefer the complete trace, please let me know the best way to=20
> provide it. Guessing the kernel mailing isn't best to attach that?

Correct.

> [=C2=A0 249.004209] [<0000000000000000>] 0x0
> [=C2=A0 249.019116] Dumping ftrace buffer:
> [=C2=A0 249.025666] ---------------------------------
> [=C2=A0 249.034534]=C2=A0 =C2=A0<idle>-0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00d.... 1836659us :=20
> clockevents_program_event: Successfully programmed 4000000 4000000
> [=C2=A0 249.055418]=C2=A0 =C2=A0<idle>-0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00d.h.. 1845926us : timer_interrupt:=20

So this is the interesting part, but that's starting at 1.836659s
while the actual problem happens ~120 seconds later and the detection
takes another 120 seconds.

Assuming that one of the CPUs does not get timer interrupts anymore, the
trace of that CPU should end around the time the last programming
happened. So the interesting part is at the end of the output. The
default buffer size per CPU is 1408k, which holds about 150k entries, so
we can just shorten the buffers to make this less painful.

Can you add 'trace_buf_size=3D50k' to the kernel command line, which
limits the buffer size to about 640 entries. Assuming 115200 Baud this
should then take about 4 seconds per CPU to dump, which still is a bunch
on a large machine, but definitely way more workable than the default.

IIRC, SPARC64 S7=E2=80=912 has 128 threads total, so the resulting uncompre=
ssed
output should be around 7-8M. That's highly compressable text, so the
resulting dump.xz should be suitable to be stored in github. If github
does not allow you, let me know and we work something out.

Thanks,

        tglx

