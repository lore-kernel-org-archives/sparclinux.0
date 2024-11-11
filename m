Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A81BC9F4
	for <sparclinux@vger.kernel.org>; Mon, 11 Nov 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359043; cv=none; b=HlhLcReZTC4i4/G9Sr/ILq/RWGku1aZvJPJMwolZKvSMgK07MRPUU5UocmUxQt+S/OGxrR1xM4dEmrIr745R0+XWjmVg43fZ00KAMxhEvKe8YsFem/FNds+81DUC4h5tw/3UHZEDlXba6q+RQNRw80k0eAUSl3VWxHVz36m/4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359043; c=relaxed/simple;
	bh=CcyrHtiCdpGxp1+G1hE2ZWOvMoT8IICiqmb9jA9nwm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2MORdRtE9aVNWR8jTRuuneaKQbjI00PHJ+o1NMPhxOhHkNzNdJQan0iQtka+yhHuR8udeRWZ3mHr+q4eVov5zYSmulczGdniWDTxA0T0OTRZ1YHi7UAVpJel1WrX3Fviq3fCqekPStIhk1ByvfVwWz9U6D3JXFsMe82+s0hS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=eUAB3miH; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="eUAB3miH"
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id AXIKt06QDVpzpAbZptKRb6; Mon, 11 Nov 2024 21:04:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AbZotvEOH827nAbZotwmYZ; Mon, 11 Nov 2024 21:04:00 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=67327140
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10
 a=HaXXRGzUH37Hqg1fP10A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3/QWkNiM7d6MQV5CTzi6B7p4uTQHyjQVd9bhUj5m0Kg=; b=eUAB3miH/q38+Ewlh2WdlqHP5p
	6pbKGVsC+A+TdRJiKZs4PMoHE5juRgH3+VoX9dnOFRjKC1jGqdgqQXbZeHlJU24ow8sDTi4aW71nc
	zaUg64HBwMhgkuTZZWFNCBQI/L+Z2lDyKxvj8c8NPLfY1vx3s7pOCme37IkqLmxS6L6aMgzER7/Rn
	uNqgMwVbc0QdBOKq+/ku8nMl4prOs92wV9iPWkyURRiBsCDMytLi6UBnYptXxTpPyK2ARvYulV4yi
	4SAOQZB2REIT83E6PrzdG8ACy/V9SZRtyX9e/iY4zd30P3XG7QQjoRH9YlLmZKGqpC06vf12jwt6v
	BHimHIaw==;
Received: from [177.238.21.80] (port=3392 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tAbZm-000Ufm-35;
	Mon, 11 Nov 2024 15:03:59 -0600
Message-ID: <3fe26d01-d704-47a8-be65-750b6a945045@embeddedor.com>
Date: Mon, 11 Nov 2024 15:03:52 -0600
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Replace one-element array with flexible array
 member
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Sam Ravnborg <sam@ravnborg.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111200155.164621-3-thorsten.blum@linux.dev>
 <83a95dfe-533b-468c-8dd4-439157c0e1cf@embeddedor.com>
 <7F05D8B9-E13A-4331-895A-65D92649B42B@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <7F05D8B9-E13A-4331-895A-65D92649B42B@linux.dev>
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
X-Exim-ID: 1tAbZm-000Ufm-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:3392
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOItjqjhIsjy0M4xYSYiT+vi4pBzcLXjAjhnNbSvHEGMDn0M2Nys7jCBcqtYngEoqsdlkbDKwYz+WFejDZK+9nEB2RY/bkLtBwM6U3+aiveyPhw60aZH
 3jjynk7bxLIkgBNyKoi/MT+NuH2N8VYxogc7NJ9ey7iCieb0t/fXNOhI101VOD1XTNFr38nGrrP97CkgOFB/4TKgACfkkkfS6et4dTnGFydATjhZoSjIZT1T



On 11/11/24 14:45, Thorsten Blum wrote:
> On 11. Nov 2024, at 21:20, Gustavo A. R. Silva wrote:
>> On 11/11/24 14:01, Thorsten Blum wrote:
>>> Replace the deprecated one-element array with a modern flexible array
>>> member in the struct hvtramp_descr.
>>> Additionally, 15 unnecessary bytes are allocated for hdesc, but instead
>>
>> 15? unnecessary?
> 
> hvtramp_mapping is 16 bytes and the size is calculated as follows:
> 
>    (16 * num_kernel_image_mappings - 1)
> 
> which is 15 bytes too many for any number of mappings because hdesc
> includes the first map. It probably should have been:
> 
>    16 * (num_kernel_image_mappings - 1)

Ah yes, that opening parenthesis before `sizeof(struct hvtramp_mapping)`
was misplaced.

> 
> unless I'm missing something.
> 
>> It seems this struct is a candidate for `__counted_by()`
> 
> Yes, but sparc doesn't seem to support it?
> 
>> Now the code is broken because it's allocating `num_kernel_image_mappings - 1`
>> elements instead of `num_kernel_image_mappings`.
> 
> Ah sorry, missed that and will fix in v2 shortly.

Thanks
--
Gustavo
