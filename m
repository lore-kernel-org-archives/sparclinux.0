Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2042.outbound.protection.outlook.com [40.107.215.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ECB171E5F;
	Fri, 21 Jun 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966734; cv=fail; b=XplKRRu5/P6EFrsIJwPry03Xef1A3MR/UU5dIbwB4SbroHbvYZh2bJKLePUqDdVsLKTk7HLh8DoQqTcgihoJqB4rKs/kjohD/L7Y5YKSJYPZSL0Sb2WO7lCAX9dWdSOXPjl70x+r+pHNJWSzxzBsnAWO8Rc6Zq+sXC01ThmvlTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966734; c=relaxed/simple;
	bh=7HzLElzkYmEx1fWQzDXu/laGXYtulLAiIeCqeyJIiWA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3t6NNrKCfUw06OhC2m5q7nnozowzrHBtRZ9hpp+8rI2q2+lllgGdUxmQzxQsrKoIY0Hn2ZnL6J5N4BHnkV9R0YR5MvJFNA3XkWbNDv0irFlFsMWSG52rCT4soxNhPTOIdzpAz7ed57lHcgmM+qVOFkatUL3s+XX76Nxr26NWuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=gBsxRt9h; arc=fail smtp.client-ip=40.107.215.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="gBsxRt9h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzoZGrGMaNqc40GZYZIauB486WpIkcTOOGGhoQcjjWUqDaDSUplQHqGKxFLZZRjrJU3eibL+/KbFS8mL3/xc++3Ccfj3lOKZzx4l18vknZetGUrI+awlvlpUHFhyGDYbQbhjnKGjKTKhURZbwQyWqf60aigCO2m+Uqe8SbvIU7PJ6dQxDZt8ZR6ixWcgnlRPuAoWl6Nr7xNRUEYyo6TmuE8HOCyCRG7PO5mFekwcJJoBfAuPtO80VH4RB1dTMjNRrjJfuxMIPxJD1FLPMQ+NzsOy4oS1KixQYHsBSV73RyVe8iESvtKP2wQhkA2eRQniOmYz2dRSbv6k5YgLf3dkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlVvWLkDz8GUbyHNkXsElcbog7x/l+YsIFtAHSBM2aQ=;
 b=h7dccqUERyrK0lAviDrXZcYiCVUJWVBui1g8bz9OaJG4p8/e4yKlV5ZDrPTMqG7gwPUREegwkQ2Cx8K11bPkVy85VaRTyzZqm6Yiyr7VFDl2tuqjK/Tg9pY9ZUBnYXiVmohZnyqdCkG1eVqpFijARL5tG9s4nlhwrJtEpwDKxbOfnyNbpORxmiHwOGdAxut+OiJqjrQ3UUePZKtgSIhug2cBewwrtwCBDvgwM/tO6c79WcbisL/awACx5NOY77CnHz7xv8NF2QDXQZkD7yBZteAearL001IW2l0wu7/xFJvotP6BA1yWuacanfKFEZ08PN7sam2DdYV3xu7/bnmYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlVvWLkDz8GUbyHNkXsElcbog7x/l+YsIFtAHSBM2aQ=;
 b=gBsxRt9hyBXzvCNVi+l1e1Grw8nEMgHzQYdAp2uPxpHLpSeeDhsH+Ntxzik/5McAjzvshbBFpAfrcGyFWqp+l48OgzDNaNE8KFoq/8ORM7KMc+gDWflb0AWGa/0RJG6ORhPtZLsBWzCNWSofRwd6pFuAgVz94zNBh1vr+dH2PdI=
Received: from PU1PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::23) by TYZPR02MB7080.apcprd02.prod.outlook.com
 (2603:1096:405:2f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 10:45:28 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:803:16:cafe::5) by PU1PR01CA0035.outlook.office365.com
 (2603:1096:803:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 10:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 10:45:28 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 18:45:27 +0800
Date: Fri, 21 Jun 2024 18:45:27 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Baoquan He <bhe@redhat.com>, Nick Bowler <nbowler@draconx.ca>,
	<linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240621104527.hzu3tsu2pwhxbhzt@oppo.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnVLbCCkvhf5GaTf@pc636>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|TYZPR02MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: abde0a8f-c712-4d7e-b04a-08dc91df43fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU9WVHhPSWg0R3JKTTVXMGVSU3FNVGcxUFhUVld3S2hMZ01qSDg1bFAwalJZ?=
 =?utf-8?B?QnBjSHNRNWVHR25uYmVUWVRrb2llSGlRKzRHQVJTdkM5R0o4RDQ5U2JwUjlk?=
 =?utf-8?B?dFk0QlB6RXhuT2xZdGhOOE16UitLcjJ4QnRKWFMxd0xPTnhsTjF4OVEyUUJt?=
 =?utf-8?B?U0RKQjE2dmk1N3FCcDNGbU1VQ2RWNkkySnlxbjIxSldDSkdKZWJDVy9wNDEx?=
 =?utf-8?B?VitlTjRIdFBhWHNuYXBwbU40MVArS21YM2tnb1pIZC9ZZ3JUd2MzZ0k3ZVFV?=
 =?utf-8?B?TnRhVTN3dHlPRXljUC8rTFB4dTdqeWhHNnllYitnZmVZWXVZdEpRK2p1K1Nt?=
 =?utf-8?B?VzVjOGRnbENSbkQwYXp4cDd4ZUZBbmJBR0tJcXpyOUpXOGFnWGNicDRaUTVo?=
 =?utf-8?B?MUxkZDZqamcxckprUFhYUjcyL0hLQ0xXMkhsZldLMSt3cWFBeG0yM0ppbDRJ?=
 =?utf-8?B?Q1RpUDZZR0s5RUpVTzk0YWIrSWVlMGkrK0h1bFY1azJXRXNvb1hFQXE3TVQ2?=
 =?utf-8?B?ZGFYd1o5NXFHLzJhNTl0QUNFeGpzZEpPOUJ2Yk82ZXczVXduZGNqSlNReFMr?=
 =?utf-8?B?OXg1S2VOemNIMURiTlBwcUVQQTFHenM0N3VhK3pmTEQ2TVBmT3EyVXdOMGxq?=
 =?utf-8?B?WUgyQ3pKVXMzQWFiRy8vNkZGUXJoS0tpNmd0dGpmUVNSTGpxSXRib3ZvREJR?=
 =?utf-8?B?UzY1ZEdHcEd3c1paWnJNcWJLRWp2bGZIQkx5VGIzbzVXZFBldXNnQzk4QmtC?=
 =?utf-8?B?T3M5d1g0QndZVUdaOTRXc3NkY1E2MFk1R1Q1S2JZUVh1aGQ4WE01WE90c0Fn?=
 =?utf-8?B?bjB0ZGdxQUtuTkdOSm5wSi9waTl4SExSajJJRXpwaVJDRGNHK3drZk5CZFdN?=
 =?utf-8?B?cHRCWkNDSTA3SkgxN0dJTmJFQWt2aWJPcU5VRUpCQjN6WHNyZDZYY1Q1OXlj?=
 =?utf-8?B?UzF3WTlNQjhKYmFMYzh0c2NhSFFPNTVzVStiZmNqbGFJQ2NWT3crckErQlZF?=
 =?utf-8?B?bkZ1bDJUSjVMV1FPbG1sQVAxRkplZzFDaVdMSGZuSk1nalo0TWdYMHJkN3hY?=
 =?utf-8?B?c2lkMTBRN2hhVXpxeVZHN082ZHlvc0Rrd3JpeDFKMTNQN244WFk0MzduMlVV?=
 =?utf-8?B?cHhLUE1ISFNOSDRoc2c3OThFL0VNb2RWbFhjamtpMGYrdU1ZSjl4Z3NaSkFa?=
 =?utf-8?B?K1l0eFJ1ZzVtU3pKN3VHMWhUbkxDUHZaWitIWHJaQmlidnR6dGJlWCtnT25j?=
 =?utf-8?B?OFZoajBXeXlEYXArcFZRTUkwU2NpeUhldnFlMEVBV0VGTklENDZlVVprZWJ1?=
 =?utf-8?B?TUEzRmtVSkQ3bXBqbzlLMVNFRFdVZndieTVlL21JN2tIY2ZjbDcyeVZ0ZnBq?=
 =?utf-8?B?cFkrRURGcElHREVXNXBVdG96TllFUlpTbUhiY3NQTnA0WWVVaFJtdnU2cy9x?=
 =?utf-8?B?SVVBQUUreVlqVzlLNmp3VkJndmJkYzJ2cXdXR0IzQUNBVGVmc2FQR2tZTkdO?=
 =?utf-8?B?UkdCMEJXK1AyTWQ3dUdEeXhJcnJrdW5kWjhEZisrdW5qSGp0bXNqdW14bU1j?=
 =?utf-8?B?blAwMmFEQzNEc2pnL3F5SFY4d2cyZWRtWS9VL3hGNUJ2U2N4VUVsUnpybk1N?=
 =?utf-8?B?MGlGMkVSZFAxbi9McHlMOTh2TlU3Z3lmVFJOdWw0VGNPalorcUVnbkh1N3Fy?=
 =?utf-8?B?U0srYnh6MzJYOGhOc0hsK1hjM3kwK21DM3g3N0tBdFU0aWZWbUh0Yy9jdVds?=
 =?utf-8?B?Qm9ZKytiVU5nQjVyOSt1NG5hNm1oVXJickV3cmEwRWpVMFM1RzNFL2l1VGMy?=
 =?utf-8?B?UDdtSmVNU2hvbUNMV0dMZlpUQm9HVE1aODEwc2Q2MGJ4SWk3MjlDVkFZWW9N?=
 =?utf-8?B?RmUxQ1FvbHZKMTkvdHhwNUo0OVJwdml6RWQ3alRYOWNVZkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:45:28.2548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abde0a8f-c712-4d7e-b04a-08dc91df43fe
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7080

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

Sorry to trouble you. do you mean as follows:
@@ -4480,7 +4480,7 @@ void __init vmalloc_init(void)
         */
        vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);

-       for_each_possible_cpu(i) {
+       for (i = 0; i < nr_cpu_ids; i++) {
                struct vmap_block_queue *vbq;
                struct vfree_deferred *p;

That’s exactly what I was thinking for the first solution as
well. However, Do we really need this for the impossible CPU's variable
initialization? How about using the index to find the CPU?
Just like the following, but this is not the optimal solution, and it
also wastes a lot of CPU time :).

@@ -1994,8 +1994,12 @@ static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
        int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+       int cpu;

-       return &per_cpu(vmap_block_queue, index).vmap_blocks;
+       for_each_possible_cpu(cpu)
+               if (!index--)
+                       break;
+       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;

BTW, Using raw_smp_processor_id in this manner is incorrect; that’s my mistake.

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

--
help you, help me,
Hailong.
