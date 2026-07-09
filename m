Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E9413247
	for <sparclinux@vger.kernel.org>; Thu,  9 Jul 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596051; cv=none; b=nb8MqNUpDZK982vPj3dED3FEGF9Kcdzh9W6xSFh2IwzI/dnEUK2LN+A8w/AntFjTcqZPMeaZrjA2B+TPoEMkXxGBP2uJHMA8HX3Thy6joix3zJs9SAjXv9j1GS7ShF7PKB+eJgsOEtcRv6AYF0fQiaP2Wzb1yXDIAcvVJtDkiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596051; c=relaxed/simple;
	bh=R+aFi5Oqdv0TDSr7wZR2WAPngeBl4pJ5LsNFoxiZF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7NsetSPneEZDu2q25KQg5coiHdpcKc65aBXuErjuf7me9LD6JyQQz+JBzrzFjTCbwPRDaJ/xKt0VLWYrhAlBit1JlOnUpkkgqzN4/bBDySritxh17qUdnKLnMYJJpSjjWOzIWrvXt2NVumzC1RAo/+9Dvi5Iiu63W7LogdKAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOWfjmK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a7clZpL6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOWfjmK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a7clZpL6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax7wX1574485
	for <sparclinux@vger.kernel.org>; Thu, 9 Jul 2026 11:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=iOWfjmK8f8Y+DVJW
	EcnBVbRqoFetWpR+MvbIm0rNsCYEYiCVdv/jb+r7ZZuAst5pdACVTyVPX1hk4M4R
	UloW32yrnx0br0O0OZPBTsUXsGcPSz6fo0b7Z9SsSAlawkneGV3knPcGuKS4ecbQ
	qUgL7kJ1kZwezKuA1OHch6fG0wR/9IjoD0gaRXopgi656DtKQN7lmNG5nDcMpELo
	+2tydKrnvkk1mYPsPWN5nD/hRUDpTxejd9pRgo55t5XyFzKGEVSWfHJeObs1qXCX
	o+wuU7kKSC/wnWW5kZ8U0x7Pvu4fl9GPrm5rLmSBf6RmcKnNqHf8RgkEBJ09ZjsD
	t7y3cw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvubj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sparclinux@vger.kernel.org>; Thu, 09 Jul 2026 11:20:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a23afcbso18489951cf.3
        for <sparclinux@vger.kernel.org>; Thu, 09 Jul 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596047; x=1784200847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=a7clZpL6nOtGSdXl/9VMFzxG3FX6J7Jpz5oRTdF3Ud3LP62vUE/2zfduFUE/Wg0Sqm
         w1xkr6dEnyY6T6tXj74TWHvp55bSy7Gu9OSAbXU+V8JTqHMHIG92VFPihlaUxK0k6We6
         suDfZ7lTXPJpRhiIrk/t18bDczgSnwKr7QZYvherjAIymulLlj6kidlUwdc2GZDQ4o40
         7c2tSW0WD7rNUUnlb2XWaPJv+kv92FjKKxiIEgZLP2juJ90L5oEGTKW1vW9KeDnzN+2B
         W4/I9Kif0Idgk83Lb1M2eQkLA1l1kX/2DMrxOMccuXA772LF/TW/pR7thgHMiiY0edpu
         SkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596047; x=1784200847;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=AxD3LYx2HbfdpXVLAxGSBiICxqXUrjsO2Eyi0NaR2LTUDkmBY1tMOroiNyIZh6h9Ln
         dNzHIg4qPFP7mr4Rv81S5FIBzhe94S5q5J3wEFR2+wA7X/fFcoxCi+2r9r4U+xHSHWAn
         gfA09a19p22No+Sxa8NDOWRQu8aj1mSRgXtRPNgN2bseEdOgcFytS/1+Yqyt+QzvTP41
         f7i7kgWJyr3kQiWZOh/TOQs+PhmOyh7vugSeXMI0zGp/TIhXPQjuID9SYvYk9n0zYlVA
         0RadYNw3sXAK+Cue892R8WG3BZg4FuP2ns/oZykxNKGB9JyLY5LlmA9wSGVOjthQHOkP
         YNug==
