Received: from outbound.pv.icloud.com (p-west1-cluster2-host2-snip4-10.eps.apple.com [57.103.64.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B747262D
	for <sparclinux@vger.kernel.org>; Mon, 14 Jul 2025 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752453784; cv=none; b=dEVvjscYSTRQpcLO5nNml+HN/JmMQ6kIODcaHkysKEseDFvKYlm1jt+xcdN+jFaRIJ3IKvWqDnMhbV6gIUwYna6EJTgFXlLffAR+L+FXagKzOHFrgS6rUBrk4/Y69gHjhDOSkJEPHRgdeqdPCPvEKd+Yf3cYezSfjVhCrWxtm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752453784; c=relaxed/simple;
	bh=5XHvvd6myXOHSnaaFgTCZbOxbLEnCPAnhZHsRpt4/Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quu0L6Ii9gdRq9qM0QX3ciUSlTq4jmy1LeYTxKmhvG6theYAeIInFs691OiL84MQ1oUvdiMJaSNoIEJdoeeEdWWjEB5AVWb/lpZdRiKqdMFMvmmdbB/sdGOZuGgH0N9xJk5LND7wX04czRDtvClhGWnok5MQXj2NSQq/tO+HVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fEEKvqR0; arc=none smtp.client-ip=57.103.64.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fEEKvqR0"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id AE81718001C2;
	Mon, 14 Jul 2025 00:42:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=cIMdmGU4tFWjTxE1aZma/FVmR11J9Mem5zRPqwQjfXI=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=fEEKvqR0rp9sGvj2sUTejf9+WKgxaG9n7kOq3Qy747hqlDxe82qmVLHOgrJPDnY5xg88wcnU1owDRCTlSDSpkVDL1ab9ZRiVm+HixtmcL21VrGpbCpu5bgSL9RWPQG5Du3qoMZtKANWtocKy8ApNVksR77GrAWN21E2//vy2uH0Kls6vyJs+jULUFiV+ryF90pXcs21KzQ0zIbcLaGK3b3ExI6uLkFcNqaR4DWF/Xzlyn3l/EH0VPXHRAptdql2Yjf+rKc4WU7pIwumrVXy31UehV0KrXw/j1WFbTUY/I7trq09dDTx9ZzWp/aG67jtPJEkoyMZfTJc2YM0ZMJc5/A==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id A6B911800135;
	Mon, 14 Jul 2025 00:42:55 +0000 (UTC)
Message-ID: <f623ea12-4795-4dd1-bc5e-38968ce718e0@icloud.com>
Date: Mon, 14 Jul 2025 08:42:51 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] char: misc: Adapt and add test cases for simple
 minor space division
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 Zijun Hu <zijun.hu@oss.qualcomm.com>
References: <20250710-rfc_miscdev-v5-0-b3940297db16@oss.qualcomm.com>
 <20250710-rfc_miscdev-v5-2-b3940297db16@oss.qualcomm.com>
 <aG_Pjl4Jl7QJxl8f@quatroqueijos.cascardo.eti.br>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <aG_Pjl4Jl7QJxl8f@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7xQA6wUDvP_kIOgKQsfHzl36qltJVPDu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX4E9l34NZXO8I
 LhzI28DXw8t8vrSsZ5l0wP5aWY21s/7sok6bEIgzDZ42JPKUcMXzmr4zIP9o2y8GmbaAcpTnfK6
 JR5ZIO0IyQb+aool9yXcu2U8c12LMXZc8SC+ApTgHE8bQWddvkUtmDo4TjbcElvRcUyEnlqSfaj
 joOQIT59uw6DAsxe0OidaJCF4u+JbFm7oT7pgTI89zW8kv4t2ELAWgEbBKz+ImMlLR7xJpNQApe
 ykEdn4B0bs+6Nbz7KC61vH46OPr8rEos44ef85dXfYHGI9A8B7sE/bVVn95cqqW1srTnULoo8=
X-Proofpoint-ORIG-GUID: 7xQA6wUDvP_kIOgKQsfHzl36qltJVPDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507140002

On 2025/7/10 22:34, Thadeu Lima de Souza Cascardo wrote:
> These tests will fail if applied before patch 3 "char: misc: Disallow 
> registering miscdevice whose minor > MISC_DYNAMIC_MINOR".
>
yes, that is expected since:
test case to expose issue may need to be sorted before fix to solve
the issue.

I ever had below observation that below patch order were reversed when
they are applied by robh finally.

https://lore.kernel.org/all/20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com/
[PATCH v2 1/7] of: Fix API of_find_node_opts_by_path() finding OF device
node failure
[PATCH v2 2/7] of: unittest: Add a test case for API
of_find_node_opts_by_path()

> One option is just merge the two commits.
> 
> I have worked on a different option, which would be the two patches 
> above,
> before applying patch 3. Then, we can either support the two different
> behaviors in the test case, or remove the support for the old behavior
> after patch 3 is applied.

