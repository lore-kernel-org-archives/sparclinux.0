Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36463451C6
	for <sparclinux@vger.kernel.org>; Wed, 17 Dec 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973864; cv=none; b=VGjlC4E14dlgX/f09WGx1Gs0ZtOoAFXH0cpPjd0h/LcKFmqBaq5GcXXzgrg/hEfUM3WItbEKqoaKfpDW+EuEOWI2e1vf/xWbcvUYwHcFIlfr2WBlrhtioJ4JNoY2NXDBRubfAqmmAWZrT2RN3xQHrDuqq14suhAFkXnYzV24JzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973864; c=relaxed/simple;
	bh=Us0yFCBAjwxulhriZ3mYjriGCty2jScVl7WxuOuzAMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTt2E68u4BZjL4tdtIoUDGmLslnubXRJxBYwhdRa4lG/YI3clHHSXTGhVOKLjHXB7wKMcFiusIst3dteqCgA3Gjn18DuWxbJEcrsKwscKdCyWlL5vv04ftDuIuqcsNpmYqodNMSjVLzIjlKtZaeeXk8y7nmECimrmlLkNFAr9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOrJ2PN+; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOrJ2PN+"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11b6bc976d6so746737c88.0
        for <sparclinux@vger.kernel.org>; Wed, 17 Dec 2025 04:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765973861; x=1766578661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TA4hyyTWjoyEecRU+tFTEv8TY8OLq5jN3IBQEP1dw+M=;
        b=KOrJ2PN+L6+TbVO7KqCSD2+r7pEofzuJHbxAc+gzotDkkNRcYSGqQmMFOThGciI5CK
         MkyLyf35dMHDxGr4kmnb8kCFXTSHXE9m6kmfctGOMf/4eKFaujEP4LY8gThUsF/qnr5R
         IrqEhZU7Ofen7fSR7WxBRcfWqsflOkCGNjynaRGVtMxidG0zLgW/lehgVvW90GJwFdjc
         lyDA+hgct4lwqEG28OC6hS4prII9m7tWioQa+xUrTubsddQWaZRjUEh/QjYHSpdTd0EB
         81l8YYCQSTLXnUfdHMteczWSqQBSl9V5ARBEgyrnjwn1j155TGGY3uP5iyx3TepXFdBN
         3Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765973861; x=1766578661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TA4hyyTWjoyEecRU+tFTEv8TY8OLq5jN3IBQEP1dw+M=;
        b=bW0GovcmmHhbeup3r9FK7XwwmmM0dsvmTVEeVAPvh5SXAgqpOmDkz0OwT/VcOsMa4Z
         kkqWvAk5uZnEgKxxvtFRIUyBQ9KtW7rddXQ4euHUSMpcmzLJK8uhjWMuzHtr9cFXbeDp
         msPXw/kHB+WYxbo0QDQvJsq2C7r6gTo9zA11+TGW7OfQaxoxLfH8lDYyo6P1JPiBdLe9
         8ndH2HCeEik0JycCQcmfQYKbakk+KdvqSTmh+b/xa9xmWWJDbi4ry4XVyHioLC2viqr+
         8X2rp2vXUse1divUr91OTazcnpg6j9HtvgwWkhOOJwDIl7YqJPPqXl3q/uiat9xrXxWM
         b6Og==
X-Forwarded-Encrypted: i=1; AJvYcCXYa2xjsxqhz2RwpsXq3Ata/BrB4QuinGrlqDrp4QhmNxKEr2DL0pKcrypU1SEfKoZQlbdkPEPOeXMP@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwXwMQ0HavHpnLPl4xidFMlzmlNvdZxH4eYgLafjufRaf6hgy
	Esvs3u/CS/VA2FZCEpOcTteUbC1PvpEquIuWWIiSyP+vR0+m7NjiIouB
X-Gm-Gg: AY/fxX6a85QVOlvz1xLQ6IQ1SbRyk1mSK9fSrLqaByUdMCk+REh7UrsryCVeZNV+UYn
	kx0n9QVBOi+sp6tOVngt35pQrb1q4Hu4MEF5xH39YCd+cd27kY0u1efjLKFSD0C4X+jHivWMK1n
	yzYPU2DG5Uw6GdRpgDG07z5QBFmsfIQYm9C2yUpqb+QMs3I3pFFyPwiPkq+t3UcA7z4rZH3f7GU
	vNpj8EkBXtX9vkrbcBz+s9lMImDmHz3NEvqfbfS2l7vKXnHOc3GhLYjBLRB0FWgOtB7NqFJL8tY
	pfsMNoiquAcxlhqKkput6WgI9NHW+0ycxoeyrvS+hdm05X00D+T+QlQj5cv+9PysbfqfHh42aeF
	jvR5NtgmvlJbGiLdQapO20ku+RpOkRjcipkOC4aVkP9mO/WbKF9+XU+snaw+JrdELVAEZd9IAj4
	zULArPe45w4ZeaQQ4C3SnlNMm0
