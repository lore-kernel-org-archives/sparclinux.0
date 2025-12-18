Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A52505A5;
	Thu, 18 Dec 2025 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056478; cv=none; b=n3wUTjpFMPPRUf9CuttBPwm6AXl+1BDMB9YwBjb9zoRBXbPUVkmuhHSChVI9BLTUhOMaIedjWy/A1DONCZ+0y/gPTAC4lnBcNtOn7IZCf1nctsQ8xDpxq5o05GUhDQghn6qk4Gyb0Klna2AijGhap8uh6PlG/KaS0kL/vJnvo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056478; c=relaxed/simple;
	bh=SFfHw+gNDeL04MTgco6eRs85Hk8QbOOz7cCbU9x2/c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT9VgDyuCf6Sy7bVtsZQS1xMI2Am9ovXz+rjiakQNnjMOsHWiUHqVJDoX9rJXxHNDbkJDZSWTCFm7Ju5cvpGIgXQtfele9m3uBwySli2Bpj8NJdue5DN1lSqAJx5BLPiUu8yoahMieJ8sEpKf/ZAKP/ofMhZO6MyI1Nwz7/frog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egorarpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egorarpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9754BC116B1;
	Thu, 18 Dec 2025 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766056478;
	bh=SFfHw+gNDeL04MTgco6eRs85Hk8QbOOz7cCbU9x2/c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egorarpWQXjj5DHb1LTP+iqt8XAowsi//jUM25yDBwoWC2Ddzo79nBvYEzIs6ww9q
	 MX2FJfeiZrkFrmjyOEp8bbpwdVx9nEGjizPaCukXlCdIu4QufyewxPKT/uv+7HZkKP
	 3XsJS+prYpl7Eb5vHpq7sOHdFIzQSsWa9P4ch1+JH/79KXJYMwK6Pa9IOPnYM5RgI5
	 zqZGRdS0+DTCHcso6i8nMv47zEVrNeV3kYT7FnHc2kN0rGmZHTOX25Er3gAhDrX3ka
	 gDWbg27foKRRN6/FKEn1CchUTgpLL6mrvBEs9riDFnKgYN75343GfQHn7VHnrM8AWO
	 k5wBbhCpkYkyA==
Date: Thu, 18 Dec 2025 13:14:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, kevin.brodsky@arm.com, dave.hansen@linux.intel.com,
	ziy@nvidia.com, chengkaitao@kylinos.cn, willy@infradead.org,
	zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] sparc: Use vmemmap_populate_hugepages for
 vmemmap_populate
Message-ID: <aUPiFbuaglcjqiB1@kernel.org>
References: <20251217120858.18713-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217120858.18713-1-pilgrimtao@gmail.com>

On Wed, Dec 17, 2025 at 08:08:58PM +0800, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> 1. Added the vmemmap_false_pmd function to accommodate architectures
> that do not support basepages.
> 2. In the SPARC architecture, reimplemented vmemmap_populate using
> vmemmap_populate_hugepages.

What problem this patch is trying to solve?
 
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> ---

-- 
Sincerely yours,
Mike.
