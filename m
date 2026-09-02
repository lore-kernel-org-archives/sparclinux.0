Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390644315A;
	Wed,  2 Sep 2026 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307338; cv=none; b=gLEqxT5alpC0v6yVQD5TQl5NfOTQnmc0Vifvm9BaspW36SPEQ+V+Ss/Evw5dVzITUC93VgAD8sxiWSK3FW4SAfFS6jDl/WZ5s56FoVWQWdDk9RITBKbJ8aYHzDVb9HeV9mhMyL+PKlCijyCBzoloEY4FOgSxBHphfx5G7ry6rc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307338; c=relaxed/simple;
	bh=gLR47n9Lfo8N5ithEwSJjh21gOHVaRUMvms5l7G8BUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFjSGfiecVzQxvVS6ZrG+qq8okUJe32bS11bJhA1Qn/nCAnb6cw9RJHe9UC+4uZBrIybN382c/ugQQtgw6rRKQW5Ak3tq+KJQc3PkmBSQs416tPnj2O/ezlP1Q4VS5ipiYGFIUzIgUBVwedapsYrhPeLgQAeaywx+loh0rgUG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSe1IiVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSe1IiVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18081F000E9;
	Wed,  2 Sep 2026 00:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788307336;
	bh=ov3O+1wTaFg0SVAxfsiOncc723aSi55QuI10cU3OXdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eSe1IiVtoGf8xyRhVAGDsHlkkK4qB6KOtB+1j3Fn//+9mUvfOfd49h1bTlK5DdU3Y
	 B2G+Aj19NQLTOsJOUAPj2GyPvzZQaFt861KiRpeWhBaWwmYMSqGKbgBZvpwZc7ADkx
	 CxR4K04VH+YmRtqOySMErCwYAOXsQ5wCAiAYXw6UTPwjN8v3xjLgvzoSSo0r/nz0+4
	 MyHxfKa3aH2EszfAGzQxVuHTSTAFepAF18UclGAIz5AMKQy74lmeeRFYTzDDkEE0CG
	 bU0AvUkaJHqKVSTCowGhkzLDaaxJ4qXzonxx4s/oIS77Rp0DZ9uxPMg0rgLoUj9OTE
	 DIZtQBcIYCqzw==
Date: Tue, 1 Sep 2026 17:02:16 -0700
From: Kees Cook <kees@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] selftests/seccomp: add sparc64 support
Message-ID: <202609011700.E21C37761@keescook>
References: <20260901220811.3369666-1-stian@itx.no>
 <20260901220811.3369666-3-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901220811.3369666-3-stian@itx.no>

On Wed, Sep 02, 2026 at 12:08:11AM +0200, Stian Halseth wrote:
> sparc64 now selects HAVE_ARCH_SECCOMP_FILTER, so teach seccomp_bpf
> how to read and write its registers: the syscall number lives in %g1
> and the return value in %o0, addressed through the NT_PRSTATUS regset
> (16 u_regs, 16 window registers, then tstate/tpc/tnpc/y).
> 
> Errors are signaled by the carry bit in tstate with a positive errno
> value in %o0, so provide a SYSCALL_RET_SET that maintains both, and
> mark the arch SYSCALL_RET_SET_ON_PTRACE_EXIT since a return value
> poked at entry would be overwritten by the syscall skip path, as on
> powerpc.
> 
> Passes 95 of 95 on an UltraSPARC T4-1 (16 skipped for missing
> optional features such as uprobes).

Thanks for getting the working on sparc! :)

> 
> Link: https://github.com/sparclinux/issues/issues/11
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 0622bc2acad4..30b777f357d8 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1872,6 +1872,41 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  # define ARCH_REGS		struct user_regs_struct
>  # define SYSCALL_NUM(_regs)	(_regs).orig_d0
>  # define SYSCALL_RET(_regs)	(_regs).d0
> +#elif defined(__sparc__) && defined(__arch64__)
> +/*
> + * The NT_PRSTATUS regset: %g0-%g7 and %o0-%o7, the 16 window
> + * registers as read back from the stack, then tstate, tpc, tnpc
> + * and y.
> + */
> +struct sparc64_user_regs {
> +	__u64 u_regs[16];
> +	__u64 window[16];
> +	__u64 tstate;
> +	__u64 tpc;
> +	__u64 tnpc;
> +	__u64 y;
> +};
> +# define ARCH_REGS		struct sparc64_user_regs

Is struct sparc64_user_regs not exported to userspace anywhere? We
haven't normally needed to put the raw user_regs struct definition into
the test before.

But beyond that question, looks good!

-Kees

-- 
Kees Cook
