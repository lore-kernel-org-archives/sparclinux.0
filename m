Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F6189B86;
	Fri, 17 Jan 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126657; cv=none; b=UOJP2aKKcRivC9LmdTPrTDgz94sZbkuphLxXGbXOLBqreAkurXlKG9YxGm04JdMraAucM0hFB7zRbm1gUYo0p4FbwyZwngy+a3L+eiKT9E0v+jLti+UuXsnEkG22fokIQlntsoisUbhJuihbO2vCu1sOl/3YkhFAVHE52peNeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126657; c=relaxed/simple;
	bh=kHt1mrKT4Cfsf8pgf3N1T/Snea2jVzup1RGOTeAba4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Poyl8D6CjC9pJJWFuzCj+1MBGCUlB9gaeD6V+59CnJl9pfHsixWrV02ko/yKkFArb5SjQGXDiulRRIOUZacunJQGwPOThL+hivIySW+w0WrIdNc6gNAbm+W50Ow9tJlmg0MqYOi0Vn8P2Hyl3Q+HIW2rlTPryEZg5rM3/rYQGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Wa1JMIGg; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Wa1JMIGg"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YZNTl1Qf4z1DDhC;
	Fri, 17 Jan 2025 16:10:51 +0100 (CET)
Received: from [10.10.15.35] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YZNTk5kL2z1DHbm;
	Fri, 17 Jan 2025 16:10:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1737126651;
	bh=ydAiVbpt2jgjFRz1ihLMdvY/hdc8amlQcApFBkksLco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Wa1JMIGg4N2JMKplr3rniB1dGZJmq0ojuad0g9qXhu6Zpu8yoss0EsnulULJnx2rZ
	 wPRlnUWocHQS02mSy3wkCo2q8y+M2fuX+qUv7SAyevnjCms1wVYGfDSTuIygN011s1
	 T+uOpPi0tzyim6Hlrs5fD0NLHzqfsHsMCIMcYbcU=
Message-ID: <19acced3-1935-4eb0-9410-e19bd4196f5a@gaisler.com>
Date: Fri, 17 Jan 2025 16:10:50 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/irq: Use str_enabled_disabled() helper function
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas
 <bhelgaas@google.com>, Dawei Li <dawei.li@shingroup.cn>,
 Sam Ravnborg <sam@ravnborg.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250115090344.918290-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250115090344.918290-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-15 10:03, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/sparc/kernel/irq_64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
> index 01ee800efde3..aff0d24f8c6f 100644
> --- a/arch/sparc/kernel/irq_64.c
> +++ b/arch/sparc/kernel/irq_64.c
> @@ -22,6 +22,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/ftrace.h>
>  #include <linux/irq.h>
> +#include <linux/string_choices.h>
>  
>  #include <asm/ptrace.h>
>  #include <asm/processor.h>
> @@ -170,7 +171,7 @@ static void __init irq_init_hv(void)
>  
>  	pr_info("SUN4V: Using IRQ API major %d, cookie only virqs %s\n",
>  		hv_irq_version,
> -		sun4v_cookie_only_virqs() ? "enabled" : "disabled");
> +		str_enabled_disabled(sun4v_cookie_only_virqs()));
>  }
>  
>  /* This function is for the timer interrupt.*/

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

