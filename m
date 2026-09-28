Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD60481FDF;
	Mon, 28 Sep 2026 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585420; cv=none; b=MMFkCTiwItZ/lKJsPEsHoRF77GoZbsuC70T3jhfpABlD252pj4SvAmmbW5CezqZnKzfcSQWopsg7mpv/nUa/hCpxcrc1Cp8SJiYYppY2NqVUD73fuh1Db32YsBYJrDJXxKGPxJeWyZ/nVg42zX7O43r7GKgvWNLylEnf0JYFVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585420; c=relaxed/simple;
	bh=mIg6S8hGocKkEZEINYG9NORlzE3e2Jr8ONsaGpZXyIc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uC60yW/MqrtXRZB80i25TKr6wXC/j7bbVFenDX8sf/Un26lQ1/g1Qw86FWdnss2K3f9ietfZtVRkLMzeMCE4VyZHnbrXjAaqMUpeeQ/CvrcH5n0/Dg7uIox05kRVyOqmc3PH+Qrfgaai6DpzLmplQ+EoQ841BhMtp/tcuvDnd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlbKJjkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlbKJjkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D891F00893;
	Mon, 28 Sep 2026 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585419;
	bh=tGo5vhliQEhZ6WLvuwztBU4iJgSnjE2RLNNM0JBA9/E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=UlbKJjkd0WGCZbT8BSg7FUUMfnFVqTaR0r8vBQR1s/lUvR6PDNikFG2npgUQanacv
	 T4vm5TPE9zQ8c4CFCCBjyeUQu7y3sqpuuYlU/49E3Ob6l4nXe/GIY233OQQUMN8cxL
	 GopAmnBeLge+yjo7+JZf0ScE/VSgYuk9qzOoVwSCew4iF7wgBnv+vI9D5hppvFG+s8
	 IKhpqIU5WkwZeLJcrhtasasEsasfon7xscuwy0AiKCKkD1ILYY9YSkXrJ7T4DqZFnS
	 9dg/fQ5DEF+rtR7vdQCOun9LyPF7IREAdMIIRQzN61tCzw7J6q7g/NYxMNrGpUq75/
	 UFDoQsi1/f51w==
Date: Mon, 28 Sep 2026 10:49:16 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    "Mike Rapoport (IBM)" <rppt@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sparc64: D-cache alias flushing fixes
In-Reply-To: <3d0f0b6aa7ccaad25d04c5cdf0475d2d030c78e9.camel@physik.fu-berlin.de>
Message-ID: <930fec55-b861-dc70-3f08-f54862359caa@kernel.org>
References: <20260927105539.8742-1-kaloz@kernel.org> <3d0f0b6aa7ccaad25d04c5cdf0475d2d030c78e9.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Adrian,

On Sun, 27 Sep 2026, John Paul Adrian Glaubitz wrote:

> On Sun, 2026-09-27 at 12:55 +0200, Imre Kaloz wrote:
>> Two fixes to D-cache alias flushing on sparc64 CPUs with a virtually
>> indexed L1 D-cache.
>>
>> Patch 1 makes move_pte() and tlb_batch_add() flush only the page a PTE
>> maps, instead of every page of its folio once per PTE, so the number
>> of cross-calls for an mremap() of a large folio no longer grows with
>> the square of its size.
>>
>> Patch 2 implements flush_cache_vmap() and flush_cache_vunmap(), which
>> have been no-ops on sparc64.  Stale lines left by a vmalloc mapping
>> corrupt BPF programs and module data on UltraSPARC III.  It uses
>> flush_dcache_page_all() as patch 1 restores it.
>>
>> Both patches are tagged for stable.  Tested on a Sun Ultra 45.

<snip>

> Would you mind reporting the bugs that these patches fix in the sparclinux
> issue tracker on GitHub [1]? The reason I'm asking is that there has been
> recently a strong uptick of patches for SPARC and I want to make sure we're
> not missing any when Andreas gets back to reviewing patches.

Was going to do that. For two days my U45 seems finally rock solid after 
many years.


Best,
Imre
