Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503C40BCCF
	for <sparclinux@vger.kernel.org>; Tue, 30 Jun 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824738; cv=none; b=Nc2zrZacDbqTnN6Najcmafg23aDC2K1LoEx2SkMDrZ/+LASfVCy90JBACNJcQEPJ/5qu6jgH2KIQD9xAf2tz9I+lXgyeVmQv1PLuRJWUiSr2ZZIDedojSI5tk2c6odvP/FiGvmTiahZGHYAnojk4EySEoK0/ZfV1+DV8AK/tYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824738; c=relaxed/simple;
	bh=bBi9IWQ0+EVG4AwDEr19PaAbF/YAmUneVlzev0FH+Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsVqIelKXbI07VKBnfnM+DKXAG87IRP2uxTwC89JZLcUa/XObfOIlNz4OTNHrWGnAnjfAFHUFxJWZ3oL+RnBGgAoCI4BsAzqAqTVOOTvNxamNtLkFTVo3AJy3qiDPJURakQh6eulm43jlmS9UY3h6E+9eAYma8fzmkQU164S2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QyqkHfTJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QyqkHfTJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782824724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1cI5B5Ab1RyoAnl7AMp4M2meU2wzOcYFwePlws/s7Y=;
	b=QyqkHfTJ+XAWzZ9M3jg2wk17wA+JCCfj9+kAYl2Ss7BmyfT9mRa7IiFJdJDOtWi1oOXs/z
	Q+LxXZJUZU++ZW88ITGRZ6N9WbLYVz8Wd/c9GvSco275i1rPYACgHiDUSwHilYKZ3fG0OA
	WUWVYpDwYwT7ciQlkAGcDibQxzwxCTk=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	peterz@infradead.org,
	osalvador@kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 3/3] mm: cleanup clear_not_present_full_ptes() and rename to clear_non_present_ptes()
Date: Tue, 30 Jun 2026 21:05:13 +0800
Message-Id: <20260630130513.28882-1-lance.yang@linux.dev>
In-Reply-To: <20260629-clear_not_present_full_ptes-v2-3-96089871a1e7@kernel.org>
References: <20260629-clear_not_present_full_ptes-v2-3-96089871a1e7@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 03:49:49PM +0200, David Hildenbrand (Arm) wrote:
>Let's clean it up a bit:
>
>(1) There is no need to pass "full" anymore.
>
>(2) No architecture overwrites it, and there isn't really a good reason
>    to do so when dealing with non-resent PTEs.

Nit: "non-resent PTEs" -> "non-present PTEs".

>
>(3) While at it, call it "non-present", similar to copy_nonpresent_pte()
>    and zap_nonpresent_ptes().
>
>It's a shame that we have clear_non_present_ptes() correspond to
>pte_clear() and clear_ptes() correspond to ptep_get_and_clear*().
>
>Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice cleanup! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