X-Forwarded-Encrypted: i=1; AHgh+Rr80aTEf/4QBENPkAhoUa9evr3bQDku0etlKyRCQ3q6bJXrzrCEgCeYcJtWAcKZWc8uvSHEDmjB/kfu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lgSDj9XNIctytbcURkeA5/kvdCYP7X7EwfVRXhSPwte/aLVe
	JrP86aUhW6CFaMlZMrvkdnMvrtPY2+xLcDk5HRqbrootS+Y4+YPLnNuRzL+T4IVW4bZ6J/wg3tS
	smVSvtZqGHMZVfHWg/1B4L00ZMHWQn2qDP9xJ26a9QacP2e0p3TGhtsrkyHOEAzbS
X-Gm-Gg: AfdE7cnYJvUYOJm9A6q0BYeckrz6Oe+/XFZTVhlVJCF3zJ22yzpk3B83MJLCapzAMlY
	0uCRuGAfEfbDk5oN0QaFYfyFs5q/Vdfr52nC4h4hF+mj9S1mVSR4uQfjWZhpqfDmnGCmknodJNN
	kExEGtdFDIEF9bqLhC5s1M6/LwIRLciWgjUPGZ55iNaLcZoy8Bus7tatjmfySQZ6DT64eKIfSZW
	bFu3q89ZbDk/1No7ZdRYTDu6d+h92ShnU2rm9MX5KnXz6DfhNaNTWCcqxLW4khbTcq+6h5cSH/Q
	KtLaTWyG1XRai/rwzijKQrjIf2zpk3MgLKjzhN6TfUahyErG60GNvRYuCFYpKWs+FC8xbsnb7aL
	Is6tSpqRHE6hKeJWjI0evfdsLirxQt5CPcxwTZL8eSpdcyvNDW2KqeyiVVvYlNg==
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754931cf.27.1783596047577;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754181cf.27.1783596047072;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd1d32c6sm1861799a12.31.2026.07.09.04.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:20:46 -0700 (PDT)
Message-ID: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:20:43 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
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
 <20260707190254.181086755@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX1fDhyOxUn5A6
 v7t55yJrRRQOigTzWR57A1asgtQVcOJE0dEt1QNrsiDVGgwwyT3YJ1065WCsNZIaSNS3oLASver
 axTSGVEYVequGgdxwBd2ksqPcdYGS44=
X-Proofpoint-GUID: Cdo_COzUgeDXzJWwsWktqw8iEPLesaJ1
X-Proofpoint-ORIG-GUID: Cdo_COzUgeDXzJWwsWktqw8iEPLesaJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXzLqgNAGLke6I
 FSUnlhywJWfFMYHtmphTJLK5qi3u6yk6CkoZKIuIXgsDrsi0zfbWFmPE2/5eoym/jFUjneep3+Z
 ucIxoB2CfpApGApwvgYvAdKJ3KlAAJTKNIKWt7xWv98SQHS5j47vrfvcrspmYdR+YlX0kS7KpQS
 vRLHbfno9tmf82CitSVl/mZEYtwL127AXad4YylgXaS5RKnvSDCvySo9SASTD67+PdMK6uWxQnU
 uAWddLLC7uppQP4hoEl4SCOQWhlCtO5B/mAVoEjH619SFiY/SUFcTJIGrDMj486BDIW87qGskoi
 AWUIZdyiyhFAlf9tkFBTtDjQ3JwHv+3mA74Oh2KIA7Bz69RnU95H1y+Q/U8q/OG0an6KHEncdEa
 pw6dIsR6sgSm15iMSSfMcjlq5fEX4Z88vhlc+X0WkdprK1JyR4QsWZSq3oI/SJgZsdK4yjZ1bLa
 BDFTUZfiIjLgQHMX34Q==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f8410 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=uucGcSui7XbmpEV0VHgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)


