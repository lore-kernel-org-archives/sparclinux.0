Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101756;
	b=oC6C4la3nVNcFlQfUjsmgD+hVWXb94LLB+gOb/2IRFxoIA2QTen/o97iR6uKgUBqhSfc
	 h4d5+BJkf0vtCwlDF1xGrKPaxRKbfAy9MZn92gZxqdFsVOyxHXZa4MWZJQJ864QA1sAZ7
	 eXY1Dsh4zrKe8CGFodvuckbi3LW4dk2FZQqmJZPbthsfMxazk3qtD5+iDodBy4NUQ3In+
	 BLFMGOXmiHF/LpE7mFkgMNTYOO5vN3/kHgmCdt1pjoJg8+eUWPC6h93LcjAMmpYNsRJBh
	 XzQ6jVoRhfm7xdUBqFCFhKA9xXrUMmUlQYt1C7oArIP3804a3oKssMvxgFxUyzlAfaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gp1dlJYmM8w8ntmi7bQBqlanLKPIa5O7ZBIuoOP2eTo=;
	b=dRzzBfpiSDtIcXxBRLpJqFW6dsa1OBCpfGirifYQUIoNUsnRy1WDES3Z4n8yXusR+nAa
	 LFGLnwZOWXP8d3HVbWf0Zj188Ntx2FiR5NHSRFkZOjXinHQGzcWZrgFZiSRek5RTA7eJe
	 G5naSF198ryU/SyKcKhMD4gHnWX87nfTE1A7888RaBrxKXmd6Bf0l8nIIcBL8Pwa17ksF
	 sipqSpQ6bpRRR5fqqdIHlx1D01yg6BdNad0H9cbFBd1xSz2d2qdK2vaUuZ4vwZ1SPKeGa
	 4a3N8teIZdE3EsyhmJiyQLK7qdszzm5z6n6Mk1Qob4K3F7nzhBh4sd+9NkgnmJCtH5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LPKx7euy;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443C606A326
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 01:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1443C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LPKx7euy
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so874655e9.3
        for <sparclinux@vger.kernel.org>; Sat, 07 Nov 2026 17:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794101754; x=1794706554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gp1dlJYmM8w8ntmi7bQBqlanLKPIa5O7ZBIuoOP2eTo=;
        b=LPKx7euykCc6fTmtO5pRIlQXGah7shoNbqdlnxNCJxyMKwTVSHYyg8Sf1ZEjPHW8vw
         PVVUK7e96QGKdUmMifjk+4oTHEcAnnj1OvCxM1wyHGfXBLNKZFOlpFWNxQbDPQoQYOqk
         MSWTlnNYM325/0NwLgUjhJoPaAzBUeVczhO0Puz5mq38WEvUgvy1Nwv12ditwAuDEgtQ
         JxewrpdwQOeebFoWjKSyn6DtVp2jWlC4YmrcgZG23vdKL7bDTPPS5xWyS0JNFRGgcrwm
         9g5RvnYCofGfkgSVnF5GVnJ6wCQSNDmyRRxYCQ0essSOMX5oRn3Pte9+lT3kRKE0BLMA
         hJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101754; x=1794706554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gp1dlJYmM8w8ntmi7bQBqlanLKPIa5O7ZBIuoOP2eTo=;
        b=D8+munT3IYt8hoJOYk7cKzZi84OyvDimCFK+zDJTWzUuZ70EjsflU/Gy6TKugfBBGc
         AHQ9sz7m5Qjzr1DVQbaHt1CM5JeTChOLcz6/OeRTWCUgmBlN8sN8lY2hNcZAj9Oz8Z9v
         K7JifmKxdl6/liWtRu8Diy9vPjQ3EW5tfZwqnmbMKcCnsooDr4pmw3qs/v/UnMfge19M
         XM+SnnF/RPtTFyV+xr1xyF4DNp5t2HsKNz3167nIngoiwqf8iXQfY/RsWpjG+ukugg0l
         XPniUUuXl3BbSA5ye4lf1lCzD4Lx+IZgLHewkfuQYFeGLaXtsaRrwBvGwiIWOQIeM1zx
         tTWA==
X-Forwarded-Encrypted: i=1; AKwUvByjmOmeMGyz4zowjVUUzqV9SbZEeUy1lZg675HWyo1LE0DV4piQIkKo/kYwVoJvr4/c72ZjAsg9DVZY@vger.kernel.org
X-Gm-Message-State: APuU4Z9/MdyIt4CQTXQ18PT8cR6xOgvDmubeR98cZHYe7efEeqwvxS+4
	woZZndVkAA1sHFO2hxKzPOrotLcis+nMYk+VcYkUGLfF0H0eoOJnKEd1
