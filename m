Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED515B992;
	Tue,  7 May 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086631; cv=none; b=nrqmlh68XP4Gipu4Rb3nSKQjV+ZP6OvbeNgWZl3DAhz26oKmDQkLzT+WTh/a1pZyPS5Jp1eOa1kcYzoM+iuRvUkExixuisYvMIvZ7zRKx7+Z0rRQkj/W06U0YhYfSI0Ma3hqHdvnCqqTF7syrek8TIjR4yHSnnHLRzpZTv+GtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086631; c=relaxed/simple;
	bh=/comYDFeZO3j2RnZQDpuK4pS2vPgW1NhCSZjPfkTJxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgeTmZD3tS3BSolnuq+NXbfrJo2ScEOgTbMS7r6ot3Q6r4cLRba9rl3nQ9HUTh8OcCn3AbBI+cgLqz7ukmyLYqoRSCVo7c/Bnhh/1/pxiJRY+Ou7MRg8kW8xQy2J/LoUx4nv4O2CriYVdD2eO2FpLyevyJdeV/vKkA5fxEVP0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz1t1715086578ty0akl4
X-QQ-Originating-IP: tyGXQ7k/fVCDZ9cvJSokRBgm4NEcZ1aL6t7xf1Nvo/I=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 May 2024 20:56:16 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: ih8wnZWEUfUUqXQrgL7//rRaWUv/yoomnC4L9l+N0nevDKkud67FOPB78fLtB
	LUgVjX8w4VZ/XPC+ZqUMW2hAp02WMCRNAIUgHnpW/l8E8e4mlZdBXkRjzg5bYwzxGi8FdUo
	x7Jn3d2SQFcmRxHC0djtkBo9z72Bb2w9KYLZrySqRwtrS1XhkHAQINdY7MPGbTvxklMZFyZ
	pq+98plMi/hYvQVCu7ngY+Ept6rhTYIu6KuII7OvqKz933J7083LvxAqrgOl7TX9ymBGQXD
	9ZL6uWLEm2lQWKgZGPETpkJhkejOPiZbQSAT3K68vAjlwXh3VNMOz8/wyjkqqqPBSNwCmfx
	FEFLkT9EIeIt+jV5hNx5NQw+uH22l+dUBKiDFtvNgii29PGx77gNnNka0b+5kVhVnhvhzpG
	Ja/3mn5OTYs=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10700211031431174611
Date: Tue, 7 May 2024 20:56:16 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net, andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	sam@ravnborg.org
Subject: Re: [PATCH v4 0/5] Remove onstack cpumask var for sparc
Message-ID: <2E1672E07EE140B4+Zjok8JvIOXBNZnVJ@centos8>
References: <20240424025548.3765250-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424025548.3765250-1-dawei.li@shingroup.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Andreas,

On Wed, Apr 24, 2024 at 10:55:43AM +0800, Dawei Li wrote:
> Hi,
> 
> This is v4 of previous series on removal of on-stack cpumask var for
> sparc arch.
> 
> Change since v3:
> 
> - Rebased against for-next of Andreas.
> 
> - Add Reviewed-by from Sam.
> 
> - Remove PATCH(sparc/init: Remove on-stack cpumask var).
> 
> v1:
> https://lore.kernel.org/all/20240418104949.3606645-1-dawei.li@shingroup.cn/
> 
> v2:
> https://lore.kernel.org/all/20240420051547.3681642-1-dawei.li@shingroup.cn/
> 
> v3:
> https://lore.kernel.org/all/20240423083043.3735921-1-dawei.li@shingroup.cn/
> 
> Dawei Li (5):
>   sparc/srmmu: Remove on-stack cpumask var
>   sparc/irq: Remove on-stack cpumask var
>   sparc/of: Remove on-stack cpumask var
>   sparc/pci_msi: Remove on-stack cpumask var
>   sparc/leon: Remove on-stack cpumask var
> 
>  arch/sparc/kernel/irq_64.c       | 10 +++-----
>  arch/sparc/kernel/leon_kernel.c  |  7 +++---
>  arch/sparc/kernel/of_device_64.c |  5 +---
>  arch/sparc/kernel/pci_msi.c      |  5 +---
>  arch/sparc/mm/srmmu.c            | 40 ++++++++++----------------------
>  5 files changed, 20 insertions(+), 47 deletions(-)

Any chance of getting this series queued up for v6.10?

Thanks,

    Dawei

> 
> -- 
> 2.27.0
> 
