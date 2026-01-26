Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A029347FF8;
	Mon, 26 Jan 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446686; cv=none; b=cNPk1BiwN8bMrGi+qcy24QmnPUcn1BiO4fvslhjzhrTKUKNoFBxpTPSEz2t8h9EVdf5iDvFlKX1b1qK/Tkl3ViZuVxyw0DiEJLlUAaGJzkvtd/QCzWbgBlKrdeMlXpgQx4uXkpNnJFla67fzDcC1cPk34AWtjYKAwJDMqPp6gxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446686; c=relaxed/simple;
	bh=BZfuoCsYkaYttrFWh+MNOFrBt/oD8ScKb675yifUSdw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DspU2lgI1GrcP6bq6ohjXQhOpxGlvxzHEumSJACtxLsl71c66icXHM3+rmyilIQYdKw2W5yxSC3lP052E5lqiTqQ9JuoDgxHlvTr0G8RindJ1DAe1pPrj+K3fYYRMayUoHUhdJtQUPYEgKWYIpGJkEwbtiKU7mfDCxHdCZg2yL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=lkWxR10E reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="lkWxR10E"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0F8q1N3bz1DDdl;
	Mon, 26 Jan 2026 17:58:03 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0F8p50Vgz1DHbd;
	Mon, 26 Jan 2026 17:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769446683;
	bh=BZfuoCsYkaYttrFWh+MNOFrBt/oD8ScKb675yifUSdw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=lkWxR10E5EveL7lLh4ojq5CdAiUy+LQPbkkULPehTDELXZYBsyS5S//wuu2TtFLtt
	 h7GFRH2pe5w0wM5cwenlsgHS98jIqCmSTbtCkgKFRTfmHhHsK/ZBPXKPEnNRThEgEf
	 hl4Re43vztuaf6RiLnS9Wsg3t/50QfVJPYJGykmEag/3w6pIVObBRprCuSrl+Sgafm
	 l+ucoXX1P/wg4yTssmF5fnZNPms5KBL322ca/LucanAKiaFcblkyIQk+A09Kdda+zL
	 q/bsWyfxxTPuZqfCAgoc0XCeolLWk/JUgsVqsabiz06h8bIpXFCqsO2CpE4zZQzSgl
	 nJJ+ik3E4Hflg==
Message-ID: <e4db0322-a7a6-4e2f-ad17-70b9bb6fd519@gaisler.com>
Date: Mon, 26 Jan 2026 17:58:02 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch/sparc: fix unused variable warning
From: Andreas Larsson <andreas@gaisler.com>
To: alexs@kernel.org, "David S. Miller" <davem@davemloft.net>,
 "open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Zi Yan <ziy@nvidia.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260107104145.51416-1-alexs@kernel.org>
 <494e98fe-0fa6-416c-b136-9c444c03f769@gaisler.com>
Content-Language: en-US
In-Reply-To: <494e98fe-0fa6-416c-b136-9c444c03f769@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Other than the potentially missing Closes: line, LGTM.

Oh, and also, please use "sparc64:" instead of "arch/sparc:" in the
subject. No need for "arch/" and this change is only for sparc64.

Thanks,
Andreas

