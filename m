Received: from outbound.qs.icloud.com (p-east3-cluster2-host9-snip4-10.eps.apple.com [57.103.87.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85B2ECD39
	for <sparclinux@vger.kernel.org>; Wed,  3 Sep 2025 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937134; cv=none; b=eiGoW2fPLCjLAMQNvZp+9JITp0qxcbOMlUwY4sjtpbSIwHoCmlXM8rrY9q+hKAncv+R39q/3oEKbedxUKJT3521nVUsJj5vBL6F4yA3t7sFaxsh9FkWwdcMGh4+qWe27bakrTFm5/EHpugY636FNTxhAK3vUF9QyvOV1dG+f4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937134; c=relaxed/simple;
	bh=2E/5JEVhFZR3/+WLzz2blRAhy7RX6tr6Ohn3x6/Kmfk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UcAG0ZbOcFAi3R3aeLL1thEDjz/BVMotTTE2CDh+qXjhK4b7rIxnGugxj00Nj6kxq/sd/MkqqhzQYDOGD6+KZM2xUzyOgXR3tXRuFtp/pNjuAhIJf+8R7haNFbZyeLurLFJyshu35DBZnxUUEwk2FOAnZWb1J92rUMEQce9HcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thejpster.org.uk; spf=pass smtp.mailfrom=thejpster.org.uk; dkim=pass (2048-bit key) header.d=thejpster.org.uk header.i=@thejpster.org.uk header.b=nVCbtHOf; arc=none smtp.client-ip=57.103.87.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thejpster.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thejpster.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thejpster.org.uk header.i=@thejpster.org.uk header.b="nVCbtHOf"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id 6E0511800885;
	Wed,  3 Sep 2025 22:05:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thejpster.org.uk; s=sig1; bh=BQbEpJDpXkVpL/d8jHcTCe0lFwB6CEZ2QFaQu3KuxQc=; h=Message-ID:Date:MIME-Version:To:Subject:From:Content-Type:x-icloud-hme; b=nVCbtHOfsesf3FuegByKBQckpIvTn6DpZfU45WGS2l2/9XjNNCUp5IeFfyp/84OZC/SOleVoJNBJX1fc9uY8TzFzj2k55nS4wTa3uog0hfTdSZigTU+4q56kZCHQsF2IYDbAVL7ax8roUpmR9EqfWff90airLGSDxcy8j1vVePF7xGvZeze0ZizdfSBODUtqpSRRcuY9EKfjjlppwqRbmzgSqOicXXYlWcyfOjEGAsEg2Df1n3/6WAZWu8wU5ZnRmxbrpPx0uuXLlcuUJUjx0OzZpYvKF5CAmQ5NyC0VOoVxar9aTxuOSuRidXHUC1U4kTeqPJrP4O4J/SsfDR1TxA==
mail-alias-created-date: 1648742848683
Received: from [192.168.50.27] (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id 262A61800886;
	Wed,  3 Sep 2025 22:05:27 +0000 (UTC)
Message-ID: <89b55629-da5e-41a0-967d-12f6e0a90854@thejpster.org.uk>
Date: Wed, 3 Sep 2025 23:05:25 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel@mkarcher.dialup.fu-berlin.de
Cc: andreas@gaisler.com, anthony.yznaga@oracle.com,
 glaubitz@physik.fu-berlin.de, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org
References: <20250826160312.2070-2-kernel@mkarcher.dialup.fu-berlin.de>
Subject: Re: [PATCH 1/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC
Content-Language: en-US
From: Jonathan Pallant <jp@thejpster.org.uk>
In-Reply-To: <20250826160312.2070-2-kernel@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDIyMiBTYWx0ZWRfX0HPLCNf9gtVS
 YsPzKWJ7aMD8dFgW4sQ7tw8WuN/h2PkLsxYLo6MJR4kxxF7ONzvU1AUOb8iNp3LfMrteHhzlOMg
 YC0+EHpykkQ2SW4OBW95Qs7as61Ba42O9LVETcI1Cr8hGdqEVUOM2xRKKWoUCTcAFs3jBvj9SN5
 JPl+sacXMApDKTv/o32mwkrpja9P4HmlriL/2nJfEpSWQ/6GIny6vcLLG3MmPsCpYlPQZlFv+lw
 vIoQz/p53xAEieEuSe933l2r5/Hwv8vqsG43TV26GoyqeOuE5duJt6WhHveOQAJYntsOENsnA=
X-Proofpoint-ORIG-GUID: Ko1z_yd-ktEjKv28ecF7feEI2eFl_t1G
X-Proofpoint-GUID: Ko1z_yd-ktEjKv28ecF7feEI2eFl_t1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=534 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509030222
X-JNJ: AAAAAAAB6wmTerPm9zUOnI5L584fG8O/swGXNVBk/G+9hht+8uNuAS1dwWvBaWbjD2SNXtfjQNDElZrOze1cI2nYC8ic6ebcJOSDygjOjAbsMVsmGPOccGbcODFJsFRzIACQn8AdWo2EO78hIfgmat2KvDOH+1KBy4oM7xXCS/QGMBkwW4TBPNINz0BaDuHAtM/iM+UKg96qJR+pJzOJHAXhNqoKO0RioKMMJ2pSR4dWPrGPgIpBHQiweaj+hq0O+8dGBufojs9ad+4yYyKMAGz0p4Aur8qZQSQI6nVF5J98pF7Sn3RzCCehCeDxnF+O/wn1n55BHf6Y91xyq2nQ81tjnUFWL1+J58xBm/0fJyqHajzGztaQiJUKtjYDGiKtdwPJdFfbKg/Osv0D7Wu9o7VCbp9nP/KUCtWsatOX1HQEf5CpfMWcxwchxMY4PV5DunqVsJZ9x1yZ/xerE8CmGWITlQF/rM8QcozTA+V1cE+THlTIo3awSeanJiCD7mUaj1JKMB4m8bISLJdQxIvUS4FNoAkmq7JWVzWpm+Lpy9TLlPmzdUJqB04GSo4pztIl/rWKBq/pc7Y6JnPQA9whCtS1O1pliaEtnU4DWMcrDq9jDV2SJfzwsitdjmMHPpFd+ZH605wfCDHOzOdvCDY+Qx4quYb2Fsvxp21A+SMRE2QkjvJHas/aoXI9C22PdQFxLKOuN49IMLBSyGiq/XI=

 > Fixes: cb736fdbb208 ("sparc64: Convert U1copy_{from,to}_user to 
accurate exception reporting.")
 > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

Hi all,

I have a Sun Netra t1 (UltraSPARC-IIi at 440 MHz) which crashed a
lot running Linux 6.1.0-9-sparc64 from Debian sid. It couldn't even
complete an `apt-get upgrade` without locking up.

With glaubitz's assistance, I've now installed kernel
6.12.3-sparc64 with this patch and the machine is working much
better. I was able to install openssh-server and run a bunch of
tools that simply didn't work on the previous kernel.

Tested-by: Jonathan 'theJPster' Pallant <kernel@thejpster.org.uk> # on 
Sun Netra t1 (UltraSPARC-IIi)

