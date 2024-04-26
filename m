Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175D148FF6
	for <sparclinux@vger.kernel.org>; Fri, 26 Apr 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150382; cv=none; b=d9VEAWot2M38exWOaMjMdIoyF03DEIvXs92JKRqUx3bSKr2U92tI6LRuriWznMuXDeqx3LPg3QMm06iEX8vJ7rGEO5LsJ31UZGIFnnhVyrUD6ybaqCpwD2mdMzVLBfdVURXmb5/DXfSn+0GjA+a+vO7RMU3L5aCVOzE3VNn4Pw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150382; c=relaxed/simple;
	bh=n+swDYlRkep2TFba88JYofx+RK+l7QpKnAUk9GLX/mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S+iZNupDxDxNSAqJbIweqhEpVUbtThDweHS8JZYX38VSSlCFnNtbHbWqqKnhl107ePabXWAG2zRV2cj/wnF+/n3cGmYXfx1H8NjZAmcixhlYiddrshvegK+OezcWjpDgIeH2oNTbkiiyPmv2+5S7iw/v8lUZJsxiY78Fm0QQUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Qt8MYRjE; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Qt8MYRjE"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VQzLJ3sMrz67xt;
	Fri, 26 Apr 2024 18:52:56 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VQzLJ28Xgz680r;
	Fri, 26 Apr 2024 18:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1714150376;
	bh=5uG/+7EO1Njy3ESIewJAJKfHHvLTEwJt9Kjxl9rrUbs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Qt8MYRjEfkVzv/vsE2QESQMLhHj4lwgFKYeCt83foba50xnIv3eCjz1Gi69mEBY66
	 S7yyYjmztg2REjMMKO8P2sQ1h/WsMHwYb/sGn8GP/Y7O6zDbi/7hb4FWP1/RanPRmU
	 afPVdhtrCYEbv0FymW6eJRUXyLagu9mu9LU6/Hh8=
Message-ID: <d2848a93-898b-4122-8a48-1922f4e42db1@gaisler.com>
Date: Fri, 26 Apr 2024 18:52:55 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sparc32: Add support for specifying -mcpu
To: Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@kernel.org>, sparclinux@vger.kernel.org
References: <20231229200604.GA4033529@ravnborg.org>
 <20231229200726.GA4034411@ravnborg.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20231229200726.GA4034411@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-29 21:07, Sam Ravnborg wrote:
> Add support for selecting the CPU architecture.
> The default is leon3 - which is the minimum required as the kernel uses
> CAS instructions.
> 
> Inspired by (from gaisler-buildroot-2023.02-1.0):
>     0001-sparc32-leon-Build-with-mcpu-leon3-for-SPARC_LEON.patch
>     0028-sparc32-leon-Make-what-mcpu-to-be-used-configurable-.patch
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
>  arch/sparc/Kconfig  | 24 ++++++++++++++++++++++++
>  arch/sparc/Makefile | 13 +++++--------
>  2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 1b9cf7f3c500..e94783ceb409 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -161,6 +161,30 @@ config ARCH_SUPPORTS_UPROBES
>  
>  menu "Processor type and features"
>  
> +choice
> +	prompt "LEON architecture"
> +	default SPARC_CPU_LEON3
> +	help
> +	  Select the architecture the kernel shall be built for
> +
> +config SPARC_CPU_LEON3
> +	prompt "LEON 3"

This should rather be bool than prompt...

> +	help
> +	  Build the kernel for the LEON 3 architecture
> +
> +config SPARC_CPU_LEON5
> +	prompt "LEON 5"

...and the same here.

> +	help
> +	  Build the kernel for the LEON 5 architecture
> +
> +config SPARC_CPU_DEFAULT
> +	bool "Toolchain default"
> +	help
> +	  Build the kernel with no -mcpu option, getting the default
> +	  for the toolchain that is being used.
> +
> +endchoice
> +
>  config SMP
>  	bool "Symmetric multi-processing support"
>  	help
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index 5f6035936131..3c3a1fd8c873 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -25,14 +25,11 @@ KBUILD_LDFLAGS := -m elf32_sparc
>  export BITS    := 32
>  UTS_MACHINE    := sparc
>  
> -# We are adding -Wa,-Av8 to KBUILD_CFLAGS to deal with a specs bug in some
> -# versions of gcc.  Some gcc versions won't pass -Av8 to binutils when you
> -# give -mcpu=v8.  This silently worked with older bintutils versions but
> -# does not any more.
> -KBUILD_CFLAGS  += -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
> -KBUILD_CFLAGS  += -Wa,-Av8
> -
> -KBUILD_AFLAGS  += -m32 -Wa,-Av8
> +cpuflags-$(CONFIG_SPARC_CPU_LEON3)	:= -mcpu=leon3
> +cpuflags-$(CONFIG_SPARC_CPU_LEON5)	:= -mcpu=leon5
> +
> +KBUILD_CFLAGS  += -m32 $(cpuflags-y) -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
> +KBUILD_AFLAGS  += -m32 $(cpuflags-y)
>  
>  else
>  #####

As said in the sunset thread, more vetting is needed from my side, so no
need to respin this series yet.

Thanks,
Andreas
