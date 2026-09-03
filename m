Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD03FF89B;
	Thu,  3 Sep 2026 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423746; cv=none; b=lO7toLs1ztnw5LjZagUUbz+ZrwSX/77JsW3hhSMVqmMERCjqtFX7+Wo1VzEbOv8HL/kEKYTroZ3gfOgvkDE+gt5Ohhn+DzOSA63cUp4EwvLs6y+uEoXgWikAoJAXgf4pedXaJ8En4egucNmJiUGsRO1LSRvehU28ibQfgrhZ4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423746; c=relaxed/simple;
	bh=aO8dKl9aCr0LrKTNXqntAwzQEzpx1Jyx7f2kERAhd48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV0QPYLnIMNCpoRwXmDIINXMalzASmwLTA8V3MpBdsYYI07Fi1Gh2T0yNyDwbkvuQeYAME1L6dZDZe3d331AYAzfpnHYWlCfYJdIiHxaX4JY5w/UFMw9n/THBpn5giXIxqdXgABXzOt2et4UtDtnwdibzAhhWhwuheNQYvXZxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq9cd/CT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq9cd/CT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF2F1F00A3A;
	Thu,  3 Sep 2026 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423744;
	bh=sd6gEu45kL7QVkA3QJVyGVItKAS2nyT21y+/hoFhCyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gq9cd/CTw4krLSlM6xfxyByPn+d9o9AHDucF1BZ0uIAQoLLXP39WKotfWt+0vaOQ2
	 nzQAl7UFgXIDhuCtbKhGZ2nkN0XaOElgOmruowZVAczze7sgMMBMDKCY5/qwCsA2c0
	 VFrIYsi+TpXhPCv2Diwq2ZCkVH7vfOEZ92b/obiZ2EFvXnWRD9/RVQdBDgIWwWzXtV
	 yk2671K9lffJrRZ7mLsndIGYpdD6nZMEAsaNsvdbucN49dU6JsmXDkLhuZ9tu+FURd
	 Z0mdSO4fmgk0AE6pEWzHv5TZ915nDk5byuw9kIqq75tr/yAM6xKWlHa9jkCXEGVb+6
	 f3W8Rp2Nt6rdw==
Date: Thu, 3 Sep 2026 09:22:14 +0100
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
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
Message-ID: <apkuNj1paR_GO3x9@willie-the-truck>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>

On Wed, Sep 02, 2026 at 11:43:37AM -0300, Ricardo Robaina wrote:
> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  arch/arm64/kernel/ptrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index f743cbec1c3a..65532b2a8cd4 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, regs->syscallno);
>  
> -	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> -			    regs->regs[2], regs->regs[3]);
> +	audit_syscall_entry(regs->syscallno, regs);

Acked-by: Will Deacon <will@kernel.org>

Thanks for doing this.

Will
