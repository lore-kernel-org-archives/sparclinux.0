Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2085.outbound.protection.outlook.com [40.107.117.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676A13C810;
	Wed, 26 Jun 2024 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378739; cv=fail; b=MpZSNa5+KYRMkdWCTRY8FqFaZIhTtcaPwUp0OXMeRwD1R7YTAtZS/NV+OmU10IXsq/M0UzKzno8HwZLttOHaoDPICpMx734hJnuUm2gnDIPU7TKMEJSxlj/0bPqm8L9/m+FiZvtcH66+Vu5op5PAmskEpuAIH/UMkMPIjPRZsVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378739; c=relaxed/simple;
	bh=Mdd8vyZUoPCm43Puzvp+BzTmRSo+Ts8LP5jUqdYff2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+HSQeATehoVwZ6HTd7SN627Sjolz9gkD7QGTmtyT/bAOh5W2ePNugDuh9FNZUY1fWRBFf6OiFryUsderLcJY6v/ZZ9KVGdSXkPDYfBogivkIbDcZokyt5k55tRzXp05jd8+nRSToEk9VHxL+2kWye+Pir9MTkn2FTz2aARf/gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=YOezDb7u; arc=fail smtp.client-ip=40.107.117.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="YOezDb7u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyNwwElvf2e7pfncKgMEwoKCJ1d/mQcepsl52pyySQCZXVWbM96CcRnpipAfn3O3k7kKF1sGql4gmLtTVN/03bq7OT4DUOB/XVKRZsY0+H9cydqUuTkY2eVSSr1+rZZXvftomq9ZzzUNNU/bC5tGjMmLPEtjbpF3lmN1CV5AiYndG+u+coQcsJW8kfzbHM5qfMHaOXVRN2z3BIMmli/gR4OBIgvdpmHb42IGQM9W90xuO+0sK1BkMcb3F0xixS7k2UUXOh+HBvZPyuhklKRR/LOC9qUUhCA7x1avJ9lEGqSS3cXHq5ZGUxFBWkuv/7tylT92V7PQqpygNHHATCo3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1lhyCs390xmQSsgJIh0jCXS6Syd1z3RP8K4gAmHxSg=;
 b=RW2kuH7YwcBVszfaLab1IyGNkFeN5Rn+7IutyoOujwMdXybuuARqYwsNwYb/wp+DGk5VdbzgqVG+TyhxMyfDh6zPw1hG0Xyo8c2mf0uyhv5BVQFPknpw8vEaO5iisj6X1GwuSTViMsD/WZQQBAQZCju91Wxdvwt8RUlHaKHlQWiIynW0KRZ/5PdyCSfxW6FGvF6xZozuiBYS/KV1vfVUOI0lzpEk1QEuZA7LLil82lrIsN/pGVW1ksf7wBZjMhawmOELl4zQK4uYQLdVVxlgbsrBRyQzThWYy+8tlGKutWppliRusjygmTFOzbfjUNzMtg2eD0reCkCfV/v0t1RbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1lhyCs390xmQSsgJIh0jCXS6Syd1z3RP8K4gAmHxSg=;
 b=YOezDb7usqSKz+HDZyWlfmLX7Iei3m0BDKFMN+31yziSnhkbIOR+2U8/0fm+QbGejWvzBjmnhTrbVN/dV8TgWrVPEvsexMeEzSYdlBuCSxOkv2oAGSj3cAje4wajxmB0U6s3/mzjlKoVLO7nVJMCrzbivEFLLT1De5Th7eWQZ5k=
Received: from SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17) by
 SI2PR02MB5803.apcprd02.prod.outlook.com (2603:1096:4:1b2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Wed, 26 Jun 2024 05:12:13 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:b8:cafe::d0) by SGXP274CA0005.outlook.office365.com
 (2603:1096:4:b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 05:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 05:12:12 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 13:12:11 +0800
Date: Wed, 26 Jun 2024 13:12:06 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Baoquan He <bhe@redhat.com>, Nick Bowler <nbowler@draconx.ca>,
	<linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240626051206.mx2r4iy3wpexykay@oppo.com>
References: <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
 <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnsjIB2byIxSgbjc@pc636>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SI2PR02MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: d11873f4-9758-4d1d-f012-08dc959e8983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEN6Yk42ZElwSDNLMVdXdUpqS1ZDd0ZDdU5Ualh4UlJzM0kzaG5Ob3liY0Iw?=
 =?utf-8?B?WWZ6TDlKUDNQamZpcENJRmtZM3huRXIyRGRLb0lreEtxYzE2ZnRpb2t5WDd6?=
 =?utf-8?B?aHduc29uVWtPN1Y2SERlejlBQUxJbXM1NklBZ1p3dlZlblhRV2RWdVBXaCtD?=
 =?utf-8?B?OGUvN3FhMjE1aGZEVmQrOWRxeUtXaWhtc0JvQmJ1N1VYdW5OVDAvZjhTUEVv?=
 =?utf-8?B?WFJCOW45M0k4TWFQMm5EUWNEdDRTTklOWXhrUk01VHdveVRod0xuMDVYT1BP?=
 =?utf-8?B?YlpaU01mSmJVbmY0RU1PRnM1bW9CWmFBdEQvZGxYZm9WRVJBQyt6YVlZbGFB?=
 =?utf-8?B?YlBYa2JrUHJpc2VVZGwzYkljTVhqcFN5QmJtck90UVpTbFA3Q3RxMnJnemg5?=
 =?utf-8?B?YWN0NzFtVUJZbUZpblpKOGc2c1U5U1cwdEh2dFZBTUxyQ1JVKzMrS05GRE8w?=
 =?utf-8?B?ek5yeHljMjdqa0t4bWttMHpRUVY4R1ZCYkFYeW9qVDdPdU50UHBYd1hORTBa?=
 =?utf-8?B?bU16N1luNC9pdzB1Y3dlbC9TVTdXTExmTE1RRVh4RnhYTWsrRE0wQmFZVGR4?=
 =?utf-8?B?Q3ZNZWVHb1ZkTURGN2E2dlJzYzA1S1RnS2w2WVZpT1pPMjQ1NTdRMjI1TnA2?=
 =?utf-8?B?em1zRHZYNElveXd2TmZ3ZnlYNWV1QzZ5ckx2QnFRNnNXc1JPNWVOY3FEWmp3?=
 =?utf-8?B?N0lsT2FaWE9Id2ZCMGMyVW9hZGpoQnp3V2hCYndTS1g3QmNOTUdBN0VvUE1w?=
 =?utf-8?B?Q0RXNGJZSEdUWnNjS1NsM003MGlZbXREVHZTQlpQWEM0M3pQWkZ4NkNvK2dT?=
 =?utf-8?B?QndaSmU4Wm9WME9mbGZrYy83Y2hOS0daVWxHVlZJQk9jT21XNlYyWHl2T0hJ?=
 =?utf-8?B?ZnJtdnI3VTFzRU90TGVJVW5tY0NOQ0dIc3pJNTdzNnQ0WHo5dm5WWmtTTW5E?=
 =?utf-8?B?dS8ydlluUkR1bE1RM1lHbVJWbzlOeXhLa1Z5ZGZJWXZxaWdpajhTeWlwc1lm?=
 =?utf-8?B?T1oyMll0UVNDdTVEUVpEMWVxMzNVS3JrbEtFdlJSdW1uQUsxUW44dXB1dDB1?=
 =?utf-8?B?NmtUTXVzdU1JdGw0S1lWUzZrbG9pSHEwdnRPbVRVNU5IWUlwOWlwUTlEQ3Ev?=
 =?utf-8?B?aWJRc2tLNzUxRUxOWWR4OWpSRHpvam5nMUVHNXZ2TDRKVHVJUDY3NlRBMlRk?=
 =?utf-8?B?ZldFamE3UkdOQThNck1XVkNXMXB1R1NHQzQ5bG96MlFibHE5aFQ5TXN2RDFB?=
 =?utf-8?B?OVhJaUhVWWZxR2ExK1lVa3RoMlY1MnMxeGx6WVZ5Qk5OOHhLTGRFNkVPVGJq?=
 =?utf-8?B?NGI0SFkvMUlXcU02WnZvRGs3UndpUkRkVzJDaDhkSWUxTDF6bllqa05JVDMw?=
 =?utf-8?B?dDI1K25KY0Rla3lUYUhBb3IyR096TzJwUlVIOWp6MWE1Z0JqOHhuQ0lzem9k?=
 =?utf-8?B?eHZKWmpYcGRVYjErVEhrcHhhem9uNUxXNVNDMHRjcUpzVGZoc29jVk1yWENL?=
 =?utf-8?B?dkgxaG5ld2VuQjlMT250dHRJTlZaam83Mk1taUxMak94ZVlUVU1JUjhOTWNr?=
 =?utf-8?B?cU9hMnRNV3VsZ2hZUTVyM2ovdDk5VUxJejI4Rk9uQitJV1JCS0tHSEZtWkJH?=
 =?utf-8?B?SkN3T0xUWFVBbnJGa05LSndpbGJLczBZN281cEJqQ0hqTlQvM2pzazVPNEUv?=
 =?utf-8?B?SE5IRWNWMlNzaHlOb3Zmd00vNFVFMXRyNXVOVDd4NmcwRncrMXhhQWVkZmZj?=
 =?utf-8?B?Mzc2UThHaFNxTWRiM2dvSnc5VFYvN0dxQUZHdTJrTjJmTy84ZjNXMk1FMHR6?=
 =?utf-8?B?Z1pobTIxSnJ3ZE1mbGNyYkVJY2R6eTRkdWJaK2prTmRVSTJPYi96bVdEdjI2?=
 =?utf-8?B?UVZ5YjFRSjFPVjk1TzhOSUF2TXpLY01GQlZKelpDeXR6SUR4eWVRckJVcW9T?=
 =?utf-8?Q?x9lxP6g3I4TUTx0NTnsXqGR8qm0vpBJV?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 05:12:12.3170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11873f4-9758-4d1d-f012-08dc959e8983
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5803

On Tue, 25. Jun 22:05, Uladzislau Rezki wrote:
> > > > > > /**
> > > > > >  * cpumask_next - get the next cpu in a cpumask
> > > > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > > > >  * @srcp: the cpumask pointer
> > > > > >  *
> > > > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > > >
> > > > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > > > be possible CPU.
> > > > >
> > > > > Do I miss some corner cases?
> > > > >
> > > > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > > > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > > >
> > > > Hailong Liu has proposed more simpler version:
> > > >
> > > > <snip>
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 11fe5ea208aa..e1e63ffb9c57 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -1994,8 +1994,9 @@ static struct xarray *
> > > >  addr_to_vb_xa(unsigned long addr)
> > > >  {
> > > >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > > >
> > > > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > > > <snip>
> > > >
> > > > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > > >
> > > > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > > > by the nr_cpu_ids.
> > > >
> > > > Any thoughts? I think we need to fix it by a minor change so it is
> > > > easier to back-port on stable kernels.
> > >
> > > Yeah, sounds good since the regresson commit is merged in v6.3.
> > > Please feel free to post this and the hash array patch separately for
> > > formal reviewing.
> > >
> > Agreed! The patch about hash array i will post later.
> >
> > > By the way, when I am replying this mail, I check the cpumask_nth()
> > > again. I doubt it may take more checking then cpu_possible(), given most
> > > of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> > > this moment.
> > >
> > > static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> > > {
> > >         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> > > }
> > >
> > Yep, i do not think it is a big problem based on your noted fact.
> >
> Checked. There is a difference:
>
> 1. Default
>
> <snip>
> ...
> +   15.95%     6.05%  [kernel]        [k] __vmap_pages_range_noflush
> +   15.91%     1.74%  [kernel]        [k] addr_to_vb_xa <---------------
> +   15.13%    12.05%  [kernel]        [k] vunmap_p4d_range
> +   14.17%    13.38%  [kernel]        [k] __find_nth_bit <--------------
> +   10.62%     0.00%  [kernel]        [k] ret_from_fork_asm
> +   10.62%     0.00%  [kernel]        [k] ret_from_fork
> +   10.62%     0.00%  [kernel]        [k] kthread
> ...
> <snip>
>
> 2. Check if cpu_possible() and then fallback to cpumask_nth() if not
>
> <snip>
> ...
> +    6.84%     0.29%  [kernel]          [k] alloc_vmap_area
> +    6.80%     6.70%  [kernel]          [k] native_queued_spin_lock_slowpath
> +    4.24%     0.09%  [kernel]          [k] free_vmap_block
> +    2.41%     2.38%  [kernel]          [k] addr_to_vb_xa <-----------
> +    1.94%     1.91%  [kernel]          [k] xas_start
> ...
> <snip>
>
> It is _worth_ to check if an index is in possible mask:
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 45e1506d58c3..af20f78c2cbf 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>  static struct xarray *
>  addr_to_vb_xa(unsigned long addr)
>  {
> -       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
IIUC, use nr_cpu_ids here maybe incorrect.

take b101 as example, nr_cpu_ids is 3. if index is 2 cpumask_nth(2, cpu_possible_mask);
might return 64.
/**
 * cpumask_nth_and - get the first cpu in 2 cpumasks
 * @srcp1: the cpumask pointer
 * @srcp2: the cpumask pointer
 * @cpu: the N'th cpu to find, starting from 0 <--- N'th cpu
 *
 * Returns >= nr_cpu_ids if such cpu doesn't exist. <-----
 */
static inline
unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
							const struct cpumask *srcp2)
{
	return find_nth_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
				nr_cpumask_bits, cpumask_check(cpu));
}

