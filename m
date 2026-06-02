Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280C270ED7;
	Tue,  2 Jun 2026 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375627; cv=none; b=oFP0ldZy+ZivQ7IAV04Rw9TgfLUWp+czH5NKHEg2ng4wTniWq4qFU5R80EJnQCaE0SAm0E6VCSgOB4oASolXsNR2kOizwdcrG3bhXIhz68j8pVJdCoFA6S4RsYjKbNKb5RWnEUNb9d4d5NawW8EXIowqNdo0RKfIb1+BUGNK0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375627; c=relaxed/simple;
	bh=ns8vYxbGh6iN5fLcvPFhgTFXp/m3fvEhis8nN+wp/1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lomawnue3rH5pksEpp6ubYsgU8Vh4H2sazcmq+ZEFUkxmO6UGNnwY+s64K8ezqFF/VVxgmhYJGykwTrSquhNYTdmV71z7ouiZdFbn6zrrr965CHQOPhwGpa/nQK8J+bmutiWGnFmUcm0qRwdQuA8N1z9pd85u5nEIUgwWZ+MDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVUczLjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVUczLjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867101F00893;
	Tue,  2 Jun 2026 04:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780375626;
	bh=w2vFw2b6Dq4kXYpDSqPPl/I2tXbfPjM4tacHe5F7/ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YVUczLjsw80yEWH3gu3NkaGjxurIFsxviLifgTASl5KmyxzFoZ9D6BRbFnC647FHj
	 lx/XsyIDDrgeNc880H1ZCzZ6k2GAkGqLt2HPVSKtCr9mjn6m2DCwScX7GkN79pS6Kb
	 Ybu4ua2edqgSU8v2FiaC7J5DsTHfum101oh9NnXGGFgdKNTpHz803fqOarf2Aq/REj
	 rrFf4M6W83xFQsgAsvLEXmOIlSUp/imXkfYWMxxsDexeQ3reNFAuz1/La1vSHOW9B9
	 ecfNlu1N+o672xehcI60o8JlzLchfcXr0Hdq8pu+MVpFykxKhmlLGaQmBsGApTcQm1
	 IWYYOlv9b/uSQ==
Date: Tue, 2 Jun 2026 06:46:55 +0200
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
Subject: Re: [PATCH v3 5/5] sparc/mm: drop vmemmap_check_pmd helper and use
 generic code
Message-ID: <ah5gPx1TuEH1wFzC@localhost.localdomain>
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
 <20260601084845.3792171-6-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601084845.3792171-6-songmuchun@bytedance.com>

On Mon, Jun 01, 2026 at 04:48:44PM +0800, Muchun Song wrote:
> The generic implementations now suffice; remove the sparc copies.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
