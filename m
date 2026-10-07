Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021128.outbound.protection.outlook.com [52.101.76.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024F42A144;
	Wed,  7 Oct 2026 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371355; cv=fail; b=Jsl6ta81doC8FbPWqaLJ69E8Dz/0KTWm2hcFSzjib97kctIsGF/KuG1axg07ExdulXNLWIDTue9s/+QFnDc9U1yomrsxqkNe68m2y6/VXIh4+8UdYMihTZXhdFXheeeUlMnmL9IZ0rKdUyhX2zJk+IGj8PbgAVeFuXeQ5qvml3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371355; c=relaxed/simple;
	bh=DBr6bzqwqxO7kHf4mHQ6fIORYrenl5rcopTW88H2H/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O7OPUsm8cFmQ88CvmrPvXYNmrMy7TYFR8VyGmNZ8LA0WqEB4iYP27NO25CWvf5RAFdCCEv4T5ZsPeSzNJm/4GXfqpAjOFCGOmDLcrI9oOWePZl/eaou0MZ31Uu1lqHer7G0wxvTAO+uz645RVP8xRXUnxs5dymv9LLTyg7k4rZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=jSS93A/D; arc=fail smtp.client-ip=52.101.76.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="jSS93A/D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDKUuW0hLuROdP/fUKKHo35pnrWXK5sBHVRpmLaxWRFTnYDSFH0mh0Gsn4uP5bpcX0xhOhvOy5POTL/QfM/+rQxv7FQacqKcA4EDn4tz5NUk3BRrrDV7hwb8q/8iu1OmsSM/S1MpYJmESh9hCTIp0Uvd2lX4Y9BehbuSSvjkkcva6tbJbHBwRpFB3l9hYVcW+rtG/IAqHXxx1OIlzxusUUKQw7jJ04chu2CVjzNkfATFEW/nwqhC6rRI5+AMrveoZD17RhdNLkwXsU3bSsLVN1LKvgoCpNvEPdplrfDAWgygrHCRFart9fpEN2L6J1BGLa32PigO1iEOcnSyJ2BPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV6yX6cITmEFruixpNYnINf0GlOyJtveFXD2lgWj0+A=;
 b=axHPtmEkxZRlW1I9L4jpxZRcoyZZV8pqqXhELEs/mz95+qvUdoedBdD35zpc8+L5Wr3zdQQ86R2TblcwG8/j6qojTxdbWg4YP3MyClK1fa4o5i5eFmFojVjmcfYFnNiEjjWkZgVzzB/pa13dj85j+1n4SFIZS8IBS3sAyBH3SnSEiVsirAjFLPp/0fud/zPEnLpMWD6C3/bArznsbGjXQKNhYCIwsmbpSTWZR3b1S1y9N3ey1JVAUw+ywZ9+hKFl9viLrDfbjd7aOChBO7qzQ48U7Ygky2srQpqNFbjvB3T1dg2aopfzbJ1nWKXrYt48dla+koUHHUtR7N6R/OEekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV6yX6cITmEFruixpNYnINf0GlOyJtveFXD2lgWj0+A=;
 b=jSS93A/DZzElHJd8LFliOsTsnzDjTIL1V0OVwEw75CblEnAmZg41SKoQkqPICg5X4dmhcV4Rp+vcq87I59PkOPW+l7TgKxWA+tWx3WKQFbDkVfmH87ijn37CMuNXY4orlqCVKC1q1lHlAmb+4n9bHufm9cUlOYjvs7Oy9OdBnWbEgX+40+Nx5NoBDzcK0tgiYQsUE9YwYUv15HqHKQfSAwfPS78ec7aCw6yl7BnyiaLiXfnCrQhvZB9aqiS8zVXnu8xdkLGXUk84zPEgRY1duJw7h8Z21dhKmClHxnLjThumlHB/ESJDEpydqSYtxqy1+LaTXf0SspYmiyjEB8LzYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVZP280MB1880.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:08:48 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 11:08:47 +0000
Message-ID: <0a72b324-9909-4c46-819a-93389bb1f04f@gaisler.com>
Date: Wed, 7 Oct 2026 13:08:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc64: Define p4d_page() instead of stubbing it to NULL
To: Nathan Chancellor <nathan@kernel.org>, Rosen Penev <rosenp@gmail.com>
Cc: Kjetil Oftedal <oftedal@gmail.com>, sparclinux@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20261005203930.246598-1-rosenp@gmail.com>
 <CALMQjD-udSokCKS07VFWauBQzac5BTPJqbORhskxgddsuX1vLw@mail.gmail.com>
 <20261006083103.GA3041473@ax162>
 <CAKxU2N-ZE7dwiGzVgxDYFvm2R0BE0nah2WehGcjpym=Kq68dYw@mail.gmail.com>
 <20261007094141.GA1527675@ax162>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261007094141.GA1527675@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0115.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3c::11) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVZP280MB1880:EE_
