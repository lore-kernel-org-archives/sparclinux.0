Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519C30CD8E;
	Fri, 12 Sep 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681862; cv=none; b=jdWvPuyoejN59aZzddkZJUPiIVTyqxN6a3PsRkdHtYEnshBD/U2KtfRx1O4jVAmrNMaLYPeMtDK0Eph9BpbhXrJZTWRMsSx459sXJ3fR9JdwTbrxFcHo1c7VdZbxal24q5xIRy8xTGwP7eDzKez4a4AemzWL4KwIDHExBqY6L9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681862; c=relaxed/simple;
	bh=nPNp7CgvxMjFNyD85c0vIyAgcirLo8qvT4U2NeokHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du/rA1y5F6qK/n909izi8+5fxdICmRwFTzSejDov3Ioxuo+b5gbVoQvYvgSKqqqJ05sZHq2FtkQw1/WEj6nSQVOz0seWy4MulNDO67EULM8unFJ+9yYoI2LP136LY+jcczZ2ztcp5QBJOXwWJib4ZIqyw1CYr2ccEsVeTL681zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PINgmJaT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PINgmJaT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CAlUZY015991;
	Fri, 12 Sep 2025 12:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=58XwPAOdgj8C/KnRAhD4XHr5Jy4g4v
	ejUcQ6Kbk//CM=; b=PINgmJaTmGHdAT2AF+hgUasxjL9BP3ekGD0+BKKS7KwoK8
	sGABYUGDODVMXQiHgWK+c+K5Qk7qSwsgdR60qqAZLzYDpggZETp3z0psgslZEABv
	bBcX5ESEIDmK3Ssh4H9tOANdUsDC4ve3Ss2+F7gv0b2x4eL+/WuLL75MKzVSTweJ
	BnHNEduw3NBEZJnatPGxz4bNXovlyj8qkSo5dnKOW7TDpBEP+nN+NRBZl40CS5Tr
	qNJ/GWrhyJzczvz2SBRv1DGgGFj+1abS9It+4g1b4P1w7KVsvZsRQWs+fZ5Ni2Pe
	K7Sikg3vWmUIf/JocL9wcnOqBq8GCKYq4CYPpeqQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffuknu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 12:56:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58CCpNN7003042;
	Fri, 12 Sep 2025 12:56:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffuknk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 12:56:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CALT4M007950;
	Fri, 12 Sep 2025 12:56:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109q31gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 12:56:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58CCunWS30671476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 12:56:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EA2220043;
	Fri, 12 Sep 2025 12:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6AEE20040;
	Fri, 12 Sep 2025 12:56:48 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Sep 2025 12:56:48 +0000 (GMT)
Date: Fri, 12 Sep 2025 14:56:47 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v2 2/7] mm: introduce local state for lazy_mmu sections
Message-ID: <248b4623-8755-4323-8a44-be4af30e4856-agordeev@linux.ibm.com>
References: <9de08024-adfc-421b-8799-62653468cf63@arm.com>
 <ef343405-c394-4763-a79f-21381f217b6c@redhat.com>
 <4b4971fd-0445-4d86-8f3a-6ba3d68d15b7@arm.com>
 <4aa28016-5678-4c66-8104-8dcc3fa2f5ce@redhat.com>
 <15d01c8b-5475-442e-9df5-ca37b0d5dc04@arm.com>
 <7953a735-6129-4d22-be65-ce736630d539@redhat.com>
 <781a6450-1c0b-4603-91cf-49f16cd78c28@arm.com>
 <a17ab4e3-627a-4989-a5a5-d430eadabb86@redhat.com>
 <9ed5441f-cc03-472a-adc6-b9d3ad525664-agordeev@linux.ibm.com>
 <74d1f275-23c3-4fd8-b665-503c7fc87df0@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d1f275-23c3-4fd8-b665-503c7fc87df0@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VjJg1bjgqAhkPIFaDf1mLUh7KWJjYCG6
X-Proofpoint-GUID: sT9Q6O7KpHDMezFzmg7Jr_oCplhrH_ZC
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c41895 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=uYqTi1GheQgrfgZHFtwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX5jpC8GUVmzcb
 WNTQnHEt7CYJzjyNcPBhadLwyx9qWJPieT278SgOv0+fgDWmcDKSO9n/bVKVzE2Km2J/kquNqse
 Jo2h4tBAH3Rq2bzLQZKuYkpibwvUYGVvMaMFCBcqCEiBXpyJ/14KPD+uGmPeQ+53nO3UReJyF9T
 vV9SHmTpFlxTvywhGFj1lAohZo5EPieMQrww4F/cF8jq4d9H2qtG/up3a2vR/gmEjopqXn2qMS8
 3cpWLt2lTNHCVrgNs3lbLBPz8/ZfWPrNMNeF/iwV1NkiQwT301stt/rMbx65ewChkpW8jMQrt+D
 mygDppYgjygKsvAP9O23nIW8cFyauWRb1MftHnofDLV/qfCy2wrFGsX2zoH6Hz3rIIVyUeTZ9rw
 xobmB0cV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Fri, Sep 12, 2025 at 02:40:55PM +0200, David Hildenbrand wrote:
> It would just be passing more context down to the architecture, right?

Yes. Namely this one would be arch-defined and arch_enter_lazy_mmu_mode()
by default.

static inline void arch_enter_lazy_mmu_mode_pte(struct mm_struct *mm,
						unsigned long addr,
						unsigned long end,
						pte_t *ptep)
{
	...
}

> David / dhildenb
