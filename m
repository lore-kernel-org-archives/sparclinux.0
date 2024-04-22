Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF01F5FD
	for <sparclinux@vger.kernel.org>; Mon, 22 Apr 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796235; cv=none; b=BS84wkcNa6j9ujlPNWRC8Yl8lJfCdjyJohRhRPNZGVjUqmVJumvV1QcSXP1vBOJNbOnNvfgGtDI/x0G2g+FOaiYiL18EHXdXmoR10LCgJcGnD3w5apEbOTRfhOSAxr4HQ5IgOptfdCP3PYrRNIPZE6d/adhl/tXysarIEAFr4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796235; c=relaxed/simple;
	bh=OV7VeNYW3irmBjmL25FIMrDZTOmNWH2zPHGpy0nthr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gyfvxUsby2+ygAlEetBqTmbnU9WcyGJiJXD4SCkjVlCmEHWswUnlOJEor2+CaU3/4+h0Ies8u6Mfb9PSjOqEm/RDC985mS/UeiS0cl98DSPgvFVKwJjPbTwkMH3qwhMQrLlaNkw1WvkEBW1u0Dpni0V/wyeNQugFWbaGTSK4loY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=KfRFvc7z; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="KfRFvc7z"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VNSMk369fz67vh;
	Mon, 22 Apr 2024 16:30:26 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VNSMk0ksXz6823;
	Mon, 22 Apr 2024 16:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1713796226;
	bh=ab1Jv9yBKnXPHFwpLnN8UByUwhmhObq3b9XSNM3fUNI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=KfRFvc7zEJ8qAeQxcWliBKUP6XF5C0ynuNpdiDjKJtFWKk5N+B6OXJkQ7h2+ikeHQ
	 pXv0729A0jolGeXgcYQizM2WMbqvGtuUJr6LolugrxBPxR10ASTKZytckyzIBm5vEu
	 eOUyXBn8cqjbbJTp/4ESlReVCz98/yV03exJMcz4=
Message-ID: <217bf3cb-9baa-42a6-bdc5-39d0b339ab2f@gaisler.com>
Date: Mon, 22 Apr 2024 16:30:25 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc32: Fix version generation failed warnings
To: Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
References: <20240324065622.GA1032122@ravnborg.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240324065622.GA1032122@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-24 07:56, Sam Ravnborg wrote:
> An allmodconfig build of sparc32 resulted in several warnings:
> 
> WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
> Is "empty_zero_page" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.
> Is "__udelay" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.
> Is "__ndelay" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.
> Is "__ashldi3" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.
> Is "__ashrdi3" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.
> Is "__lshrdi3" prototyped in <asm/asm-prototypes.h>?
> 
> And later a lot of warnings like this:
> WARNING: modpost: "__udelay" [kernel/locking/locktorture.ko] has no CRC!
> WARNING: modpost: "__udelay" [kernel/rcu/rcutorture.ko] has no CRC!
> WARNING: modpost: "__udelay" [kernel/rcu/rcuscale.ko] has no CRC!
> WARNING: modpost: "__udelay" [kernel/rcu/refscale.ko] has no CRC!
> WARNING: modpost: "__ndelay" [kernel/rcu/refscale.ko] has no CRC!
> WARNING: modpost: "__udelay" [kernel/time/test_udelay.ko] has no CRC!
> WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
> WARNING: modpost: "__ashrdi3" [fs/quota/quota_tree.ko] has no CRC!
> WARNING: modpost: "__ashldi3" [fs/ext4/ext4.ko] has no CRC!
> 
> The fix was, as hinted, to add missing prototypes to asm-prototypes.h.
> 
> For the __*di3 functions add the prototypes direct to the
> asm-prototypes.h file.
> Some of the symbols were already declared, so pulled in the relevant
> headers (delay.h, pgtable.h).
> The include files was alphabetically sorted to make the list somehow
> readable.
> 
> The .S files exporting the symbols do not include asm-prototypes.h,
> so they need to be explicit rebuild to generate symbol versioning.
> One or more of the generic headers pulled in by asm-prototypes.h
> did not support being used from .S files, so adding asm-prototypes.h
> as an include file was not an option.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
> 
>  arch/sparc/include/asm/asm-prototypes.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
> index 4987c735ff56..08810808ca6d 100644
> --- a/arch/sparc/include/asm/asm-prototypes.h
> +++ b/arch/sparc/include/asm/asm-prototypes.h
> @@ -3,15 +3,18 @@
>   * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
>   */
>  
> -#include <asm/xor.h>
> -#include <asm/checksum.h>
> -#include <asm/trap_block.h>
> +#include <linux/atomic.h>
>  #include <linux/uaccess.h>
> +
>  #include <asm/atomic.h>
> -#include <asm/ftrace.h>
>  #include <asm/cacheflush.h>
> +#include <asm/checksum.h>
> +#include <asm/delay.h>
> +#include <asm/ftrace.h>
>  #include <asm/oplib.h>
> -#include <linux/atomic.h>
> +#include <asm/pgtable.h>
> +#include <asm/trap_block.h>
> +#include <asm/xor.h>
>  
>  void *__memscan_zero(void *, size_t);
>  void *__memscan_generic(void *, int, size_t);
> @@ -23,3 +26,7 @@ void *memcpy(void *dest, const void *src, size_t n);
>  void *memset(void *s, int c, size_t n);
>  typedef int TItype __attribute__((mode(TI)));
>  TItype __multi3(TItype a, TItype b);
> +
> +s64 __ashldi3(s64, int);
> +s64 __lshrdi3(s64, int);
> +s64 __ashrdi3(s64, int);

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas
