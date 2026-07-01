Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A313C1098
	for <sparclinux@vger.kernel.org>; Wed,  1 Jul 2026 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892304; cv=none; b=MAUFU/O6QfO44+DliwgmWXW7sJxZ9sz/0U3eK0dUv14LKBDw8BO09/udIvoJ8qOym6rw36auxc4FK4fxjd8w9cCeN+K2UjoGsPrrL26N9p4T39yJin3Vte2PeQd/GxTNg8hfENsUpShk27P+uZVzhaVBna74bzqRuY1US3CZKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892304; c=relaxed/simple;
	bh=cjosReaGgzzEhX5VIa/0e68NTsVETg6Gw16U7jnPHsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/dbsl+tMuq2N9hs8IEaOX2N7UMxBjyRuABrBIM5mwAHcxAwULsFXRkdJ2eCHnAMAOvPhrL6PPBqink9xhS8SFYYWsGH4tjCNaWS3C5VfynZ9/EiePvvzX5SyX0Wgy8NC/zGHM2Yn0AxKaYiBlk2TWL82RKdm+q+2HD2olZnaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHrmkNT/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W4q0mENl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHrmkNT/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W4q0mENl"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lOML102900
	for <sparclinux@vger.kernel.org>; Wed, 1 Jul 2026 07:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T5Hajlt0GSOifEEgLYuCorRENs6/gAytzHqsua8a2iM=; b=CHrmkNT/8n82uDku
	5W/oxi04FrcTejUH736a5SP/Dy+IdwMaKBBx4VlX/kzWSVybP0ERM9fwN3EW28be
	nxp8N4flgNS8xHjUTYPB0hTXFaFH0K3VbYIjfdwVSGYa/kU2s/6l6B4vn/4eD77n
	8CN7VAuJMdRMXbZ1MI2Ql1w4vPnltoAe7CUmD/W7PdPwfFcnNFXzV9SXm2tbEaRU
	9U6CncWN1oDCGNXO3xt8q4o/xS5QJ3DTPoUXCms7wc9lreP4eMDOBSVgUt+BUGSN
	FY9IflqNWjSL0RY00wl2hBKCFMky8dE0xbgHmdI2nti6WFzd0HvmcwxhMCHOFHDv
	DFT4ag==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwaukd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sparclinux@vger.kernel.org>; Wed, 01 Jul 2026 07:51:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0d6a2f4cso3718441cf.3
        for <sparclinux@vger.kernel.org>; Wed, 01 Jul 2026 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892297; x=1783497097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5Hajlt0GSOifEEgLYuCorRENs6/gAytzHqsua8a2iM=;
        b=W4q0mENlPn8PesA4joqNAsZMbsgjFmlACtI91Z127yXgF7fjzU+3+Sev8X6TvNyq2c
         ECoejTQs2D6N3wm2gykkWqyLcnJAnhRPRF0rU51cQk1A6415wLasjMdTG4Y8ACLn1mq2
         Nh6cSVbBcXV47xajnLH9AaLxN7pA55IgAx9Q3Ycq0TQlho506QGfFmjKh2/Z2UmB1qiQ
         T2xcLvk8vF9lKbQq8BMNTmdy1u32Y0xYAO5ueCNWszKhiUaBaeJ5BGxhC6XWsGIDTDjV
         5VvRrOVy8y+XUp3ervZnvmF++DXguQUq3XHhTsqAhTew2TqR8ffGYf7EBN9BWXAXE5no
         X73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892297; x=1783497097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5Hajlt0GSOifEEgLYuCorRENs6/gAytzHqsua8a2iM=;
        b=S8kPWbomp1V+qEyXEGtUGCoeANSvONv4fuY8KuWKndI7gsZBtT7Yk4V7avpoLneRSW
         ShaEM+u7ESfjrsxEbWJxVluc2lc59CKWX8I8QKmV+Ycpj9zTam3zvqjZ68eHo1f4R7w7
         bWSjjlL3K5IqEMTYao54iYrPRIBOATpWvmBp+eoiBWBJecf3jFRHfDc3XBH+ZohxcL9B
         +8djxfpdttvm0yFGaQhlwhUdVbHPOKBWZDbSobl0tBxRxiSkVkKuFhAkx2o5JJOP/PY4
         zRLz4gu6fjFtk8ac4lg4VhkMzjn1yhvYq2nE0WudFFYT+zX0F7SGUDh3MgmaVpPDmsfX
         RIOw==
