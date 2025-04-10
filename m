Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD61E9B14;
	Thu, 10 Apr 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301350; cv=none; b=QaOqa2KbLdXCsJhvFONJ/jtICZuGnLdICImUV0DlGpsioWeCaxY2aaSpSNf1Q7yiTWzuegOVPgpSJ9dcJ1+FLoDoNz4MgynAMCQxNGqwQI/L9D91PwK0Hap+6zaNVy7n1BdpS37baCgb6BSoOZrE8VeBSpINN0ARtbtx71A6qZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301350; c=relaxed/simple;
	bh=Dm4Kh3MvKTubnFzQYLat7M3s+XFsAC2SkpBaJhEWgf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT0sqSgmcsPhey3hnE82CZt9M6J9fnhbA5obGTX8RhXYD1nu/BP1YtQr9TfTwFfD0BAn1aJABY1AbiXpCyCW/mvT+2K+Jvg56xOIAR1HNBXHdeOKKDTVZx7HyjSKBTazRSeKjc26MHkHWBBdfwTVdx0yn65L47PyRuDMNLJHacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KeFXTRMr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KeFXTRMr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9vhWL025345;
	Thu, 10 Apr 2025 16:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Jmp1TuG2rk5K6Ce5PuPbd2zgfuoBes
	e75oMt4oJEqFw=; b=KeFXTRMrvncRLBLOSZihPcfH8PnGHMOqw/mHIMC9+jcV7r
	3tbCvVZgLf/TazLxRstYbgeSilvo9dnkQrP8GLZmdCLP7hdgfS+pkqs9INITQDkg
	T2HE3mA0tY6cCiOjFIeFG4XrbkilmiOfe4bJ2uXJGkSGYpDWZPzJpRf8Q8UfqalD
	1CebmuMJfdmCLXHOg3FqkHKYI/Ii9HIld7NTTOecyj72tFJzSX9SlqDWmWk5FBk1
	ZqLBZaAIh98rcIrrrmwglOKbYKDbWtxoar9QCagJyJPXCGZkd7ppURgrDNEYz5xA
	RkTJiRkBoXLMNPSqxBNFta7pxtSKrRmzyuagJ/7g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ww2xettf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 16:07:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADaw5Y013858;
	Thu, 10 Apr 2025 16:07:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunxs3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 16:07:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AG7p5N34996542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 16:07:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3550B2004B;
	Thu, 10 Apr 2025 16:07:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52D020040;
	Thu, 10 Apr 2025 16:07:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Apr 2025 16:07:50 +0000 (GMT)
Date: Thu, 10 Apr 2025 18:07:49 +0200
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
Message-ID: <912c7a32-b39c-494f-a29c-4865cd92aeba@agordeev.local>
References: <20250303141542.3371656-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303141542.3371656-1-ryan.roberts@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JX9GiUvvsSXRJxqGU54xz_Dphrw8Y78U
X-Proofpoint-ORIG-GUID: JX9GiUvvsSXRJxqGU54xz_Dphrw8Y78U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=896 bulkscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100116

On Mon, Mar 03, 2025 at 02:15:34PM +0000, Ryan Roberts wrote:

Hi Ryan,

> I'm planning to implement lazy mmu mode for arm64 to optimize vmalloc. As part
> of that, I will extend lazy mmu mode to cover kernel mappings in vmalloc table
> walkers. While lazy mmu mode is already used for kernel mappings in a few
> places, this will extend it's use significantly.
> 
> Having reviewed the existing lazy mmu implementations in powerpc, sparc and x86,
> it looks like there are a bunch of bugs, some of which may be more likely to
> trigger once I extend the use of lazy mmu.

Do you have any idea about generic code issues as result of not adhering to
the originally stated requirement:

  /*
   ...
   * the PTE updates which happen during this window.  Note that using this
   * interface requires that read hazards be removed from the code.  A read
   * hazard could result in the direct mode hypervisor case, since the actual
   * write to the page tables may not yet have taken place, so reads though
   * a raw PTE pointer after it has been modified are not guaranteed to be
   * up to date.
   ...
   */

I tried to follow few code paths and at least this one does not look so good:

copy_pte_range(..., src_pte, ...)
	ret = copy_nonpresent_pte(..., src_pte, ...)
		try_restore_exclusive_pte(..., src_pte, ...)	// is_device_exclusive_entry(entry)
			restore_exclusive_pte(..., ptep, ...)
				set_pte_at(..., ptep, ...)
					set_pte(ptep, pte);	// save in lazy mmu mode

	// ret == -ENOENT

	ptent = ptep_get(src_pte);				// lazy mmu save is not observed
	ret = copy_present_ptes(..., ptent, ...);		// wrong ptent used

I am not aware whether the effort to "read hazards be removed from the code"
has ever been made and the generic code is safe in this regard.

What is your take on this?

Thanks!
