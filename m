Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01632E738
	for <sparclinux@vger.kernel.org>; Tue, 16 Dec 2025 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862224; cv=none; b=MA1xqdTcrdTGvwmNSVT6F/WKt4R++pbBGtcvlOay5+KN+9C65xs9+BgjE/wYF0p91PL0yf2s8Vd02E31ZcfuXret6VwnaYrk7FpGZ9TUOaNGgM4j7K4RjL+N7Q3x5WNEFjHHAbTfXF22gOEW6o+z8x8wQG9Bok5/PfO5Bp4AVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862224; c=relaxed/simple;
	bh=4mIT6zYV5aYOwoCqi6mBDFljI6pEkAQxYIyKHnYjXEY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=YpeqWgBqdLnyvo4tBQWevQTt78QM//YOVnVLNJknwI0dcFuT3PVlroXlgwg9FVxGB0QKjcavzeMBl/ayffhAdEQKd/E04OBUuTCPufJo6aKCEGorBidGRtNHWBCOTwnlvaNrNPEYMA7O+OkEs1Snv0hZ3LbzzjPLvPClfEWX730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpD09eHT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpD09eHT"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ba55660769so3234703b3a.1
        for <sparclinux@vger.kernel.org>; Mon, 15 Dec 2025 21:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765862214; x=1766467014; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjD+cNbyJGOMAKpBo5e8LJBh9aFpu4/6uuuLCwZXOF0=;
        b=DpD09eHT0SSxatXw2WFgOfB74+Vw9Ihf67PFLENOuwdg2/wGxaepZMZ2PpOV9eIgNj
         x9u0ZlfJvkh/vrLJrqy6+P746QIAq8ZvbvSd0Rfe2NX6pJ0LNWYUFZNTlWXje5vsaCHD
         qEIMsh/UQMYtwqwMHKbaVWEJXd/InOCq6qHBgjQm/+87QHJCJ2I3ELot+l0k+OAQrw5l
         xuPMv60wX1JmgEztTDw5oOh1mf6TLnA5KxUPcE5HIhGpIGAzAso806pybjMm3LOcjUOI
         kuFutuzFhzmnJvneYxD8lIiEuTqdfFhYbNVUGcV5X9ZWuyS6oBSn5rd19UPNFiD2sMnN
         cN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765862214; x=1766467014;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjD+cNbyJGOMAKpBo5e8LJBh9aFpu4/6uuuLCwZXOF0=;
        b=Jx7qQr3nV+3AYHJFZfR5MyiVoRT08YXC58RjcANN0XSpENeI3i4A9CGudwHqtpQEpQ
         qzVL9s6tVQc0yoNYKM6+GUNGYnsVTcw9kMocxcT2fOVVR4FMQB9ck9gOVZHPwVcxsUsn
         VxStjGiF2eBaAU+MYeJGfCWVHvJEuxTv7JUunTljh3b5alSMykDJ9Z9mOV0mBhSKwogj
         KE/4r/Zimm556JVG1rBc7uI4m/lOgeN6xdKQMzBpBU1tjrisbFRqfhG+deK8uP3ii1Ms
         qPoceBOBJPC3FoNkN3CjeP+MCwYdpY2vwu8rcKVffFrroVKBNQYkX5fnFHBMnj5E7be1
         1nSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEwl2ppxHZSXDLbOldxBuRf/5aPG6ha0u/iXJpAjy1A/M5evUUcdOz75dYJ3iENM4/keQa7M188YCD@vger.kernel.org
X-Gm-Message-State: AOJu0YySOS78z4yiMiCtN/0zFE/TdL6Pz5osnmiu81KH6MLXxGgpjppG
	mWXmd2jW3hAJ3ZvBhBSdwCf7Urjq38OK3Wof8hOhOq8YBfGMsrcBMyVm
X-Gm-Gg: AY/fxX4v/JRC3IJg83baBqEm0hw2B4ZK+B4Gz2NDbU1dIjRMceMct8ezcQJi2fUr7vR
	Q40tY2Omk6CcuqjaK9ZVgba0faScayulTHpMIr5F44GpEc0kuK0In1CkYJuRv4F0bbzA6tQgbgL
	QYrXWPAexigoO2TaE/tCqkEedsf3oiZY4J6BXDZiPHknlOud0x5xRSWZk4NltbKdvRpQULEeBX7
	d8OBRDg+hcUy8v+Rej5g6C05AoTYokQQrXmAkwhLz0wBiUYnWh3+wORevZCfWxP8T741uHiu0mW
	OYorZ0+//QSO5GHx+ZqGP/c1nRLo9RcUMeVaRsEDGuwczV/tkgbBXTlNsc6v423CUr3iee18ezg
	1raF+sxma7avJ470d7/G4FFalX5Ybg9EF/6jq8EYl3SwyPfhfDPQRrFS14HnSjJvnSDqxe5HbBR
	nD3j45
X-Google-Smtp-Source: AGHT+IFRNBpu36xO7SS++RmJSf+Yd0YivNXXnhzhZN3Px6CmR0fp7AX2KZRojw083jfNpLsrb718Lg==
X-Received: by 2002:a05:6a20:5491:b0:366:14b0:4b05 with SMTP id adf61e73a8af0-369afc00407mr13380900637.65.1765862214371;
        Mon, 15 Dec 2025 21:16:54 -0800 (PST)
Received: from dw-tp ([203.81.242.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c25a87487sm14064659a12.7.2025.12.15.21.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:16:53 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, 
	Juergen Gross <jgross@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v6 03/14] powerpc/mm: implement arch_flush_lazy_mmu_mode()
In-Reply-To: <20251215150323.2218608-4-kevin.brodsky@arm.com>
Date: Tue, 16 Dec 2025 10:44:45 +0530
Message-ID: <87345b6m9m.ritesh.list@gmail.com>
References: <20251215150323.2218608-1-kevin.brodsky@arm.com> <20251215150323.2218608-4-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> Upcoming changes to the lazy_mmu API will cause
> arch_flush_lazy_mmu_mode() to be called when leaving a nested
> lazy_mmu section.
>
> Move the relevant logic from arch_leave_lazy_mmu_mode() to
> arch_flush_lazy_mmu_mode() and have the former call the latter. The
> radix_enabled() check is required in both as
> arch_flush_lazy_mmu_mode() will be called directly from the generic
> layer in a subsequent patch.
>
> Note: the additional this_cpu_ptr() and radix_enabled() calls on the
> arch_leave_lazy_mmu_mode() path will be removed in a subsequent
> patch.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-hash.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Sorry I was away for a while. 

Thanks for taking care of the radix path as we had discussed previously
here [1]. 

[1]: https://lore.kernel.org/all/87jz044xn4.ritesh.list@gmail.com/

The change looks good to me. So, please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
