Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11AB2E3E8;
	Wed,  8 May 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190108; cv=none; b=cdD4Sxe8ZH0gf4aZRTnGfBtKtvWzqF7gLZfwvXwF36VfXHEp6mSIvGmKGpnlNCScF/dv8uJFln7fDUbe/hiS7dfEMI/Fobl9206bOTDDaecOXmlKC942camYtahsqhvFkOgcd6G71JyYityrs6t5KOz8X0Z0ha39XMvwMx2RH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190108; c=relaxed/simple;
	bh=IiR4SdqEVfpLMIvkfN2nNdhAA3VmaICpuxaPIz4gPUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abG/sUXTGr7TGUsPazGVQ6OrwT/19ZfzOCRiHvyHVZlUsFIeIYb70I0/uaGD/v0M3lPBPetyw8fzA5010SRQHTyfz+wFpPOZFNG0heJAi7ATv9lVxvkvl/zTI8FxjxwEBmPSrG1TJCXEnv4DCxuWh9nRAYOvMSQOrFAxQWQQhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=jWCfjxFS; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="jWCfjxFS"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VZMf30Vgvz682x;
	Wed,  8 May 2024 19:32:11 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VZMf24mdQz67yg;
	Wed,  8 May 2024 19:32:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1715189531;
	bh=SOJNho+VRhSE+48vSA0Z0GxI1ApE1Uw/XOa1wvD9TU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jWCfjxFScjkVKzG2nqlG9dJ7VWlkyRAwKbivcZ3G2H5sVAamIndSrr4HGjRwtzXsT
	 R7y0BqnKNiIaJCVCOri/6Pm3BbADtvI8omJS9HwBOzBJFqPM7XGdBKGliN7tVmwprU
	 1fCQe8gV2uuY7hpELd9UbctyXfRg0K5bE/mQdlBU=
Message-ID: <c58d729a-4d8a-4a19-9313-85fa33b5d0af@gaisler.com>
Date: Wed, 8 May 2024 19:32:08 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] sparc/srmmu: Remove on-stack cpumask var
To: Dawei Li <dawei.li@shingroup.cn>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <20240424025548.3765250-1-dawei.li@shingroup.cn>
 <20240424025548.3765250-2-dawei.li@shingroup.cn>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240424025548.3765250-2-dawei.li@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-24 04:55, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_any_but() to avoid the need for a temporary cpumask on
> the stack and simplify code.
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  arch/sparc/mm/srmmu.c | 40 ++++++++++++----------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 852085ada368..9df51a62333d 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -1653,13 +1653,15 @@ static void smp_flush_tlb_all(void)
>  	local_ops->tlb_all();
>  }
>  
> +static bool any_other_mm_cpus(struct mm_struct *mm)
> +{
> +	return cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids;
> +}
> +
>  static void smp_flush_cache_mm(struct mm_struct *mm)
>  {
>  	if (mm->context != NO_CONTEXT) {
> -		cpumask_t cpu_mask;
> -		cpumask_copy(&cpu_mask, mm_cpumask(mm));
> -		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> -		if (!cpumask_empty(&cpu_mask))
> +		if (any_other_mm_cpus(mm))
>  			xc1(local_ops->cache_mm, (unsigned long)mm);
>  		local_ops->cache_mm(mm);
>  	}
> @@ -1668,10 +1670,7 @@ static void smp_flush_cache_mm(struct mm_struct *mm)
>  static void smp_flush_tlb_mm(struct mm_struct *mm)
>  {
>  	if (mm->context != NO_CONTEXT) {
> -		cpumask_t cpu_mask;
> -		cpumask_copy(&cpu_mask, mm_cpumask(mm));
> -		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> -		if (!cpumask_empty(&cpu_mask)) {
> +		if (any_other_mm_cpus(mm)) {
>  			xc1(local_ops->tlb_mm, (unsigned long)mm);
>  			if (atomic_read(&mm->mm_users) == 1 && current->active_mm == mm)
>  				cpumask_copy(mm_cpumask(mm),
> @@ -1688,10 +1687,7 @@ static void smp_flush_cache_range(struct vm_area_struct *vma,
>  	struct mm_struct *mm = vma->vm_mm;
>  
>  	if (mm->context != NO_CONTEXT) {
> -		cpumask_t cpu_mask;
> -		cpumask_copy(&cpu_mask, mm_cpumask(mm));
> -		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> -		if (!cpumask_empty(&cpu_mask))
> +		if (any_other_mm_cpus(mm))
>  			xc3(local_ops->cache_range, (unsigned long)vma, start,
>  			    end);
>  		local_ops->cache_range(vma, start, end);
> @@ -1705,10 +1701,7 @@ static void smp_flush_tlb_range(struct vm_area_struct *vma,
>  	struct mm_struct *mm = vma->vm_mm;
>  
>  	if (mm->context != NO_CONTEXT) {
> -		cpumask_t cpu_mask;
> -		cpumask_copy(&cpu_mask, mm_cpumask(mm));
> -		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> -		if (!cpumask_empty(&cpu_mask))
> +		if (any_other_mm_cpus(mm))
>  			xc3(local_ops->tlb_range, (unsigned long)vma, start,
>  			    end);
>  		local_ops->tlb_range(vma, start, end);
> @@ -1720,10 +1713,7 @@ static void smp_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
>  	struct mm_struct *mm = vma->vm_mm;
>  
>  	if (mm->context != NO_CONTEXT) {
> -		cpumask_t cpu_mask;
> -		cpumask_copy(&cpu_mask, mm_cpumask(mm));
> -		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> -		if (!cpumask_empty(&cpu_mask))
> +		if (any_other_mm_cpus(mm))
>  			xc2(local_ops->cache_page, (unsigned long)vma, page);
>  		local_ops->cache_page(vma, page);
>  	}
> @@ -1734,10 +1724,7 @@ static void smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
>  	struct mm_struct *mm = vma->vm_mm;
>  
>  	if (mm->context != NO_CONTEXT) {
> -		cpumask_t cpu_mask;
> -		cpumask_copy(&cpu_mask, mm_cpumask(mm));
> -		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> -		if (!cpumask_empty(&cpu_mask))
> +		if (any_other_mm_cpus(mm))
>  			xc2(local_ops->tlb_page, (unsigned long)vma, page);
>  		local_ops->tlb_page(vma, page);
>  	}
> @@ -1759,10 +1746,7 @@ static void smp_flush_page_to_ram(unsigned long page)
>  
>  static void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
>  {
> -	cpumask_t cpu_mask;
> -	cpumask_copy(&cpu_mask, mm_cpumask(mm));
> -	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> -	if (!cpumask_empty(&cpu_mask))
> +	if (any_other_mm_cpus(mm))
>  		xc2(local_ops->sig_insns, (unsigned long)mm, insn_addr);
>  	local_ops->sig_insns(mm, insn_addr);
>  }

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

