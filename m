Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F113ACF0B
	for <sparclinux@vger.kernel.org>; Tue, 30 Jun 2026 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821042; cv=none; b=KR+/Ae8qqebetTEZJ5pTqzjsawBgOWyZlEUAg6eTVao/+HNHokuhCL+H5duqjqwG12UYWlSdL6X6FYyPJW1tDtSE9Jyr/s9o11QgSL+nWWRD4hZUoiNT0O4ppkSITCoy1ti6LbHgIArRGYrdjAYSF+UBL7YWv5Na1r1ZkTNysSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821042; c=relaxed/simple;
	bh=V/DMUiQ1VPaw+ocwoQ3oyh/3Cnm4EySYJMIokcHus7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k16G3LYVE50L0EnqAn2L2koVKbiU7QJYeAzBPUuMDdyIchNOWgSkdTkJA1sFzdxMvmkPCklH2J19k7J6m3rc024yF+O71PMo6oDHMbGsoyV88WdEstMODJEnojyvYoEhl2PxhoGyiAvXmWWNq+s/n3HfNSWVph/vfsVPMCIsKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=afnIokYB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="afnIokYB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782821039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/DMUiQ1VPaw+ocwoQ3oyh/3Cnm4EySYJMIokcHus7g=;
	b=afnIokYBOW1Nsyw5v2FMpAPhzWDSn8Xmhm8lmi4QXXJYhfCyHTu/UVshzew1eNimj7yZJl
	5tPyYbPjrpHXa0TJ2MYRl71Qf/B0aW970KDwwl91kx9ODE/LlDdCTkLiwA5pgrxNr3s57T
	Dh0Z1m+HITnk4VjZz8g8g/Gx9nDfeSE=
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
Subject: Re: [PATCH v2 1/3] sparc/mm: drop custom pte_clear_not_present_full()
Date: Tue, 30 Jun 2026 20:03:44 +0800
Message-Id: <20260630120344.81142-1-lance.yang@linux.dev>
In-Reply-To: <20260629-clear_not_present_full_ptes-v2-1-96089871a1e7@kernel.org>
References: <20260629-clear_not_present_full_ptes-v2-1-96089871a1e7@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 03:49:47PM +0200, David Hildenbrand (Arm) wrote:
>On sparc64, pte_clear_not_present_full() nowadays does a simple
>__set_pte_at(). In __set_pte_at() -> maybe_tlb_batch_add(), we check
>pte_accessible() to see whether to call tlb_batch_add().
>
>However, non-present PTEs are surely not accessible, so tlb_batch_add()
>is never called and the "full" parameter is irrelevant.
>
>Let's drop the helper and just let common code do a pte_clear().
>
>pte_clear() on sparc64 maps to set_pte_at()->set_ptes()->__set_pte_at()
>... so it ends up calling the same function, just with "full=0".
>
>Given that "full" is irrelevant, there is no change.
>
>We added pte_clear_not_present_full() for sparc64 in commit 90f08e399d05
>("sparc: mmu_gather rework"), and I suspect that it was already not
>required back then.
>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

fullmm only matters if an old non-present PTE can pass pte_accessible().
IIUC, that doesn't happen on sparc64 :)

LGTM. Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
