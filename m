Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2B171E68;
	Fri, 21 Jun 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968556; cv=fail; b=WJRIJmMN5E3UC435RaIyH8HOT5EpzxBhUzDYQc455kDJMPgKZ13hY44mhZTLBODeJVKs6jmbGsx5aSjdFu59JS533hievMu5qDZ+nUS4oZyl9PjoUB0APj2YQRytrvR3xSkBevpHpybCZMmjMVAl1CYb4VUVxeLekz7/ivji7z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968556; c=relaxed/simple;
	bh=qf1xe6DlL/I2vah51rEunZTJRUwXdv4eSsClLjci25o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPkJAgBchMwtyZWFYk3/F/lKdgs/X9QUGcXUiZAwpP76lF5FcotR6PyT7G9zFLNvYdqcwhkE0yVOAJaATRwgScbfvh5jB/svZIp2nZO6twCDZSOCoZW5trDUqfIZc1p3U+ko6bcO8/irY+iD+JKKkF0DSLrpMWZRpM1mJwstWBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=gWqfZNRi; arc=fail smtp.client-ip=40.107.255.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="gWqfZNRi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPWH7J3if0/Fx9k6yKObkpd2+UnmkD8vV8TROWJ8QZ6P4uXLG9UyKcOrxfW3/lhQYj7XWbLFhvZMAkJVhNGoHCZNFSDmAZvBki7Iuvj/saH4voSv5jGiY3VqUMMqc2aUaoGo58OAyrUwSTZyDnyfCl2IQVRAyZEIRI6AWxmGVoF7A9J8lsuEEzqt4HPfTuZARgTeRXmxaClR4KkvaKkAnIpx5ECWjld8Ck+7UT1V46YSi6wd67qd82KbOkEilw5mUb4W5VXBkXAemuCQEHntkQSC+CcSPUDY6//pu8cbrzIuPCQzA3ltNgC+sSSNcelO6JYznbqTfmp3T2AtuGqYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aul5vaVzJf++w+6GW0Zz8yhsj/0b1HhMbOFLJk61bkI=;
 b=XYFvTOjsjee1iBHIEVeY8i2iRjhVWxKzY2sp5M31//af2B9/idU0OjCEoSPCCYjgOrDlh/irEPXwBCAZXyt9oy+ylDxZ6aHyEaOYf61+VQa63ljaw2QkXuUAbvQBTbKVoZlEZLPQ5RPdMGuTLD6ObUi1EGBjmZfx/Sr8lP2RE5D6cGPsvDqMffpCAo6RXEsYNosSNvkDpchdUUV9nYnLL9O2Pqoj/QcQ6i+wcS3QQWCDsfBE43OogXD+zGyQF8Rzy+2G/1yKeLD7JtYvHrsSVTn7L1XGrIi4/lvo+vbhI8ZyynuwMTxjOrFoDQm1ZmaEkLi0ZpYfYPhfIHb5GlCvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aul5vaVzJf++w+6GW0Zz8yhsj/0b1HhMbOFLJk61bkI=;
 b=gWqfZNRi2/mQIcrYjuFAQm9DNnNkXDmAHB285kwSqI9AEnmmcvjOPCHrYov6Uk8383j9j7QXxFLOawbitTy0nMUz9eJRWWqRGvfV65ZkXB6QdC2tQHTA5s7NoLpD/BUdHjA6Cp8uV2S8HQ00x7EjKt7HfzNnTBKLwyXvay76+6c=
