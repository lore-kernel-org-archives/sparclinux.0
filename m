Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022080.outbound.protection.outlook.com [52.101.82.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B2296BBC;
	Tue,  9 Jun 2026 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011481; cv=fail; b=K6aGRmtzMBwFqoZRByaUgFtIIltzxtBHAbJBBH/dcwUCJQyFDVbsl6gpfeD1j3NZjlmD+vyeJNFh95Ii2fsamLppLxHAVWs+Rl6uXe2+my0c5o3nL4aPWpyfjxhIV0kwUoGoVvNrpZV56aslRy8dO0Hus7jEhXF8EClor0Jrsl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011481; c=relaxed/simple;
	bh=kK/nfUrvGuwQobY8dho7MZMytvXgrKvYFmGRvf/XMzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lyjAq3Ze1jtDajjFFaYzXh72an44sACfG8ZORVgEzIYCXXqABwCubvGJkb1ZFCPdtI6Ncrpm8fkukYWfAZBQ3iYFZMVem3oT3gCe74bonZB4AsuaZQ9LxmUjgQB+4FY7R7a2+DHvH1VGCXndf7maCpAiFZZIgo3e0pGycKj//Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=d4nfrSQw; arc=fail smtp.client-ip=52.101.82.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="d4nfrSQw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnl5lmtgum8k6vc3C9OIAkAmTY2m4aKcc3lcsLBjLUJUIpRWbx0n6dYkMmt3JyR7MqqRVYSnP5LEDSqwGJvcr0ln2B8kQjm49YHiNkn3mboAmRSCcNZTkDKY3Z7hF5LoR8SOQ53jniZLZsusS2rgdf9s+aYP/lNm62y4b+gi+6knDGoOn1L5+oH2bVQzClZubJTH/47sBp0ijrtCQsSZBERmjJt5a1liA+ib/QEFafnthY54jEXvZ3Nz0oKvhXGotlUaO8GG9HrO4RjKMgW1/AnlkHejUbLMazvkOrvOwOfG+C8cN0rgjuhDlesi1NbM0mxA3r5iw3SszenLgQzafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6Y7MnbF3HHZ6e+TeAvgOpLVjeuGiYpIoenUNW3BfmE=;
 b=HM1+ruJv1DhDGZxLVjLX+O/RfOvdYCv4KvMdaEc7YUzSHZkoePxv98OJOkiwrCC2lymz3yJcSrmy4lV57UaPFRbfct10mfgiLmA3rk5xjy9LT7k7zKiHl+iZdp4WyntIedKm/vkBN1SXA7fqozpzC9u+qu4wPESCbMRa4dY6gBBWOtHSlLdgedoZJ/gFIbJpNurx9Sh0WhVMWpQvy4pGxJ9lS6iJddRW8BMX4tYGlLFQIRqexyeiDadyoBq1PxpN8sIrEbypHwEF3tZzrWbF8WrKo4ivM/pUMPlKzWQxlKIlV6zho5CM3E02oVVnnNSn/9Kuk5XIua0rj5qOK32B/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6Y7MnbF3HHZ6e+TeAvgOpLVjeuGiYpIoenUNW3BfmE=;
 b=d4nfrSQwzHnIze5GR/udCblPIrqsflSUlk9oVG5iPE5VJ8XiHq8EoF+/rHLGVKma7d3G22/uX+dLBNgBf+zr9wJxOHaV//cp/2wjAlMkvGsqCrgzRYRMMoZ6y+Uld0RNGimFb3BI6/xtucWpjXqovA37iw960zCdwIMEkz8N6hR5wcdlZFTbrNx5FDBMaLw1jVyIpJEbqdCZgJGuJKNyZvrZLeBDqnYifW0L8JfFd4huW5P8RA/H0moixPn403q/d67Lnqe3g17oG8xOVD/P64ieKtvmS9+KCXCjhgq8FHl1F//KKecmDGyoEB7lwPUo/+1hnbK/nQCOTAEZDN4sQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by MM0P280MB0663.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 13:24:26 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:24:26 +0000
Message-ID: <16a65612-0ccf-47eb-b6b2-e15a30e886cc@gaisler.com>
Date: Tue, 9 Jun 2026 15:24:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sparc: vio: use sysfs_emit in sysfs show functions
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Kees Cook <kees@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260504181320.143003-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260504181320.143003-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF000239ED.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2b8) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|MM0P280MB0663:EE_
X-MS-Office365-Filtering-Correlation-Id: 756863db-0d16-4a0c-1f39-08dec62a6d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qqr6zf0M4RUFlt+Mn4ERsTzR7Oet/MHugT4sAYae8ylEuOsKHxn2sKFB08653V7hmtSOkrTzrgzF6VW7Ujs7p6zgNk07eCNPTJNYsWQaGlAOV+gaERL32AGkhYDXoNzq6rqqR+FwxmhFQY+IMiAZiBQ0Z1Hp6GZgLqU2CpsdWBH251oRi8EteWVw30sJed3MhYNaeEpCUq8OozCCnjcbFEAZn05rAgGGCQISK9R/WY1pplCILz1EJwoSBIKLNhHan9TowzXpwzmhCI65eI/8Ma6TALUBmVTBDAO0pgBlOzJKvbXqhLDrXtjJDvQqev8oW1LuetNrM6pAcdCUthOIJYUci1Mq0WxTR4CbuNCjSjShDspdxWcrla05GDV68+0ZvsA8LFAEZoCAYfjGlzJh0XYLpYJyPGm4mUmXsIxDWivs+pKgUb0gAtTtibvBFyUf5ZUP0JAP/eu6fVjMUfEoAy2LB7LLLbLiGUhP/ZP7EMijOCL081EXGzM5yLvBP1cf4+rxjtiBHOUJSMfpPyNWK/i/S+dHWg+3+vUvXdFlS7Ee4wmM7lmTASL8qIcwv4WsIw8icNwlLKm52nkjTK2OYEFXEvBnMyzeZiOmMJvRFqXCygX3DYHxAyGrm9ssP7AWwHTIKAMzfN3+bhe/G04/N097uvqGGnP9NbYqDkgdJ5DqrxQEzvjuGwFGv0m687Im
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0R4TTkwbFAvSE8zVXoxK3hDNmt3b1h3VXN5a3ZlUTMyc0s2TUxhYnd2bGV3?=
 =?utf-8?B?ZGNvTS9zL2pzbnFJNlVVbmdaTHRoYkJ0aXh0RFkwWUl3cHRkWUhwWWFybFk0?=
 =?utf-8?B?VjMzS2ZJbnpEeFRoMTNVOUd1b2pTM2xTL1V5VTJvQW1Mc0tHeWlOcmlheXQy?=
 =?utf-8?B?ZDI1SlA1SHNUNk9Ybk53ZEFPOStLK3hVclcrdXppMytmSVBlVS9BdXJTUEMv?=
 =?utf-8?B?bzBUbllvQm56MjJnajhla0F5KytKc1gva0pEN2ptcTArSnd6bytjblJPNlI2?=
 =?utf-8?B?Q2I1RHVkKzRWL1JPUUJGaS83d0h5V3FORmQ3OU9kaVNEOGMvNHNPQ1hBODJS?=
 =?utf-8?B?K0FST0NFUG1xZ0d0RHJLd2lWYXRCZFZFMmhvWXdiSnp0ZmovSDQ4MWdoWm9t?=
 =?utf-8?B?ODZBZ0U0RkZuR2JOQlQzMGJIZUUxbi95MXcwaW14WWp2My8zb1BQNnpWaklM?=
 =?utf-8?B?MC9oZzRoakE4dHFmUzZKWlhZZkIvNnQ1Wlg5MHF4Vk1CL05sYVc1d2EzeXVM?=
 =?utf-8?B?OFcyRmFhU1pneUJPeHJMR2xndkpoVWtpWFh3UWdudFkzcHpRYU5QK0VBZmkx?=
 =?utf-8?B?NzZILzYzekxRaU9aZ0FiTW5XUnp1RHFLSXliM3hRcFIwUEtVcVB4cWU2Lzk4?=
 =?utf-8?B?YnE5aFduZmtTSHhZRlhEdkUzNHpmajZMMDUyZHBIbTZXSjJ0MnpObEJnWXAv?=
 =?utf-8?B?Y01iYUZUc3hmY0hnK1JyWVFqb1hib0d6Vkl6dU1oRDVNMUU0NnRpai9PMzRD?=
 =?utf-8?B?T1FZNzFxOGJLQnVQb1VaUkNSSEJ1QWpxTTNXNkE1cTkwZlQ5UDhQLzlLUE1Z?=
 =?utf-8?B?bHVqcVlJVnU3aXE2QzhlS3g3NkQ3M1pMcWE5clBIZXh2VVZpRWFSUGdjM2hC?=
 =?utf-8?B?N0FHaUMrYUs5QmlDamZmZmhtc1lDd20yeWpRMTJkNWVLQTZVMFZMQmp3aitl?=
 =?utf-8?B?eU1IS3h1ekIybGlyakVWR1dUTng0RGNTR0dEQmVKaDc2VkQwWk5hdExXUXVP?=
 =?utf-8?B?YkhSem9QUlJkeU1lMTcvTXJKNU4xcExxYm1tWU12eUJlRlZ1SGdrR3czeFpP?=
 =?utf-8?B?NWVremcwQ1JncnZ2NTlOU3psak4vNFFZZThjZzFsOWRlcXkwUFROSUM5QWZl?=
 =?utf-8?B?RFk5ZmhFUjRuRVdFd3lmbUFWU2FSQXJ4RWpLdmRrWUtTK0thRlU1Qng1MUFM?=
 =?utf-8?B?NndYbVZxL25WNVNRWitaWWtkcUhoYml5NXN4eTNFbklMMWtwVmJSN21PQkpz?=
 =?utf-8?B?TzR6SjFUakZLZ0x0QWI4bFlXUGZvOHdUeG9wZGMxTVMwaklqYVU1bWttWEto?=
 =?utf-8?B?ZjhIamVSV2dTNGtRazhkbCtkMnoyQ0tJam1tTmpmOXoyZk1peHNRa0Fkb1J2?=
 =?utf-8?B?eFNsWEM5MmdoYTNvLzVvN2xnb0h1dS9rNW1EanFHR0Y5QjQ3T0dPcFhiN2Er?=
 =?utf-8?B?d096NnRhb0w2dmRXOXp1NVVNMWx2Y0RuY0ZwNUp3Wjc3Qm1JcWlrenZ2SFQr?=
 =?utf-8?B?NE01VW45dmdZY0VXdlQ3SThYWkRhWEdWOWxmVkFpUDNHK1NZS1JEcGdkbkJr?=
 =?utf-8?B?ZjFsbGNuTlRDNkc0eURMclJQdWw3bHlPbnAwNGtvQUhERk1NZTcwSWJaSi9W?=
 =?utf-8?B?RnlOWjIzcGNiaWVFV2RPR3BZSlByOGxZZUdJSFJKWkI0QmV1cU1vNTdBTTg5?=
 =?utf-8?B?SFE2Ti9KZFl3ekJFamlyQW5uMEI3VERRbjVtMTNWK1hhbUJYYWcwcW9Rc0VJ?=
 =?utf-8?B?QUN0ekNYU2hyaFpnMlQydGMrYnlQYnlsK0lqVHFPdTdmVlVRYVRYYlhpc0J2?=
 =?utf-8?B?RjM4QzZ4ZDZFdDdQQXFlL1NDSGorbnA4b1UySDlyejJxYlRhMTVyUzIxbm51?=
 =?utf-8?B?MmpRMFRxZlppRHg1NG9FVndxcTFqeDZBNGNZbUh4ckppMzduQVd0MThEOGox?=
 =?utf-8?B?dnpBZFJnSW1EYnkxaUFvZGlBQ1dJZzBuNU9lSk5ZNnV4OW1YYkZIeEptTUUy?=
 =?utf-8?B?bjZISDRROTZJY3lnZVVEUHhKbk1Uei9uc2JjQUhkR0NKZVNKQWM0anBuVlJI?=
 =?utf-8?B?VEcwZnBOUFNaRXlhdFRmOVZvczlNK0xEc1U1RTltKzBFbGNMUVlQV2NESlM1?=
 =?utf-8?B?a2hLUEVobUYzU2JRWlM5cjlOY0FhSnBtSjVmVjN3QkhsUFc0U3BuVXgzQkNF?=
 =?utf-8?B?d1ZiZGN0bDFkaUVDNUt4UnR1ek50Zm5CbktKdGx1TXRZZlVNTlNIUHR1TXNI?=
 =?utf-8?B?LzdqWE5FZDV1SlNUdWErK0xqdlplcnFMMUdxUWRJZURsQit2M0ZHTVJMN1dU?=
 =?utf-8?B?bmhjWXVtc1JLVGptUXhRWVNYMlgyTjJCWkNvRFQ3Y1RGSFRjRDdRbG0wYllw?=
 =?utf-8?Q?Dn942lXiWuLmEsB8=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756863db-0d16-4a0c-1f39-08dec62a6d5a
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 13:24:26.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVfgclJFGmobjOnqGlLRFeXBMXtP6Q2WpwXm0X/nAv6+y8vFNUTe829m56k2iM8tItpiAuc9mBGGqmc0KrYdgvdvczFK7CHFBup1BIFLBBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0663

