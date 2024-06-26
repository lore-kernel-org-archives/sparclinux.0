Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376023BF;
	Wed, 26 Jun 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396234; cv=fail; b=ArMBUx7CLgZ9gHcHt4Ol0m1/0O349dUlcedyN8YjRORAxjhQYUlM3pR1BpNoL5IKvRwqybmIVxEVMwTQZKBrWdkMvolMNxsJTSr+/W2C/rk/5goNjunUqN3gpS3jbw6oUgw7t5n6yH8QWG4dkI2jRDDFuSnbMreeZCHLDSy9fn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396234; c=relaxed/simple;
	bh=lqjATdbRgxbwx9DYVgnz2g+fHBzWiSrEZbGJMx260Uo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOsBBWd2sRLL2sE+YySCx76iJmTFuVGYg5BExL92eyuypmNR7stnHPVRZe3Oa/VdfWOy9FCE44AyhXP2+bh1ycF4K/bMak0ynttIAPsquWWj+2H2VQX0YJoVa4dcJliucN68zlssjftaFtf0n94u2Rz/YvwaIbDknMsURr3Ka/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=mFQ0FtQL; arc=fail smtp.client-ip=40.107.255.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="mFQ0FtQL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYspFKHz2MrFlrrQ3jl3ma6R79zeegXD3bAAyyYi2zX5HmxdNvmGT9QD1gJbBFM3mZffPk5yJhRRfjvsYu6G0wP04Z6oLP70AHiuN/QPhkWkcY84IyqZMCj7AbvRLKx8lhfb6F0p2Pn8Rv4SSlIsms5dji9bxlay7wJSpBskX5K70DWatRy7j3ZuwcPrFnoC5SdoUWlbb9SLoV/P0ay7phaYmmVSXbQSLqSR3ZtIO8URB3fJrpN3YT9rpBeNWFUtnwq/f/Zc+QJGLX/5/UrV8FojvIDd06z00FNqMldrrMmoJunlnNcYqPKh8N7kUrziTEFQ0wpAJ5k4Kc6Vc7t8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZvnVaEwxpTQyauTTLqZou+VXTcWoWvqSQsp/cTpTdo=;
 b=ZShHD3p1f6KP6ZEn/til5YwRUKFMKLcspSbNKfH6IFBJsS/QorRVigDcEGAQc5LqQZ2s20/cKPQrMgQj2fEt25MgIXUZvFwGaZfzVPl3pen2qRBSvGb2IPnjg8I9aAMYFRlUHnIx0JiVl3yLmvrXTKg7akbSrK5xGlbNfngndMDa++0bOAAs1CFZIP2bkhrutGiwd4fqV8Ls0hB2MCFJ+zFwYREwIriYpemsooYT0Mftt4PvnNTGgEsSjA5BPPNbrU53FGSYCDRc9Db6PebDM0qs+G+5aoXPj3z973BJeQwRp4ZX2kxaFnw6G87iwGQ4WC0N9B8/QANAxGoNNe4voA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZvnVaEwxpTQyauTTLqZou+VXTcWoWvqSQsp/cTpTdo=;
 b=mFQ0FtQLWmd40ZOLXtw8822xsrXj0ogOpn0niRqTUAeEgCRHMbWJEblv8hrYHvRzbery/VMwhShRdCGp3PmZQ1nUvmvQxDZefl6q7ZElDW6SOxITQt8roHmHCF9NUUB3ZMMaBGPK+A7/uphxL1YyJyPOhPon5+KtwLVSKEei3aQ=