X-Gm-Gg: AYBFou2pUp02OyiHjVkr3jp/wr4T742gh337FlZaPmf5Ag5JP/UnaHvG93hI9DC3zbR
	RjxTUXCkn7n0/sHHnZ0SmyK/f0Vt1/hMDf3uBF9P0WE7ezUPkR917tdcTboMt66wyIgbGZsK4wq
	PP62b53oL8eaO5S7zuE6gPyzkF94p5g1EspG2LTIsDGh8vNwGWlye4pyr5MByMENwroS/XPKG1E
	EAngLE8V8z3XKJD88CEDoIoK/hu8usGGKiJKB5wYnEmIOdSEJ/aB3a8huDWR8+yIuxu36uiZHO1
	cnD6+sDTbeMd6NdILH5S+hwOslBAcprcVXLRi++r0RfeEvXevqX9WIV4HX0GVgXC82sLpV6nCr/
	3ZmaDNiPmpkKU0XfP/+zDey/cKFfzLvk52VankpNNcGAdMCQVuKKBYT8wrdbnVDMFodx9XPeDls
	MbiUxFQv/OheBfQ3uj8GPoyM3nOBGD78gdam0Lgw+JiZMTYxK7mA5JEBEicq8RMHyYFl3R9SqAZ
	HQ7jj1YJVmdfE14ZFRs5eBzddSbKe8GTY9jNSfVu7surCIIxTgo/fX8s67WP7tekwhTvXyHLVdm
	xxTerMjJY4SrhmO+PbvUdNSwf2H86Jknc2AZtz9/NnGKiaEa4Yl7Zu+R6d+QJua4I2qeyj5H2qR
	JK0Dxwnl3bPr7UaO3GYDdYyQhGZ/v2oHAlcQCPcH2F3T6Qa+6iKprCRCcfmTZ9KA8gHrT7jhCqd
	rABXofQsZBhRhKjj+2Bcrb6ZzrztyzCrrS7u7Dn6Mp2VkxaBVIqLk=
X-Received: by 2002:a05:600c:5397:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4b963c8715fmr5551595e9.35.1794101754249;
        Sat, 07 Nov 2026 17:35:54 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb134ccsm103722785e9.10.2026.11.07.17.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 17:35:52 -0800 (PST)
Date: Sun, 8 Nov 2026 02:35:49 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc/iommu: Use raw_cpu_read() for iommu_hash_common in
 iommu_tbl_range_alloc()
Message-ID: <au_RHuVI6noT1W0X@gmail.com>
References: <20261107195147.70084-1-kmehltretter@gmail.com>
 <155ec5c6c5f6d4287a420191cb3927eba1d97526.camel@physik.fu-berlin.de>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155ec5c6c5f6d4287a420191cb3927eba1d97526.camel@physik.fu-berlin.de>

On Sat, Nov 07, 2026 at 10:13:51PM +0100, John Paul Adrian Glaubitz wrote:
> On Sat, 2026-11-07 at 20:51 +0100, Karl Mehltretter wrote:
> > Fixes: ff7d37a50202 ("Break up monolithic iommu table/lock into finer graularity pools and lock")
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > ---
> > Assisted by an LLM.
> > 
> > Tested on v7.4-rc1 (d48723711bae) under QEMU sparc64 (sun4u, -smp 2)
> > with PREEMPT and DEBUG_PREEMPT. Without this patch, two consecutive
> > boots emit three "BUG: using __this_cpu_read() in preemptible
> > [00000000] code: swapper/0/1" diagnostics in iommu_tbl_range_alloc().
> > With this patch, two consecutive boots complete without the
> > __this_cpu_read() preemption diagnostic.
> 
> According to your Fixes tag, this bug was introduced in 2015. However,
> I have to admit I have never seen this message, neither on sun4u nor
> on sun4v machines.
> 
> Is there a reliable way to reproduce this bug?
> 

Hi Adrian,

Yes. It needs PREEMPT=y and DEBUG_PREEMPT=y. Debian's sparc64 kernel
uses PREEMPT_VOLUNTARY, so a kernel built from that config cannot
print it.

sparc64_defconfig with PREEMPT, DEBUG_PREEMPT and lockdep, booted with

  qemu-system-sparc64 -M sun4u -m 512 -nographic -no-reboot \
      -kernel arch/sparc/boot/image \
      -append "console=ttyS0 loglevel=7 panic=-1"

prints three reports on every boot, from the pata_cmd64x and sunhme
probes.

Danish Khateeb saw the same reports:
https://lore.kernel.org/r/20260923144909.414968-1-danishkhateeb03@gmail.com/

It is only a warning. The per-CPU value only picks the first pool to
try, and each pool has its own lock.

Thanks,
Karl
