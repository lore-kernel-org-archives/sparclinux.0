Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21613D897;
	Fri, 17 Jan 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127715; cv=none; b=JjfcBpHWUDjjzn1HqD2lf3CnoU0Nd7ZEIratwuDnpHowfYbxd0vr2rXUjbqObQskEHAbjGfDkg/Y4HB4TpG08lIblGz8EJ07ecCpvX2yFcrssItZyDbnVtxQTdhrMq8++y1asSFlfNigGw6Ka1Js3ldiLjNXDl1IA9NSdMFJlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127715; c=relaxed/simple;
	bh=+j/IzZdIZesq5jLwNEKx8fNE0J5BBI7tpoXLfzpq1mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdGJunpV2K5R7c2DWSVIfR6ujXZjywDyUaFMu5H8+gH4M1SbXHsmw0iOlp/dfoy3NPa5iPWv3sDc6JzZ0O7hISicp3xuhEl60JhSY/QgywHkZvroSTN2zfM3IxT9D9TUOFMJCrpJ2sLqa745adguQkq80l885DdSn2+UVwBe05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=aLru6iVI; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="aLru6iVI"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YZNt63Wjwz1DHYW;
	Fri, 17 Jan 2025 16:28:30 +0100 (CET)
Received: from [10.10.15.35] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YZNt61frFz1DDhC;
	Fri, 17 Jan 2025 16:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1737127710;
	bh=OsvONSh+tqrWq1Jz7smmogxeCQdXrlHeW74z46aaRYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aLru6iVIuurTAMyM5iD6UgiCsc8oB0GD5XFaRxMVcGKggjIN1hHlcEHrf6kX7rsx3
	 NNcGXH7mI9mJgolxR1DdNN5QKvJdyOwSsOAuieywHGfVGfgxRUK/Ay4gc+Gtt5UcOU
	 LBf6TSXFf2ds5EDicmMUzuterRYjeYl7B0X4P60s=
Message-ID: <69e24f81-c9fd-4815-b803-c6d094b84e9d@gaisler.com>
Date: Fri, 17 Jan 2025 16:28:29 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] sparc/irq: use seq_put_decimal_ull_width() for
 decimal values
To: David Wang <00107082@163.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20241108161123.9637-1-00107082@163.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20241108161123.9637-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-08 17:11, David Wang wrote:
> Performance improvement for reading /proc/interrupts on arch sparc
> 
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  arch/sparc/kernel/irq_32.c | 12 ++++++------
>  arch/sparc/kernel/irq_64.c |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
> index 8605dd710f3c..5210991429d5 100644
> --- a/arch/sparc/kernel/irq_32.c
> +++ b/arch/sparc/kernel/irq_32.c
> @@ -199,18 +199,18 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  	int j;
>  
>  #ifdef CONFIG_SMP
> -	seq_printf(p, "RES: ");
> +	seq_printf(p, "RES:");
>  	for_each_online_cpu(j)
> -		seq_printf(p, "%10u ", cpu_data(j).irq_resched_count);
> +		seq_put_decimal_ull_width(p, " ", cpu_data(j).irq_resched_count, 10);
>  	seq_printf(p, "     IPI rescheduling interrupts\n");
> -	seq_printf(p, "CAL: ");
> +	seq_printf(p, "CAL:");
>  	for_each_online_cpu(j)
> -		seq_printf(p, "%10u ", cpu_data(j).irq_call_count);
> +		seq_put_decimal_ull_width(p, " ", cpu_data(j).irq_call_count, 10);
>  	seq_printf(p, "     IPI function call interrupts\n");
>  #endif
> -	seq_printf(p, "NMI: ");
> +	seq_printf(p, "NMI:");
>  	for_each_online_cpu(j)
> -		seq_printf(p, "%10u ", cpu_data(j).counter);
> +		seq_put_decimal_ull_width(p, " ", cpu_data(j).counter, 10);
>  	seq_printf(p, "     Non-maskable interrupts\n");
>  	return 0;
>  }
> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
> index 01ee800efde3..9ab6e79b617b 100644
> --- a/arch/sparc/kernel/irq_64.c
> +++ b/arch/sparc/kernel/irq_64.c
> @@ -304,9 +304,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  {
>  	int j;
>  
> -	seq_printf(p, "NMI: ");
> +	seq_printf(p, "NMI:");
>  	for_each_online_cpu(j)
> -		seq_printf(p, "%10u ", cpu_data(j).__nmi_count);
> +		seq_put_decimal_ull_width(p, " ", cpu_data(j).__nmi_count, 10);
>  	seq_printf(p, "     Non-maskable interrupts\n");
>  	return 0;
>  }

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas
