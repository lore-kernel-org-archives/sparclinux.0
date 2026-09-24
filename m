Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24C4119F8;
	Thu, 24 Sep 2026 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269707; cv=none; b=uTDfRj9p86m7jrWDHDq2JQ0WYerOvuCcAeoEVrSfZpMee2geOo4kytUkTjLnpS6xnRCjx708jr7BWP/3/JhQoYGiq9pvMfTIUcmtfhMOStOILx9gWgZBDKNFXfZYU1oQO9puAV2UvqaB0YVikpLLO8QCa3607a0sc4EzQt6buMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269707; c=relaxed/simple;
	bh=AuXEzlBNE68cTE75S0awvX6nrpGy2KmP7nLUc2Gx1A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK6HKlTHBDuq60mXHnpnlDn+Ny8FXXTIM3Qw2iPxJ2xf6kktpfScTHOkfxsx0Mazo1Cf8uTvnNdr3g0vUyGGonkmc1ydb6wq00NBGA/XD+/Gqj7ESfaMDUk3a1cWmeWMklDS83T5nM383UZqzAbXnmvQ3HEB5S2ExbgTq9zyT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivKF4TLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivKF4TLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A01E1F000FF;
	Thu, 24 Sep 2026 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269705;
	bh=VjBY3KmumkTHAQos/bBCamisos2hvjM1r4thzkMoC+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ivKF4TLLY6MbwWt5WCXzIpdE12qBQK4uLlTCPRbW/KLIqK8FLQIuUDXcb933sdla4
	 9vRXQWVDmTOESMRV/Muql9J/OV2TGTPrD6bCw/Hn2mP2qlZxem1pj9Zgwpsjcw3i3A
	 R8IzhvcPgNYgCOQcCIG/lCo27j0PK3LyR/ow1VpIF18qbhTrOQHcxZVIzd/cMZB6/r
	 4xFQqFOJ2Qdw5HW09JooKUS1FnFa9R9OPG7JikPGRlPIEHXBPLaR2lqVOck5E9Q4tV
	 go0jkMQB88GNE5tphQ7hHa0FiqR2Tn37BGJrd6jKhSbHPBqCTb9f8ai/wv9FWvnhP7
	 +kr6zqRzenUcQ==
Date: Thu, 24 Sep 2026 19:08:23 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Stian Halseth <stian@itx.no>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf unwind-libdw: Fix reading the stack of a 32-bit task
Message-ID: <arVZBwpMEWw3thzZ@x2>
References: <20260923193432.2489729-1-stian@itx.no>
 <CAP-5=fX2M6ndLGh5GKjiP2eK=tCp_LpE1iVjDH+Nkz5jJVpxqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX2M6ndLGh5GKjiP2eK=tCp_LpE1iVjDH+Nkz5jJVpxqw@mail.gmail.com>

On Wed, Sep 23, 2026 at 01:33:48PM -0700, Ian Rogers wrote:
> On Wed, Sep 23, 2026 at 12:34 PM Stian Halseth <stian@itx.no> wrote:
> >
> > memory_read() hands libdw 8 bytes whatever the sampled task's ABI. For a
> > 32-bit task libdw keeps the low 32 bits (__libdwfl_frame_reg_set()), so
> > on a big-endian machine each word read from the stack or a DSO is the
> > one at addr + 4, and unwinding stops at the first frame restored from
> > the stack. On sparc the 8-byte load from a stack address that is only
> > 4-byte aligned even traps, and perf dies with SIGBUS. Read 4 bytes for a
> > PERF_SAMPLE_REGS_ABI_32 sample.
> >
> > A recording of the other byte order has each sample swapped in 8-byte
> > units when it is read (perf_event__all64_swap()), which leaves the
> > 4-byte words of a 32-bit stack dump reversed and paired up wrongly.
> > Undo the swap of the unit holding the word and swap the word itself, as
> > __evsel__parse_sample() does for PERF_SAMPLE_CPU.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Stian Halseth <stian@itx.no>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
