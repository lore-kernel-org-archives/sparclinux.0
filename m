Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1FF1A681B;
	Tue,  2 Jun 2026 04:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375284; cv=none; b=rF4pI20cmK2VmC2f4nFMvqYtQ5HIqRyqSOZb3RvgaZ8WUn/zYlO4f+eJkyk7PiIyqwtIQVxn8rysgQBdjBqDWUhxQMittNBOy/lUY4BfteTwRdntnyXp5WdgKz7fhMamloWDv+8N3/7fFEijI39D4MM54HoN1UedgWE5Sev7+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375284; c=relaxed/simple;
	bh=XIPqheZyfxMHX/MdGE3lK6sIyCyahrpLJ6uAqRJ/k2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5XV2cMM2H7XibeVGHm00pHmgPBrcLjAnoUTgzDbrNN/TmApC1JfAAidqvTjrTtqALVHxAJQjyBabogD+F/j3eRvagMULGOrvDjsgDFRrhRWl86r+dHUkG5BDazjMOQNTFau7yK+igvH5ktvOzSN3dmGCHP6HmA79a9dnjztbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVVCf76D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVVCf76D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227081F00893;
	Tue,  2 Jun 2026 04:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780375282;
	bh=5iTAXR5bbzIxHxlJbNzCQ0CqrWCPbLprw+Rivi0AdWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fVVCf76Dx7vvRtOjppgGy1UPYStuohI+uy9DWtC+LjMgaEMLbdvFewnh94OAL+CM2
	 pCOKO3Nnfhfp4QVVVFHJ7pGlC0pcRPQSBoK+8qI+lMS8vE1L9za9TMoAEhapGCyg9z
	 oSOX6UXAQ0qI8lZdcWzGnsDHIE/3SlXVTvbbZnLLGgJsb+q9w7gAY3CfUe/oXsaq3F
	 IKCnC0jDUA164OuR9mISVXoVORX5ONpBDuDwwi+L6+sBtk7/0MupCBLirVc0R3mesL
	 YLqI48YwygT3VSDU6XtM8NAwITqzxDNVTMAKliil4c0o+GhGmZTerIkNtW6sdsl3Fh
	 evYO5/MHJ+rmg==
Date: Tue, 2 Jun 2026 06:41:14 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>, WANG Xuerui <kernel@xen0n.name>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 1/5] mm/sparse-vmemmap: provide generic
 vmemmap_set_pmd() and vmemmap_check_pmd()
Message-ID: <ah5e6i8EfoLUnyn2@localhost.localdomain>
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
 <20260601084845.3792171-2-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601084845.3792171-2-songmuchun@bytedance.com>

On Mon, Jun 01, 2026 at 04:48:40PM +0800, Muchun Song wrote:
> The two weak functions are currently no-ops on every architecture,
> forcing each platform that needs them to duplicate the same handful
> of lines.  Provide a generic implementation:
> 
> - vmemmap_set_pmd() simply sets a huge PMD with PAGE_KERNEL protection.
> 
> - vmemmap_check_pmd() verifies that the PMD is present and leaf,
>   then calls the existing vmemmap_verify() helper.
> 
> Architectures that need special handling can continue to override the
> weak symbols; everyone else gets the standard version for free.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