Received: from SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) by SG2PR02MB5724.apcprd02.prod.outlook.com
 (2603:1096:4:1b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34; Fri, 21 Jun
 2024 11:15:51 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:191:cafe::48) by SI2PR01CA0008.outlook.office365.com
 (2603:1096:4:191::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Fri, 21 Jun 2024 11:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 11:15:51 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 19:15:50 +0800
Date: Fri, 21 Jun 2024 19:15:45 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>
CC: Nick Bowler <nbowler@draconx.ca>, <linux-kernel@vger.kernel.org>, Linux
 regressions mailing list <regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240621111545.awvgrap2nscgehxv@oppo.com>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnVLbCCkvhf5GaTf@pc636>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SG2PR02MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 1542f1f7-172f-4d61-1e89-08dc91e382b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zm7oMC2yOGdOgIzta3wdwwJVrQ7sNIrIUGL8VWKoGr2Dwcxd9R2oE+dpEsm/?=
 =?us-ascii?Q?kV/aq01Uu2VsNlQ++06rFGfb6Pk3KdppF7L+xUUfbH3f5qlg2zGZT/6udlfD?=
 =?us-ascii?Q?EEFaOxT2c1/RQ4soR4CL+yMykaN6rSQ5OPg4Wi6WrGXaIKjDJpuUbqrvhiWs?=
 =?us-ascii?Q?3kMdy1gAzIV4yCMWoa8ZyFMzRJ5L4o4YfHy4TICE3zYGCJjf9Mtout08tjqE?=
 =?us-ascii?Q?FzDWTZpDdJF3emlc2by30HB9I9Nep/vpUiIuN/hT6gTXqvyfMEHyOyw0V/8L?=
 =?us-ascii?Q?O9KtjoLPbdCQ2byCPdYfRn0X9J7qUoadUuoCHqBKvk1k8nfQmC0d7ng8ht3c?=
 =?us-ascii?Q?j7Hzti+DUesDt4N0ur34ewe22bFEd/b8dQDXsoETs6wkvDHemoHu8Zx/chJL?=
 =?us-ascii?Q?i+NuTpehqVd+ZWlzonE45C3HruZncd924p4F0nkX22dBc+5f0GSiPfkUmXj2?=
 =?us-ascii?Q?hCuYU5NHE21ix4zoUCwYBCR16s9nYVEWRCo2sC4MeQvL1yQ9KaSiutRd+nul?=
 =?us-ascii?Q?/0WoMYnm4aK7byGyPt3ACuGFmI/951XoN5vjx5eoMtqgqk/AHlAXuus5N9bJ?=
 =?us-ascii?Q?hB+uc4ExIr7iNtispXGIl0Bz6e1zu1I19nZPhFmJ/mpsouxxuNStJUh+hR/O?=
 =?us-ascii?Q?0y/J2WCAb24vj7EZAmVjr/DvqOAF07O6Oud64X6g/B3Raz7P31cOj8KSOnOC?=
 =?us-ascii?Q?pAwbJmEEhFQgpgCiTYyhXhBcz+Nr9YB4yo+aR3nXGu7hT4nrkai6AmVRJnQL?=
 =?us-ascii?Q?hXcz3CQiyOvl0HZI6Akpxe81+kdkcDIsYJ3CswooC2fJKe59oKVqPbGkt6cA?=
 =?us-ascii?Q?b3kKVADyERkPngFkuoCbAo9CUJ5gTY+cDNQBA4U4PaoduZjII/nlavJ8At3K?=
 =?us-ascii?Q?8gKEPxMYNXyup0wOn87HWr7rScl3KFCqtygUpxl/mNCirZJ0Wd6Ce18i7i45?=
 =?us-ascii?Q?viF/+QQ80LZ6VtXb/jjebNvWAx4kSz30DovqXqhSohb3bo4b42aH8ybwmctT?=
 =?us-ascii?Q?9IwWMtnTNQCwA2H3J/K4YBMTlX8/Pp0h0kyY4qbLg/vCs6vZCVfUjluAxk8V?=
 =?us-ascii?Q?sHwX96WFWwRZ772LFf07uuv/dndFdth0lS4shaFBVpdwEQfV0A3vu7QFSJpE?=
 =?us-ascii?Q?0Zu3se9csLDXaXEeXws1x4nm9d+UCQqo2VtQebpf4VhWQo/4RwMUkFBNdbn+?=
 =?us-ascii?Q?Awsrc9Fm5LA41xLNqX3sHJI4c/D55vthSY6OmtnuBCTUetmeJ5IHsPb/Xqcr?=
 =?us-ascii?Q?7160pVunYiFs0MWQ2cciNLhLn37ONUxoYTWu1nEFNZbiQlYX0CBVgXA2jRqH?=
 =?us-ascii?Q?QwJ7CVnRjSv9FsgVTwPo5hsCKWWlCiYWVuKWCiP5aZz/yf9D0d1eXih9Uhed?=
 =?us-ascii?Q?J0YlwFRV3x4lF72lqVmA0obn30Tc9Obe51ZVrwfnmTo+waqnMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:15:51.5473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1542f1f7-172f-4d61-1e89-08dc91e382b7
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5724

On Fri, 21. Jun 11:44, Uladzislau Rezki wrote:
> On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > On 2024-06-20 02:19, Nick Bowler wrote:
> > > > > After upgrading my sparc to 6.9.5 I noticed that attempting to run
> > > > > xfsdump instantly (within a couple seconds) and reliably crashes the
> > > > > kernel.  The same problem is also observed on 6.10-rc4.
> > > > [...]
> > > > >   062eacf57ad91b5c272f89dc964fd6dd9715ea7d is the first bad commit
> > > > >   commit 062eacf57ad91b5c272f89dc964fd6dd9715ea7d
> > > > >   Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > >   Date:   Thu Mar 30 21:06:38 2023 +0200
> > > > >
> > > > >       mm: vmalloc: remove a global vmap_blocks xarray
> > > >
> > > > I think I might see what is happening here.
> > > >
> > > > On this machine, there are two CPUs numbered 0 and 2 (there is no CPU1).
> > > >
> > > +Baoquan
> >
> > Thanks for adding me, Hailong.
> >
> > >
> > > Ahh, I thought you are right. addr_to_vb_xa assume that the CPU numbers are
> > > contiguous. I don't have knowledge about CPU at all.
> > > Technically change the implement addr_to_vb_xa() to
> > > return &per_cpu(vmap_block_queue, raw_smp_processor_id()).vmap_blocks;
> > > would also work, but it violate the load balance. Wating for
> > > experts reply.
> >
> > Yeah, I think so as you explained.
> >
> > >
> > > > The per-cpu variables in mm/vmalloc.c are initialized like this, in
> > > > vmalloc_init
> > > >
> > > >   for_each_possible_cpu(i) {
> > > >     /* ... */
> > > >     vbq = &per_cpu(vmap_block_queue, i);
> > > >     /* initialize stuff in vbq */
> > > >   }
> > > >
> > > > This loops over the set bits of cpu_possible_mask, bits 0 and 2 are set,
> > > > so it initializes stuff with i=0 and i=2, skipping i=1 (I added prints to
> > > > confirm this).
> > > >
> > > > Then, in vm_map_ram, with the problematic change it calls the new
> > > > function addr_to_vb_xa, which does this:
> > > >
> > > >   int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > >   return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > >
> > > > The num_possible_cpus() function counts the number of set bits in
> > > > cpu_possible_mask, so it returns 2.  Thus, index is either 0 or 1, which
> > > > does not correspond to what was initialized (0 or 2).  The crash occurs
> > > > when the computed index is 1 in this function.  In this case, the
> > > > returned value appears to be garbage (I added prints to confirm this).
> >
> > This is a great catch.
> >
> Indeed :)
>
> > > >
> > > > If I change addr_to_vb_xa function to this:
> > > >
> > > >   int index = ((addr / VMAP_BLOCK_SIZE) & 1) << 1; /* 0 or 2 */
> > > >   return &per_cpu(vmap_block_queue, index).vmap_blocks;
> >
> > Yeah, while above change is not generic, e.g if it's CPU0 and CPU3.
> > I think we should take the max possible CPU number as the hush bucket
> > size. The vb->va is also got from global free_vmap_area, so no need to
> > worry about the waste.
> >
> Agree.
>
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index be2dd281ea76..18e87cafbaf2 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2542,7 +2542,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >  static struct xarray *
> >  addr_to_vb_xa(unsigned long addr)
> >  {
> > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> >
> >  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> >  }
> >
> The problem i see is about not-initializing of the:
> <snip>
> 	for_each_possible_cpu(i) {
> 		struct vmap_block_queue *vbq;
> 		struct vfree_deferred *p;
>
> 		vbq = &per_cpu(vmap_block_queue, i);
> 		spin_lock_init(&vbq->lock);
> 		INIT_LIST_HEAD(&vbq->free);
> 		p = &per_cpu(vfree_deferred, i);
> 		init_llist_head(&p->list);
> 		INIT_WORK(&p->wq, delayed_vfree_work);
> 		xa_init(&vbq->vmap_blocks);
> 	}
> <snip>
>
> correctly or fully. It is my bad i did not think that CPUs in a possible mask
> can be non sequential :-/
>
> nr_cpu_ids - is not the max possible CPU. For example, in Nick case,
> when he has two CPUs, num_possible_cpus() and nr_cpu_ids are the same.
>
> Or i missed something in your patch, Baoquan?
>
> --
> Uladzislau Rezki

IMO, I thought we can fix this by following.
It doesn't initialize unused variables and utilize the percpu xarray. If I said
anything wrong, please do let me know. I can learn a lot from you all :).


diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 11fe5ea208aa..f9f981674b2d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4480,17 +4480,21 @@ void __init vmalloc_init(void)
         */
        vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);

-       for_each_possible_cpu(i) {
+       for (i = 0; i < nr_cpu_ids; i++) {
                struct vmap_block_queue *vbq;
                struct vfree_deferred *p;

                vbq = &per_cpu(vmap_block_queue, i);
+               xa_init(&vbq->vmap_blocks);
+
+               if (!cpu_possible(i))
+                       continue;
+
                spin_lock_init(&vbq->lock);
                INIT_LIST_HEAD(&vbq->free);
                p = &per_cpu(vfree_deferred, i);
                init_llist_head(&p->list);
                INIT_WORK(&p->wq, delayed_vfree_work);
-               xa_init(&vbq->vmap_blocks);
        }

--
help you, help me,
Hailong.