X-MS-Office365-Filtering-Correlation-Id: bd220612-8f92-4e0a-dc54-08df24635c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZGcu5U+oYgUNwcTQhyaiWesanStAPB59w93R44ACUmwNoJSmh5+Pfk9FYfnNxh4oe5ZaGSub2HATYaejAzuDWWmJlG9Gb53ARKdpwRTnKpyMy+gMnFITdOqyNnwC3/kwXKlckIjuy7RE3+8TY8vkME7GBEcru3166LzibcQpQa6IpijBAXxo4UEwhrdGP9SJoO/ke6JT40KuckNN/fbLlwcNbEM9Z378X17sfMy3mv6V9VpFN1Kv+IXygsVlX5s0BD26Zj8wRQOrzl6z0/05HO35xWRd399NFM7upo0n2oi/DNtSWCLsQB5l8UV1wWHzp9rdKbssAnVvTmoZVIw2N3BNxlT4zAQ04KWzM8JcQW471id+6ZDaudMBq65uGNl18oTiW/KOMfQ57a+rfCqjTNsXMNRAhj+bHSGAdVDfix1cqSuDrqarhmjAAfptjAQgmMxMabIz49Jf+YV65ue2VR+wyfoTux0Qtq7CSkaOVWYpOjj3V+nza9iURr1i0K8KUBTi4lcDpei81keDa9TjyNEZUcrVEI2gmvt5gXgjsy9Mwvgs0rVbWbKKyQuhNxMT+D1ElN8DXBSRt15D/Du2X5Gq7TzilsvPJLt4AAvMl51wGBFg6VJ8Hxmhwv0L0zoxPsXOG41cbV4LIRDZCwrBpXE9oVU4Ls7MbGcmiYtfXHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRoWkZCby81b3JKYWZ0UVNnWFR0cm14cGxGQVRpeXkwK3p4L2x5clBUVEhv?=
 =?utf-8?B?K0Y3QmtxTnBxcmpPSXl2MG9HZzNTQTQ1TStCUkNDT0lnckpsellkWTBYazdS?=
 =?utf-8?B?MWpiOEhoYTNHUEllNC9Dd2lxQXdHeEVyMXo1dTR2c0NmdkQ2SFl2NkFtczR5?=
 =?utf-8?B?K2pLbW9FK2Rzb1NETjRTM0hlUlFIa1VnV09aS0doUmUvNDVyZlVnQ01ZUmJF?=
 =?utf-8?B?YmdHWitETGQvLzA0MGRqRTEwMWtnbmZvaFp6OURWNGc0V0tlcFUwNVExUlFj?=
 =?utf-8?B?WTNUc1Z1NlV2Ujk5R2MvdHVrVDgzQzZpeVQ1RjBiNmtkbEVad2pmL2IwaUlh?=
 =?utf-8?B?elVsV2JCOUVXL3JBdWJiVlhSdlNyRlQ2a1Uvc1BURld4RGVudmphL21SL0hS?=
 =?utf-8?B?blVYVm9sR25sQ0FNQXY2ZGZjbExEV21Ba2RqY0JtYjBXL2Z0UUpPUFNpZjZ0?=
 =?utf-8?B?b25HUXVTNlprMDUwMU91NVVMRkJ2Zmd1OUFmY1VIQzBTVTNrSjNlV09hNUt0?=
 =?utf-8?B?QXJMU0ErQVgzUHEwMEFxRHVCVExRMzZ3TllTak1YWUt2L0NMYzhWQVVEYWUw?=
 =?utf-8?B?d3BoZEFmVXRhcU1UNUI4YWJsVndkZVhWMEl6bjF3K3NDakJRR0V1b3o1NW1P?=
 =?utf-8?B?WUg0Y3VyTnRzVVU4SG03Uy9jb3UwdEluRytHTzhKR1E1NUtFOXJ4M0RUQTZw?=
 =?utf-8?B?WlFDanZLcXNCUGNkWkJnSmtPNENiOHQydWZSNXkyUnNjU3BhRm9wZ3Q5b2JJ?=
 =?utf-8?B?Z0VOaUpYcVRFT0pBYzFrTzYyelRjQjhuZTR6SDQ3c09RUkVUSFcwU0oxRHZ1?=
 =?utf-8?B?NmhRMG04YXp1a3E4MlQzc0R1ZlpBZEZuNmszZFk5eUFVOWIzZVV5Z21ma3pr?=
 =?utf-8?B?V2ZZUnJLa1dxelV4Mk0wT2ZhWms4VUxsZ09QT0pjbFBlazVXeEY4Qmd5clp4?=
 =?utf-8?B?VjY5Y0NoN3dydURxNUZiVWRiQU9kb3MweXEwNGhRV3liak1oWloyZWRISkwv?=
 =?utf-8?B?ekFJejdnVGNrOFFuM3RVcG1JbEdlMlJJcCtmWC9aeERrbUF2NjhKTGh4RmhZ?=
 =?utf-8?B?TzBwY1M1L2ljcG5yMUxnNlNORW51dW54eVpiMUVVYVNROFdDd2J1S25ORm1r?=
 =?utf-8?B?M1U2S3lBaTdZZ2tWbm9KaUw5NmdwRnoyWTZYYVNBTU9pajZXS21iZmlQR1VQ?=
 =?utf-8?B?NFgzRi9RMEtzQ05LUUNKWjBZVEd0U1pIRk9OSDlyQ1JvdEQ2bnYvb2pBVHNp?=
 =?utf-8?B?VXd5emN1ZjZNNkRnazhTdXBsanh1eDlCaXVNRDFtMW8xY3VZNENxOEo3ekFz?=
 =?utf-8?B?SG5YTWgwWm5xSnB3QnFmVzZGMm9NQ0FlSVRscnIvbUJzOC9Lbkp5TVFHRVNz?=
 =?utf-8?B?bjRLaW56bTRJY1RTbitneGtPc3NuNHR1Y3YrL2RnNnJqNGd0em96Y3paenNw?=
 =?utf-8?B?cGF3T3FFc0NVUSs5R2pMU1BkVCtXbXZaVUovc1hyUGVFZDRJaDRVdllzZ2pR?=
 =?utf-8?B?Y0U1d0dxb1Vka25mV3hsMng5OUx1Sk1GMTlRTmtoZGgvdDJiYytJWDdib21p?=
 =?utf-8?B?QjFHbURZcm9VdkNWTjkyT1o1NWdnL1RJNm90UWpCVHRYem10VHIwMmdTbHZu?=
 =?utf-8?B?MUlQUjNiU2xKd0luRlc5WklkcThkaUlFZDZjMktvUHNwM2lEbkx5aEdnNm5M?=
 =?utf-8?B?UHhTVUNaajl1ZktmWTlUZVF1YW1DRXFLSTdVN3NGVHZCYmRZdnNsaHZmNE12?=
 =?utf-8?B?elVnRmJEYVY2bjR1bWFuT05qT21VWGVVQ3VLdlBzUTV0Zk8wSGJPNmJtek5t?=
 =?utf-8?B?blpZS0k4dmRSTm45MFhrc2s0bUtGR3NjeGczMWpkYllnSHI2RVBrVTJnVXZW?=
 =?utf-8?B?QVpxMTNtTFkwWWpFNU8ybVhjWUgyRkZ6VVNabmFZbVlMRlowSHhZT01xSEFs?=
 =?utf-8?B?dThqZnVqQWRNcFA5NCtlV0pwdEJ6OFd5L3Via0FFSlFzREpFWHNvaFlCd0pi?=
 =?utf-8?B?UWdlSHRYcGZPWmFkcVBCbm4xekZYVFlqckxsV0hPSGJoVXlzMXB5ZFJUcXFs?=
 =?utf-8?B?dC9oMWg1VWMzdGhqMDlsSS9CTmZFQU5RcGR4UWFpV3BhUE8yWk96ekFFUVdp?=
 =?utf-8?B?dE1NM3BOTzNFRHVsaysyNXlJYXRwODNrTWpMdktSQXlKek5jMFl4N1ltaFp3?=
 =?utf-8?B?T1ZsOUdhaDlJMUlpcnNvRnVqZFZQWStwb2w2ZEtFSHZrQzZGamY5TGNpOFhi?=
 =?utf-8?B?MmxxVzBRVWcrS2RORThwSURhcDJRS2ppSTBRejFuTkRFOWJHcjRsLzZickNW?=
 =?utf-8?B?dm5RNEZDaERySlNXQ1IzOUViRjdQckdKazNyRFpNY0pVMWhKYVVNSG1Cc1Bu?=
 =?utf-8?Q?bGuJ6Cxey3CQqg8Q=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd220612-8f92-4e0a-dc54-08df24635c32
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:08:47.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoQzr1LZ6COOZ+ZHuRDwoOx2vm2D9p0ToDxPViP331FT42xDVZVAmKgZHJJuQUxroms9VDxz4tfhAq3rr12O/p7FS7zZ0uCvusRqM4qUB9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1880

On 2026-10-07 11:41, Nathan Chancellor wrote:
> On Tue, Oct 06, 2026 at 05:00:30PM -0700, Rosen Penev wrote:
>> LLM suggests as an alternative:
>>
>> /* sparc64 has no p4d leaf mappings, so this is never called */
>> static inline struct page *p4d_page(p4d_t p4d)
>> {
>>       return NULL;
>> }
>>
>> Not sure how to proceed.
> 
> That seems like a more reasonable fix to me, as it is still obvious this
> is not supported while hiding the NULL value from clang's frontend that
> emits the warning. It could be worth a comment that it is an inline
> function and not a macro to avoid the warning but I guess that is up to
> the sparc maintainers.
I agree, including comment.


Regarding "ptdump and KASAN" in the commit message, while true, both
these are locked behind KASAN which is not supported by sparc64.

Cheers,
Andreas

