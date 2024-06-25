Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2089.outbound.protection.outlook.com [40.107.215.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5217BCC;
	Tue, 25 Jun 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314408; cv=fail; b=s4VXQWNc7ZMPhAfKNtsAZ1RdV1LuspLEJoeI6mnqKnVd13D7L42VapZaOwv3Jt1cN83vxm8P6x+rT0JtejGoB2cga9vHi6fbNN5F3HtYm4lnPDgYzDe7XD9JMSbkn2hUsnnkh5YC+17T9aMo+iitS6cSF2vlNsBw3c2HjnczHpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314408; c=relaxed/simple;
	bh=wcG4G9GkeTSaidNrBoIRCwc6EcxbjitnqcuerNtCv/U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZvbbXgBKKS9O+ikXZfGHjx691rJrUJaeiHAm2MKTeF7Cvh8BXP9qlrgTFwoxNL0Fs3Ooo2I2/gSaw6PnnBUYbMDv+aTQacnbQP+lA/iggeEzTw4MAuvrIWs6QLy1AM/ItM8vIXAzLIbIrahos4pyKpFcofPJJGnudt9BTvctEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Y1hu+Ik7; arc=fail smtp.client-ip=40.107.215.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Y1hu+Ik7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2Kzm4ItFKj6p8pHhz78DG0ozmzWFEpYqL/dkbQOp2goWr+z4SklXOXGBKterbJOd1JHBqFTNo78xzq5L3cBdvluxVBuKPlXCWNPoAtJGmDqLPcflJS9SfO6KZ/ILJCmnD2tB61o7IXEtvlL9Dpd7vVkZBVuleFNrobN4KDP5PLDqM5BtCf7pX0I8YDIja5Md2BmwSn+A879gGaJhlhMGjQSMP1ir/QZ6aP/LJmYfHybDe+U39OBUSMP2g0A/xhOMs10wJBOvekgusGTerE7EvpsgX/NIbeVVGb8RgV/xBMrreWV+iE+CHaX4odgpjgZSMPu1uf5koTNCc1jw7Hw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZJIX06pp3yB4FbFPKqcCmRxoWu5HS/PJHew8jMD4lM=;
 b=lel+kc4m60h543iLA+b+1+6IKegVXI+ge8PaGpcjUFto/6YsMLujH6aOQFHCUkZk0zrFsKKm4w3UkBj7DvXDkrKhsD7Nll5Ai6cGvk1XQ67LbhvfyIC0K5i9HAo9zx1kIGub5dn/4GOLSoHY5UlRHZCnIZApEAIeAibgh+WdzU9gGK57uXM7zxjtAuHRMBhYuzPjcZehElvqyHmqLaIT9RC1cwPWIq3ZwmnpIz6kDUjqD5RSdpUAhxlwrAFer8iixn2vx0oyOlAfvpgxjt29P9BhNKF0eIbP1cHbHmhFrx2FE4FFAYn6fhxGnrSQhO4cNB0a31If/g5OclqOZYaNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZJIX06pp3yB4FbFPKqcCmRxoWu5HS/PJHew8jMD4lM=;
 b=Y1hu+Ik7iPeZmYz2juG8Nf30J2EpP8wREWV7+eeU36KiKxQQY44ncZyhkUFBo9/5h8qojfKZhyoKXuH8V4Pq+z4DJXKzsWZqb0kZH8ADj69MVR7kzRnpcMeuGCZHdXkYaSeeHIZ+KsClKJD1xnkj3oqdLHNENZv2r98xPwfyT4Q=
Received: from SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) by SEZPR02MB5885.apcprd02.prod.outlook.com
 (2603:1096:101:70::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Tue, 25 Jun
 2024 11:19:59 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:193:cafe::41) by SI2PR01CA0050.outlook.office365.com
 (2603:1096:4:193::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 11:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 11:19:59 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 19:19:53 +0800
Date: Tue, 25 Jun 2024 19:19:52 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>
CC: Nick Bowler <nbowler@draconx.ca>, <linux-kernel@vger.kernel.org>, Linux
 regressions mailing list <regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240625111952.sbeuw2kbx3b465rb@oppo.com>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
 <ZnWICsPgYuBlrWlt@MiWiFi-R3L-srv>
 <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|SEZPR02MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: e29e50a7-3ce9-4d25-e89f-08dc9508c005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Tv6U9t64cUDu6lOVeyYVSmHavkfksJ8yQrZ+cirpZI9hcvasucgm14lzH6E?=
 =?us-ascii?Q?WVqqNeYURD3MX+OBszdu+RX/WuO3fr3wFDcu8gjUglLxEWQnJEwXbvXZnebW?=
 =?us-ascii?Q?ZSt+G+g17rwtg9yToZutZJ2hi7YxRMEnCkOMYiDPUQyXFZY9S7zGx53RBosQ?=
 =?us-ascii?Q?NBrrFbgIESkh+XTepScILVevNMO7psNm3g45fdj6l5sqvIFILmPfPLyvtiOM?=
 =?us-ascii?Q?YuW9esp/C0WnZGL6Fugv4hXfOh+ufHzIJ072PbzN7/JRsqYm3MVchd9dgZcB?=
 =?us-ascii?Q?GyBI65KNKItwkbEj8C7SzuSAFUNVYsTgFi+aRSk2B1oCmenD9DgSqWlD2q87?=
 =?us-ascii?Q?i6L1gnJVtjL3twv7/aLbfhk7BZ4YsvATM4b5+X+jzuDXynb3+LDZW6W4t0Gi?=
 =?us-ascii?Q?1v02kibMuiB6H38Ar4f6L8aNOvdXcyUk9N3zlVu914+YOp+518DoJglHapIT?=
 =?us-ascii?Q?Zz8cnF/sh5/4rzq3G8ADuoSzwFlsed8g5oDWU6ZoH0sxwBilGRj3QZF+9HAb?=
 =?us-ascii?Q?1fuMXNyy0lk8CupjRbEvR0qWIWNCAn9WnEFqoBLsJJgNEOYsS9OJYKnwRMFK?=
 =?us-ascii?Q?Mxfk/eCkzJ4Irq6RY/uNv8obBwLZPuG91ID2+bp+IgnbhQkcPTxzeNwonSG4?=
 =?us-ascii?Q?rlZLnFdTBhY/dPG14NOrFtbU2/U9z8d2DxgIT8pYJCig+2Jb+ZLxXj7tU5mF?=
 =?us-ascii?Q?z4bB+9IcfdemaHFC4f/rv7SDZ8uXIRpHXJPBcdReTsoL7ZpTHCLWhEpgKFuK?=
 =?us-ascii?Q?cG6aNjcL0eULrvk2TP3YZNlEp6rU/96Vsa0kiHv9vuk2NGj+5iEKERV4GdOM?=
 =?us-ascii?Q?2scCEqVEOWhrbyrJ5K1MKhNTrS1P+aaKkjgH+jaG+O6W4znyfryKI55mYNZp?=
 =?us-ascii?Q?kvqhmJ5EXXkC7Fxk4w4a76SplqfxPSdYfipHcnkQXe0TbtgwNj+VvON623pD?=
 =?us-ascii?Q?yREWpPqxxcsQQ/xrVR9sodJJzakuL8YG8ltcLDUVExgjhiRNl1Dd9MnevAk/?=
 =?us-ascii?Q?Gk9qPPn/xtOaNM/eLLF2O8dY7XpZQoNhmL3Ma3I0iGGVeZ6Syy/EylgFRmfV?=
 =?us-ascii?Q?tRzUEYGGxMnT30pVKYclk/oYij7910xFlQvcq0mVzozJG3tz1BBoisEp/CJj?=
 =?us-ascii?Q?rjsups65JdaZxzFcfBhrKWx394qJyA51OxAX423y+eNs41YX4QhX+lkcyjMZ?=
 =?us-ascii?Q?wkFASsuSGKSN1cRbrusFStzunXzVOIzlrIuVLEKACablCQ/6pgUYQY3uTHL6?=
 =?us-ascii?Q?w7tMOckh1XM89+rW30A5QmPDb0Z2HCWthrbmOA9Fw2yAtcP273TZGmiUNIxy?=
 =?us-ascii?Q?MWg2b4dJ186WdP0ymL17QTNh+W/UVkBHs/SD6xZnO98cm1DahlRz1R8brSvm?=
 =?us-ascii?Q?yeAtd+WAc4tVuEe35KUrUT84oWl05w0jo+fabFK3yYbg0QTG/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:19:59.2720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e29e50a7-3ce9-4d25-e89f-08dc9508c005
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5885

On Tue, 25. Jun 11:30, Baoquan He wrote:
> On 06/24/24 at 02:16pm, Uladzislau Rezki wrote:
> > On Fri, Jun 21, 2024 at 10:02:50PM +0800, Baoquan He wrote:
> > > On 06/21/24 at 11:44am, Uladzislau Rezki wrote:
> > > > On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > > > > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > > > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > > > > On 2024-06-20 02:19, Nick Bowler wrote:
> > > ......
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index be2dd281ea76..18e87cafbaf2 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -2542,7 +2542,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > > >  static struct xarray *
> > > > >  addr_to_vb_xa(unsigned long addr)
> > > > >  {
> > > > > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > >
> > > > >  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > >  }
> > > > >
> > > > The problem i see is about not-initializing of the:
> > > > <snip>
> > > > 	for_each_possible_cpu(i) {
> > > > 		struct vmap_block_queue *vbq;
> > > > 		struct vfree_deferred *p;
> > > >
> > > > 		vbq = &per_cpu(vmap_block_queue, i);
> > > > 		spin_lock_init(&vbq->lock);
> > > > 		INIT_LIST_HEAD(&vbq->free);
> > > > 		p = &per_cpu(vfree_deferred, i);
> > > > 		init_llist_head(&p->list);
> > > > 		INIT_WORK(&p->wq, delayed_vfree_work);
> > > > 		xa_init(&vbq->vmap_blocks);
> > > > 	}
> > > > <snip>
> > > >
> > > > correctly or fully. It is my bad i did not think that CPUs in a possible mask
> > > > can be non sequential :-/
> > > >
> > > > nr_cpu_ids - is not the max possible CPU. For example, in Nick case,
> > > > when he has two CPUs, num_possible_cpus() and nr_cpu_ids are the same.
> > >
> > > I checked the generic version of setup_nr_cpu_ids(), from codes, they
> > > are different with my understanding.
> > >
> > > kernel/smp.c
> > > void __init setup_nr_cpu_ids(void)
> > > {
> > >         set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
> > > }
> > >
> > I see that it is not a weak function, so it is generic, thus the
> > behavior can not be overwritten, which is great. This does what we
> > need.
> >
> > Thank you for checking this you are right!
>
> Thanks for confirming this.
>
> >
> > Then it is just a matter of proper initialization of the hash:
> >
> > <snip>
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5d3aa2dc88a8..1733946f7a12 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -5087,7 +5087,13 @@ void __init vmalloc_init(void)
> >          */
> >         vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> >
> > -       for_each_possible_cpu(i) {
> > +       /*
> > +        * We use "nr_cpu_ids" here because some architectures
> > +        * may have "gaps" in cpu-possible-mask. It is OK for
> > +        * per-cpu approaches but is not OK for cases where it
> > +        * can be used as hashes also.
> > +        */
> > +       for (i = 0; i < nr_cpu_ids; i++) {
>
> I was wrong about earlier comments. Percpu variables are only available
> on possible CPUs. For those nonexistent possible CPUs of static percpu
> variable vmap_block_queue, there isn't memory allocated and mapped for
> them. So accessing into them will cause problem.
Thansk for pointing out. Indeed, I have very limited knowledge about
CPU-related :)
>
> In Nick's case, there are only CPU0, CPU2. If you access
> &per_cpu(vmap_block_queue, 1), problem occurs. So I think we may need to
> change to take other way for vbq. E.g:
> 1) Storing the vb in the nearest neighbouring vbq on possible CPU as
>    below draft patch;
> 2) create an normal array to store vbq of size nr_cpu_ids, then we can
>    store/fetch each vbq on non-possible CPU?
>
> The way 1) is simpler, the existing code can be adapted a little just as
> below.
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

If cpumask is b1001, more addr would located in cpu3.
>
>  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
>  }
> @@ -2556,9 +2559,15 @@ addr_to_vb_xa(unsigned long addr)
>
>  static unsigned long addr_to_vb_idx(unsigned long addr)
>  {
> +	int id = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> +	int id_dest = id;
> +
> +	if (!cpu_possible(id))
> +		id_dest = cpumask_next(id, cpu_possible_mask);
> +
>  	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
>  	addr /= VMAP_BLOCK_SIZE;
> -	return addr;
> +	return addr + (id_dest - id);
>  }

How about using cpumask_nth to get cpu id ? It looks simpler and more
straightforward, it may waste some cputimes :)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 11fe5ea208aa..e1e63ffb9c57 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1994,8 +1994,9 @@ static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
        int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+       int cpu = cpumask_nth(index, cpu_possible_mask);

-       return &per_cpu(vmap_block_queue, index).vmap_blocks;
+       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
 }

>

--
help you, help me,
Hailong.
