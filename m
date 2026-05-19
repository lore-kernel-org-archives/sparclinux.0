Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5019ABD8;
	Tue, 19 May 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200535; cv=none; b=Eys/Tda4PsiGzkAVtu53wKURgGI/9v9m1vauQFbnuMUd1zeEir/z3bCq6I0jZVJCK1wnN/omivySxHx/l5+0IQl7kXRytcxwu1qMn3P5sXfRUM/7O9W0EIXcg6v7LC6DassR4g8GAzNjThqk0id/K7v6KBRkWXb7/fZ3480a/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200535; c=relaxed/simple;
	bh=Nj0+fOHrT8gzoSrRvxdofwjdBxWWBmtjb01jCAdP9qY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MS4q+MJR93VGZm3f28pFyrKh0y8AIzLYvSv1FIt1FrG/pMlN5d6SUbRUVaSP7K0NzvjRNxHLhkYM9gAVd4nBAQipH70tHC1xaAefSjbYB+NNRGfR9wCR9J+HQ5lX1ntElmVJzDCOFuWO9lFjQovP4ZIt3+bjWdWT/NzysBWxr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC2F/+7u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC2F/+7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2EEC2BCB8;
	Tue, 19 May 2026 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200535;
	bh=Nj0+fOHrT8gzoSrRvxdofwjdBxWWBmtjb01jCAdP9qY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rC2F/+7uO+8hfWiwmoz0iE0V98UG3QrbpRHPov6WuGQzv1rIvgQDf647O37bclSc8
	 HOcpWUTW7oaoY01syoUBNYSeJJyaFlNnNTgwUuA4HdWT2O2zK8/YP68aQT2ltFd0R0
	 ZDs+qcSWC6o+Jm8cpkzTv9tGW5u6hlQ5ewKmjtIHY7118gVAg0psEsfSizVtp6CG4Q
	 k5m74pG/U20ik+LNlftEsfpcFeu4yKsTWGw24nHHzo2qNOB2wHPz9Ev5BckPBnUIyS
	 o35AK+FlgUCDL98JXGtR3iK7uc3FnQnXmNG6iiSQT/O30l353OlaAGs8jz6nlcBtCa
	 Tzs/8pJAdWsqw==
From: Thomas Gleixner <tglx@kernel.org>
To: Tony Rodriguez <unixpro1970@gmail.com>, davem@davemloft.net,
 sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andreas@gaisler.com,
 thomas.weissschuh@linutronix.de, regressions@lists.linux.dev,
 glaubitz@physik.fu-berlin.de, linux@leemhuis.info,
 torvalds@linux-foundation.org, Tony Rodriguez <unixpro1970@gmail.com>
Subject: Re: [PATCH v2 1/1] sparc64: Fix comparator problem with timer
 interrupts
In-Reply-To: <20260519022421.5978-2-unixpro1970@gmail.com>
References: <20260519022421.5978-1-unixpro1970@gmail.com>
 <20260519022421.5978-2-unixpro1970@gmail.com>
Date: Tue, 19 May 2026 16:22:11 +0200
Message-ID: <878q9fxywc.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 18 2026 at 19:24, Tony Rodriguez wrote:
> On SPARC64 the check:
>
>     return ((long)(new_tick - (orig_tick + adj))) > 0L;
>
> Is safe only if retries make forward progress. The comparator can
> take effect with a latency, so the moment when counter == comparator
> may be missed, which can cause delays or hangs on some SPARC64 systems.
>
> For clarity:
>     exp = orig_tick + adj   /* expected comparator value */
>
> The current check requires new_tick to be strictly greater than exp;
> equality (new_tick == exp) is treated as not yet passed and the caller
> will retry.

That's confusing at best. You really want to explain how the ordering is
similar to what I described in the analysis:

        exp = read_cnt() + delta_ticks;
        write_cmp(exp);
        return (read_cnt() - exp) > 0;

If the counter advanced past the expected expiry time, after writing it,
then the caller will retry, as the calling code does:

     return tick.add_compare(delta_ticks) ? -ETIME : 0;

But it won't do so when the counter is equal, which is causing the
problem.

> By contrast, using:
>
>     return ((long)(new_tick - (orig_tick + adj))) >= 0L;
>
> causes the caller to stop retrying and assume the timer is scheduled;
> both equality and greater-than are accepted (new_tick == exp or
> new_tick > exp).

It's the other way round. When counter >= expiry time, then the write is
considered failed. If the counter has not yet reached expiry time,
i.e. it is smaller, then it assumes the timer is scheduled.

> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>

It would be nice to have a link to the original thread in the change log
itself as that gives people quick access when they are wondering about
this a year down the road.

Thanks,

        tglx
