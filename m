Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538B3D9665;
	Thu, 24 Sep 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269800; cv=none; b=dMcrfK0RQhkT/nmv5MUshIrcK8Ksc15O3NYw22SB0qywNxHUk2kq4ruOtPQUO7HBUedm+PJ7BkDlHqGuo+TWZ2BpM83xAxmnB5x8abafUl4DoRTIpdtXiI3vozRY2k8OcPqoTljIOkDLAzJFE4JkqOxcU/orUY4j7AnsmS50QC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269800; c=relaxed/simple;
	bh=XTqaO9MrJ/IvZRYs4uzLv5veDPlD2xKflY5/ApelDA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHLn9YzjM06Efd40lIgSrxq01AzO4xjydBZjvHwWn41hAv21WWOIb2iU0PBDRsDw674Y/AqWvcf6fYDOY5DtJAMZMv3GRh8XgplYEldpWNmmoAwqp7toUqXPsZe3RTSC+QNJTwVmq63lDDbg0Qiujawk034ae+pPxNFte7fCcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIYvBYM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIYvBYM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A91F000FF;
	Thu, 24 Sep 2026 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269798;
	bh=3BBAbR054arD3ru3ZfA5MXSP3f4EpL7YgDzUT/PAMvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bIYvBYM5/zR85IZ7yxSSOmlwQFy5gftzsHRSmtIE8/EY952DZ3RtSlYh4qXosPmKO
	 5W+6N3UxT/CLzF2Tksi13KisXCrJACutg84cRsHQ0rrJ30ywWWubioEl0hdQTVPeN/
	 mNy6/R8cu3T0kxbzaOkaRmfLpxWu11zFjj84/wRQuh7fFxqKlZ3T/y/DhfbGu/56P0
	 Rtj2AquWMuBUgL55Er133ETh61HxXf0yBDc87hNbuenBBigsEVgZ0Div4zgdraGTdN
	 5oCnp+PhDDgjIOHJ2dScGIHxXngGZgWYQ7oFDlWh/LnyxMTRLT/6n7to5wkG6jBGTz
	 8XWuPE+Ke2mzw==
Date: Thu, 24 Sep 2026 19:09:56 +0200
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
Message-ID: <arVZZCidUqSnIg7u@x2>
References: <20260923090429.2026529-1-stian@itx.no>
 <CAP-5=fW4bzmy5_6a-8YucOy7JGKg+izRbq+7TaOGKV5aG0oYcw@mail.gmail.com>
 <4927bb40f34ec6d3d5591dabba755452bd6b4a39.camel@itx.no>
 <CAP-5=fWhk8Z22+PhFKbatO6fYgiNBgLGwVgg_NxS8fg=uEdDUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWhk8Z22+PhFKbatO6fYgiNBgLGwVgg_NxS8fg=uEdDUw@mail.gmail.com>

On Wed, Sep 23, 2026 at 02:16:49PM -0700, Ian Rogers wrote:
> On Wed, Sep 23, 2026 at 1:57 PM Stian Halseth <stian@itx.no> wrote:
> >
> > Hi Ian,
> >
> > On Wed, 2026-09-23 at 13:38 -0700, Ian Rogers wrote:
> > >
> > >
> > > For the series:
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> >
> > Since this series is still marked RFC, should I resend it as a regular
> > PATCH v4 with your Reviewed-by, or wait for additional maintainer
> > feedback?
> >
> > And thank you so much for the reviews!
> 
> I think we have everything we need but the kernel changes are really
> up to Peter and Ingo, and the tool changes are up to Arnaldo and
> Namhyung.

Exactly, as soon as the kernel changes land in a path to upstream, I can
do the same for the tooling bits.

Cheers,

- Arnaldo
