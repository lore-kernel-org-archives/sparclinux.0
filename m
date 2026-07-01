Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D73BBFD0
	for <sparclinux@vger.kernel.org>; Wed,  1 Jul 2026 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892169; cv=none; b=IRNOTC6cultcUTeSrdcZC3Ker18n+ytVPJdz7hodyy7APkdlHmkadsGs/u7Dm3W2M4WP2dEHag6qCcjq5nKPRtZ45Dv2rijgnm8FU0ZDE06D3j/EShvS+F38tgt4K4IK1wLTc9RYFqOINura0ZM4uDKYvouM8NwN8stFeG4EUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892169; c=relaxed/simple;
	bh=Egx9zKfonwBVdkXfuEdGPk6S855zvPqzLD/eAbfoqFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Knbp/Soq0SKA0ThshSR9nV9EJQ3ypOj20C8bMzvODobYQ4FNGcsVXM6VXIgoNSuWShh/EeNQnTaGcF01gMvp3nnFp6ZcCaQJeuL0crMuXj7i0nNE7sKbUb5qrj/v7OwlEu2Xf5BlYBxFANI4ZqZBdekW52vcQN5++hy1wQKfRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXxgkaw2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=La/XE5h8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXxgkaw2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="La/XE5h8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lI7c138708
	for <sparclinux@vger.kernel.org>; Wed, 1 Jul 2026 07:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=; b=nXxgkaw2mzHJ/1IS
	1rf4VfEZDPDNc4qpaQP8bdnXeePd/fo2H05mnI25TgyeX6YBFWKYHAhIkZcTKDCC
	d8z7l8KKPmnhxxzUwNaEXJ9Ni5P1JIiI2aWruoIZMD+ZEsePMccKTIPdgDeDevFi
	yrs/DGuzA4yQhLp1OM0a6l8f2O/n6aTqDRZcXMoWxJSzzHj8gIYH5bFsGnn3QUSf
	at7oOMd7Z+9vF7IO2YV8r63ADuq3z+zUikqIeYEa7HXj/kakGmyZPINV16bfDemz
	u39XkDRnAIeOkZYiMLIiAuXKaX/w2/KYDjGdNnAu7Kcei2t1Uph3dxbbdVb4pxgh
	Dj6kfw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw2sr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sparclinux@vger.kernel.org>; Wed, 01 Jul 2026 07:49:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e53b8a302so35682885a.1
        for <sparclinux@vger.kernel.org>; Wed, 01 Jul 2026 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892166; x=1783496966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=;
        b=La/XE5h8VbZJ7MNFuXMr07Q6da9wNnXHjFLztbsQUOVS0EUzPtWLPhNS0jSImZvqB1
         dgrTDRdwhd4tN/x06EedREoBWWvLra8loGkBg3uB6S+UsRyyzehDCCOhQCNPWrmFTf+D
         SCm+pMzBhexDHbDUH05cW3DLZnwBMx2CveIAg30Vx8/719Bsr8uAbdbDjsx2mWsL5HPc
         kfE/nO93MYAHQ28dl5uyxl2kTOJcApldguOANzwwTgyp9efjRvfEa1YB7spp1NYIgB7G
         euoVbOXa+ofXQ4nuVm6TNc4TRqUhLPXe90n9U4BDHjm5KsdQcsd1/v99xO+fpL1h9mem
         A/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892166; x=1783496966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=;
        b=SJhG7JAKV28iQ9E3MGceYyaIBFWHQAMi446Ye71H1b4uP1CF/i/F0FWytvm+zv1MWj
         ThSBRDiGt4pH9W90TOBpQNEkWUZvsDKnaOudDAvStn49d3vY4tzjpX+5yPPMCyaBcxwi
         xpsV7BVjkJKUHq+cwkznB0Ms5vajSPwu1GZwqDBiMuHjvyLPSa4ftuVW3P+mHKbTd+6R
         RTfxDuyw3PFSnCdvJyXMashXVVs2L70S0kPJbBDVg3nlKu39skULFOfnZtcJL71NOZ2H
         oprJhRoOLy+tK7G4MxjULwjWfedhv5uQcgAYURO+pHQRJuX/uxKjhdrTEByb97Duk3bK
         rmMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lU0YSrXtBiMHCWK76geH2RhpUsH+v8n6jjfIuCgbp6wnCQwdLQPZYAVu4qMIYbTif1jd3itmFRWBR@vger.kernel.org
