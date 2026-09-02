Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31E4ACC92;
	Wed,  2 Sep 2026 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368740; cv=none; b=hCEdwXEj1OCLddjprmhbDz+QaNvMFWn5Fi2s6OnXIpjlWIchzhLrWuwZE3MyZjRKLMP/bfVsj/tTSSt7K7rgmQCchh/CGmCeKFqcKWYZk0hOnpMVNL3S0xG7HWyLfmari9OpqcICwERowZK5VXJimm5tQxMeRTQ049GIbsuM32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368740; c=relaxed/simple;
	bh=Fq3alcNz2zZyFZW1oE90k5toLReb4c0YdTnwRiDWGIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBVPSj7SbVeRcFDN7aN2cQiiUk5/sMHSl8K9nVBcYMyeigHbu0BbNQDTX/E6BkWqsjE67MjZ3+lXfZEt+io80FDpxnlq4jh6fmUtbi3/qwKV6aJrzOECcLleEcvtuk6Ze0YX9YhoeuE9oLhSBpZLSq2MUk7j71P0FCYfGJsFxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QnkElQZg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnkElQZg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GYSucsbC9T3wMbj4cbfwLizGeJpBjh0QW5Tk4uOM13M=; b=QnkElQZg9eNKJKc/QXu0FFAlBx
	yzK8nT+NmTd+NI5P2phRDDlvGM2vHS3yjhks84RMzMD/OHBGL/MjSifPRIZIyAuvi/C0FDQrq82Dg
	dyiQHf4FKdp7aFUs5rnlG6YUmiimxL6k6lA8BCVT2x9RiLGES1mvtLDNfscA9xblRuIIfPlOmSKQ1
	ukObAe0z0LF1OiKtF1IFZ6iKvuPubZu67xZg/YpZmDijW3BpbG78/i6LfMjKsv6K9OKtz97fU4sVj
	Sh/RCkhCtkXAcEx44LEnqZDelFClEmTsCoe+06S/FL/GXpWYjfTO6jSZSIrDmuNdKr/jdvJbvKwzV
	2uYs3pZA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oP1-0000000FO8L-08DK;
	Wed, 02 Sep 2026 17:05:35 +0000
Message-ID: <e79a472d-3e7e-4d9f-bf85-b3c1d5bc14c7@infradead.org>
Date: Wed, 2 Sep 2026 10:05:34 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc: NMI: Remove obsolete comment
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902113009.684977-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260902113009.684977-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 4:30 AM, Manuel Ebner wrote:
> OProfile has been discontinued as of commit 24880bef417f ("oprofile-removal")
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
> Bhaskar Chowdhury review doesn't show up in the mailing list, but I got it.
> 
> [v2]
>  fixed referenced commit
>  + Suggested-by
>  + Reviewed-by
> 
> [v1]
>  https://lore.kernel.org/all/20260830125506.632168-2-manuelebnerli@mailbox.org/
> 
> prior discussion
>  https://lore.kernel.org/all/875527abdf9df0393ade872c6df3612ae9945b44.camel@mailbox.org/
> ---
>  arch/sparc/kernel/nmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
> index 149adc094..1571d6298 100644
> --- a/arch/sparc/kernel/nmi.c
> +++ b/arch/sparc/kernel/nmi.c
> @@ -41,7 +41,7 @@ static int panic_on_timeout;
>   * <0: the NMI watchdog has not been set up, and cannot be enabled
>   *  0: the NMI watchdog is disabled, but can be enabled
>   */
> -atomic_t nmi_active = ATOMIC_INIT(0);		/* oprofile uses this */
> +atomic_t nmi_active = ATOMIC_INIT(0);
>  EXPORT_SYMBOL(nmi_active);
>  static int nmi_init_done;
>  static unsigned int nmi_hz = HZ;

-- 
~Randy
