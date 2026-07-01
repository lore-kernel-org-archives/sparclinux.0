Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D93BB126
	for <sparclinux@vger.kernel.org>; Wed,  1 Jul 2026 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892069; cv=none; b=mj06afYp2E5dRfB2ZsuJjuVG+49HWHL+tcEgRBTquUyO/ZBXZS2vZLs13q2FBFc3gXGUwjKsa82y6NepWJpEQhUkB+orq3EOwy9t3ws3s4W42DisXP5xU0GUggoJKdKWC4XjIXQxOdwjnqnXREtX2Gml/wwrr0dy6DsgzLX9Emc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892069; c=relaxed/simple;
	bh=yfjzU0KmGln7hjJBe3II97fq/ldZg9TJRBjLk+zMvAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+1FlBAhZda+ey8rVlLKEyeCPW2X0Q3m5wgOK5dCs80GP6t8u8pEhmFDG2p5DuvwEYzno93w5vrQCcT0+CFAXpg1TrKiGFjnuB+GwX9iZBBhTWp5TcWSYPr+oHZ3jC7OU4MZGc/Du6ougz6sNfh81EMyKRW5aGVhZTogr8s2/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WY2RJu67; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OkqRvQ8H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WY2RJu67";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OkqRvQ8H"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lj8P026070
	for <sparclinux@vger.kernel.org>; Wed, 1 Jul 2026 07:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dEWtdTAHqA8hd6AGc7LBd9M+QPf+f5oKuJGFwhYdbIM=; b=WY2RJu67VLHvQJ32
	1OKJlZNJIXAJByudwZGbrQA9uRqrVfY/ixF77iI5yzwHe+hZBxp6KvNFcezUD24P
	PEvh54vbLG4Hegu9YXgz9DwuBxjAfz/Gpesnd2/UgmZc3kG768ZU+xyK5wjti5e9
	qavcXa6+3jBA+ZWUmFO0GxjlSfnl+HzYPgSFfdECy/A/P2KbtTdOCDL1LhPDVVeB
	rnf82+KAtN/ztk0Db+esChQG0Pm0WJX5o+dYEexsbZCYm+6RsySEC/W3NsrDz/Ux
	JFNknuOMWBn4e+0SebBjqK9NxtbhImI8oCFmyZMHA4q+lvbyykjW9gNB685Ddrh4
	VkCH8g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd3hsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sparclinux@vger.kernel.org>; Wed, 01 Jul 2026 07:47:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92b8fc5cc89so40216085a.2
        for <sparclinux@vger.kernel.org>; Wed, 01 Jul 2026 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892066; x=1783496866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEWtdTAHqA8hd6AGc7LBd9M+QPf+f5oKuJGFwhYdbIM=;
        b=OkqRvQ8H4ABUJzWYBPQ9uygbmTf0fj/dtSvOk/gah2PO0sIPom4anMrcCxcfx/XJd9
         NcpA7/V56Ps5wSp0DKSUEGhrvNFn92/Pp5RQhuhDgPGRPgFGjk2x74OPcSRd9Bdj4hCc
         DhEOcEc233nf3SPB0EkKY4kUpNSnNN0vodLzB4k54PLcUHUfKOhqKnAjQlGdra4IxAnH
         5+2J+rxvBdxOuervPkElsOswDj5/0Psm6BBOvb0Okr6d6dRoBZ0J0yM6VSWSF3vCOCi+
         7/nlGYe2P8ZcB1Cmv/X2/lg6LzRhoARVrueWBH6r+7wLwZXGeAXKR7MQj28Zyhy+WPVn
         CCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892066; x=1783496866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEWtdTAHqA8hd6AGc7LBd9M+QPf+f5oKuJGFwhYdbIM=;
        b=ZrII1JjibzvqW0oiNjBSZdQ5ENJKDy1KNvLDLx8SOpRw2BhzhXy5npxRnNFdee3Iww
         V7ibGXjL3TO+Vq8ukdwCwS87Oury/KySsn801KKvWlbdxfI2Ry9c2e6G05T6i7megkMF
         +IeOf1JeDhudOl5zdXMl6cHfEiJ2rofLSspNVJPmkwDfwEUFPVTpSSJWqXrpdMPkp+fW
         gAGgdppAHUlaKKSrY4xVpBWBK9hHck0XvZVBRSrVuZ03V7aWm6wZo4TAFa81rKl9Ew13
         Utx3Q+gAe45CRD9bLAy6eAMqNra9A01eqdwUCfN8mflxmJvGhpFkUEQ6W0F3tgX+5CRa
         DEww==
