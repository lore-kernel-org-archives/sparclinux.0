Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38D31E853
	for <sparclinux@vger.kernel.org>; Thu,  9 Jul 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595764; cv=none; b=G/sBxO3QtBN5th3bZEyn2bb08w5aDOxLwxH5uENfmKlXQtDpFZIyJ/z66E0+enL6Hbiz/2Am0bYDbyN9qoxPuLrfPR09R/TvySPNc3ZRRoFUTH1Aib9YakP8kvNmOPQqcWqrrwQpSUT978MX1n176sT/Fv2S6jv5FiTidp+4VnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595764; c=relaxed/simple;
	bh=2OZyqeCMlAjx4K2K+b/k9iOm6BK8Cqfe058LfZSp27I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXGLKk7BGSBT0viKZmjaLk+lhfIv4fMNIav9RrC1jPJJmCUxAm7b4OLk5P+syl717EeWmc0NWEuLA1CwewBxe1zJdlixo5Iq1RjiAH1Utc5jFBL1DtElf1htJQbHBmBtVApU+rYTbTRUe7wO7QvcSgfQwsjfa82LPKefgnWK/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULLpdAqj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMSp+MCX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULLpdAqj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMSp+MCX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669B03vu1620682
	for <sparclinux@vger.kernel.org>; Thu, 9 Jul 2026 11:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=; b=ULLpdAqjhcPbhl+a
	9wkFVF2/lY0nTNUibaezE3oRQ6lteQ4HDVcOfqHDE7vtflCsPuubuaBt22suHv5C
	J/GboNexxusvk46SeLD4YSCgJibhGpTyBp7Ew2CmZmE5Kc85FL5xmUGbwX2SNRRm
	AUKTk+C5LBwuGwFJB3/1RH6SX3HPCEtPeI30OoMKGubID5ux/F8g5HbF1COPW79s
	OzhxWi76MMCFcorNKYBBg01ItlLF46P4rAQRFOMzzGhz1/Bz8zCwIh87EUtM9Vze
	DADpxILacbIASbBx5FZNfW6HGEmYrVnOynweeKBYk1Yd0I8v8nqfQQ/58XsDZx94
	8Wm00w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqsbxc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sparclinux@vger.kernel.org>; Thu, 09 Jul 2026 11:15:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91931144870so101579585a.1
        for <sparclinux@vger.kernel.org>; Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595759; x=1784200559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=kMSp+MCXIXJE0DIs7pFLHYpvXnsnX3iIWZtDgN0i1fJWjnjBoz1NYPDmjbbQCCRNEK
         vscp+wRWlJNCjh/XanhPMyB6cllBsqrXbJaR+3Yim34KJ+QqVhYiq4XnmxXbcn3+kzYX
         htjTdXGkRRCxkvb6URsJhgktwib3kHT7eKtJttgS7TcTyMyPpdBJUvP2lYCZTsqMbzT6
         53EbRfFizqInCSE9LMw26TK3JlfoQcPT/Fcg6Pw9vXT5ycRhoHqWKtMQJQ6LJMNItBsU
         p5s3qJHEUsH+n8X9iO9VfJurTdzfT3D39Xrh9IZvupN59Nvf5nehBIKJmRnYljAv7uS5
         Bxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595759; x=1784200559;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=S97XLJgDaXQQSveWa6eUunn/UjZdyNwzCtB43XxL9lzuqJlJkDoXfkpk9q+0fdpXn6
         9M1i7rTa1odALf1qCJaSPwSFiFdNXNuoPKJTYoYWITOG902Qh7ljGYWkkwJJqukPr7Td
         l8wX0crH0JnNVEh+KIe0ZG2ztF7PGhZL+fn40aoX2r4XXRUz5If7aXxCUOgoAFyNaUPH
         wHdl4aaciH7TPOBSi+GlriRPhH/bLZb5Z08EmkzNZskGJ5NHytAQvd177Sm2XimWHuo2
         7bGcws3bQ9hI6qJIPIXkMbfJh+iDSSKmS5IibVf1GzeA2fiV9LUj8YefuXdkLJOb5kN8
         ocfA==
