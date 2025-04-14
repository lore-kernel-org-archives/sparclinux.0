Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793702D029E;
	Mon, 14 Apr 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639528; cv=none; b=Y977EbC6JLMssf8FFevouduVbZSYDwD9KmYLzgoOkq3hWR9+lu/OSxOPxj8q5yszjTCXwRCtCo/6zvH6nnnm0FGYiaXzPH7tkkqdaznqggjnADAFOQMjVZpwzvzu98/XF0z2RbDzEa0ejQtDl9fgeRlrqlETPMr975jK2/1I5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639528; c=relaxed/simple;
	bh=HMYMErHV6+yJLG42JhO3GcxUwWl55Dfqs34lA1L5jME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl9/l5fjhZBPQ4aME2kF6f/MTw+JuR/VmT10sX5Roab1DIiRA+trmHr8cuXtFRIDSDaMkRVYye9o4w5eI6kPvRNBNdmQ7Zvgit4Y5qIETp7KFgN7HGSPXJFzvzDJiSFRRW3Ocx+e5bRh+e+rJrgS2LhJuUycsIhC7wV10V3YK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DpyD6Udw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DpyD6Udw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EA4ATV027370;
	Mon, 14 Apr 2025 14:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mR/z8wqlahqEQEIdoTwi+iagtqGDJe
	kWvs0xnEoJMPE=; b=DpyD6Udw88tqaPr0fYcs3CazdQ5QWENJPynzyhJZnbNOi5
	zY0G9Hu7PEsJ3TjJG7rVrb/GbHvfITN3AIbtoLh/H0aKWaZX+1eKMHjVLpwTeAUE
	lRbqHvx0K9kSyQT0HXlbLRn1suq7p1N21lpak5cyhNJDX+1kLb81jLSzQe19TM2X
	xKrKJV6i/xFFC2mKilEeszzr+tgbhoVNSPBwhEulRvMdF1Ct68oZPbXVDMaG0p/U
	WXYRkSiwc4AJlRENzE7s4q7aNYIHCvE9+ZUHe6U9seSlEUrtTlhISJ0ht+Fdm4uA
	x4K+2XDTVTvm98SnPR0wm7k4SM2+vbROYs8t7LSA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46109f167h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:04:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EDcZPO016703;
	Mon, 14 Apr 2025 14:04:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460571x6a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:04:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EE4f4G48300418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 14:04:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 212F720043;
	Mon, 14 Apr 2025 14:04:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30D1920040;
	Mon, 14 Apr 2025 14:04:40 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.13.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Apr 2025 14:04:40 +0000 (GMT)
Date: Mon, 14 Apr 2025 16:04:38 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Fix lazy mmu mode
Message-ID: <Z/0V9r6rjEjSH3fh@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250303141542.3371656-1-ryan.roberts@arm.com>
 <912c7a32-b39c-494f-a29c-4865cd92aeba@agordeev.local>
 <5b0609c9-95ee-4e48-bb6d-98f57c5d2c31@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0609c9-95ee-4e48-bb6d-98f57c5d2c31@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xm9MkOqhRW8-TUfXNY7yPIc4SjJFzfI0
X-Proofpoint-ORIG-GUID: Xm9MkOqhRW8-TUfXNY7yPIc4SjJFzfI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140102

On Mon, Apr 14, 2025 at 02:22:53PM +0100, Ryan Roberts wrote:
> On 10/04/2025 17:07, Alexander Gordeev wrote:
> >> I'm planning to implement lazy mmu mode for arm64 to optimize vmalloc. As part
> >> of that, I will extend lazy mmu mode to cover kernel mappings in vmalloc table
> >> walkers. While lazy mmu mode is already used for kernel mappings in a few
> >> places, this will extend it's use significantly.
> >>
> >> Having reviewed the existing lazy mmu implementations in powerpc, sparc and x86,
> >> it looks like there are a bunch of bugs, some of which may be more likely to
> >> trigger once I extend the use of lazy mmu.
> > 
> > Do you have any idea about generic code issues as result of not adhering to
> > the originally stated requirement:
> > 
> >   /*
> >    ...
> >    * the PTE updates which happen during this window.  Note that using this
> >    * interface requires that read hazards be removed from the code.  A read
> >    * hazard could result in the direct mode hypervisor case, since the actual
> >    * write to the page tables may not yet have taken place, so reads though
> >    * a raw PTE pointer after it has been modified are not guaranteed to be
> >    * up to date.
> >    ...
> >    */
> > 
> > I tried to follow few code paths and at least this one does not look so good:
> > 
> > copy_pte_range(..., src_pte, ...)
> > 	ret = copy_nonpresent_pte(..., src_pte, ...)
> > 		try_restore_exclusive_pte(..., src_pte, ...)	// is_device_exclusive_entry(entry)
> > 			restore_exclusive_pte(..., ptep, ...)
> > 				set_pte_at(..., ptep, ...)
> > 					set_pte(ptep, pte);	// save in lazy mmu mode
> > 
> > 	// ret == -ENOENT
> > 
> > 	ptent = ptep_get(src_pte);				// lazy mmu save is not observed
> > 	ret = copy_present_ptes(..., ptent, ...);		// wrong ptent used
> > 
> > I am not aware whether the effort to "read hazards be removed from the code"
> > has ever been made and the generic code is safe in this regard.
> > 
> > What is your take on this?
> 
> Hmm, that looks like a bug to me, at least based on the stated requirements.
> Although this is not a "read through a raw PTE *pointer*", it is a ptep_get().
> The arch code can override that so I guess it has an opportunity to flush. But I
> don't think any arches are currently doing that.
> 
> Probably the simplest fix is to add arch_flush_lazy_mmu_mode() before the
> ptep_get()?

Which would completely revert the very idea of the lazy mmu mode?
(As one would flush on every PTE page table iteration).

> It won't be a problem in practice for arm64, since the pgtables are always
> updated immediately. I just want to use these hooks to defer/batch barriers in
> certain cases.
> 
> And this is a pre-existing issue for the arches that use lazy mmu with
> device-exclusive mappings, which my extending lazy mmu into vmalloc won't
> exacerbate.
> 
> Would you be willing/able to submit a fix?

Well, we have a dozen of lazy mmu cases and I would guess it is not the
only piece of code that seems affected. I was thinking about debug feature
that could help spotting all troubled locations.

Then we could assess and decide if it is feasible to fix. Just turning the
code above into the PTE read-modify-update pattern is quite an exercise...

> Thanks,
> Ryan