On 2026-05-04 20:13, Thorsten Blum wrote:
> Replace sprintf() and scnprintf() with sysfs_emit() in sysfs show
> functions. sysfs_emit() is preferred to format sysfs output as it
> provides better bounds checking.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/sparc/kernel/vio.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
> index 8b4f55047716..b7b06752a038 100644
> --- a/arch/sparc/kernel/vio.c
> +++ b/arch/sparc/kernel/vio.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/sysfs.h>
>  #include <linux/irq.h>
>  #include <linux/export.h>
>  #include <linux/init.h>
> @@ -121,7 +122,7 @@ static ssize_t devspec_show(struct device *dev,
>  	else if (!strcmp(vdev->type, "vdc-port"))
>  		str = "vdisk";
>  
> -	return sprintf(buf, "%s\n", str);
> +	return sysfs_emit(buf, "%s\n", str);
>  }
>  static DEVICE_ATTR_RO(devspec);
>  
> @@ -129,7 +130,7 @@ static ssize_t type_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct vio_dev *vdev = to_vio_dev(dev);
> -	return sprintf(buf, "%s\n", vdev->type);
> +	return sysfs_emit(buf, "%s\n", vdev->type);
>  }
>  static DEVICE_ATTR_RO(type);
>  
> @@ -138,7 +139,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  {
>  	const struct vio_dev *vdev = to_vio_dev(dev);
>  
> -	return sprintf(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
> +	return sysfs_emit(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
>  }
>  static DEVICE_ATTR_RO(modalias);
>  
> @@ -192,7 +193,7 @@ show_pciobppath_attr(struct device *dev, struct device_attribute *attr,
>  	vdev = to_vio_dev(dev);
>  	dp = vdev->dp;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%pOF\n", dp);
> +	return sysfs_emit(buf, "%pOF\n", dp);
>  }
>  
>  static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

