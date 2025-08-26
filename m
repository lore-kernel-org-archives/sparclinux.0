Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D482F4A1F
	for <sparclinux@vger.kernel.org>; Tue, 26 Aug 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234146; cv=none; b=dSqHC9VNvBghoqJtn0f066yKJOnj9wDjbmeBI9iC4QYKtq93yKvG/nfXqL/h5BGqacmrG9v+lWNZTuxDQWcn3DZ/fpjYuGG2NIsRROxlQq+snBNKO39knpw+uuAwkN65YtcdzZQtUmv2hMfQEgaXbBehAhv7aI0ae6U7lO96ANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234146; c=relaxed/simple;
	bh=E/Ye7/SL7tqTx9oBx/tviBmGnvw5YMp+2zk7nWejWf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmedU2bpIzRqZHjSQU8cWvDowuxb2mpLm4mstd0b9esb84LOYj1j/71LhxbOE242BodFfrDaV6aDu1yRoSlvbEIbDIy/Q5j31imUSIUiYtCa4jCiOAN13BOuavydn8Zc/LvZRilzpYzYbEMFdLstMUolXtMvLiOuf0TpGQf4IFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgVXpgcj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgVXpgcj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248681b5892so43955ad.0
        for <sparclinux@vger.kernel.org>; Tue, 26 Aug 2025 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756234141; x=1756838941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/Ye7/SL7tqTx9oBx/tviBmGnvw5YMp+2zk7nWejWf0=;
        b=AgVXpgcjDr9q0cS0bj8JMWInMebRYXt+OlXrwg9uWZtxCDEGAAIHZ3Q2+foOHm7EtJ
         M1a1/P/1ZdmsTqvgB91Fw1oLEKJfkEpPxtdXyO1h+ZsMNoRasLukg83hO8hxEBl/vzgb
         blej+3tX1kv8vjoxm0eeYveDe1fVratZcb+0nZ3k+zAKqfH7DstQSzftAdjrLUY3b9lP
         VFLjfXViSByXPGHLsW5+jWUlRlaRzYxqpZOBet0a0sHAv33muLCeUj/m1cERrLdDvs2X
         qVaW2rEgwm+AmTJUnEPaJUqi+6dDEd0JieCGzRPCDS5B94usjZMauleUCipOGgMEJZTo
         LxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234141; x=1756838941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/Ye7/SL7tqTx9oBx/tviBmGnvw5YMp+2zk7nWejWf0=;
        b=kTv48Fzvnrq1omO1Q7FDedflrL2ytRsde+Ca9RXlNUK0pYZ148fi4AZX9IcFXdDBze
         SIx3LZCASitctdjYp4DxecJypK6vDqi5q2itiH3+iyCsCPNd6PwZodMXNyllRB2QZ2p3
         wUiDdze5iEzPVsxEI+/9C8jA412kq8ML/3Jp2WR/BgdvLxUN9SoScvNZWfhNtTvjQJd7
         HxukCNUnTiK4qcnDj26BWD5f6MOPc6l/KU1RhdFKV7FWDfjbH4T8Ut9FSemMa2efUGlN
         7hWcVVjbCaK+b4O6R1nIdWfG7Y+DnBdd9FsuM3j0WU2leiW4eMkv7NR+EoUcJr7d5hf7
         +PAA==
X-Forwarded-Encrypted: i=1; AJvYcCV/boZV2YTeaQpED/Izmc9Wo4yF60uquucwb0fw4n4WZemqm1/JRkaqlMVWYWt06bERJPBEB491DqVZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbF1zYxXbKREpt+u9hY4pG0ilhEV6RwTdeJImdSDUbbhgYv5S
	aPfWnGC3kR04F61bBEfYID0NAJRyQMXYCQPe3s8YdqWH+QVv9Ke3ahvqfHtwA4pJo59mATu055q
	m/+NfTmDCeogdTYk7tMYDVJSwmwGkhB/v2WryNMgB
X-Gm-Gg: ASbGncsp3p3XpmwlntIbDQ+Kd0jsh1XJvBO/2yz3LFXYkDeiH0lLkdGorRVqC7VGwBH
	NsOd8B5xCo1iC7d4j0xWhzM8dLgxjmFM7aV9jN7uzt+bhJ6khoJEJWCVoXqRDZP8qUrlrZlS0Rn
	GjeRGUXqqVAGuifR5ehdG5mJcLamjjXSl9OnP0U/XYgBjXv2Hfvqr+TNtLLZu9yV5KlZLaGNTSK
	Lh6uqalk9FgvYv3HJbPTOuZXEbu+3e2yli92hIH/KEUfePthz02l3uibLV318bi
