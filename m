Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551E143C67
	for <sparclinux@vger.kernel.org>; Fri, 23 Feb 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712882; cv=none; b=KDLY1SFCrFVGpd8AOEHxh4QZoRQ2Y1Iy8DnoZcbaHp6OWZ3GTYb5ybZ5UcJS7Vt4PyyqsC4ZC+MzhnqDvj8tkapacSZMdIl9OimJWUxUNI3i0LrT2vWNRtM7nKRmcPsv+jSxs4ujjIiAzYimqtiYP4S8gZgCaAa0w4XXNMd4e3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712882; c=relaxed/simple;
	bh=D1QGXZw6sUZ778PeZk9AsWl7LhHjAPoaCloTBO103w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruDd7X3BDa5OEO44DEiA/jPO9BLeAK/Trjs181JIRPfSJ//QpuugSnF4H14mxKAZETVIFj7e66dF1Q11e7e3+cCLxVxc+U6rRfk+M80zYBCum/99nWC1VONP35c7FPkNvfEYm88ENO1vgZpSPSP6TKMHqnFOwoMhkyQS3orMtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=uiEBRAvj; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=oLwsR/0C; arc=none smtp.client-ip=46.30.211.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="uiEBRAvj";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="oLwsR/0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=B6EjNaWdiktqEuLncaKVE82jxx+NKh1TlSMryRmLWUA=;
	b=uiEBRAvjxOsaJwk90DFlIOWSmTME7MH4GDlWu5J/vG1Okq9cmza6UGoBlXeNS3sLDcVsBLxHAADjD
	 e2ZxhAQj4u0cQOdBAuCjB6Un0IEmUZDOm8lciiu7GhoQvittFnnYTZZN1nqSLQaJvZDcEo/XsU/EeY
	 9jhdNMSD8/Nidu4uaxLuUdRBrtF1MI6JyOCLP+iLcglu6K+1WpQxA+E3YZZHzkGjCfZA9JD+RRUDeg
	 riAheo4PZlQzGtOdPfZ+6di84OcIaib+qjrbHiHIUBXxppG+GEZlylwj1TymX1asVXMUKAVI6/fFoN
	 eK84IcYM75uHLBRpWw/gbRdBjFQF/gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=B6EjNaWdiktqEuLncaKVE82jxx+NKh1TlSMryRmLWUA=;
	b=oLwsR/0Cr6RWTYv5L83UN2z/haUi/To0reQmcJ4qbMung9oH9COqad2IyStuvbuQoBprzANSv0l3C
	 CW/4520DQ==
X-HalOne-ID: 19483c2d-d279-11ee-ad41-657a30c718c6
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 19483c2d-d279-11ee-ad41-657a30c718c6;
	Fri, 23 Feb 2024 18:26:47 +0000 (UTC)
Date: Fri, 23 Feb 2024 19:26:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Helge Deller <deller@gmx.de>, Guo Ren <guoren@kernel.org>,
	sparclinux@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: vdso: Disable UBSAN instrumentation
Message-ID: <20240223182646.GA2825372@ravnborg.org>
References: <20240223165942.work.950-kees@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223165942.work.950-kees@kernel.org>

Hi Kees,

On Fri, Feb 23, 2024 at 08:59:45AM -0800, Kees Cook wrote:
> The UBSAN instrumentation cannot work in the vDSO since it is executing
> in userspace, so disable it in the Makefile. Fixes the build failures
> such as:
> 
> arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/vdso/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 7f5eedf1f5e0..e8aef2c8ae99 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -2,6 +2,7 @@
>  #
>  # Building vDSO images for sparc.
>  #
> +UBSAN_SANITIZE := n

When I read:

config UBSAN_SANITIZE_ALL
        bool "Enable instrumentation for the entire kernel"
        depends on ARCH_HAS_UBSAN_SANITIZE_ALL
        default y
        help
          This option activates instrumentation for the entire kernel.
          If you don't enable this option, you have to explicitly specify
          UBSAN_SANITIZE := y for the files/directories you want to check for UB.
          Enabling this option will get kernel image size increased
          significantly.


I am left with the understanding that only arch's that
selects ARCH_HAS_UBSAN_SANITIZE_ALL would need to turn off
UBSAN_SANITIZE.

Are this fix papering over some other bug where we enable
UBSAN_SANITIZE_ALL for arch's that should not have it,
or something else that enable it?

	Sam

