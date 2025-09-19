Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012E1E3775;
	Fri, 19 Sep 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305271; cv=none; b=AifPU33/nFINYPm87aN5NboISZHHr1IZx4SrQBdoLsFuQlgJUQ04Zr/UfCH/spxMBGNIwZbnK+5YcrloUU0edTX1DAnX2VK/cVRNfnguSG/uK77gU3MqK+QIivFFt1fCpUOQs0H1WLP1MsAuiCYsZGbsoqo6z0tN58/0G9CtHAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305271; c=relaxed/simple;
	bh=Wu2eGe/mS7p0B/NwQeCMwaT+SVke7lnfsACqDjeip8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVK8sYYG8svIEZhNM9aQBFjBGtXdvAhYHnRZTURdtlpmUkflxITRAXU2/Gblh//tsKSGF/NPKhQl6LYqnJ22dH2WF3eBy5KUu4ZNmW60yQbk3o1alhIMqCCgBAnjlxeNfkbB+14py9opIi5zBbQ5zl5Hj1SKqmUnpZxrDV5ucw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=jg3RGqYI reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="jg3RGqYI"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cT0dw1MhMz1FZQ2;
	Fri, 19 Sep 2025 20:00:04 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cT0dv3wqTz1FZPt;
	Fri, 19 Sep 2025 20:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758304804;
	bh=LqvDpcvx2GGFtaGzwciQP0I53j4IeLbgBmByFqDVHuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jg3RGqYIkZu/7obRV0oU3eMhOy39tnwUTd+0P/BmInKHXFjQCmypR/IubKJfTg5la
	 KCHpoRLy0YMfGs3K203wCGu5AbKRuxR4XU0iTZyAnSKTlgIo8X7UiHgAQ1JFdz41wl
	 3ztVrx19rNA+GOoBXvTKjiqp2oBoJPEoZvVmLz7LK7yEdQ6q3a4cKvEziQiArysMU3
	 ks7i5cpSQFaxJer32ZINVdx6rDL9TZpY+/nywKHSgg9npsJ0HHejvDrAXD3mDpwyHW
	 FN5D4fZLHiWEhJ+2n2VUL6yfmQIvAGni88nPxxBjGMRg8g0gOd8hHZuwuWfmnO9M63
	 v3bfvkNpXjH9w==
Message-ID: <c3ef33fe-58da-4c43-a0cf-10794b4d867c@gaisler.com>
Date: Fri, 19 Sep 2025 20:00:02 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] sparc/module: R_SPARC_UA64 handling to help with LLVM
 IAS enablement
To: koachan@protonmail.com, "David S. Miller" <davem@davemloft.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-06-09 15:53, Koakuma via B4 Relay wrote:
> Hello~
> 
> This series lets the module loader handle R_SPARC_UA64, which is emitted
> by LLVM's IAS in certain conditions. Additionally, I put on a small change
> to the error log to make it clearer that the printed relocation number
> is in hex.
> 
> The intention is to get both the kernel and LLVM in a state where
> doing a clang+IAS build is possible.
> 
> As with before, on the LLVM side the project is tracked here:
> https://github.com/llvm/llvm-project/issues/40792
> 
> Signed-off-by: Koakuma <koachan@protonmail.com>
> ---
> Koakuma (2):
>       sparc/module: Add R_SPARC_UA64 relocation handling
>       sparc/module: Make it clear that relocation numbers are shown in hex
> 
>  arch/sparc/include/asm/elf_64.h | 1 +
>  arch/sparc/kernel/module.c      | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250305-b4-sparc-relocs-65ac77ca8920

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

