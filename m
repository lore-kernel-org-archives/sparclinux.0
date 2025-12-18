Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009F314A70;
	Thu, 18 Dec 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063874; cv=none; b=T59RtbVFezZ23c2+aR+GQhrfuJrQikVJLotG3Gzq7vM0499X4BXoSeFj2lS4eeyA11vD0xb/cupwHNiUVk6CO2WonhpIq6Aulwn+kiN593sJ3eMXUqYnTW4X56u9ShynJ/Obdujx34tqokdEJbSD9jQh6MXJn9l6Tpa7xh9/fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063874; c=relaxed/simple;
	bh=4VWyNDc7jkUhFCG28e/nJjTfP2bqEFkzHBtDEtmEzi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRyurRJ84htNWLVY5+ipGm+9nN4LB9UVdnsjM0KAj86/Gnd8YBmeqMXUvVF8tOVE0t+PYGYijexa+EmsO71Z/WVFcvy0uVKu3rBHP4q1WryEf46UD7OsDSIR1/+r6QzuE2jQ9KcC/buV7oLMg2t47nJJMkJ23dYAS/lhkhs5qA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6CJ2Dol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6CJ2Dol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9350FC116C6;
	Thu, 18 Dec 2025 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766063874;
	bh=4VWyNDc7jkUhFCG28e/nJjTfP2bqEFkzHBtDEtmEzi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6CJ2DolkyOCrETzfXDQBKmayYQWHkhuiWBCF1i53hHX/QHK7i/JFcq/sBxsfwiil
	 j0qOV3XgnIFtCKdY0watZKSlPdwl+wS/ScPfDje5dGkQ80b+x+YKEn700nz1pvdecO
	 Nb8V/wacRMDjfV5TL54Jmy7VSmNs6GPIW0uYq4p/KoSFkPNKgebVDr2kO/3PZPZBmN
	 H7ELFEWy1a8oMZQGE+5aGIkZhZp/0lZyWod1+yXYdVFr6uApMblgMLs79SWmbLdaf+
	 cO0As7Kg40ramCm5m6iRVSCyAlVyLztL2Wj+FnwSdOy2/hS2F31d5p1FnjZl4TLrn6
	 4WfhCno5t/qzQ==
Date: Thu, 18 Dec 2025 15:17:44 +0200
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
Message-ID: <aUP--JzrvOm1-Q2P@kernel.org>
References: <20251217120858.18713-1-pilgrimtao@gmail.com>
 <aUPiFbuaglcjqiB1@kernel.org>
 <CAAWJmAaxtKY50BEm3N8V1QTwpyCgQLfLFarrVfPVVpXg9ftmcw@mail.gmail.com>
 <aUPvecgVj8XXBcw5@kernel.org>
 <CAAWJmAa44SF=dj+FTiXn0aZwLLGbSTAieb8Cy73RE0sGAkAYLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAWJmAa44SF=dj+FTiXn0aZwLLGbSTAieb8Cy73RE0sGAkAYLQ@mail.gmail.com>

On Thu, Dec 18, 2025 at 08:29:27PM +0800, Tao pilgrim wrote:
> On Thu, Dec 18, 2025 at 8:11 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Dec 18, 2025 at 07:45:52PM +0800, Tao pilgrim wrote:
> > > On Thu, Dec 18, 2025 at 7:14 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 17, 2025 at 08:08:58PM +0800, chengkaitao wrote:
> > > > > From: Chengkaitao <chengkaitao@kylinos.cn>
> > > > >
> > > > > 1. Added the vmemmap_false_pmd function to accommodate architectures
> > > > > that do not support basepages.
> > > > > 2. In the SPARC architecture, reimplemented vmemmap_populate using
> > > > > vmemmap_populate_hugepages.
> > > >
> > > > What problem this patch is trying to solve?
> > >
> > > Following the pattern established by other architectures, vmemmap_populate
> > > is reimplemented using vmemmap_populate_hugepages in the SPARC architecture,
> > > which fulfills the intended purpose of vmemmap_populate_hugepages.
> >
> > But what's wrong with the current sparc::vmemmap_populate()?
> 
> The current implementation of sparc::vmemmap_populate() is correct
> and functional.
> 
> However, I believe that generalizing vmemmap_populate_hugepages()
> still results in certain architectures requiring special-case handling
> branches, which is contrary to our goal of a unified implementation.
> 
> Another benefit is that it allows us to eliminate the external
> declarations of vmemmap_p?d_populate functions and convert
> them to static functions.

If the goals are to provide a unified implementation and eliminate the
external declarations of vmemmap_p?d_populate() functions, I'd suggest to
send all this a single series rather than a single patch that updates sparc
implementation.

Regarding the ability of sparc to fallback to vmemmap_populate_basepages(),
it does not seem to me that this is an architectural limitation. sparc uses
base pages in the kernel page tables, so it should be able to use them in
vmemmap as well.
 
> > > The functional logic remains unchanged.
> > >
> > > > > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> > > > > ---
> 
> -- 
> Yours,
> Kaitao Cheng

-- 
Sincerely yours,
Mike.
