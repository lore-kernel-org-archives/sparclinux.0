Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022108.outbound.protection.outlook.com [52.101.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9C466AED;
	Thu,  8 Oct 2026 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451454; cv=fail; b=sNw06UD+QEske4yxioIqPuWL5FtmTi66yD0CtmtzxEkKxYcNP85SmocClR+MDd7NYiwDtHmP5vdIwVHMB8Q4pHKspY2+hlxe1NIBhGBFpzBouw+LgFtsXaCWpIDrW/lPgTwFEce0k3v8dS56hRmEkD0hy6McaHj2izkLxnFUkuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451454; c=relaxed/simple;
	bh=q9fKq7Y0n7TB8k/wbDtFfIGQPgJD9YC4ljnLWEvfd5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tq0Vj8d6ZZgRviyGnhTLAPbtF5gZVC/CIECZOeoLiA5Ev2OkAs70ByS7e+VwREBjbYczA+fv7RFARW9h8Rh2bltYMvO4KNYQeWNNDuRH2aeniwXDNDS6CKzu+nhG3EnIDmNPOkG1Ojsv6RuNSekES87dgoZvzS3cF9usspO4hxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=WEU5pDhz; arc=fail smtp.client-ip=52.101.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="WEU5pDhz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1KIAfBsBOYBuG7FiVWMYhmvqVfISNH0w+BbME0a2AMj85aUB4jqtnuZzxEYHXIIbbDHxzS4ICrZfdwIWWjhfVfTmPdMdgt6Lz5BAc0QxxoFIOd6YeABmaCt4rbK6fj4H+F24lz0GBqVsNfatXafkVNyjadUBcJ1ZMIVoLgUI7d/lyd4qSe78zrXPiyAPluL2MK3OKFUlhrpr+02wZGGEqhBY3oH7VQrhwzd4gqozrKFjCgRdb5SypDj/gcB3rT8k1yStT1dNk77C9q7athUQfIWx0aKMTygC1HYrnGx2wi2t2rY054ZX8b3q8YPH4k76oB0X6J8PgOdF+H6YRIjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nhDK/V6jea0KeG2GS8Fe1EdsgFsIx/I8tlvFyDr8UQ=;
 b=IOSCMu8u4Ndg7HlPK+AbE1Nm+phpfBirurrYaNBbjh01bxV+gaARJAy4Tcaknj1BmAm1eBLQgHXg8OUtAF93sPc7rTu8xx36JhzY58dWQ2IWCftto/0n6C+YN/1MfpZIhJBy26Ng8CRlHhNf8AEDh9z6qfyCAfIBNDx1XqUO84n0fQn2lcUJBTZIppAt/3uyuM87lN/9vmNIXiRGAWHLMG89PEhw3O7GwOY5tpVVDbIdJueYsoo/luh3q7i9HOcRxAb40RG1/nWuLvhy+6r8EorbdJbPzoGc3mVItn5dFSDAkubaLyD5jUz/yGyjujc7yOZPC2njLIDgNiZn9U4dXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nhDK/V6jea0KeG2GS8Fe1EdsgFsIx/I8tlvFyDr8UQ=;
 b=WEU5pDhzLCZZuFvDjrIABbP0Q7C91f/PMFK3jZKqynrxNjyiqqqksisE4nmrJBvzj+EWOBhMr0SwZGeoZW5hWjnDlLZv7y89fp67qy67WNUau28Fh6l6msikmE7BLiWgLe0uoeLXU1tJhLQPxr522Wh9S2VfZ9TEji6DSVY6b4b/6+YUANkb/GgTvDzgU6L45VA17HLIlIxp/fMNorjo3/IgVGvXx86S/ff+nimeeeqrZTK+MG+bXi1q7Z5+/LLoXuzK/jSPpmUE/GxnYcJE9Ov5sFEXjSUmPsR5hbIldN6KSMMnCfDmeIb7+MDKbiMBgavr+y/gE9lpQnA1Yyt8RA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB593873.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:602::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 8 Oct
 2026 09:24:00 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:24:00 +0000
Message-ID: <0174ee88-4bb3-4af7-a171-7438e81ed124@gaisler.com>
Date: Thu, 8 Oct 2026 11:23:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc: NMI: Remove obsolete comment
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 "David S. Miller" <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Bhaskar Chowdhury <unixbhaskar@gmail.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902113009.684977-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260902113009.684977-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::10) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB593873:EE_
X-MS-Office365-Filtering-Correlation-Id: 92eb9bdb-05f1-48d5-131f-08df251de32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	OP2l4faE/NLGIMAIGM40nM02ieyCFsxFz6jJCR6ywGbeXA5E7pNUfQTDPbBLr1F+LfQLLQYUJPm9qRGu886Q2Qzk6VfizIWNU+hZxcSxKfILAByX2/7WZC1lgQd/wvirJ/uoaP7yY7tglilBMAGnciaQmI10PUnHb/TV5//jMR/IUR0jVr7Ku5MXrjj3/q/DvQoEdZqF6zBFU88C6rW60Wof3/ngm5X+fqPKu+3lkNji6IzgA2c5Hqp9Av7CohD3BGXuI2Aogb6VGd3ezb7gsiX0eIsiDxj5w9EvXXNMRDmpp1JFhMWyHEaLnNIFi+tAhvg2hlaEDHTjtjPYWyS9IlbV1+7FcF+aHWeo5Ho+FFe3Zb03suWznEFUZysXTTZfP8uAtemVrT6bnGzxWoQOxAOGZinFDfZjYtlBkyPQnr5VXDnBzNX2g3dr7AGeU5WDU+TlN0kkqOTxGEzz0AI4Zpd/Le5ot60us8p9jtQK5knnSzoVeOP4iklFPSYfwYEp6SHAUANr81yO4FM6SVokOHmyjEjicJ+sgMzTQf2FfTe/WqVuIhbe2L15HUw3T3nXUHrQR9c1Um+zUeXkUdD9HFAJy9mDTHb/MUZO67/yuwN0XGeXXmFxSEosKffZU8G6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWhBTEM3NExsM0pkVzh3NVdsZFVJOFo5NHRpOWIycHFTRTlwa01KMGxpRGNh?=
 =?utf-8?B?ejU5RVNlUmNiR0liU2QyL2dxQjlXU0JiTlZkMERzcDJGM0hUZDluZ0NheDcy?=
 =?utf-8?B?a3NOMFIvblNlcFQrWmYvTmdSVU5iKzNUbjJEZTFVWWNEblBjbGV4YTh6UmdP?=
 =?utf-8?B?UGpVdlAwVm5FaUw0L3RiVU5ad0VZdjcyblQ5eFA3dUFLQldvTUZFd3huMDZ4?=
 =?utf-8?B?NXoxcHVsdjh2NlJueldNSG1xZWZGZ0NTTUxKV1BIb0dUdWhyUmR1Q3ZRNVkz?=
 =?utf-8?B?Y1NPajRUKzJGWXljQWJRbDVqcUl0UGlLbGhjNHZkeDNTWjh0S0F4U2d1d3dm?=
 =?utf-8?B?a3Z3akdoVEdncDJLQmNGdkVObmRSZTZ3dDkzRURUcUVIQmpIK3lKRWdCWGhz?=
 =?utf-8?B?Y3EzQ2lkRlFsRXdTNzJQMkZKQ3JBYktUZDdlL2FWNElGa243b2R0MFU1UXhC?=
 =?utf-8?B?eE5idDdpenovT1BIYW81Qyt3YUszNlptdEwwZjJFTUJHcDF5c2paZjBsUU1H?=
 =?utf-8?B?Q25QcE5ySzFkM3AxUWZJRnRPUEtvTm1rdTlSYzVHamo2WFZ2a1lQRmNsYndI?=
 =?utf-8?B?ejUrOWVQR3FuQ2s3QXBnN3FRWldNMmNValR1b29FdFBFQjdLbkQrS3ZEblcr?=
 =?utf-8?B?Z0tZLy9rWjVzOTJTeEdzQmV1ajJJbVJrdUtJLy9waGpZSmxLbXMwUHhhM1kr?=
 =?utf-8?B?OGxqcTJPaW5IajkzQVpWVlI4TURNTS9aTVpGV0pQc21Ob3pzNkpsSUJpaGR1?=
 =?utf-8?B?Yzc5R2hoYWFwMHFtRGRCUE5QSEJCOEdITHhTK1c4NE1mRlJiWm9Kd2gvcWNF?=
 =?utf-8?B?QUNsdVZYRVlVZkh6d1dsNXF0MCt5Ty9CL1VnVVJJNGM5QWJ3YSt1Y2tvZFhG?=
 =?utf-8?B?UndHR0k2MjN2cTVrM25wanlTUE14M0RUYUpDYTdXYWJtTTNVNENzNnlLRUJU?=
 =?utf-8?B?VDR6OFBwYXVNYlVEakUyOEQzR2dIUTB2SVl4Yyt0NElqT1Y5U0ZHTzdYS2VF?=
 =?utf-8?B?a09RYmVORXRxNHBqZDd2eE8zbnByZS94N3pMVmhpemc2N1FsaGswcFlKWG9L?=
 =?utf-8?B?ZWVmVUFoY0VUSXlBeEdyY0ZUZWZTelhrMWd0alRVQ1lrc2FoeDlCc3JsVGhO?=
 =?utf-8?B?R0pNVThEbEU5aFYzMm5sZ3l3V0pkM0QxdHk4NGxDaWd5cWhMSTBWenFQRmxi?=
 =?utf-8?B?SkM0RzBvUkFVSkQyTlg3UGw3RVhKZDhSdytMOHZTa0FDeXlqdDZUQ1ZPYjRE?=
 =?utf-8?B?MjZPNVczQVRxd2VxemFmRWZKakVyK3lqZmRRUHZISkhKTkdOdjVJVmI2Q0Yr?=
 =?utf-8?B?c3hzdGdBNGM1UDNiU1VzemZrRTBhakNaWm5rV3VhVzJ4NU9mVU9OVytjcTJr?=
 =?utf-8?B?cytxd0VwbC9CWHNPdEZBZFJaZ1BxQlorRDRxK0R1Um82VVRUYkpEZTFyRXRX?=
 =?utf-8?B?SkNwNGswZGJLWHFzdUdiMmxNQ09HaFJ1ZVpld05RdWUvdDE2RkxwakNOZytZ?=
 =?utf-8?B?b083WldZVlhLeGlmWmcxY1Q1MXBtazFJYzVyU0plVUJiL2d2a01VTGpHRXFn?=
 =?utf-8?B?K0tkSWhlKzZ1ZjZveDhhc3hQcDEvLzRIR2s0UUdVOElGRlU3bFU0Yitha3FN?=
 =?utf-8?B?MC93MFRVcUd2QmlaeENzZ0laVlltekI0cU9reUJWRnMrS1QzRXZvaHV2eTRz?=
 =?utf-8?B?U1Z1TjZTdlkwc1hHRGxHdTQvUDN2dkRQWlc3Q0VNQlVxV3cxRW9RL1hKZWEw?=
 =?utf-8?B?ZTVWVm94V0NwODhWUlpuNUs0SWovdGdmZTNncVQ3NlZkVGdzZm1hN01oRGtL?=
 =?utf-8?B?Y1RScTZrSC83YVYrbElPM3AySkF2MTJQVHdxUGFsVjlTZlQrRDJreUdkY2Fx?=
 =?utf-8?B?d1hiQmJONStvbGhJL1ArR0ZqcS81VFozM3VhZUhOdmpiMkJiV3RsTUloNlpV?=
 =?utf-8?B?dU1ySUtQcy9ud1lpcVgwcDRpQXBScWVSek1MVkVDcmN4TEhkcy9va1l4UUpF?=
 =?utf-8?B?NDBiaXVmOS9NUGZGdnN0SktqT2N5SlltUlpITG9DWldCMUloYll2eStodysr?=
 =?utf-8?B?RjJjVzZoVk1BbVZCUThnRkNLN0ZGekVDb25vWTBDMm03TXNjRmI1eFZnQXhk?=
 =?utf-8?B?T1lzUGd5RDJlbERFdXJQZW0waE4yRXpKdUhVTDR6bmRZd2VKYmF3dmJITVVa?=
 =?utf-8?B?YnM5azVwY1FlNkgrd0pVdjc2T0k0ZVF0cmRzUjFWamhsNlVrbVVSWVN4M0Q5?=
 =?utf-8?B?ODNOTUlGaGR5eFdGUURRNVBsUUY0ZC92aE1nZ1NBTmFkd1IzVnZZUzVaZ0Rr?=
 =?utf-8?B?TktBRzhVNEQ4QTNJQmRtcnRsYVFTMC84TVJEdVZhQkk1N3VLS0Q5alZydEht?=
 =?utf-8?Q?9zSNIbOQ0HhsuFPc=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eb9bdb-05f1-48d5-131f-08df251de32d
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:24:00.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRwnMPN934F8nNdharfWMRCq4ieBU6dqeA3UYWB+6Gk+k1j3r6i5LptnKQqSMyenIr33D20ptSFYx4ZDZGm1VQvs2C07fI3sQMsvxNtlaMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB593873