X-Google-Smtp-Source: AGHT+IHtTckxV0BrLKUtwEMMlG/KT0X6JCzQ/eEGNn1nvrPgi11fSB7RRA3IhgmdXndE9lBsM2aS9w==
X-Received: by 2002:a05:7022:e806:b0:119:e569:f86a with SMTP id a92af1059eb24-11f34c29cefmr11289687c88.7.1765973860378;
        Wed, 17 Dec 2025 04:17:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30b799sm60713771c88.17.2025.12.17.04.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:17:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 17 Dec 2025 04:17:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geoff Levand <geoff@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 09/14] parisc: Convert DMA map_page to map_phys
 interface [qemu test failure]
Message-ID: <b184f1bf-96dc-4546-8512-9cba5ecb58f7@roeck-us.net>
References: <20251015-remove-map-page-v5-0-3bbfe3a25cdf@kernel.org>
 <20251015-remove-map-page-v5-9-3bbfe3a25cdf@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-remove-map-page-v5-9-3bbfe3a25cdf@kernel.org>

Hi,

On Wed, Oct 15, 2025 at 12:12:55PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Perform mechanical conversion from .map_page to .map_phys callback.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

This patch causes all my 32-bit parisc qemu tests with C3700 machine
to fail. Network interface tests fail, and all boot attempts from
any kind of hard drive (scsi, usb) fail with this patch in the tree.

Guenter

---
# bad: [8f0b4cce4481fb22653697cced8d0d04027cb1e8] Linux 6.19-rc1
# good: [7d0a66e4bb9081d75c82ec4957c50034cb0ea449] Linux 6.18
git bisect start 'HEAD' 'v6.18'
# good: [6dfafbd0299a60bfb5d5e277fdf100037c7ded07] Merge tag 'drm-next-2025-12-03' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 6dfafbd0299a60bfb5d5e277fdf100037c7ded07
# good: [09cab48db950b6fb8c114314a20c0fd5a80cf990] Merge tag 'soc-arm-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 09cab48db950b6fb8c114314a20c0fd5a80cf990
# bad: [701d7d782d98242a64cdeed90750f88ff733bc39] Merge tag 'spdx-6.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx
git bisect bad 701d7d782d98242a64cdeed90750f88ff733bc39
# good: [66a1025f7f0bc00404ec6357af68815c70dadae2] Merge tag 'soc-newsoc-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 66a1025f7f0bc00404ec6357af68815c70dadae2
# good: [c84d574698bad2c02aad506dfe712f83cbe3b771] Merge tag 'modules-6.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux
git bisect good c84d574698bad2c02aad506dfe712f83cbe3b771
# bad: [b0319c4642638bad4b36974055b1c0894b2c7aa9] Merge tag 'nfsd-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect bad b0319c4642638bad4b36974055b1c0894b2c7aa9
# bad: [e637b37a520513a04d00f4add07ec25f357e6c6d] Merge tag 'rproc-v6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
git bisect bad e637b37a520513a04d00f4add07ec25f357e6c6d
# bad: [56a1a04dc9bf252641c622aad525894dadc61a07] Merge tag 'libnvdimm-for-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect bad 56a1a04dc9bf252641c622aad525894dadc61a07
# good: [d0cf6512bbcf77afb6102f886fcd7fd48b7ae043] rust: bitmap: add BitmapVec::new_inline()
git bisect good d0cf6512bbcf77afb6102f886fcd7fd48b7ae043
# bad: [936a9f0cb16b0646143f8e05afab458adc51d0a0] xen: swiotlb: Convert mapping routine to rely on physical address
git bisect bad 936a9f0cb16b0646143f8e05afab458adc51d0a0
# good: [14cb413af00c5d3950d1a339dd2b6f01ce313fce] dma-mapping: remove unused mapping resource callbacks
git bisect good 14cb413af00c5d3950d1a339dd2b6f01ce313fce
# bad: [96ddf2ef58ec070afa8275f371b619462cd8fb2c] parisc: Convert DMA map_page to map_phys interface
git bisect bad 96ddf2ef58ec070afa8275f371b619462cd8fb2c
# good: [e4e3fff66a57a7aee048e0737a16874aeaffe9f4] MIPS/jazzdma: Provide physical address directly
git bisect good e4e3fff66a57a7aee048e0737a16874aeaffe9f4
# first bad commit: [96ddf2ef58ec070afa8275f371b619462cd8fb2c] parisc: Convert DMA map_page to map_phys interface
