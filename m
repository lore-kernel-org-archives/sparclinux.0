Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022134.outbound.protection.outlook.com [52.101.77.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538F25B09D;
	Fri, 12 Jun 2026 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255727; cv=fail; b=DRgpzaKQJGzQ9SJnC8xwot+zU8nyPv7rC8SauMxaE5HA2zODOWx8zNzNnCQ1QhmZrfHp0eup74P1lUt+gQPQDTuID0Yy8hYjNdenzgOZK6zlt/TiwOC2nsL53RhROPae3gIkgRzQdD+k/k6exPcXP6Ww/XqwTCAtYnM9BzZinvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255727; c=relaxed/simple;
	bh=hC0ITUf3tTMTMg4QsqLtodshxpThbU+fLd3faDY+9Tc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rb8kRODwZKRih8qqsC0LAFsfgNTRnz0jrM6PGA7eh3XF4Oq7oB9hpXQb1MULQxGdhmUgwSYXVhjPlhxzyNphNUDr8TwStsSofQ/s9d57n3P8NuOGdVUmflPMTYXYiDKm5xi8CkB+1v0qyYTA+1ZMJdUNUQf4aX7ou+IL4dQpLLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=PjpvkUBn; arc=fail smtp.client-ip=52.101.77.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="PjpvkUBn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzxzioGAqb96RbdyRjkztjaLJB+H+6PRvaOzRprs6zrTi4PsJiiRBzN69rQR33wDkBjexFpDpQGuD07AANfr/8A5thm1JdM1g0UUjcphOc4ooB1fkFXRfN9YQfIK93BhiMZOOX9ZlfYpryQ0C/7bG7UoRbB+ZEWz+JsYgl/T/nPtPNkwa2QEgHpukYAqIz8kuodSxLjo+2TaJ6ckIOqdz7uVV2e3Nw8BjCoWWNjC/kdz6ZZvKW8Z1injOgJ89r1nk5Os/eQYODZpv9m0CkXLjaBxTInimYZyTk69G5hwRQ7mMjA+II9QzyrXmOm4o/QKOGRjyC5rk7XncAg7pkO1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYdpjlmDXNhLVrup3b4U0DuGYwoTrZtWgd1NoueHjKA=;
 b=l/jdlxHr8GPJ5U5AjHvCV5Gnqpfn+TKqFEbNwinjkCUlOtLWKh8MS/BWGcS0fXavvEfk4k4QWyKU4FjXHDwvWMdReGo/47NPruV8ICF5ce0gjJsHq9eOzSbx9Ujv+aLKp01dBRIJM+ogzDrqKnZdxzxT0Ql28TWXEDAFEqP7+CbH0yun08jdfuNvuZJ28bhKBAgQe8jImAUgAmFAbIFGAVdF8ph9lMjJF1wJJHRTwZKlN6zPAtBjMPhB7k3IXad9vI7WfSxcbsbbQaiHrf4YF4kzMakY3BtHclTCcfoUvrjXryCgG0ZkwkoLYjOlECw+cRk3m877/XfwQG6vkOOmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYdpjlmDXNhLVrup3b4U0DuGYwoTrZtWgd1NoueHjKA=;
 b=PjpvkUBn6mK8dwF0CZFE/qlOaSf+BlwF5qs7zjyEr9aTLs+lkhgZGiWsX8pm04XEIcPT+GBZl5IWycclz45aZZ/KNmtE3gYU746FYjPcfhCUJOcpyaBU36lOUXVGaoPTmVjLoVLl/Cp9LV76hit/X0eR43OaoSC0XhOSULxQeAkL5HeMEuBM3aSM73bakYb1DdV1RiqI/DzcjL3sEoK6ru/Hu6gKrs2/cG0vvnn2YMbkaLZkWB+ICa9ImLz2Y59lWj0/HwrjKTE/OdyrQjQECleTazVgrwONrvu0OQv1zMSNok0WPUCcItlONTVVa0l5gWAgWZOTyp2Qt13CFQm51g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GV3P280MB0759.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:15:23 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:15:23 +0000
Message-ID: <b7749d3f-ab9a-420d-a203-2a9d5289e22b@gaisler.com>
Date: Fri, 12 Jun 2026 11:15:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc: Avoid -Wunused-but-set-parameter in
 clear_user_page()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Ankur Arora <ankur.a.arora@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260525-sparc-clear_user_page-v2-1-e7a47fbcf439@weissschuh.net>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260525-sparc-clear_user_page-v2-1-e7a47fbcf439@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0002398B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::36d) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GV3P280MB0759:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8d5f15-4703-4c55-a21e-08dec86321fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1NYcna6FFmpInzjP8PlFOouUCnCYPioj6dh2SpCkZQY2rXUFH6zrmKuqt6JqCF0nDEm8YChQNOMglLN+xD+hhmH+XOxNnJADOQIDQRONWWUgmMKmEgYcQ0yN9W6nJNKTofd30kuKwdKrfHDtjXqpFCL0iYyExRT2ajKbWB9hEkxRLezEjCUzznjhTXVzhPjhp8XO+zof2p3RpUo1H2ARKSzFsLzmUbPNH0UEPFsIaQD+LkQIK37hwocldl3cxEsMSGyYRBTVeeQ2jRUaau60WJy3v2d9g+WRBdKmBdAj+M17azs/w1urPhj+K0Ss9AfB1T0saOHpeGXXo6EXxoxU2/zTEv9kiVuMeMGuFnBBWP8qFkdBFSJhVLNrJmizCC1Ni3v6lroZUidfzsxaBXQ0xSUDdIsScGX11utGcbyh6xoBzoj/dqUL9LCURS7hdP+HoE7pYFYpGR9VEDqJYxtbwYoJsJ3PTjbXMlAjxb1b6RD49IEavSR8aXwiJYUcppLzFAqgmcmLHQtQQ6+A/kwBEvh9nwMHSEpJRU3I59txRNs9G3F2ekkeO9Wfj41gST5XmhWfIeugAjSZ6I/QHhY3LZ2KsZAfTkaONDZ9CvektvnXDg/umyCYS7YYk54Dsuz43PijeHqKGCu/pJx4PrlSxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHc0MDFFdm9ZMWJCeFFXeWtQR0k1Nkp6di9wWWU2bVJvdFk3VkFQOFhld3l6?=
 =?utf-8?B?dUJDbWhFbWVRUXRXU0xsWFZhZzJ3QkFaaFZyOGFMTFpLUlVvWk56bXVOcTZC?=
 =?utf-8?B?UFFXTjJZSm9YMDR3cWM4eTQzdXl3TjZlblVLMTliOG55Rlc5QlM3MElnd1dW?=
 =?utf-8?B?MEdFbGlYazdEcE1DbjZTTzM2OHVmbk5pRjAxUVNNMWpIbzZueldGNnNVcWhX?=
 =?utf-8?B?cVpDUXJLZldwbDBRRVJMMUVLbGpmNFZaZzJScUN5Sk1nUTltT2lDWFA0OUYr?=
 =?utf-8?B?UWVBZ3Y1dlVxWll6NVdMVnhPbzhVOXRMTGU2UThrS1Jub0x6NFlyZ2Fya3dj?=
 =?utf-8?B?SWxhZWQ5UEdxV1FRbllYblFoMXVjRzVFRkJwNWpPcWxMRDlrcURhRVQwcEMz?=
 =?utf-8?B?emJRSWxMRWpXakoyNnFNQTRQZ1ZJMS9nYjhJbGVsNjB6SDh4djF6TmlpMnFL?=
 =?utf-8?B?cjN2aThmbGpiSUF4OWxrc08rSXpMYlllRVM4WUxQWHdjMEN6YWloeHpmZmQ5?=
 =?utf-8?B?SGFlMDh4TFRTaWtoVjBmWjdWY1RtbkxBckVra1JhSy84Y1BwS2JJRUdoOG1r?=
 =?utf-8?B?WlgwUGtaTlRkMmJqQVczNDJZQVpncjJnZFdibWdJUldSZVBHRkloZzMzVFMv?=
 =?utf-8?B?TTB1Z3cyVTlXelR0SU45N2U0Vjl5WkFPNWFuZDJRZDZ6V0VVRkRUYlhSR05t?=
 =?utf-8?B?QVk1aDJ3UFczb1VSbmUvb2JINERSNzBwNmg0RTR0ZHVUd2pVN0twUU5CTmxF?=
 =?utf-8?B?bFE1aVdKWG00MkJwTjB2ZnZsSU9ic1lzSG1kamxFdldVM3pSTVlGWThjZXB6?=
 =?utf-8?B?S3VnTUo2dHg4NDFCN0pVTWhKVFRxRHJaU3Rlai94WGFNbFByaTNzRXF2YWxK?=
 =?utf-8?B?eXdydFYwUEVVak4rWkRFMXRDbDh6RzZpaGJPSVdiOUl4cmxzWTU3dlFvcDlB?=
 =?utf-8?B?ak5neG52ZWtYZlNyL0FWR2FXTGF2YkJSaWNIcEc2Q0ZpSkdqaWlUS1R0L3kr?=
 =?utf-8?B?MFZlRCtVMGdBRzZjeXd1WXFlRlJ0TlgwQjhlOVcwSk9QUXdWSzJFWEpxcEIy?=
 =?utf-8?B?QzFxWS9ndGtGUWJ6Sm1pS2FxS2lHZHZNNTNLNG5QQ2JTMERGQXhuaERSdlR4?=
 =?utf-8?B?Vk05b3ZHSU5HSEV0QXNRamw4RndOUVRUdVVYZXByVlVVLzJSeElBM0FkV050?=
 =?utf-8?B?WU80ai8zOWlLdkJMNXhqVXJXMWZHNFZPSjd1eDIrRnpMSGlkVFk2dTlzMVZZ?=
 =?utf-8?B?SkhmRnp5cjFqSHFKMmVzRndaSGtWUDNteGo4Umx5N3VzNTcvN2tCYmRHd2VC?=
 =?utf-8?B?WGtPc29oVURQVWpzOWFNbkExQndxbUNhMXlEQXpzbWc3M0E0NHBMSEwxM1pM?=
 =?utf-8?B?Mnl1K2ZqOE9kTGdnNXlHcTZoZ0lGa1hLY0E2Y2ZDR2lqZU1OY0dXZjJkWVlB?=
 =?utf-8?B?NjNjVWpZQ2pJVjJrSlYzUThKRjlvWUtOTTdJc00yaUs5MWkrR1FZdzIwNlpV?=
 =?utf-8?B?WThTekNQamVmL0NBUW9RckxkeXdIQnRUbWNMM01nRTUxbFY2NmVJY3FmNmc1?=
 =?utf-8?B?L3Frb1NCN05MY2xadk1kQWxrY1FvOE85N01DblR0alRIb0tOK3M5OXpkQStz?=
 =?utf-8?B?WEFlU04wbTBDd2RTRmhLZXNBd3ljUGhod216RXJsTmtOWk1ReWxGR21vNllN?=
 =?utf-8?B?akpvckE5UU9XN3ZhcVNjOGljalkrdFkvN25mNkxpL2h1RGdLd0Z5NWpkaUV0?=
 =?utf-8?B?UkxOZ3VFOVdqWkhXdlVGWEVzVFR1N3VBTmNzcFd4WFFtUVpmTjBmYjc3NTY3?=
 =?utf-8?B?cFV2MTJqdURNdzdOZEhQYzNZSFI2YzZSWjVudWh6UnVvNUF5MjRMYjhZbmcr?=
 =?utf-8?B?VkN0Z0V3bllaQWJZd1M3cnFTbnpjalRoYWhZOFZBUW5ndm5hSzluWEU3SGZr?=
 =?utf-8?B?YmVzWGxjd2J0T2lZeHova0RnTmtHWnBSMERMUjRkYTZwWVZvTmdFcEZYVllx?=
 =?utf-8?B?NkRhaHV6U3hLcmpUck1EY2pBUnpBdi80eisxb2wyenMzam9BRG0xK21UeHZ1?=
 =?utf-8?B?eTh3Q1c3ZHB3eHVDaUVSMnNIN2szQmlJZnhTWlk1QTFVUld1OUdvTk1MYndY?=
 =?utf-8?B?Z3VHb2NzaTRoNTJBWjVtTmNZa0RSZXV4aWd6SXUzN3Rrblk5bU1zWm9pelZp?=
 =?utf-8?B?SjltU3JNWWRteWpqWko4em5iL1drQ25ZcTJxTHhVTHd3THFsYXBKdjdYYmJx?=
 =?utf-8?B?Y1NhTHdsUTRxUGhWVXpKK2RtVnkvOTlJYjBodEZkSG1oVndSOUFHeVBiUkcr?=
 =?utf-8?B?aDRwdnV0WjJBVVVZZTl3Q0pBK2pZS3hDNDdheXB1cEdXU1FFMEc4Vm5tOHl0?=
 =?utf-8?Q?XnD9PV3t5B1udSz4=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8d5f15-4703-4c55-a21e-08dec86321fb
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:15:23.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lO7xg89YuDBpPoUJkMAmLsBqgH2U0WZG4g/06QiZa+JtmmxOQKn2OwbhekVea841Rox57tqzynVCv/4Z3cGFHJnlwT/Lcc78NVk+MEFe5xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0759

