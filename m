Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B235C1BD;
	Thu,  3 Sep 2026 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423719; cv=none; b=MkHDyMvg2WEqXn+8y1V7EkeQ+Tg0a1Q2cQmRxJMu24E5vWjjiIXTIsQJvqxxOq+vnHjom0iBga3c9NaU4orsAWL6ycmcbSa9Ub1u1I+bDdeS+k3kJXxc76S5QUvb0+SVhCnz6qOsYIVctVTQseVnmzyMSWgxbfh78XAw76OlByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423719; c=relaxed/simple;
	bh=jjITHw1T26l6KwPui0ZC+QZoQATrnibNgc1ptfQqAb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuPadGj9GSJMfdflsIjjivSbRW3FlGT1HPgVVZpBrUENh0B/VJgwnaDDFCI2ParnK/T7OEhVNX2O6MbuE6KdHj+Q1ya620+W9p1JXLzIyTy+2i2Gyq0oMPgsYCuXjvxySipIwk3/S+NjkbMJVaMRPPiLaU3DtEbMRW/QiaiBM6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKrxZNXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKrxZNXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4170E1F000E9;
	Thu,  3 Sep 2026 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423717;
	bh=0p9MAmMqYQA+pB3vITqVC9F/6eE2jvI8gIptx42Zmls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IKrxZNXHTN0f9gmnSG/t1VXsGHT2QgKcCOBJS0IZ7bMJBjaJf/QTC84q4CilAtIVf
	 3L1sOIKBxl/m266LpzBQITvbyL5pabZyT1RZgvCakcI1Zf0nzxoerhWMe9Q4s72+lb
	 3zRM+gxShR6cic2hBlse2WRIZPsvaL4xY5aslfw05KRNhHaMCO4R5+JK8YPTpbPq7Q
	 Y7LIMc5fw8bkQ6wvpLwML5sVH6VJkSHMJPH4M3TSOQO+VDjfk7253/ikZbWgvyu6sb
	 7nLqyK8JT3eO6niqBQqEuCwwzRlXK2lNuQZqjjPirPijR9x72CIN8YX469mspH2i2v
	 7CZNV3dW0o2ZA==
Date: Thu, 3 Sep 2026 09:21:46 +0100
From: Will Deacon <will@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, bpf@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com, sgrubb@redhat.com,
	oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com,
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
	guoren@kernel.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, davem@davemloft.net,
	andreas@gaisler.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com, tglx@kernel.org,
	peterz@infradead.org, luto@kernel.org
Subject: Re: [PATCH v2 01/13] audit: log all six syscall arguments in the
 SYSCALL record
Message-ID: <apkuGoWQwLJ7AcUC@willie-the-truck>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <b30076994d49fa393251c836b5a57a725f218572.1788351089.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30076994d49fa393251c836b5a57a725f218572.1788351089.git.rrobaina@redhat.com>

On Wed, Sep 02, 2026 at 11:43:34AM -0300, Ricardo Robaina wrote:
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3). The remaining two are captured but silently
> discarded before reaching the audit context. This leads to the
> need for auxiliary records when audit-relevant data lands in the
> 5th or 6th argument of a syscall.
> 
> Extend the SYSCALL record to log all six arguments, by adding
> arguments a4 and a5 (5th and 6th syscall arguments respectively)
> inline within the existing record. Also add the two new args to
> the audit rules switch case, so audit rules can filter on them.
> 
> Rather than plumbing two more register arguments through every
> architecture's syscall entry path, change __audit_syscall_entry()
> to take a pointer to pt_regs and use syscall_get_arguments() to
> retrieve all six arguments.
> 
>  audit-testsuite# make test
>  audit-testsuite# ausearch -i -m SYSCALL
>  ...
>  type=SYSCALL ... syscall=sendto success=yes exit=1088 a0=0x4
>   a1=0x7ffe43518b60 a2=0x440 a3=0x0 a4=7ffe43518b4c a5=c
>  type=SYSCALL ... syscall=openat2 success=yes exit=4 a0=0x3
>   a1=0x7fffc74692c8 a2=0x7fffc7467390 a3=0x18 a4=0 a5=7fffc74674f8
>  type=SYSCALL ... syscall=openat success=yes exit=3 a0=AT_FDCWD
>   a1=0x557ced4141a2 a2=O_RDWR|O_NONBLOCK a3=0x0 a4=0 a5=0
>  ...
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/audit/CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=gqy7dX4Ah11RVhdyCBUQ@mail.gmail.com/T/#t
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/linux/audit.h         | 13 ++++---------
>  include/uapi/linux/audit.h    |  2 ++
>  kernel/audit.h                |  2 +-
>  kernel/auditfilter.c          |  2 ++
>  kernel/auditsc.c              | 19 ++++++++-----------
>  kernel/entry/syscall-common.c |  4 +---
>  6 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 45abb3722d30..9ce5962bc537 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -323,8 +323,7 @@ extern int  audit_alloc(struct task_struct *task);
>  extern void __audit_free(struct task_struct *task);
>  extern void __audit_uring_entry(u8 op);
>  extern void __audit_uring_exit(int success, long code);
> -extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
> -				  unsigned long a2, unsigned long a3);
> +extern void __audit_syscall_entry(int major, struct pt_regs *regs);
>  extern void __audit_syscall_exit(int ret_success, long ret_value);
>  extern void __audit_getname(struct filename *name);
>  extern void __audit_inode(struct filename *name, const struct dentry *dentry,
> @@ -373,12 +372,10 @@ static inline void audit_uring_exit(int success, long code)
>  	if (unlikely(audit_context()))
>  		__audit_uring_exit(success, code);
>  }
> -static inline void audit_syscall_entry(int major, unsigned long a0,
> -				       unsigned long a1, unsigned long a2,
> -				       unsigned long a3)
> +static inline void audit_syscall_entry(int major, struct pt_regs *regs)
>  {
>  	if (unlikely(audit_context()))
> -		__audit_syscall_entry(major, a0, a1, a2, a3);
> +		__audit_syscall_entry(major, regs);
>  }

Won't this (temporarily) break the build? Maybe you need to introduce a
new helper e.g. audit_syscall_entry_regs(), then convert everybody over
to that, then rename it to audit_syscall_entry() at the end to keep the
series bisectable.

Will