Received: from SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29) by
 SEZPR02MB5934.apcprd02.prod.outlook.com (2603:1096:101:76::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Wed, 26 Jun 2024 10:03:49 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:b6:cafe::e) by SGAP274CA0017.outlook.office365.com
 (2603:1096:4:b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:03:48 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 18:03:47 +0800
Date: Wed, 26 Jun 2024 18:03:42 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Baoquan He <bhe@redhat.com>, Nick Bowler <nbowler@draconx.ca>,
	<linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240626100342.2dudj6fjjx6srban@oppo.com>
References: <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636>
 <20240626051206.mx2r4iy3wpexykay@oppo.com>
 <ZnvcToH1h-sVtikh@pc636>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnvcToH1h-sVtikh@pc636>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|SEZPR02MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 968c00a8-2aa7-4870-526e-08dc95c745d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H6JcD6L7iZFZEU+6qk2QUV5A2BpiKIL1fuVcu9pBc3Vmx/8uz3JXuL5zODG6?=
 =?us-ascii?Q?GtDhT0FLUwRb2PRpUopRFBoVOuwztmpD3bFQP2eA3D7sVB3XjgpG/pRQTvho?=
 =?us-ascii?Q?KjYmjOWBSh/lRntgzpOyeZe6FFa/2kRCZciUquLo6x1muwXXjE51OGlr2GyM?=
 =?us-ascii?Q?OvETPhCWQ3jqY+Kd4XDANQC2bfZCcA7zcLhyb+62qnKs3woK2Pny3p2H5sAR?=
 =?us-ascii?Q?yz7HqoI/W4OtwJZz4TuLr2qGqL15GjMsi0hIc7XEcHFATxEznJ89idKcC6+q?=
 =?us-ascii?Q?K0qzM+iZG0dE/WUpOuIB1SMjqWFCgX03helG5aQdskT0ZhajMBeOmp6Y0AHh?=
 =?us-ascii?Q?ua4yt4NICs63y6vuaC6Z3JgePf8qkwftLJ+B39lHAxIajSelpAhyKwGdFv/8?=
 =?us-ascii?Q?Tba16y1XeouHD1yY0/RQ+lM/HaBzOJbCokPVhWZ2H8ne5OHNgMA8tM039xkI?=
 =?us-ascii?Q?g0sr6S4JTXUxKW5HJAgglDZXuRb0Q2zsSTNrtF5rDxOvyEyfPBcL2DLr+i0s?=
 =?us-ascii?Q?YE/k8z2m8TACS1eah8tSCu240CshA6/yMzk9yb4c4NdMGGQtjp9mtS2I6UJy?=
 =?us-ascii?Q?LcO1ZKaL5zHM6dgfdcxmdhWy+LptwAld3EVn4w2DjC3rSwd5Ho1/9Djby9gO?=
 =?us-ascii?Q?YLl5WZbxF6SsjkZkezouG/Z2ViT9IYvTs3v8yccfapTcMVJBjN9ryI2TSSsp?=
 =?us-ascii?Q?och4hRGbLh/+33+Q2I7gJwiiplBzhJ5jWln0TEkWcwpU+3byhRu5RO1GcfVY?=
 =?us-ascii?Q?3aANoGq3WKY2S7GMac+tKzgnaglE6mULv8ptYAuwisaBoNTokowKwcnh5oXC?=
 =?us-ascii?Q?LXFWKAsnn0oAdavgXm4aKw8u+k+MsNm6VmWhyWr44Q4lfONkkgzQL3fZrjA+?=
 =?us-ascii?Q?2oa8W28nMX6B1C3czkYxJTEwoyIwpAsUecrmA/zjXHja/AWQiLlTxfwFLl4l?=
 =?us-ascii?Q?nivrTALMbR4MdhjcJudVGYCpJwsB8flAFKge0si6l6ZCHojCcziKgqoQbhNT?=
 =?us-ascii?Q?hGmZT6UM9CTVS/A/alLrEgztVUO4C5xh3UeFVROhagrlYSWU9IBtBJ5jKJR/?=
 =?us-ascii?Q?6Vmq5jdgWQl4eSD+mvxWv+3tEd33Fj+YLKOkAcoGSSFP5vupwnGj6c6xXOsv?=
 =?us-ascii?Q?W8u7QSI/eJTTB8O3rbnSsdAuev9dmWBdddHBk4utEVO3bwHFNK8MOCTE9YU9?=
 =?us-ascii?Q?exxKzla1jy7ze1PAqFZJnZnxvS/7b8TrQhR21TrTq2BZ+xKOjzT8Uk5/Uwil?=
 =?us-ascii?Q?Mri05OhcfBqQJOgzW/MvL2vak0LFBSlu1WGX5K8qPCaETBj9w2IWjmA0Czk/?=
 =?us-ascii?Q?G6/6IFsVoleUK6JOierKpd3qZuq7F7nh2i2ZGzTLojC8m0ZZdyAoV58OoVng?=
 =?us-ascii?Q?PKXpvB7PvmHRzPw4j3ES/uuJTGi76xjCdRZHfxbFq4mLfym6iQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(376012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:03:48.1665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968c00a8-2aa7-4870-526e-08dc95c745d8
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5934

On Wed, 26. Jun 11:15, Uladzislau Rezki wrote:
> On Wed, Jun 26, 2024 at 01:12:06PM +0800, Hailong Liu wrote:
> > On Tue, 25. Jun 22:05, Uladzislau Rezki wrote:
> > > > > > > > /**
> > > > > > > >  * cpumask_next - get the next cpu in a cpumask
> > > > > > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > > > > > >  * @srcp: the cpumask pointer
> > > > > > > >  *
> > > > > > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > > > > >
> > > > > > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > > > > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > > > > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > > > > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > > > > > be possible CPU.
> > > > > > >
> > > > > > > Do I miss some corner cases?
> > > > > > >
> > > > > > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > > > > > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > > > > >
> > > > > > Hailong Liu has proposed more simpler version:
> > > > > >
> > > > > > <snip>
> > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > index 11fe5ea208aa..e1e63ffb9c57 100644
> > > > > > --- a/mm/vmalloc.c
> > > > > > +++ b/mm/vmalloc.c
> > > > > > @@ -1994,8 +1994,9 @@ static struct xarray *
> > > > > >  addr_to_vb_xa(unsigned long addr)
> > > > > >  {
> > > > > >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > > > > >
> > > > > > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > > > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > > > > > <snip>
> > > > > >
> > > > > > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > > > > >
> > > > > > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > > > > > by the nr_cpu_ids.
> > > > > >
> > > > > > Any thoughts? I think we need to fix it by a minor change so it is
> > > > > > easier to back-port on stable kernels.
> > > > >
> > > > > Yeah, sounds good since the regresson commit is merged in v6.3.
> > > > > Please feel free to post this and the hash array patch separately for
> > > > > formal reviewing.
> > > > >
> > > > Agreed! The patch about hash array i will post later.
> > > >
> > > > > By the way, when I am replying this mail, I check the cpumask_nth()
> > > > > again. I doubt it may take more checking then cpu_possible(), given most
> > > > > of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> > > > > this moment.
> > > > >
> > > > > static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> > > > > {
> > > > >         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> > > > > }
> > > > >
> > > > Yep, i do not think it is a big problem based on your noted fact.
> > > >
> > > Checked. There is a difference:
> > >
> > > 1. Default
> > >
> > > <snip>
> > > ...
> > > +   15.95%     6.05%  [kernel]        [k] __vmap_pages_range_noflush
> > > +   15.91%     1.74%  [kernel]        [k] addr_to_vb_xa <---------------
> > > +   15.13%    12.05%  [kernel]        [k] vunmap_p4d_range
> > > +   14.17%    13.38%  [kernel]        [k] __find_nth_bit <--------------
> > > +   10.62%     0.00%  [kernel]        [k] ret_from_fork_asm
> > > +   10.62%     0.00%  [kernel]        [k] ret_from_fork
> > > +   10.62%     0.00%  [kernel]        [k] kthread
> > > ...
> > > <snip>
> > >
> > > 2. Check if cpu_possible() and then fallback to cpumask_nth() if not
> > >
> > > <snip>
> > > ...
> > > +    6.84%     0.29%  [kernel]          [k] alloc_vmap_area
> > > +    6.80%     6.70%  [kernel]          [k] native_queued_spin_lock_slowpath
> > > +    4.24%     0.09%  [kernel]          [k] free_vmap_block
> > > +    2.41%     2.38%  [kernel]          [k] addr_to_vb_xa <-----------
> > > +    1.94%     1.91%  [kernel]          [k] xas_start
> > > ...
> > > <snip>
> > >
> > > It is _worth_ to check if an index is in possible mask:
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 45e1506d58c3..af20f78c2cbf 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > >  static struct xarray *
> > >  addr_to_vb_xa(unsigned long addr)
> > >  {
> > > -       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > +       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > IIUC, use nr_cpu_ids here maybe incorrect.
> >
> > take b101 as example, nr_cpu_ids is 3. if index is 2 cpumask_nth(2, cpu_possible_mask);
> > might return 64.
> >
> But then a CPU2 becomes possible? Cutting by % nr_cpu_ids generates values < nr_cpu_ids.
> So, last CPU is always possible and we never do cpumask_nth() on a last possible CPU.
>
> What i miss here?
>
Sorry, I forget to reply to all :), I write a demo to test as follows:

static int cpumask_init(void)
{
       struct cpumask mask;
       unsigned int cpu_id;
       cpumask_clear(&mask);

       cpumask_set_cpu(1, &mask);
       cpumask_set_cpu(3, &mask);
       cpumask_set_cpu(5, &mask);

       cpu_id = find_last_bit(cpumask_bits(&mask), NR_CPUS) + 1;
       pr_info("cpu_id:%d\n", cpu_id);

       for (; i < nr_cpu_ids; i++) {
               pr_info("%d: cpu_%d\n", i, cpumask_nth(i, &mask));
       }

       return 0;
}

[    1.337020][    T1] cpu_id:6
[    1.337338][    T1] 0: cpu_1
[    1.337558][    T1] 1: cpu_3
[    1.337751][    T1] 2: cpu_5
[    1.337960][    T1] 3: cpu_64
[    1.338183][    T1] 4: cpu_64
[    1.338387][    T1] 5: cpu_64
[    1.338594][    T1] 6: cpu_64

In summary, the nr_cpu_ids = last_bit + 1, and cpumask_nth() return the nth cpu_id.

--
help you, help me,
Hailong.

> --
> Uladzislau Rezki

--
help you, help me,
Hailong.