X-Forwarded-Encrypted: i=1; AHgh+RoNVsfbhinJl0xeOs5j7CFdYj+TtORNkfetd6gUMfVpFSwUYFvsl7Cdqr52OMBfJsCW/g6kLoWGAhvZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YjtXuPZesr4IYoFBkEYBsdkG+AMq7STH0oHSQUx8CCRKno/H
	v52ahckTbWIbcqbVlzqtegDpxTofv+zaY1WaGx6qfTuaDz3gTUwQ8LT7HQS/7amfWIBSk6sBS1a
	lj3gRZHGV05CE1893ypRqOcVxiQQJnNLiAz9dm1iGgcm0fJH9h7otQtAk8gc7l76i
X-Gm-Gg: AfdE7cm5KhtmumX6MTliCkEh66/8WiPpu7+ogFs6kY/kDT/IIguAYjipCBnFteb5E1p
	d6D8+rd/VwKmhRjAnBVbEVuUd3W2MJOotBbG5PAK17F0zTDRThIeGJHB30sSP4vI5pIAxJWQHjI
	X4mykW8yRP05J1RYpp2+p/PRzN243JV1BYkDEx2nq/mRHLZall8xhkmfGB46hY7vF8a9grBmIlg
	nEzDc5Uf4OSVEXJ969agNlJmlCm4+7O9reuOxvFt/S27Z6JElfz+zdFVJ2iIjsaTAIiiy1nxBZR
	YRTspdzvGiHecfn9nyxXfuI9eolXhbbJtibbCPyaMfAD9WHjtEaYX2xZRL+0GNpk9gXX1TmML1M
	oR15k/szs8rDNHaRJfcgxie4UksHeI43YYGlzdJLfHYkkInP+zgr8FJ4kmLo5fA==
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191891cf.28.1783595759115;
        Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191231cf.28.1783595758685;
        Thu, 09 Jul 2026 04:15:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm50274140f8f.24.2026.07.09.04.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:15:57 -0700 (PDT)
Message-ID: <cf26fe68-5a8d-4d6e-b9f9-d69faa8a6012@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:15:55 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190253.865955911@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.865955911@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX9aazgubSW9e7
 6zCcASn7RE+DfhGBz6oXygdPfW5czR+a84XBnhOTU5+2Raxa4ecdOUy1heMrjDYl9kS6k738nGi
 3M39dMJeG9QEFA524uZmDjdPswhEpRc=
X-Proofpoint-GUID: qRG5m-8qCyTPAPlNeiFNk_nx4X4ZfXqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX7q6w7lX+j05U
 Uk6dM7T6O6XYsScMjMSJFWzjFOk7udwa6zSrg1m67hNVPsw4bYVkARdhBMw40nqUhtdeybsiT7H
 LURdBovhk//mZWl4WdbErD/RWlxJBx3MoHsw1tZZVqIZbEP91WymeulcNKd4aFSlm/sF72kuCoZ
 ++ZDlk9wKRFKhtiuozvCiFhdKq91mOv3xnWJBhJPNhiNLYCmVLneW9tgXR6TemAqn170t91Ktiw
 KwpccaqLcFRYbbhITbDJXCHWV0GR3fCoqT7JcZHov0DQNRo+Kn6AXD2E55W6LYUfRiFTBUYMlRm
 ASeouBfvOkIEcK9wbMzUnSL0caY3l7CI00wqCQok03FGT43zV5QeppqCB9DW4oSumfmqrmms+sD
 HcawvB9qNJ8+LManFLHHzlmcqSLnOx+/r60/i1b9SSPuHS9iOaEpzwKy6HqM7ifnUgiTwlIlRw5
 YWB/yHV53PtIp+cJHlw==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f82ef cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: qRG5m-8qCyTPAPlNeiFNk_nx4X4ZfXqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
>   arch/loongarch/kernel/syscall.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

