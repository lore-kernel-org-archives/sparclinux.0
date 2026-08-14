Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDC3DA5B2
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740246; cv=none; b=Bmz9HZ0kR9bOpxsgm5SOUk7XMQ2cU32V8caN8akTdeEP/GAOevntjl1J3ztOVX87rCEWIoAVpdsBLrQ9D4BDvlh0od5CmhOITNQvbgq20yYGBygpJUdWBxqU+UbF6V/iesxptWXbWmcBPvAcxRBXKJNolMDiJuLjNqaHpY8UO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740246; c=relaxed/simple;
	bh=XG9XyUH9tLfoC0GNoT+wZt2xFsXamxRdce0B5rCbUC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tosAzOJVwhL0mhki9z2Bkq2eYv+rXb1WarxL+2yDWrF50FbRK3MskAYuOROZwOpt90TKx4Cjkv2W/sW7c+FqZYltnWyTRvYg2B87pUMXNaIVWgy2LJpCY7YxPszwfD2ludtqRaTY/LVZQtERptwbdjeFXjucmzAy34AaEuvydQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=eh3cWre0; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=MLjkrELH; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="eh3cWre0";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="MLjkrELH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786740238; x=1787345038;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=xUZucRKN0OCUyPPUz2a8tYi6rcDVvsCr9N8L2/ismro=;
	b=eh3cWre0vAYotDvqY6qirYAivOheOzGhYch0IKXujI4AOXq/whJY7esOpWIi2s9MgKbeg+wQ9oIWQ
	 q4733IPwxUJyW2ZqBDmzZG+hehhZ/2F5RBPHM3TOcgFzLvMKy9AAP939f0dA4Ig/JMAZAl5rvMYdFO
	 oJfLkOPMGqXFcWiZHH6c9Ci2MAcj0wlN1XyhgIeM++MM++BkH3M5rql1fLgAbCj65SR6XaEYcIWRbc
	 EC5jPmtikfEPTYtl4zd8vHSMosboi8vZ0JWDNpDy9YJkpli5oTp8Cx5Cx1oQsjmr/ysKlzg58A/pL9
	 kWRMFLAPLjzFGtHwfy+FXRDsr2N3J6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786740238; x=1787345038;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=xUZucRKN0OCUyPPUz2a8tYi6rcDVvsCr9N8L2/ismro=;
	b=MLjkrELHgM/toxawp48QsPyeRUZ1bf2W0xxSFeHQOj5G/kQCXuqirnfq8ctavTmri3qflrnd11b4A
	 KLdoMMzCw==
X-HalOne-ID: ddc28510-9820-11f1-bbab-6bcdb618a7d0
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:173:77b0:ce00:a307])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id ddc28510-9820-11f1-bbab-6bcdb618a7d0;
	Fri, 14 Aug 2026 20:43:57 +0000 (UTC)
Date: Fri, 14 Aug 2026 22:43:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sparc32: honour phys_base in the viking cache flush
 routines
Message-ID: <20260814204356.GA534878@ravnborg.org>
References: <20260814105723.3454511-1-linmag7@gmail.com>
 <20260814105723.3454511-2-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814105723.3454511-2-linmag7@gmail.com>

Hi Magnus.

On Fri, Aug 14, 2026 at 12:52:32PM +0200, Magnus Lindholm wrote:
> viking_flush_page() and viking_mxcc_flush_page() derive the physical
> address of the page they are asked to flush by subtracting PAGE_OFFSET
> from the kernel virtual address:
> 
> 	sethi	%hi(PAGE_OFFSET), %g2
> 	sub	%o0, %g2, %g3
> 
> That is only the physical address when phys_base is zero. The C side spells
> the same conversion __pa(), which adds phys_base, and every caller passes a
> kernel virtual address expecting exactly that.
> 
> With a kernel loaded away from the start of RAM the two disagree by
> phys_base. viking_flush_page() then compares cache tags against the wrong
> page and flushes nothing, and viking_mxcc_flush_page() streams a page that
> is phys_base lower than the one it was given, so the intended lines stay
> dirty in the cache while unrelated ones are pushed out.
> 
> The visible effect is that anything relying on a flush to make memory
> visible to another bus master silently keeps working from stale data. On a
> SPARCstation 20 this shows up as every SCSI transfer failing with a DMA
> error: iommu_flush_iotlb() cannot get the IOPTEs out to RAM, so the IOMMU
> walks stale entries and the ESP DMA faults.
> 
> Add phys_base, so these agree with __pa() again. No change when phys_base
> is zero, which is why this went unnoticed.
> 
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Looks good, I checked and as the other variants are coherent this
should be the only place we need this.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