X-Gm-Message-State: AOJu0YwmcMf0yFq7qtvOVDIvhSErXH334pJhlRwlJYO4m/uZyDSE/Gcf
	MXuodCnnk+KwdIRu59hcfcX+SyVhx/zovIQDafchoxzATye0zJXBhfeUPGcHZBuKlriOPKb0KuP
	fRH2odInu36OHx2RCVWQpHctwpEx5yPTpqeIgbzs98J+KZbEmhKtfh+3aLoxaflyz
X-Gm-Gg: AfdE7clvfNpitc+17Oqch1QT+sSJIScDrxh6fXLl1vp02HMUaJ1sxV4dk1htkrVDI6M
	PIsSQzKUZRAa7QmthtforPU5Y1JB8vtQPa32KrUZaK0MnO1EzjLOG8klraeWVHOicpegL065f2a
	w+ewIWDZFdTDH7bpT6rIAmqAnhOnwQZnLs11bL+KT+B6FPHBLH2/6WMCNOouC5m+ca+3WQ1s0o1
	8egmWEzLOKMJ+m3m8m8h7kPKv8PHQ2zYw2JtEnRnpJpFICfX3ieyuD2HFmIZ/zCUo2S6w8MecZZ
	B+4aD2LPr6kpdTAldsPE2mzSNKT7PVbpUtSDbKpf24dsl5PkKDfoHmVZzBfgHwrydk2Q1+xnvtW
	bgxWv+k8hePswDyv8idVDsAPQIyz2P3DJ9hzm11F/Pn5RXshK+GdjsJwQp3HMug==
X-Received: by 2002:a05:620a:2b42:b0:92e:600d:b9ea with SMTP id af79cd13be357-92e78224b5amr72109085a.21.1782892166377;
        Wed, 01 Jul 2026 00:49:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2b42:b0:92e:600d:b9ea with SMTP id af79cd13be357-92e78224b5amr72104585a.21.1782892165851;
        Wed, 01 Jul 2026 00:49:25 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756797a8besm15540687f8f.35.2026.07.01.00.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:49:19 -0700 (PDT)
Message-ID: <1df42f13-229e-465c-a5ce-40ea3bd93e8b@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:49:16 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: vdso32: Respect COMPAT_32BIT_TIME
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
 <20260630-vdso-compat_32bit_time-v2-4-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-4-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44c687 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=gC1PrsFcNpCBvASTUOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: SiledxrFMBzUgBXtcD4wfzyY3nyGTBZh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX/MkQWH9a7JGn
 BNRuc6rWiqZ1U53+8eV5IYGsoPCinrAQPapRjyt3TgHKwhHw+ls0K3hHrd5c/XsQ1v5j+0obluu
 SgEGaCpOuWXwFdJa23sFcX8Jkwvonfg=
X-Proofpoint-GUID: SiledxrFMBzUgBXtcD4wfzyY3nyGTBZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfXzv5+mwpRpI2y
 JnQ0hS1jxIXEkAa7b5sNK3lI76TN9XYmAgfR7tXefMiW4gBhqEdFyyd+klLEf708iuuCCW5YGXD
 t1SeAmLxfnLNVJnXi2vNa1gsIAdkjFrt+Uugj4b+8XnCKaWGvLTaUARZzFAiiLDZtpgLwL8i+qe
 GmyNoHJdZzPwu9pUcORGu0fk4TU1SWYQ40dXet2UK36Ib5v+f/TnsVSQGmpPTRUXZZd+QMT/Fjd
 NRluDf8fWSLk+XM7+iL2VNjgde8Tj6325eFmdcpgolCpM3fhhuuMnFLdH9ufOMGgZsl7OzOocQq
 YscpM5P3brOfdc8wD+8v3qSPbz9Zb7jjU9UNgmrYYygFjkiqowgVNhYdH5QbQRuJJf9UgbGYdBM
 cUp8XwzEvcSiYCoz9DVq57IS5YoXMLwDBmLTo35E+1aqakZOiEf2NTWotwq8zsMhOufX6TPQRJz
 FlhIWIWvMoHP8OEQMhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010077

On 30/6/26 09:38, Thomas WeiÃschuh wrote:
> If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
> provide any 32-bit time related functionality. This is the intended
> effect of the kconfig option and also the fallback system calls would
> also not be implemented.
> 
> Currently the kconfig option does not affect the gettimeofday() syscall,
> so also keep that in the vDSO.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   arch/arm64/kernel/vdso32/vdso.lds.S      |  2 ++
>   arch/arm64/kernel/vdso32/vgettimeofday.c | 14 ++++++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