On 2026-09-02 13:30, Manuel Ebner wrote:
> OProfile has been discontinued as of commit 24880bef417f ("oprofile-removal")
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> Bhaskar Chowdhury review doesn't show up in the mailing list, but I got it.
> 
> [v2]
>  fixed referenced commit
>  + Suggested-by
>  + Reviewed-by
> 
> [v1]
>  https://lore.kernel.org/all/20260830125506.632168-2-manuelebnerli@mailbox.org/
> 
> prior discussion
>  https://lore.kernel.org/all/875527abdf9df0393ade872c6df3612ae9945b44.camel@mailbox.org/
> ---
>  arch/sparc/kernel/nmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
> index 149adc094..1571d6298 100644
> --- a/arch/sparc/kernel/nmi.c
> +++ b/arch/sparc/kernel/nmi.c
> @@ -41,7 +41,7 @@ static int panic_on_timeout;
>   * <0: the NMI watchdog has not been set up, and cannot be enabled
>   *  0: the NMI watchdog is disabled, but can be enabled
>   */
> -atomic_t nmi_active = ATOMIC_INIT(0);		/* oprofile uses this */
> +atomic_t nmi_active = ATOMIC_INIT(0);
>  EXPORT_SYMBOL(nmi_active);
>  static int nmi_init_done;
>  static unsigned int nmi_hz = HZ;

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