X-Forwarded-Encrypted: i=1; AFNElJ/5TRMxIvM3olc76r8pgFr9JOvc8XvQ2o0ha9dbF2Wn2aHIyVeLla1rNZsDiOTo7gypc3U+HJ0wZWfI@vger.kernel.org
X-Gm-Message-State: AOJu0YybPSyse1sHI63FoS2s8a/TrDpM+5zhpa5mtH6FlHUu40t9vSme
	N+UKMJ0uRTkk9+3ZaFXDassmiXjKrHlH18XIQ4B6htgoslPvpNyc3CtjQhDRyzKW8NwDvCQdYVo
	Nv/PCP30S1Bqux9FnULOdQ4aeJX4tD4fIxgYJmda36NAiV1LkIKs00iuz+fGDpqud
X-Gm-Gg: AfdE7cknx+cDqZsoNkVESXJljGat8cjk3FN2lE7SzTGS1vbkJL//J1NTDsGLacu5jFr
	s831glFW/qQO4+s8rGlutllFb9FhDoI0hD+XMBsMmbi+96D1VSCa6b+1FtCaeIeVf7jJ4bNLok9
	gvI2pJBe2d131A4We5sonMbDVrZoFtP57+qgULZxEkhg/ZlOkXtAN/CAMSkLjx9KdzZG+dVfGAe
	d8dxd9IvSciHLogVVlFRsLbHRcpEbdfjPiFJMDqEOQrYqv8T3IlqeVQMdGtAqXqizk8VNiDX1A1
	BoVUEgGIN8fwKX+GFss7gsU4Bxp36z+OVf6GEyl3gqeB9Sx04DIU2apyzZqLpBfrezPJwMEAaGm
	uN1hBnjaZDnqqEr2Yd4kBPKaeulVrrrjhfRzet+eh5WPZ1n8cd+0mqfD7+2vGOA==
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr78274485a.9.1782892066297;
        Wed, 01 Jul 2026 00:47:46 -0700 (PDT)
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr78272185a.9.1782892065821;
        Wed, 01 Jul 2026 00:47:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be82fd71sm77510895e9.15.2026.07.01.00.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:47:42 -0700 (PDT)
Message-ID: <0d210cc9-5565-47e9-904f-3e8dbd910d6f@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:47:32 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] vdso/gettimeofday: Validate system call existence
 for time() and gettimeofday()
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-2-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-2-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX7tILrhfWoCpm
 eRChbq3rjhHRZZJdYj9S6LHEoI648qmN4t+9OZZNZDHzpWUcIt9GIcLRyD/Jwz09n5tKS6NimyF
 7NmMgq5y4g0+Liq8J7odToZ4RsUf1sQ=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a44c623 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=nV7M3V7dV4ZlPVs255YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 8bZ_aCh8Q916x-gWp8NeqIy1SAe9-7Fy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX+zn2D5eeLv6N
 TG2xZz5+1J7Lxywpudizp03bwCq9K6EKr9guczVRLuRqeSXibkYj2T8dynXQu9Ph8j6LeAR1Sl7
 qB0TGPrfvuPYz4RWXf+CoQ69uGYRoIJfwTdWzB90NypTmc+nKBDdg3ROHK00cYhFv/V8Qbd4Tyv
 sNtxj8+bVOp60Syk+36thNPFIAvbF7BPuiWtC0Mgku0VA8zui49FAteH7MOeAkjGVyym237AtAI
 w3P5II8WEhFzGzIxje6rKIBgr3SiJ+Il1pCpBqi9LBwQP87iUsI9GGIR/9n4EgrSkMGrPd7LE1h
 YqNV4rQmzv5W+2fEjd1GOLjPF8kWBmfBugSzTmSKo1IEo1qdX5VNie1A3vWYUW4oF14qNCvEbbl
 JM7zY6NbXwpLqYpld4PqjkSa5m7swdH+NHoEz/++oUVWh/sQIB/fmoJ6198df00fpJkIn7Bg6fh
 UHwzoCQuXvdg5wYe+Ag==
X-Proofpoint-GUID: 8bZ_aCh8Q916x-gWp8NeqIy1SAe9-7Fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010077

On 30/6/26 09:38, Thomas WeiÃschuh wrote:
> Not all architectures have the system calls for time() and
> gettimeofday(). When the system call is missing, the vDSO function
> should also not be present.
> 
> Validate that.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   lib/vdso/gettimeofday.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
