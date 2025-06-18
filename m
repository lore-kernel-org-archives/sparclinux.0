Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2102EAB6A
	for <sparclinux@vger.kernel.org>; Wed, 18 Jun 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267954; cv=none; b=RE9rOmGk/bhuDyPf/1rLT+uVYJKAyVvd9SrZEd30AkTrWELUL2e0Frd0utYEUWWBuPXPOkIHGc6HXg9wBFQgYV9GJhM/zCyYUNddkjgZSSY+JGQuNdEIxYgSlP9QWs850N4zaDE4w0oGK7uZhKF0ZjcXSQlqUFm4vOEwzIhHZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267954; c=relaxed/simple;
	bh=v4oN1Zbt/jqOeCuJzUI6GMQJVeCDE6fmJeTQzN10rck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sQgY5Fy5GHmLjT2bmLYYWlkfb4CHoPyknYLY//tdrfKh6xmUm3Gmj8y1QtqZ4jvustMcItUazZKaLMyL/LRrPJD9tG0MOlgSU9OR5NlBK3mRZUvGEHdlw30ecYF9JfswNnBRCJKEHAW+VaqNLm16S5Pvxu9CIGRusecvq02MohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBMkUFIW; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBMkUFIW"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40667dc8a62so3909541b6e.0
        for <sparclinux@vger.kernel.org>; Wed, 18 Jun 2025 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750267951; x=1750872751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPaDHCf4QQfYtlFAEXP1n0ACjJsy8xyFFkSONW+4dVI=;
        b=uBMkUFIWiIA7sJChNVbe9BKjQte5E+weUv1Ed7bF8vH2pbb8ImwdK8Zp9gqRMZtNxN
         pRObl9ZhXpekm+eAqzswKGP87e3KAA1216BLNq/7yLm5CONfXPIbMhV+dg7hLecpxlMH
         Ot3te0QDzUgybup5T0IKldN2O20SCfA3jEXYZHYSo9NehFUUJ8uE6W6ggeO1sQX+Ri8W
         vsXmgPpVBIli0ErAHmTSYVCF6Y91bsq/we6D4hKlvVE91aychnWMRWgER0Qfu3d9R81O
         vziKqOkE5AH673PvlyGTPAwLQqyJ5qVSA3ZzGtF9y3/lPdxgVNNXeQCFk6YMan/8DGHJ
         pc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750267951; x=1750872751;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPaDHCf4QQfYtlFAEXP1n0ACjJsy8xyFFkSONW+4dVI=;
        b=djtoB+OIZQIj5cS2sJztAAFOmsuO8CMPLPkO6ZJnExcikRGlg33/cfAGXmF2k4akNG
         lmBIW8KJc1QHa4Ry8Z/hf55r6pZ3dcCuvc5hY0bC4u3/z3kCcMP9lEGsvhs83ab3K90l
         Av1ekfCLIizlOT6YCl7auTvixxhGI9VNCFLecHr9sQ6wYHS9BPAhM5f90T9qs3Jx8ol+
         TzsGNPw4b2UJXKXUCAgYe028M29OIEr9zhR7zcd9bzE8suTcsbKzjnXfCFGPQ0J5nWFG
         MY2li4jdQqlTLEeouMOEkrR4sZvVHNQwEzfHdWi/wmi+kemgxpbJnz7PcuOhTlgD6HV5
         obww==
X-Forwarded-Encrypted: i=1; AJvYcCXqg4w+8oKJiTsjjLZEyAMzz2QgjrtGSr68/ABBcnhLvlnIJ+0n0R4hR+Kzbz96Snwde5b7WSequTYx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2LdqUf9QoXrasEQN4vR8gRlzTpjBIkblm3ugaQfL5i6TVfhx
	x7TpXUjXZJogEYM/83v8h5QtWR92+KXtDsj+Bq2FDn6tHA+pnAgJIQ8FQPeZw4cnkeQ=
X-Gm-Gg: ASbGncvdQtMrA+E4CaADtEGioAfTQTR6uGUMjjtXXPKc8GsrkjPUBjU1UqFrOPkFQhd
	gNQfMqUQ6cuhmrnILb3kpx/ss8hqNkoLBWEmRlbfXmwvZcO907+vNqCJ8CnL+WoEe0vM4XXCtE/
	4PtqGGMy7dFOx0aN78heqwgKQhYlE9gvhryEMJUYYyN70sJFvu0J6dAt41HtXF1YuHeLg1PxLqY
	Aq1la37+j7FzoY1HRYIHwYpMrYqvaUJPKeLwzxFKcCCM8PeDsN3i8F0u/Y25XKmxz5Fn9yHukDd
	UBUtI8Syc4a0t7V3XUMKiwYocAqSBOqQMSIYMyL8j41AjQjuOPMynGWx6mDJuZ7lJng+Xw==