On 2026-05-25 10:36, Thomas Weißschuh wrote:
> The loop in clear_user_pages() iterates over all pages and calls
> clear_user_page() for each of them. During the loop "vaddr" is modified.
> However on sparc clear_user() is a macro which does not use "vaddr".
> The compiler sees a variable which is modified but never used and emits
> a warning for that:
> 
> 	include/linux/highmem.h: In function 'clear_user_pages':
> 	include/linux/highmem.h:234:63: warning: parameter 'vaddr' set but not used [-Wunused-but-set-parameter=]
> 		static inline void clear_user_pages(void *addr, unsigned long vaddr,
> 
> Other architectures use an inline function for clear_user_page() which
> avoids the warning. This is not possible on sparc, as
> sparc_flush_page_to_ram() is not yet declared where clear_user_page() is
> defined. Including cacheflush_32.h will trigger recursive and lots of
> other issues.
> 
> So hide the warning with a cast to (void) instead.
> 
> While we are here, do the same for copy_user_page().
> 
> Fixes: 62a9f5a85b98 ("mm: introduce clear_pages() and clear_user_pages()")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Put parens around vaddr.
> - Link to v1: https://patch.msgid.link/20260524-sparc-clear_user_page-v1-1-baa5b90e5d0d@weissschuh.net
> ---
>  arch/sparc/include/asm/page_32.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
> index c1bccbedf567..9f0b54f70908 100644
> --- a/arch/sparc/include/asm/page_32.h
> +++ b/arch/sparc/include/asm/page_32.h
> @@ -20,10 +20,12 @@
>  #define clear_user_page(addr, vaddr, page)	\
>  	do { 	clear_page(addr);		\
>  		sparc_flush_page_to_ram(page);	\
> +		(void)(vaddr);			\
>  	} while (0)
>  #define copy_user_page(to, from, vaddr, page)	\
>  	do {	copy_page(to, from);		\
>  		sparc_flush_page_to_ram(page);	\
> +		(void)(vaddr);			\
>  	} while (0)
>  
>  /* The following structure is used to hold the physical
> 
> ---
> base-commit: d87895ce6e45997825cfe1b3565a1843e8ac8011
> change-id: 20260523-sparc-clear_user_page-7448669a2476

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

