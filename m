Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D53659FB;
	Fri, 14 Aug 2026 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696848; cv=none; b=KuYBWsvkPhULybWE/UJYIGlORT3JfHcVp/AsD5m7bRIa79HQ4kj6HUBKCeTbkb2UR7o9eV3bs+48/kfvfjhHaItwSh4BToV+y9VVTVsX5JPW/Bt5DbBWmtISr0EGprCeN3xmFM3R38VCIswipIfyAmc30EaCWhBOljBe5BRidmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696848; c=relaxed/simple;
	bh=vuyEOZezIe8j3IIiejI9b2lnmYaV4Pp6o/h//bkrwgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMmLSUUJz0qbq9IfhHKxfde9daYjDH74YOS1HQSbeaAb0HXWKlWeNpjdj0gNlcO/i4S7v8dO5DTu2bNl42qV9WPyPlgCl0couCrRLwq6ElURHp/ZRdJraraFcXyCJ6rR0ddByFydi/r+ezuA3ScsEtCpUq0ftJ/m6RyYT4Ya4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM16Mf85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM16Mf85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41881F000E9;
	Fri, 14 Aug 2026 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786696832;
	bh=ts3OQ3CDgVCUAfMfHv4o220aVGh37gfNtGvw/u6SvTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hM16Mf85mgC/Qtx63cwHwSlhdwmibQneXxkss9nozdQ9jCucf+ThUePxzU1MdY0uv
	 ImunJTjJjx4fNvym3BanCyDxSQ4YX5pl6xt/LW/x88OCf171Il5QH87Qs76TZTbgG4
	 DIl3DWBmf78B/Ntganv/j5Sg5BJ1afi7EkkfqYcfmq4SDwRw9OD6yA3FmarPvFppd0
	 rXd8xAdrUkpAbSubb9b/8BLlKFHVYEVICbM2RgRP1Mqn+VEEkilH8TIRdT0b9sNL15
	 YfTRkG/XDhh22yudn2vyBScQk1qAbeygitXVpRiWAY+ICbgI/u5EbUKTy9Hgoqzg9A
	 UOzTfV3mk1Xpw==
Date: Fri, 14 Aug 2026 09:40:22 +0100
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
Subject: Re: [PATCH 00/13] audit: log all six syscall arguments in the
 SYSCALL record
Message-ID: <an7Udt-luZfJO71U@willie-the-truck>
References: <cover.1786626275.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>

On Thu, Aug 13, 2026 at 02:02:50PM -0300, Ricardo Robaina wrote:
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3), silently discarding the remaining two. This
> leads to the need for auxiliary records when audit-relevant
> data lands in the 5th or 6th argument of a syscall.
> 
> This series extends the SYSCALL record to log all six arguments,
> by adding arguments a4 and a5 inline within the existing record.
> 
> The audit testsuite runs successfully:
> 
>  # make test
>  make -C tests test
>  chmod +x */test
>  Running as   user    root
>         with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>         on   system  Fedora
> 
>  amcast_joinpart/test ................. ok   
>  backlog_wait_time_actual_reset/test .. ok   
>  bpf/test ............................. ok   
>  coredump/test ........................ ok   
>  exec_execve/test ..................... ok   
>  exec_name/test ....................... ok     
>  fanotify/test ........................ ok   
>  field_compare/test ................... ok     
>  file_create/test ..................... ok   
>  file_delete/test ..................... ok   
>  file_permission/test ................. ok   
>  file_rename/test ..................... ok   
>  filter_device/test ................... ok     
>  filter_exclude/test .................. ok     
>  filter_exit/test ..................... ok   
>  filter_inode/test .................... ok   
>  filter_saddr_fam/test ................ ok   
>  filter_sessionid/test ................ ok   
>  io_uring/test ........................ ok   
>  login_tty/test ....................... ok   
>  lost_reset/test ...................... ok   
>  netfilter_pkt/test ................... ok     
>  signal/test .......................... ok   
>  syscalls_file/test ................... ok   
>  syscall_module/test .................. ok   
>  syscall_socketcall/test .............. ok   
>  time_change/test ..................... ok     
>  user_msg/test ........................ ok   
>  All tests successful.
>  Result: PASS
> 
> Ricardo Robaina (13):
>   audit: log all six syscall arguments in the SYSCALL record
>   alpha: pass all six syscall args to audit_syscall_entry()
>   arm: pass all six syscall args to audit_syscall_entry()
>   arm64: pass all six syscall args to audit_syscall_entry()
>   csky: pass all six syscall args to audit_syscall_entry()
>   microblaze: pass all six syscall args to audit_syscall_entry()
>   mips: pass all six syscall args to audit_syscall_entry()
>   openrisc: pass all six syscall args to audit_syscall_entry()
>   parisc: pass all six syscall args to audit_syscall_entry()
>   sh: pass all six syscall args to audit_syscall_entry()
>   sparc64: pass all six syscall args to audit_syscall_entry()
>   um: pass all six syscall args to audit_syscall_entry()
>   xtensa: pass all six syscall args to audit_syscall_entry()

Could audit make use of syscall_get_arguments() instead?

Will