I use num_possible_cpus() and cpumask_nth() here to distribute the addresses
evenly across different CPUs.

if we use cpumask_next(index) or use cpumask_nth(index, cpu_possible_mask)
becomes as follows:
  CPU_0  CPU_2  CPU_2
    |      |      |
    V      V      V
0     10     20     30     40     50     60
|------|------|------|------|------|------|..

> +
> +       if (!cpu_possible(index))
> +               index = cpumask_nth(index, cpu_possible_mask);
>
>         return &per_cpu(vmap_block_queue, index).vmap_blocks;
>  }
>
> cpumask_nth() is not cheap. My measurements are based on a synthetic
> tight test and it detects a difference. In a real workloads it should
> not be visible. Having gaps is not a common case plus a "slow path"
> will be mitigated by the hit against possible mask.

If cpumask_nth() is not cheap or have performance regression. Perhaps we
can use the solution suggested by Haoquan. I’ve drafted as follows:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 11fe5ea208aa..355dbfdf51f1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -92,6 +92,7 @@ struct vfree_deferred {
        struct work_struct wq;
 };
 static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
+static unsigned int *table_non_seq_cpu;

 /*** Page table manipulation functions ***/
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
@@ -1995,6 +1996,10 @@ addr_to_vb_xa(unsigned long addr)
 {
        int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();

+       /* recalculate the cpuid if cpumask is not full. */
+       if (table_non_seq_cpu)
+               index = table_non_seq_cpu[index];
+
        return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }

@@ -4473,17 +4478,25 @@ void __init vmalloc_init(void)
 {
        struct vmap_area *va;
        struct vm_struct *tmp;
-       int i;
+       int i, inx = 0;

        /*
         * Create the cache for vmap_area objects.
         */
        vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);

+       if (!cpumask_full(cpu_possible_mask)) {
+               table_non_seq_cpu = kzalloc(num_possible_cpus() * sizeof(unsigned int),
+                                           GFP_NOWAIT);
+               BUG_ON(!table_non_seq_cpu);
+       }
+
        for_each_possible_cpu(i) {
                struct vmap_block_queue *vbq;
                struct vfree_deferred *p;

+               if (table_non_seq_cpu)
+                       table_non_seq_cpu[inx++] = i;
                vbq = &per_cpu(vmap_block_queue, i);
                spin_lock_init(&vbq->lock);
                INIT_LIST_HEAD(&vbq->free);
>
> --
> Uladzislau Rezki

--
help you, help me,
Hailong.
