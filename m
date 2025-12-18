Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A27328248;
	Thu, 18 Dec 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059909; cv=none; b=UAWgoNGn/pLVoJ8taFn7U13qwhHSBmESzo8/NDRFA2FhlMnjfe25hD/IO1ptRWKI69yH9NaqaAQ1H2uirRCeCmcYgRhVfyuk4+4BQsVHF9Vt+NaRGg3phcbFHARet6vaYNRx0JTyWLE0N4CthMf5P3eN0oJcaYztrVpHiyw3I8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059909; c=relaxed/simple;
	bh=ipI3gqtuXeH8Ewu4AyGr2xi/tSRvuGR+xxhOF1hRRs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P80WKRzjB5p9ARu9EYTAlVpnpIOu7z7Cd+7r1PcXUpN/1e87QmhxsZNPRg0s4gp3K1fGC22Ts1kYWyK0MKJ5W6jz33SGgt6wuS4+ZwheVW19oikn/R4uZ4aC0kTSjuqWZPnMwlNS32Z4z3BFCd2r3IidI3TYjYbYDnHPHt0gl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tifMOqAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tifMOqAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515F6C4CEFB;
	Thu, 18 Dec 2025 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766059908;
	bh=ipI3gqtuXeH8Ewu4AyGr2xi/tSRvuGR+xxhOF1hRRs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tifMOqAT2f2HQ4jFq5UqKvTU0mF0DIM0ZYg4EcGmCcHD3ApJwCUlaEkx6WrErE83W
	 zfVw+lvsLSuw3BAAGLDj/rfEui+S/6bV25HghWqJhKBGp4e+fYUCabjUaNgq25cdrD
	 fZiEnD2vP+zR4cz6ocWYmBpyirf1rop1A/XYuEpMGleN/Q5WWurzifZBJmaMOrXpih
	 Y5WOnDjFSyI488CRoaOk3uHWiKTuCN0UxLHysQSEoypsYPCJPwmYgE4blkiDEBHUgH
	 5Sd1mLAEAEZXZVQrVYb8pkkWpGDP9UkfhtdfShTLC1WXDD/0oDNb1BM3X/fU2Pl5rT
	 P+LSgV6IuayVQ==
Date: Thu, 18 Dec 2025 14:11:37 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tao pilgrim <pilgrimtao@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, kevin.brodsky@arm.com, dave.hansen@linux.intel.com,
	ziy@nvidia.com, chengkaitao@kylinos.cn, willy@infradead.org,
	zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] sparc: Use vmemmap_populate_hugepages for
 vmemmap_populate
Message-ID: <aUPvecgVj8XXBcw5@kernel.org>
References: <20251217120858.18713-1-pilgrimtao@gmail.com>
 <aUPiFbuaglcjqiB1@kernel.org>
 <CAAWJmAaxtKY50BEm3N8V1QTwpyCgQLfLFarrVfPVVpXg9ftmcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAWJmAaxtKY50BEm3N8V1QTwpyCgQLfLFarrVfPVVpXg9ftmcw@mail.gmail.com>

On Thu, Dec 18, 2025 at 07:45:52PM +0800, Tao pilgrim wrote:
> On Thu, Dec 18, 2025 at 7:14 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Wed, Dec 17, 2025 at 08:08:58PM +0800, chengkaitao wrote:
> > > From: Chengkaitao <chengkaitao@kylinos.cn>
> > >
> > > 1. Added the vmemmap_false_pmd function to accommodate architectures
> > > that do not support basepages.
> > > 2. In the SPARC architecture, reimplemented vmemmap_populate using
> > > vmemmap_populate_hugepages.
> >
> > What problem this patch is trying to solve?
> 
> Following the pattern established by other architectures, vmemmap_populate
> is reimplemented using vmemmap_populate_hugepages in the SPARC architecture,
> which fulfills the intended purpose of vmemmap_populate_hugepages.

But what's wrong with the current sparc::vmemmap_populate()?
 
> The functional logic remains unchanged.
> 
> > > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> > > ---
> 
> -- 
> Yours,
> Kaitao Cheng

-- 
Sincerely yours,
Mike.
