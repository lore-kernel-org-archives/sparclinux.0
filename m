Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3B1CACEB
	for <sparclinux@vger.kernel.org>; Mon, 11 Nov 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356420; cv=none; b=uE0B3pcMDLhQRDmuMIcEGSAQtgSdG1xYlLMXZ+YW/YjrfAhIn3T/BEfVlVTd3bS/BftfHZS/xVUS2vtXOTEZ1kpqQDVJNXuYD0S/VLtiF1OyJA6+dLKhSSWh6AyEErQk3WM0T0VI2oCXnDw4B9pJ+UQA4J2hEOqse6poegwpp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356420; c=relaxed/simple;
	bh=5nObU1H3RQO5wQq2IQiPJN22sxHEe9cuBxTBHhohV7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsR5J30NH2JqxZrfmB+Fw6e4RXoujv+ain81i7+RqWdQBIrP+q4fbNytZbPkXAemH6yiJGEPkA44PzTihSM1YMXE0BwfOaE1yYpYfpxXTmAiVtYeePM8og7mPwbi+ZOF7osntkdmZ/KUprxcBbhZr1+4kaA8K8qVETM5T3fUnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ZZX5ZGh4; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZZX5ZGh4"
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id AR7MtX2Mzg2lzAatUt4ktb; Mon, 11 Nov 2024 20:20:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AatUt9jJVb1ivAatUtljtj; Mon, 11 Nov 2024 20:20:16 +0000
X-Authority-Analysis: v=2.4 cv=c7GtQw9l c=1 sm=1 tr=0 ts=67326700
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10 a=NEAV23lmAAAA:8
 a=5KPgfr56f6HAAAPAhSEA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3eE4W7pHIfAEUaD5vYAx7ulLkMGc3zLHTAhLskNYybY=; b=ZZX5ZGh4j9ily6GGlWAQlXYRUQ
	aLNVWhNBjVWSPWWA8xqTD+nR1ByBZXu2amFdiPOck7q6KqHeRS41EHObBYEPNTkGLWpllUdODW3VK
	MVvmtSq1BKnwcMIrDKtWa4cpOOHCJwyJOw1Cf+LKv0Xc7k8pHeaIlykBFDrcuf3YHBzpqm+TFKUub
	KUCYx/kh0axD7Oqz6wN60xxT15FharU31yu2nMNAJSXz2EPxqiluAltCEadyfoDNKKbffkzhI8TCP
	fjfxWgshK5EDuV+lbdcfGncbvAdWlc4z4msSC1f7L+Gw/JYTWOGUxx35I06xn22RucYwYFdCoByyC
	I2IJiWUA==;
Received: from [177.238.21.80] (port=45958 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tAatT-004DXv-0x;
	Mon, 11 Nov 2024 14:20:15 -0600
Message-ID: <83a95dfe-533b-468c-8dd4-439157c0e1cf@embeddedor.com>
Date: Mon, 11 Nov 2024 14:20:12 -0600
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Replace one-element array with flexible array
 member
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Sam Ravnborg <sam@ravnborg.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241111200155.164621-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241111200155.164621-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tAatT-004DXv-0x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:45958
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNNVelfUivROJ6+03hE6qeosQ8HzXAhlLe8Ir7AH5baX5CJIYGtQZEfh+8W3laHAKvndM1hehJZhMQgqePun3SMN2f2LnfJqUrhQAsQYFnbSDO6PoOxq
 K31U+Rw4Jd68rJAoNpvtchcQ2qAxTt5Et25Tz3gt2RT/sIgd5dCmjoK+E5q8tvp6/tL3Hei46luZkrZ2OmhiLXNI9LlMVZZngdmN9j6QCk5TfKkGPkNtjsEq



On 11/11/24 14:01, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct hvtramp_descr.
> 
> Additionally, 15 unnecessary bytes are allocated for hdesc, but instead

15? unnecessary?

> of fixing the parentheses in the open-coded version, use struct_size()
> to calculate the correct number of bytes.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/sparc/include/asm/hvtramp.h | 2 +-
>   arch/sparc/kernel/smp_64.c       | 4 +---
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/hvtramp.h b/arch/sparc/include/asm/hvtramp.h
> index 688ea43af0f5..ce2453ea4f2b 100644
> --- a/arch/sparc/include/asm/hvtramp.h
> +++ b/arch/sparc/include/asm/hvtramp.h
> @@ -17,7 +17,7 @@ struct hvtramp_descr {
>   	__u64			fault_info_va;
>   	__u64			fault_info_pa;
>   	__u64			thread_reg;
> -	struct hvtramp_mapping	maps[1];
> +	struct hvtramp_mapping	maps[];
>   };

It seems this struct is a candidate for `__counted_by()`

>   
>   void hv_cpu_startup(unsigned long hvdescr_pa);
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index e40c395db202..24d980220bf1 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -297,9 +297,7 @@ static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg,
>   	unsigned long hv_err;
>   	int i;
>   
> -	hdesc = kzalloc(sizeof(*hdesc) +
> -			(sizeof(struct hvtramp_mapping) *
> -			 num_kernel_image_mappings - 1),
> +	hdesc = kzalloc(struct_size(hdesc, maps, num_kernel_image_mappings - 1),
>   			GFP_KERNEL);

Now the code is broken because it's allocating `num_kernel_image_mappings - 1`
elements instead of `num_kernel_image_mappings`.

--
Gustavo