X-Google-Smtp-Source: AGHT+IEhmsXj/9aFuinmgp9fFM5zxL8AzdLs118MWezycsaLkbKoWiwnYgYHLgU6A9s7/1JQmPa7zA==
X-Received: by 2002:a05:6808:1523:b0:403:5150:c348 with SMTP id 5614622812f47-40a7c11902fmr11343414b6e.4.1750267951380;
        Wed, 18 Jun 2025 10:32:31 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a740c2484sm2410989b6e.13.2025.06.18.10.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 10:32:30 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:32:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 2/6] mm: Lock kernel page tables before entering lazy MMU
 mode
Message-ID: <0be7d42e-5898-4b94-829b-59c661c2f07b@suswa.mountain>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd3a45dbc375dc2c15cebae09cb2bb972d6039f.1749747752.git.agordeev@linux.ibm.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Gordeev/mm-Cleanup-apply_to_pte_range-routine/20250613-013835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/7bd3a45dbc375dc2c15cebae09cb2bb972d6039f.1749747752.git.agordeev%40linux.ibm.com
patch subject: [PATCH 2/6] mm: Lock kernel page tables before entering lazy MMU mode
config: x86_64-randconfig-161-20250613 (https://download.01.org/0day-ci/archive/20250613/202506132017.T1l1l6ME-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202506132017.T1l1l6ME-lkp@intel.com/

smatch warnings:
mm/vmalloc.c:552 vmap_pages_pte_range() warn: inconsistent returns 'global &init_mm.page_table_lock'.

vim +552 mm/vmalloc.c

0a264884046f1ab Nicholas Piggin   2021-04-29  517  static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
2ba3e6947aed9bb Joerg Roedel      2020-06-01  518  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
2ba3e6947aed9bb Joerg Roedel      2020-06-01  519  		pgtbl_mod_mask *mask)
^1da177e4c3f415 Linus Torvalds    2005-04-16  520  {
^1da177e4c3f415 Linus Torvalds    2005-04-16  521  	pte_t *pte;
^1da177e4c3f415 Linus Torvalds    2005-04-16  522  
db64fe02258f150 Nicholas Piggin   2008-10-18  523  	/*
db64fe02258f150 Nicholas Piggin   2008-10-18  524  	 * nr is a running index into the array which helps higher level
db64fe02258f150 Nicholas Piggin   2008-10-18  525  	 * callers keep track of where we're up to.
db64fe02258f150 Nicholas Piggin   2008-10-18  526  	 */
db64fe02258f150 Nicholas Piggin   2008-10-18  527  
2ba3e6947aed9bb Joerg Roedel      2020-06-01  528  	pte = pte_alloc_kernel_track(pmd, addr, mask);
^1da177e4c3f415 Linus Torvalds    2005-04-16  529  	if (!pte)
^1da177e4c3f415 Linus Torvalds    2005-04-16  530  		return -ENOMEM;
44562c71e2cfc9e Ryan Roberts      2025-04-22  531  
dac0cc793368851 Alexander Gordeev 2025-06-12  532  	spin_lock(&init_mm.page_table_lock);
44562c71e2cfc9e Ryan Roberts      2025-04-22  533  	arch_enter_lazy_mmu_mode();
44562c71e2cfc9e Ryan Roberts      2025-04-22  534  
^1da177e4c3f415 Linus Torvalds    2005-04-16  535  	do {
db64fe02258f150 Nicholas Piggin   2008-10-18  536  		struct page *page = pages[*nr];
db64fe02258f150 Nicholas Piggin   2008-10-18  537  
c33c794828f2121 Ryan Roberts      2023-06-12  538  		if (WARN_ON(!pte_none(ptep_get(pte))))
db64fe02258f150 Nicholas Piggin   2008-10-18  539  			return -EBUSY;
db64fe02258f150 Nicholas Piggin   2008-10-18  540  		if (WARN_ON(!page))
^1da177e4c3f415 Linus Torvalds    2005-04-16  541  			return -ENOMEM;
4fcdcc12915c707 Yury Norov        2022-04-28  542  		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
4fcdcc12915c707 Yury Norov        2022-04-28  543  			return -EINVAL;

These error paths don't unlock &init_mm.page_table_lock?

4fcdcc12915c707 Yury Norov        2022-04-28  544  
^1da177e4c3f415 Linus Torvalds    2005-04-16  545  		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
db64fe02258f150 Nicholas Piggin   2008-10-18  546  		(*nr)++;
^1da177e4c3f415 Linus Torvalds    2005-04-16  547  	} while (pte++, addr += PAGE_SIZE, addr != end);
44562c71e2cfc9e Ryan Roberts      2025-04-22  548  
44562c71e2cfc9e Ryan Roberts      2025-04-22  549  	arch_leave_lazy_mmu_mode();
dac0cc793368851 Alexander Gordeev 2025-06-12  550  	spin_unlock(&init_mm.page_table_lock);
2ba3e6947aed9bb Joerg Roedel      2020-06-01  551  	*mask |= PGTBL_PTE_MODIFIED;
^1da177e4c3f415 Linus Torvalds    2005-04-16 @552  	return 0;
^1da177e4c3f415 Linus Torvalds    2005-04-16  553  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

