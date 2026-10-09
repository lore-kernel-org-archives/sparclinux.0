Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E11478E52;
	Fri,  9 Oct 2026 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531307; cv=none; b=i5JNL25cL4LKr0+9AXUCwaORKunrBn0BvH0h/0hKFGZK8urgABjCyC3/V60gQNtZ52oZTEkydg+b3cuvRyHhNhuAxBWPlWeqaYWE9z+YxwsJHvNjVstPzQ9gOKbCRokJi8SKVDNqc2Xw+A09KMK5qNEpTo9yDDydMqXzMULyfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531307; c=relaxed/simple;
	bh=zqxsH3nZSSvmGRcc7mxXXPlZIDXNgbyoD/HUBKidQjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCrk6X3TtRQfXOhhhQ2a7DGWwKIcrIFB2xFcc8c5bAkuR0BUixoFvgSh9DfzX/PgFm96CUzATMt0aHoKxQZdHswvs5ZvaLoOoiKtLhyWSik/qQREgPKszleaJg5RTwFQ1oAHJr4D9RsNTGHBlOaojSTJ5MALLRwNn3EhEeBA+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adDC93Mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adDC93Mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2CC1F000FF;
	Fri,  9 Oct 2026 07:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531306;
	bh=NWNrPugntBWj1Qo2Ell8SFle+IOobBDdqaXoAnqYkDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=adDC93Mmch6yIYtPTtCsjtKsIYWgAA16ZAD9P0Y/IdR88lMtGT1/ZEUHg4x4vpRGg
	 8LjwWdHUXcbuZYnYs9zzTJvY1VeHdIwYmkZoR3NxQhke2e7KGusVh144j+WGrrRxbS
	 0I6N5/kByf978LLQThs1XSV/c2hFgzBslyGPXGBE+5W5oQhE8RXsYijRkQKstTck/H
	 ayfMYRILLIh5Nk7aytPWXThHehVfIo04sLrUgwayMK9/x7Fjkp2p73A62Bn+k6DWax
	 gM3/iC6fKBnAZ7Iv/U9woWsshOCs9kySu4OimPCTiRnHVlRJwB6iTShSvS12f5BHLW
	 RLejfCx0joGBg==
Date: Fri, 9 Oct 2026 00:35:06 -0700
From: Kees Cook <kees@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v2 2/2] selftests/seccomp: add sparc64 support
Message-ID: <202610090034.BD0FB41CB@keescook>
References: <20260902072745.3412940-1-stian@itx.no>
 <20260902072745.3412940-3-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902072745.3412940-3-stian@itx.no>

On Wed, Sep 02, 2026 at 09:27:45AM +0200, Stian Halseth wrote:
> sparc64 now selects HAVE_ARCH_SECCOMP_FILTER, so teach seccomp_bpf
> how to read and write its registers: the syscall number lives in %g1
> and the return value in %o0.  The NT_PRSTATUS regset appends the
> register window read back from the tracee's stack and has no exported
> layout, so use the sparc-specific PTRACE_GETREGS64/PTRACE_SETREGS64
> requests instead, which transfer the uapi struct pt_regs directly.
> 
> Errors are signaled by the carry bit in tstate with a positive errno
> value in %o0, so provide a SYSCALL_RET_SET that maintains both, and
> mark the arch SYSCALL_RET_SET_ON_PTRACE_EXIT since a return value
> poked at entry would be overwritten by the syscall skip path, as on
> powerpc.
> 
> Passes 95 of 95 on an UltraSPARC T4-1 (16 skipped for missing
> optional features such as uprobes).
> 
> Link: https://github.com/sparclinux/issues/issues/11
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> v2: use PTRACE_GETREGS64/PTRACE_SETREGS64 and the uapi struct pt_regs
>     instead of a locally defined NT_PRSTATUS regset layout, as
>     suggested by Kees Cook. Note the historical %g0 omission in that
>     layout, which shifts the u_regs indices by one.

Thanks for this cleanup!

Yes, please feel free to take this through your tree.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook
