Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2045.outbound.protection.outlook.com [40.107.215.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDC1591EE;
	Wed, 26 Jun 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401454; cv=fail; b=uN3nO3fEkxQspd9NfT+xMjqksdhS61VBHOSw0ScPgEZi8vNbA4tyoMYIDRAbQGqeEARtFRsWf2gKffdt1NEA80xcni3F9niEq7fSRnAKGIV3y5Z8toQf7BP+0FeDRH853llM593cY3ivL/pl0kA5NC8d5F8aYDvyHgnhTEitEkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401454; c=relaxed/simple;
	bh=K5aj5z24fFV+B7Bs/Zoma5PRvDHMp4HqXl6snvShnY8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu4pG6jHsx7iRr5aOW0Cs0BjGMVLj5oZ2bzkQIojkozGSWSUKcpxrxpxhDeAuWxSbl3EaOPdQFclQ2ChLt8pFG73w2eVgUqPPQ41U/FgaQAe7II6eCNig784bi+1Y0aTpcWb9/eBobbt5JKJH/G0+BExZY7zlnnr3W5SIUYnQhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=IuKFCHnZ; arc=fail smtp.client-ip=40.107.215.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="IuKFCHnZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQdXiemieWO0iMf2JrHVuOkNPZNZ1GcDrYOIHn3nrn8GZ1dMc9avXlCA5dKbnfewwJx1dAGF73wgh0uawHwpy+tULWnAgye9bngyNXlqnaf5biTjGeSzlSmT3rFbjt5GhUzRyy2jdGWfiYo1J4nea6tIy0eCoGtrU+3GskVC0+70yjBdvse18NcCjRcnR2PBXalIoVRXBEYiEXUl7OCkPqa6FDGdZeG7Eq5/wKExyDICMNFesYQ0OesthsevNb8XCT1sgfYUgUR6Az5pOr2rEI6lxFfWbJajh27NA4qVnFoGv72cz83BFv95713/nvxhZFEXzGokUAlRa98Oq1udoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41jJPNm0cjyq/D5dkQDMA9IA9Xt9vDwZ8WR1Rj18iPE=;
 b=eA/q63KLlpLSG9CH3+47o/ZQGexhYKPmFfx7dkV+VlBt8FWPnQzqlQwI4tjAV4ek3yllHhadkZr/BfnpjwDDXOivugcp9rCsxiejamfAXhqlDqyjpZ6WHvCOK+dTHMUzGdgSIopx8fPQtt6y3AIRiRUQSOjwGM247xIPAiIeWIVJL0Ldv8GrkNYLku5Y5xZrBOwyT53nEZq+1dxNgs4KFc5hbVxkYeGcT6nTSTijilPLUHOLjlACcEKT5izq/RyIBzBzYLfhmcPbPdoPkQVnIbyqvLTjBeXGaWL6UZwKrfBmGECvtCkEaxksGIfvqmGyjttzPfhDqnv4OeSo+BpD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41jJPNm0cjyq/D5dkQDMA9IA9Xt9vDwZ8WR1Rj18iPE=;
 b=IuKFCHnZu4o+Mb23Fk7CmVL/r3+TGPJJJ32S99evl+D2ZzCyvm+0Zr3PCtsm780J+kjS9I4H8cfCUSKOluCzytxpUz8Ilfj7m1Ycqbp1zAuWDYmO0vhVs6lZvYLrA7AYHGs/giTp4INwXMtIHXO7l0NMOx+m7WQ7heUPk/Jy5Vs=
Received: from PS1PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::24) by KL1PR02MB6612.apcprd02.prod.outlook.com
 (2603:1096:820:106::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 11:30:47 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::47) by PS1PR01CA0012.outlook.office365.com
 (2603:1096:300:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 11:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 11:30:47 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 19:30:45 +0800
Date: Wed, 26 Jun 2024 19:30:39 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>
CC: Uladzislau Rezki <urezki@gmail.com>, Nick Bowler <nbowler@draconx.ca>,
	<linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240626113039.a2rvjarq6zbrgjis@oppo.com>
References: <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636>
 <20240626051206.mx2r4iy3wpexykay@oppo.com>
 <ZnvcToH1h-sVtikh@pc636>
 <20240626100342.2dudj6fjjx6srban@oppo.com>
 <ZnvytLzoLrVwymXv@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnvytLzoLrVwymXv@MiWiFi-R3L-srv>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|KL1PR02MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbfe83f-8117-4abb-f6c6-08dc95d36c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWdJRkErbCt2SENYL0lZWkdDaUdETWlnMHVuQjZaMHF4Q0IvSkJhV21DNDhS?=
 =?utf-8?B?OUlIczV1aUUyRW1rUVdRYytkOXBrT0VweEZOQ1RKZU5Oa2hZRzh3NXIrMGww?=
 =?utf-8?B?VlltSnVOb0F0TkhwdjF5UW5WQWNpVGlnT0lDb0p3U0g3Y0U5UThPb2R0UWlq?=
 =?utf-8?B?cmlQdFhDd2U1elFYZ1AxOHRDZUJBMGlwMldFa1hLdStBNU02NUprcXF4ZzVs?=
 =?utf-8?B?NGZVNlpnTjN5bGZJblMxQXFEdEh0YjBPd0ZBSjEvL2RsSmR1MHA2N0Z2Y3NC?=
 =?utf-8?B?a0dxQXhFTEtrWUJWT1M1MEROOUJ4TGJDNlRjT0VSRDE5S05IUVdDK3lIcW9N?=
 =?utf-8?B?T2x5ZS9nTDB5aFpnNlVZNnF1VUF6YmlGcEo1NzhWZ3p6eWRWU0E2TklvZmFx?=
 =?utf-8?B?aXg2UkJwMmQxTnIwazE5NzltWjJrQzdXOU1OL0FJWHdPTmExQXlSNjVQT3Zv?=
 =?utf-8?B?UFBLanR5V3Q5UHU5aC9odmdhTi9UK2tiUS9aMzNlc1V4QnlWb2RsS0FYbXpz?=
 =?utf-8?B?WWRnSTN2cWNDT0cybnVsSnFXVW0vMURwVzZhWXhaTFU1RzJQK3N6cWF0a2dz?=
 =?utf-8?B?NVpjTUdXaUlJTnkxcjFPRTJtcTJhaHFlZTBndEljOVhrd0dsRWw5azF0TTZH?=
 =?utf-8?B?YVBVRSthZGZwVVpOS0dXaDVPbUdudjliUnJTL1hrWVl1UzlnKzI4LzhZSzhv?=
 =?utf-8?B?a1EzckQxTm9KbnJYUUZLSXRFdWsydmdOcWc1SFB3bUxPeUhVK1NoNWs1dWJv?=
 =?utf-8?B?UXFnNnRGS3lId0x3SGxKM3lGdW1iRUJjWVdsRDFObUVLd3MxVU9xWDIvdjZp?=
 =?utf-8?B?SmJybnBockJOUUJVVVJIL2kzWW9mYWtkVCtzc0xTcnNmZTBsZVR4cGxhVldx?=
 =?utf-8?B?QkhzTlRNQm9qbmI4L3lucEM4bkVuTnZPY3NKWTFLd3l1NU0xbVNHdnRXVEJz?=
 =?utf-8?B?b1VERUwwUmU2K1ArU2pnYmZQY1Fldm02ek1sclYwOHVXaGdmdkV6dTVnb1FU?=
 =?utf-8?B?Zm43b1pmNkxoSlZLNUJ4SjNRUzBDMEZYRWNxUW1lclJwVkxhdEZrYkZJeTRN?=
 =?utf-8?B?aEphMTZ0bVhic2hZRFI5QytSYnI3U3MyRXFIcCtWMmZZNDdlL3RpVXVMZ1Vk?=
 =?utf-8?B?MVRRYmlFaU1EMWdHc0lzTnpvRlNxNnNKTG0zUmluZHR3bUtoVm9jcXU3dDd2?=
 =?utf-8?B?bVRXbCtRQXk3NzZCWHBYd1ZMWGtEMDd3YjhQeFBqYXJJMHl1UmtTNC8wZkNV?=
 =?utf-8?B?TUdNUFhhODBlczUrN01QTHlqa2Y1d1VLSWJqNElpQW9ON29vRzBIWTFXeGlt?=
 =?utf-8?B?R3U4NWdPalZQZHBQK0hIMHFCOGhiQ3g4R0VDbU5sNWFhclRHVDllVXovdWFK?=
 =?utf-8?B?bHdyMXFOVGQ3S1RCdzYvWWZGT0Eybm9LZVZaSUhXN3hHUGRNUHY4b0lhSjJw?=
 =?utf-8?B?bVNZUG4rZjFTd3VJVjl4MGxqVklXcjFnTTJQalhEM2xZeFNPQ1NES2FidkFH?=
 =?utf-8?B?Q2FNVmxybVJKOFdXY0Vka0sxc1Bhc1Z0Zml2RDd6RTdQWE5KcCtRUmluWmJC?=
 =?utf-8?B?RVVXTTI1V0JiZVRHVUNrNThRb3ByQU93UzlyZWJBaWc2MWFxZzVqZkFCbXNp?=
 =?utf-8?B?bGlMSTlGaTl2RkFlUjlsdzhjTkxmMEJXOVlEQ05tMTRyZG9PSHQ1aWtiNzVz?=
 =?utf-8?B?WjlFbU1JS0VyRHF0ZXFIR3d3dlhTNWZ0cmFDQUU4NHhBUEp5NUlmOWl4aUpK?=
 =?utf-8?B?QnNtSjhnNkQ2K3ZsbnNTa3lsNGZMd1dYVW1qSHNwTG1ia1NGMEs5RE5pWjRF?=
 =?utf-8?B?Q3cxaXgwTnJSMlgyeTU2L0pPZFB2eWs5bHhvdFZSUEFuQUM5QjVUaDBpOWVR?=
 =?utf-8?B?UVVhYVlXR3ZvSFJ1d0F4aU1zRnRrdEZyL1A2K0dONURPb21sTFUxditkQndr?=
 =?utf-8?Q?owDFn2VAHBx8DXP+GJdRI6RQzEFmujs4?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(376012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:30:47.0545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbfe83f-8117-4abb-f6c6-08dc95d36c94
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6612

On Wed, 26. Jun 18:51, Baoquan He wrote:
> On 06/26/24 at 06:03pm, Hailong Liu wrote:
> > On Wed, 26. Jun 11:15, Uladzislau Rezki wrote:
> > > On Wed, Jun 26, 2024 at 01:12:06PM +0800, Hailong Liu wrote:
> > > > On Tue, 25. Jun 22:05, Uladzislau Rezki wrote:
> > > > > > > > > > /**
> > > > > > > > > >  * cpumask_next - get the next cpu in a cpumask
> > > > > > > > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > > > > > > > >  * @srcp: the cpumask pointer
> > > > > > > > > >  *
> > > > > > > > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > > > > > > >
> > > > > > > > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > > > > > > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > > > > > > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > > > > > > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > > > > > > > be possible CPU.
> > > > > > > > >
> > > > > > > > > Do I miss some corner cases?
> > > > > > > > >
> > > > > > > > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > > > > > > > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > > > > > > >
> > > > > > > > Hailong Liu has proposed more simpler version:
> > > > > > > >
> > > > > > > > <snip>
> > > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > > index 11fe5ea208aa..e1e63ffb9c57 100644
> > > > > > > > --- a/mm/vmalloc.c
> > > > > > > > +++ b/mm/vmalloc.c
> > > > > > > > @@ -1994,8 +1994,9 @@ static struct xarray *
> > > > > > > >  addr_to_vb_xa(unsigned long addr)
> > > > > > > >  {
> > > > > > > >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > > > > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > > > > > > >
> > > > > > > > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > > > > > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > > > > > > > <snip>
> > > > > > > >
> > > > > > > > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > > > > > > >
> > > > > > > > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > > > > > > > by the nr_cpu_ids.
> > > > > > > >
> > > > > > > > Any thoughts? I think we need to fix it by a minor change so it is
> > > > > > > > easier to back-port on stable kernels.
> > > > > > >
> > > > > > > Yeah, sounds good since the regresson commit is merged in v6.3.
> > > > > > > Please feel free to post this and the hash array patch separately for
> > > > > > > formal reviewing.
> > > > > > >
> > > > > > Agreed! The patch about hash array i will post later.
G> > > > > >
> > > > > > > By the way, when I am replying this mail, I check the cpumask_nth()
> > > > > > > again. I doubt it may take more checking then cpu_possible(), given most
> > > > > > > of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> > > > > > > this moment.
> > > > > > >
> > > > > > > static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> > > > > > > {
> > > > > > >         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> > > > > > > }
> > > > > > >
> > > > > > Yep, i do not think it is a big problem based on your noted fact.
> > > > > >
> > > > > Checked. There is a difference:
> > > > >
> > > > > 1. Default
> > > > >
> > > > > <snip>
> > > > > ...
> > > > > +   15.95%     6.05%  [kernel]        [k] __vmap_pages_range_noflush
> > > > > +   15.91%     1.74%  [kernel]        [k] addr_to_vb_xa <---------------
> > > > > +   15.13%    12.05%  [kernel]        [k] vunmap_p4d_range
> > > > > +   14.17%    13.38%  [kernel]        [k] __find_nth_bit <--------------
> > > > > +   10.62%     0.00%  [kernel]        [k] ret_from_fork_asm
> > > > > +   10.62%     0.00%  [kernel]        [k] ret_from_fork
> > > > > +   10.62%     0.00%  [kernel]        [k] kthread
> > > > > ...
> > > > > <snip>
> > > > >
> > > > > 2. Check if cpu_possible() and then fallback to cpumask_nth() if not
> > > > >
> > > > > <snip>
> > > > > ...
> > > > > +    6.84%     0.29%  [kernel]          [k] alloc_vmap_area
> > > > > +    6.80%     6.70%  [kernel]          [k] native_queued_spin_lock_slowpath
> > > > > +    4.24%     0.09%  [kernel]          [k] free_vmap_block
> > > > > +    2.41%     2.38%  [kernel]          [k] addr_to_vb_xa <-----------
> > > > > +    1.94%     1.91%  [kernel]          [k] xas_start
> > > > > ...
> > > > > <snip>
> > > > >
> > > > > It is _worth_ to check if an index is in possible mask:
> > > > >
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index 45e1506d58c3..af20f78c2cbf 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > > >  static struct xarray *
> > > > >  addr_to_vb_xa(unsigned long addr)
> > > > >  {
> > > > > -       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > +       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > IIUC, use nr_cpu_ids here maybe incorrect.
> > > >
> > > > take b101 as example, nr_cpu_ids is 3. if index is 2 cpumask_nth(2, cpu_possible_mask);
> > > > might return 64.
> > > >
> > > But then a CPU2 becomes possible? Cutting by % nr_cpu_ids generates values < nr_cpu_ids.
> > > So, last CPU is always possible and we never do cpumask_nth() on a last possible CPU.
> > >
> > > What i miss here?
> > >
> > Sorry, I forget to reply to all :), I write a demo to test as follows:
> >
> > static int cpumask_init(void)
> > {
> >        struct cpumask mask;
> >        unsigned int cpu_id;
> >        cpumask_clear(&mask);
> >
> >        cpumask_set_cpu(1, &mask);
> >        cpumask_set_cpu(3, &mask);
> >        cpumask_set_cpu(5, &mask);
> >
> >        cpu_id = find_last_bit(cpumask_bits(&mask), NR_CPUS) + 1;
> >        pr_info("cpu_id:%d\n", cpu_id);
> >
> >        for (; i < nr_cpu_ids; i++) {
> >                pr_info("%d: cpu_%d\n", i, cpumask_nth(i, &mask));
> >        }
> >
> >        return 0;
> > }
> >
> > [    1.337020][    T1] cpu_id:6
> > [    1.337338][    T1] 0: cpu_1
> > [    1.337558][    T1] 1: cpu_3
> > [    1.337751][    T1] 2: cpu_5
> > [    1.337960][    T1] 3: cpu_64
> > [    1.338183][    T1] 4: cpu_64
> > [    1.338387][    T1] 5: cpu_64
> > [    1.338594][    T1] 6: cpu_64
> >
> > In summary, the nr_cpu_ids = last_bit + 1, and cpumask_nth() return the nth cpu_id.
>
> I think just using below change for a quick fix is enough. It doesn't
> have the issue cpumask_nth() has and very simple. For most of systems,
> it only adds an extra cpu_possible(idex) checking.
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 633363997dec..59a8951cc6c0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>  static struct xarray *
>  addr_to_vb_xa(unsigned long addr)
>  {
> -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> +
> +	if (!cpu_possible(idex))
> +		index = cpumask_next(index, cpu_possible_mask);
>
>  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
>  }
>
Agreed! This is a very simple solution.

If cpumask is b1000001, addresses being distributed across different
CPUs could theoretically lead to such a situation, but it has not been
encountered in practice. I’m just pointing out the possibility here.

  CPU_0  CPU_6  CPU_6  CPU_6  CPU_6  CPU_6
    |      |      |      |      |      |
    V      V      V      V      V      V
0     10     20     30     40     50     60
|------|------|------|------|------|------|..

Thanks again for your reply, I learned a lot.

--
help you, help me,
Hailong.
