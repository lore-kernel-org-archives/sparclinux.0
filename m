Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE481723
	for <sparclinux@vger.kernel.org>; Wed,  4 Sep 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475921; cv=none; b=mjRESYjxOa5jPwcYezaSMtwV+tQGLCOPmCfcjFH4c9ICyPLL3XB5NkxcntU6+F+9PB8n1i3hzAf1LkMVN3+cIUsT6agwGM4aVxNSzlUVkyUCNVs3CYcgyPM5NJSWOYI5nFhoLyXDd6UiC8iPx6FesQpB36y1O/l8m9Mz/Bl+uZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475921; c=relaxed/simple;
	bh=eoj+VLOqGJa6LbdWtGkk6SXvNIMddi3dJ20lVqlAgkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s497hbLrPHx9FFp7G5UJvliXZcM11YZgkeziHjgExljtqE5tiMEjvTE7GQ/mycVuHYWfH4VnZE7NxLKbvuam0dduSawNj8ODjCJqlcVlXTQWQUpzxlFeZYSKCraJpeuVZMe90+rjWBKNR/MnBNW5E17Xq+EJluT2ii21SPPBcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IzEmcNyK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IzEmcNyK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso3898933a91.1
        for <sparclinux@vger.kernel.org>; Wed, 04 Sep 2024 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725475918; x=1726080718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6ZVaLfTmncaiFC3xCMQJd5Si2uYtr9Mg2hPai6p2Zs=;
        b=IzEmcNyK1v9vlTdaK4RPuV6wC1TlHPRAFRKHo/3OXzA3xD4sTLudbsYe5ZmMsoeKAa
         HqYz7zKizlvCocbvqVirQtVcJHjhqdkHX5jbjyi7mEjPNmTw2CtZAChH9tsIGnr31W34
         mUb+81c1cyLJMcCyiYr54F1PtE68RrLS+7b+Moblb2axPGonufIgAiJ7I+m/LCSV5g4g
         G7XEuW8Wa3xnHZcXkVfcY/tzbCZj0sQRsuBz2NUn+Jfc/0+xojqv3DPOXe2lOrKuwTaO
         9/caw2ck37/3nFwELF/atx00pKlQnXm75R3f3//3PPQsyHsNRB8XTKadJ2DHafShOzJg
         DAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725475918; x=1726080718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6ZVaLfTmncaiFC3xCMQJd5Si2uYtr9Mg2hPai6p2Zs=;
        b=UQ763193uBHfb7AlFd6bGTH+ieEjnvJUJtUDXkdYlVWs6trG0toR3TtmZy7w5msCjM
         eBZ9I4ndRG4404KhkD9m3PcW/uNhVJIfb8w+Q1Qj2I786ToAtPjjjbSGuErVdXYE/nBQ
         jvq9pcyJQpfGjYlTNCeBEbNo+aaw2wGgJyUOsH0sK8s5fapIs849J/lR2uHzubozSgaP
         SEWEmj0zhuPaboW6jetRKTerUWlOZply/JSo0uFoWCJq1UbVo2xsb09B0f+9+JeRqSfz
         BzTL98MnNQixmXBgaXoKg15STZQifhiPKei2mK5EKR4o87v7Z9Itm41wC2ys2RzjmEup
         adkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBmC6bUNANJzf3rkMrxkFezl1QZ2GLRIlefenl9FTvtC3hfnrZy8YaEGrTEm3B4iZbvv7C7SXbL0sm@vger.kernel.org
X-Gm-Message-State: AOJu0YyzS6xVlIADoPUzSLphfezVzk/gr2BBi/mCFn2IZ41jKq+TGBkE
	8ANi0xzdqAH/7h/hj6sS+yU8zQ2VhqhL7o+HUH8Ur/vRMX3ftJZg8Bf6HYxOpdU=
X-Google-Smtp-Source: AGHT+IGxM6h9S0OM8htpvDl1qRKbi0apkGb/RUsvutqrVBDacyDPb7hJbcL2mjRY0/SNPdo0kubr6w==
X-Received: by 2002:a17:90b:3903:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2d89728b29emr15224775a91.10.1725475918042;
        Wed, 04 Sep 2024 11:51:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8e1ae1b3fsm6674555a91.33.2024.09.04.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:51:57 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:51:53 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-mm@kvack.org, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 3/3] mm: Care about shadow stack guard gap when getting
 an unmapped area
Message-ID: <ZtisSerxbnDaWr5l@debug.ba.rivosinc.com>
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
 <20240902-mm-generic-shadow-stack-guard-v1-3-9acda38b3dd3@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240902-mm-generic-shadow-stack-guard-v1-3-9acda38b3dd3@kernel.org>

On Mon, Sep 02, 2024 at 08:08:15PM +0100, Mark Brown wrote:
>As covered in the commit log for c44357c2e76b ("x86/mm: care about shadow
>stack guard gap during placement") our current mmap() implementation does
>not take care to ensure that a new mapping isn't placed with existing
>mappings inside it's own guard gaps. This is particularly important for
>shadow stacks since if two shadow stacks end up getting placed adjacent to
>each other then they can overflow into each other which weakens the
>protection offered by the feature.
>
>On x86 there is a custom arch_get_unmapped_area() which was updated by the
>above commit to cover this case by specifying a start_gap for allocations
>with VM_SHADOW_STACK. Both arm64 and RISC-V have equivalent features and
>use the generic implementation of arch_get_unmapped_area() so let's make
>the equivalent change there so they also don't get shadow stack pages
>placed without guard pages.
>
>Architectures which do not have this feature will define VM_SHADOW_STACK
>to VM_NONE and hence be unaffected.
>
>Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Mark Brown <broonie@kernel.org>
>---
> mm/mmap.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/mm/mmap.c b/mm/mmap.c
>index b06ba847c96e..902c482b6084 100644
>--- a/mm/mmap.c
>+++ b/mm/mmap.c
>@@ -1753,6 +1753,14 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
> 	return gap;
> }
>
>+static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
>+{
>+	if (vm_flags & VM_SHADOW_STACK)
>+		return PAGE_SIZE;
>+
>+	return 0;
>+}
>+
> /*
>  * Search for an unmapped address range.
>  *
>@@ -1814,6 +1822,7 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
> 	info.length = len;
> 	info.low_limit = mm->mmap_base;
> 	info.high_limit = mmap_end;
>+	info.start_gap = stack_guard_placement(vm_flags);
> 	return vm_unmapped_area(&info);
> }
>
>@@ -1863,6 +1872,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
> 	info.length = len;
> 	info.low_limit = PAGE_SIZE;
> 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
>+	info.start_gap = stack_guard_placement(vm_flags);
> 	addr = vm_unmapped_area(&info);
>
> 	/*
>

lgtm

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

>-- 
>2.39.2
>
