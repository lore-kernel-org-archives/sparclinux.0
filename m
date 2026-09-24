Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473404AEBE5;
	Thu, 24 Sep 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269881; cv=none; b=r8TJUWYWT2BytGmfrk46s9pFv1MQrQWRzJHRM1H4+1EOZ2IMiZRi95JkbmW/pfEwe5tDtVuumgaBqb93yhB+pYtPxViRF/LSHGKdjHM5UDTle1tVcYp3HdcwLKPT24QjehjVKGD5JUWi+9v9wubjKJG2Modg8A7z9fAS6/5l3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269881; c=relaxed/simple;
	bh=a8o8R2K4xz7+aGVEIIII3Nv0KLBqdjr8eibmf2YyP6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSMShI3WGrfE5PaFMtapEonNGByG2sJEFQY5PqPKnT8AY3EacL8HYs4jAeHxOcuUibTQzi5dPh/fmVaWZ0JvVlft3QUoNwVze4ysvHjLdxnRjpnTRtNoFFHhvRiyGEkCJEt2vQoXPN/WnndEmS7eYZHO+H6EUAAPGGRs3UcsGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyMRh3Q7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyMRh3Q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FB81F00893;
	Thu, 24 Sep 2026 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269880;
	bh=ZWdVAk49LuLPxvSLCIdjvGkb/oHKHD0hXvWre6vT2+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UyMRh3Q7mBVL3rEFjtCvyDTZYKqtB5p1FWJlA8fl0gRYRKwjuSquQafnLJVYfDHUt
	 KylhZbU2mye3IAqwDCCCEZOWpcXRAFEyYWS5BQkysMPUjlPVduySHuY3VtU+YoCGxR
	 i6l9+QkkG91AfXuMfh65Zo8MYTHN1x2J+06gSYiefHXsyeKT+apusTQwn0a386K+Pl
	 /EHX3mmvoe9lF8desd0H5C91Z0c/74+nk3IT0Z38Lis5SQPAZGwXiIYcyKFFHG+5Wp
	 kAOeLvca+rpAi4FBQXEIP4ntTo4+O7S1meknWyLV4YguTcXsK7iIS6wfvlhwW7/tTT
	 WmdOosTdLEA4Q==
Date: Thu, 24 Sep 2026 19:11:17 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Stian Halseth <stian@itx.no>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/3] perf: sparc64 user regs and stack dump, with
 arch hooks
Message-ID: <arVZtcrJRRxI6jYd@x2>
References: <20260923090429.2026529-1-stian@itx.no>
 <CAP-5=fW4bzmy5_6a-8YucOy7JGKg+izRbq+7TaOGKV5aG0oYcw@mail.gmail.com>
 <4927bb40f34ec6d3d5591dabba755452bd6b4a39.camel@itx.no>
 <CAP-5=fWhk8Z22+PhFKbatO6fYgiNBgLGwVgg_NxS8fg=uEdDUw@mail.gmail.com>
 <arVZZCidUqSnIg7u@x2>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arVZZCidUqSnIg7u@x2>

On Thu, Sep 24, 2026 at 07:09:58PM +0200, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 23, 2026 at 02:16:49PM -0700, Ian Rogers wrote:
> > On Wed, Sep 23, 2026 at 1:57 PM Stian Halseth <stian@itx.no> wrote:
> > I think we have everything we need but the kernel changes are really
> > up to Peter and Ingo, and the tool changes are up to Arnaldo and
> > Namhyung.
 
> Exactly, as soon as the kernel changes land in a path to upstream, I can
> do the same for the tooling bits.

Once that happens, please resubmit just the tools patches without an RFC
in the subject line.

- Arnaldo