X-Forwarded-Encrypted: i=1; AFNElJ9Wny9W951jO0QN3N8o7AQXdIIXhhpq+cLtE48TxGGMFMLpTP/scYZQ+StVfrTBwgm6IyqCwv/dHBbI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HcwquPNGWehk7Qbw5N6sOfuZ/DzTBJ8JBxmLVsKiuvpK3Sn/
	vZhbViwhTJwEPvd+BDvhKkNOHBsOvyK5Or9IjK/1F2AuR/g7bJR+2UlxJiGY0+FAMb8NPkKQn9L
	j8zJPV88gdaJMeY+Ej2dR0aLTJpQddgdNyGER77OJeLKxwzvzvxEjkbkvijLkeuLN
X-Gm-Gg: AfdE7ck35KOIHsxc/NGfrZ0xW4i86pSoWrQSlBBp6NAKPICLjBtlncGO48CtaiZjwJp
	l8f0NGlKBX8kkgZB6Xbd43znHXETsFKwHCefPTYshQ9GsEmNiZv8DxVoTfNsWR7r2YSJDZK51zQ
	snUv7Ui9GRf362AE3SZ9G+vOP4t+efW9YXz295uHIMtytzd4XreffaI7c7CLGnl5tIgVhWA4H9/
	ZD2XcJdgjFD2cIXUF5I5kPM/MwOro0WSZWS7138KGtA2ixFYoVBoGXwO0lFdfU6Am0i/mCF7/Q/
	F6eFxqsi/cMwcu1jXo2e/giw7hcAgK+mp4JBmicrrlQ8pgl/F1BqgynAS6SiHR5M/ClrpKof9oL
	nbiErdocDnc6rRnyb9wuXkuJV8wXddtJEjUPMOF+2xVTybXxZ+7jkRHxJQm5pYw==
X-Received: by 2002:a05:620a:2a08:b0:92b:6805:eaed with SMTP id af79cd13be357-92e785233cfmr72405985a.74.1782892297534;
        Wed, 01 Jul 2026 00:51:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2a08:b0:92b:6805:eaed with SMTP id af79cd13be357-92e785233cfmr72401385a.74.1782892297051;
        Wed, 01 Jul 2026 00:51:37 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d6a3e8sm228444966b.19.2026.07.01.00.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:51:36 -0700 (PDT)
Message-ID: <7b5b211d-bbf1-42ea-9b1d-f8dfe744841c@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:51:33 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] vdso/gettimeofday: Verify COMPAT_32BIT_TIME
 interactions
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
 <20260630-vdso-compat_32bit_time-v2-9-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-9-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oj4utD6uv0BckC1KlPi4pkNuib-ZzXAs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX14yOKvKpYi9N
 IZ7kpc3+1llGn8BrHtN4CdEf+UDtjVRqVtBVMnjDrkGRGH5R0xxblUbbEXzX+ki7NnAcz2ebPSC
 9T8xWy6DPX5yqDTtFBlDO65QLJo+1Oo=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a44c70a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gC1PrsFcNpCBvASTUOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: oj4utD6uv0BckC1KlPi4pkNuib-ZzXAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX+P5b0KBIKUpf
 CnqCcEUFRx/lY/lYxnDLKDfrZ7dUIHRaDF9ymiZ2CjiLFrpxIsa2nW+8nkqGyXXEXQzdaEK+Lww
 agtEgzdnDbVEE0gCG7UbehW6csK/vznpZUt+YF4GW2MvfFaVoQak8PH3jb6HRhx57Yawn11sZEI
 MBRyscS38TqwfjwJvPxAbUaih70sjCIQ7OliEM+DkV5dGYvEHG7DG0B8dvMqKwxQZ//LdCJLp6s
 ed415rH1qiFoIAzWfSqnONH8jqC+xtnUztJT5AFoMp59WnZMwMZuyWl38OAeXiGFA17woSv4Rtw
 BHuVYQNMpoR4ovBHd2wwf9DbBu3wpKhlnIcyE9Uxa0Q6419eBWcaylpokpDmxy2FtfW2Hb5dqMT
 DEYNjJ0/2FjrLafvyD1b5tCSCukpKTmsImH6wAAj4Hcu9Un7zLtdd6gZozd2xrflb8vptlNxc1r
 nv/HZv8pn9nPYe8dN9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010077

On 30/6/26 09:38, Thomas WeiÃschuh wrote:
> If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
> provide any 32-bit time related functionality.
> 
> Add some build-time validations to make sure the architecture-specific
> glue satisfies this requirement.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   lib/vdso/gettimeofday.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