X-Google-Smtp-Source: AGHT+IG+ollMBmiaOYcyGD4fK0EXbH34IwD2F+IqBBnZbD5S5EK8GUe1Cco16tj20beWZxJ5YP1hQInru/5q0vhDcUY=
X-Received: by 2002:a17:903:228c:b0:243:afef:cd88 with SMTP id
 d9443c01a7336-2486395f193mr4627105ad.11.1756234140425; Tue, 26 Aug 2025
 11:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755096883.git.robin.murphy@arm.com> <d6cda4e2999aba5794c8178f043c91068fa8080c.1755096883.git.robin.murphy@arm.com>
 <20250826130329.GX4067720@noisy.programming.kicks-ass.net> <6080e45d-032e-48c2-8efc-3d7e5734d705@arm.com>
In-Reply-To: <6080e45d-032e-48c2-8efc-3d7e5734d705@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 Aug 2025 11:48:48 -0700
X-Gm-Features: Ac12FXxL0fQGFTk6-3SCJz15Qd8Ums9V_bcQA6gIxaEwQacWk3scYfeQZZ7cYZQ
Message-ID: <CAP-5=fXF2x3hW4Sk+A362T-50cBbw6HVd7KY+QEUjFwT+JL37Q@mail.gmail.com>
Subject: Re: [PATCH 12/19] perf: Ignore event state for group validation
To: Robin Murphy <robin.murphy@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, 
	mark.rutland@arm.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-fpga@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, coresight@lists.linaro.org, 
	iommu@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:32=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-08-26 2:03 pm, Peter Zijlstra wrote:
> > On Wed, Aug 13, 2025 at 06:01:04PM +0100, Robin Murphy wrote:
> >> It may have been different long ago, but today it seems wrong for thes=
e
> >> drivers to skip counting disabled sibling events in group validation,
> >> given that perf_event_enable() could make them schedulable again, and
> >> thus increase the effective size of the group later. Conversely, if a
> >> sibling event is truly dead then it stands to reason that the whole
> >> group is dead, so it's not worth going to any special effort to try to
> >> squeeze in a new event that's never going to run anyway. Thus, we can
> >> simply remove all these checks.
> >
> > So currently you can do sort of a manual event rotation inside an
> > over-sized group and have it work.
> >
> > I'm not sure if anybody actually does this, but its possible.
> >
> > Eg. on a PMU that supports only 4 counters, create a group of 5 and
> > periodically cycle which of the 5 events is off.

I'm not sure this is true, I thought this would fail in the
perf_event_open when adding the 5th event and there being insufficient
counters for the group. Not all PMUs validate a group will fit on the
counters, but I thought at least Intel's core PMU would validate and
not allow this. Fwiw, the metric code is reliant on this behavior as
by default all events are placed into a weak group:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n631
Weak groups are really just groups that when the perf_event_open fails
retry with the grouping removed. PMUs that don't fail the
perf_event_open are problematic as the reads just report "not counted"
and the metric doesn't work. Sometimes the PMU can't help it due to
errata. There are a bunch of workarounds for those cases carried in
the perf tool, but in general weak groups working is relied upon:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/pmu-events.h?h=3Dperf-tools-next#n16

Thanks,
Ian

> > So I'm not against changing this, but changing stuff like this always
> > makes me a little fearful -- it wouldn't be the first time that when it
> > finally trickles down to some 'enterprise' user in 5 years someone come=
s
> > and finally says, oh hey, you broke my shit :-(
>
> Eww, I see what you mean... and I guess that's probably lower-overhead
> than actually deleting and recreating the sibling event(s) each time,
> and potentially less bother then wrangling multiple groups for different
> combinations of subsets when one simply must still approximate a complex
> metric that requires more counters than the hardware offers.
>
> I'm also not keen to break anything that wasn't already somewhat broken,
> especially since this patch is only intended as cleanup, so either we
> could just drop it altogether, or perhaps I can wrap the existing
> behaviour in a helper that can at least document this assumption and
> discourage new drivers from copying it. Am I right that only
> PERF_EVENT_STATE_{OFF,ERROR} would matter for this, though, and my
> reasoning for state <=3D PERF_EVENT_STATE_EXIT should still stand? As for
> the fiddly discrepancy with enable_on_exec between arm_pmu and others
> I'm not really sure what to think...
>
> Thanks,
> Robin.
