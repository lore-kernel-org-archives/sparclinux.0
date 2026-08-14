Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE652E3FE
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740419; cv=none; b=NOJULR7+sUZysPC7Q+qjQFKEwHCzDBRoY1Tc270Ngrlkh3wEIhXi2WZKVzS9j+eX+rWYBwAWnsQCUyZZ3IIDSPw/OP4WbKRVOvKEx/n6+BjG1SXMbOvLX5AJG+UAU2AP/qG3SZttWhouqTOXDUfy0W1Amy/mYe7CO2m9KHaL/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740419; c=relaxed/simple;
	bh=4oMEG3leINCAxl/tEkDvA9HTFLSxYZzkFE6e++cuJoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7iQP+wcW3UB3dUO5KTAS4/vrHI4w6g6QoIaKKpfE+q/4xUvXDXvIGnT3AOc93YYKvQY5fmk2Jwm+4xlwBGV0v9OlyK7yR9GbXfeJOqOlY8NzQU9yntGaP7gAzxmMAxWHF4KS2bgd61Q7LlX7MsxJh0W6F5FN9Zw6eRn+1FeR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=dBx12h3W; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=9RWANs3S; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="dBx12h3W";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="9RWANs3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786740414; x=1787345214;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=0gomNESFBq8WBiPUuyH86V03gV2HH2aOpdzggAGk0tM=;
	b=dBx12h3WtyJaGQfvkoVau3Jk1G4cwd7hjbLtKzM5h8E7ljkz2DWuLqCcQMlilaXOE4EF857RyUGtC
	 7ZshyT2QCThL5ZGZSDNT4G3VYD9UYuZZ0FEWyWpMMJ5+jDahMz6/ia0TaKXGOFjTLDDbeemJEFsH04
	 vB02noK+uea95Botf3U7QkEu5TdT3bjG7uspPiTJpIB/jBhjA/gJYvKVPBJWCHZcQFbhTkpwC8VC7T
	 Ve3CIFnxMJe9j23AjjUqK3zNY3zH5vBUYZRZJ32O+bCDL0Q0p++WUU3AFcy5zdXr4I7m4p0nWvrMMm
	 UGjwLg9TEeN1lU6UvgeoEvr6gzPQHBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786740414; x=1787345214;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=0gomNESFBq8WBiPUuyH86V03gV2HH2aOpdzggAGk0tM=;
	b=9RWANs3SHGb6Hbs4sa3T+7DszCTsAHYW5mbpPzKBoXYAinz1hpk5FQvoO9LQ5MtYty1Wfn5x5Gl2N
	 zO76ydsCg==
X-HalOne-ID: 468ced16-9821-11f1-bbcc-6bcdb618a7d0
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:173:77b0:ce00:a307])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 468ced16-9821-11f1-bbcc-6bcdb618a7d0;
	Fri, 14 Aug 2026 20:46:53 +0000 (UTC)
Date: Fri, 14 Aug 2026 22:46:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sparc32: derive phys_base from the PAGE_OFFSET
 mapping
Message-ID: <20260814204652.GB534878@ravnborg.org>
References: <20260814105723.3454511-1-linmag7@gmail.com>
 <20260814105723.3454511-3-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814105723.3454511-3-linmag7@gmail.com>

Hi Magnus.

On Fri, Aug 14, 2026 at 12:52:33PM +0200, Magnus Lindholm wrote:
> setup_arch() computes phys_base as the base of the lowest sp_banks[]
> entry, that is, where RAM starts, and assumes the kernel image was loaded
> there. That holds for the traditional boot path, where SILO places the
> image at physical 0x4000 and PAGE_OFFSET is mapped to physical 0.
> 
> It stops holding once the image no longer fits there. SILO loads a kernel
> between physical 0x4000 and its own text at 0x280000, a window of 2605056
> bytes; a current sparc32 kernel is roughly twice that. The loader must
> then place the image elsewhere in physical memory and map PAGE_OFFSET to
> it, at which point phys_base describes where RAM begins rather than what
> PAGE_OFFSET maps to, and the two disagree.
> 
> phys_base is the offset __pa() and __va() are defined in terms of, so once
> it is wrong every early translation is wrong by the difference, including
> the physical addresses written into page table descriptors. The
> tablewalker then follows pointers into pages that hold nothing while the
> same tables read back correctly through the nocache view. The failure
> surfaces as a hang right after the context table pointer is installed and
> the TLB flushed, with nothing on the console to explain it, since the PROM
> mappings the early console depends on have become just as unreachable.
> 
> Ask the MMU what PAGE_OFFSET actually translates to and adopt that.
> __get_phys() already implements this probe for sun4m and sun4d and returns
> zero elsewhere, so no new low level MMU access is introduced and machines
> without an SRMMU are unaffected.
> 
> Memory below the kernel cannot be reached through the linear map, which
> runs upward from PAGE_OFFSET, so drop the banks that fall below it rather
> than leave entries that __va() would translate to below PAGE_OFFSET.
> 
> With this a 6MB kernel loaded at physical 0x03000000 boots on sun4m: the
> context table lands at its true physical address,
> srmmu_inherit_prom_mappings() preserves the PROM console mappings, and
> srmmu.c needs no change at all, since map_kernel() already handles a
> non-zero phys_base via do_large_mapping().
> 
> The cost is the RAM below the load address the loader chose. SILO's
> memory_find() picks 48MB on machines with 64MB or more.
> 
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  arch/sparc/kernel/setup_32.c | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index 1b0db16cd37b..795714959da6 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -254,6 +254,30 @@ static __init void leon_patch(void)
>  
>  struct tt_entry *sparc_ttable;
>  
> +/* Drop RAM below the kernel; the linear map runs upward from phys_base
> + * and cannot reach it.
> + */
> +static void __init trim_sp_banks_below(unsigned long base)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> +		unsigned long start = sp_banks[i].base_addr;
> +		unsigned long end = start + sp_banks[i].num_bytes;
> +
> +		if (end <= base)
> +			continue;		/* wholly below - drop it */
> +		if (start < base)
> +			start = base;		/* straddles - trim the front */
> +
> +		sp_banks[j].base_addr = start;
> +		sp_banks[j].num_bytes = end - start;
> +		j++;
> +	}
> +	sp_banks[j].base_addr = 0;
> +	sp_banks[j].num_bytes = 0;
> +}
OK

> +
>  /* Called from head_32.S - before we have setup anything
>   * in the kernel. Be very careful with what you do here.
>   */
> @@ -332,6 +356,22 @@ void __init setup_arch(char **cmdline_p)
>  		if (highest_paddr < top)
>  			highest_paddr = top;
>  	}
> +
> +	/* phys_base must describe what PAGE_OFFSET maps to, not where RAM starts. */
> +	{
> +		unsigned long real_base = __get_phys(PAGE_OFFSET);
> +
> +		if (real_base && real_base != phys_base) {
> +			prom_printf("phys_base: RAM starts 0x%x but kernel is at 0x%x\n",
> +				    (unsigned int)phys_base,
> +				    (unsigned int)real_base);
> +			phys_base = real_base;
> +			trim_sp_banks_below(phys_base);
> +			prom_printf("phys_base: adopted 0x%x, RAM below it dropped\n",
> +				    (unsigned int)phys_base);
Use 0x%xl to avoid the casts?
If we are noisy like this it would be nice to always print the RAM start
and kernel start.

The logic looks fine, just the few nits.

	Sam
