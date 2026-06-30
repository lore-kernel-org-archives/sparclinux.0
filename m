Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814F3FD12A
	for <sparclinux@vger.kernel.org>; Tue, 30 Jun 2026 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823112; cv=none; b=URRfhyXtofAd5W1cVcEjrh2tGLVtCfvJ34VzvA6oGbjXUSsWMTE/Ovzey8081TaAA6T+2X5m0nukUWSm4rjKyI38hlkvFQVAiqk3SGtOjlrmIp9gvWO2MtMH5qRvFt6UON+PY3UnYtz32RCCYyUrakV6Oeg5o7qfeFPIWgSXBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823112; c=relaxed/simple;
	bh=wwukuDKbyljD7hId+oIoTVO7P14eUg01P4v4+Ftn7VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rnhu7bgsWdhA/f/imHZN2iXzz3zqVgTANqqNRAdRZxKV23C9dXJ0yPkm7KV4rpH7qy3DIVOJJKdZjhvfjW5R55RqGDHuOv2UTlFnQFBmMjBNNtzReA6fY5x2VzGqY/sa9UF5AN4Cl+Nyr/Jp8n8VqunbCYzVgEdBNso+qogm1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jgSEgznx; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jgSEgznx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782823109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwukuDKbyljD7hId+oIoTVO7P14eUg01P4v4+Ftn7VA=;
	b=jgSEgznxBiHGQaexqZhJkecqo2BuwDaiUFnh5YpQFZ9C/GoUdN7hdqIrEOAZ5aNblcamMw
	iv6u9XKMGSbVfvZf1nt+cwmRBML8NyeguYi/xGsDFnS3FC2QqntjZ20gltPoXsMtN+lduw
	QjDRfgzcPuAoUoCiHCPJEf6RyCceCXA=
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
Subject: Re: [PATCH v2 2/3] mm: drop pte_clear_not_present_full()
Date: Tue, 30 Jun 2026 20:38:04 +0800
Message-Id: <20260630123804.10313-1-lance.yang@linux.dev>
In-Reply-To: <20260629-clear_not_present_full_ptes-v2-2-96089871a1e7@kernel.org>
References: <20260629-clear_not_present_full_ptes-v2-2-96089871a1e7@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 03:49:48PM +0200, David Hildenbrand (Arm) wrote:
>In general, there is no good reason to do anything special when clearing
>non-present PTEs.
>
>In theory, HW that does have to invalidate TLBs for non-present PTEs could
>benefit from a "full" parameter, but fortunately
>pte_clear_not_present_full() is not wired up anymore ... and there would
>have to be something very convincing for us to care about that to re-add
>it.
>
>So, let's just use pte_clear() directly now. To avoid the compiler
>complaining on some configs about unused "addr" parameter, silence that
>here.
>
>Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

With the sparc64 override gone, pte_clear_not_present_full() is just
pte_clear() :)

LGTM. Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
