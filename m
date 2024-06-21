Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E902746F;
	Fri, 21 Jun 2024 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718940628; cv=fail; b=mMtcgwg/0ikm64JKTmLuVFLunaEWO2ZhNuFaS5YpkzfWZyDTnjOziZ6xV9vskeCyY8jmL53s75si4/iH5eo8Lv55FgeuGi49LXhbo3MggdjP3N3Kzlvlek7qOcmKz7fVRyUo5fEgkuG1k/Cx2X8UlcUWEAoJXe+vJcjAZ6ocR/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718940628; c=relaxed/simple;
	bh=m6fOaIrIDH47qZntJTN35PQNKkUsA2MYQidr8EGOjPk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9BzkG2vpw84Bu+aRSTUupmFTi/BEm6+3vyjn1HTOHZv77Xku6OeR/t5H0bq7EoLjTw+18H1NBqkWlwPBWSIsDiJiehSrGpYheHqJI3TfqtjldqXiJSL65ROh3EDLi+9b6EQHFxhqUKazYUexMZIOPvzgOu+sMN5TiTwCCovCwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=tDTMFMgt; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="tDTMFMgt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpvoe9pC02BlWt2W6ieAJ5dniLHhA3ybK6joaJhhxQaeqwD51VgAfLIH5hDTBDJqKngiL1G1lbtl3NPU9ZHGBuu1GzCDQm98wF6gXZP/1/83MgagptOtoD1lH2WocFOPwt3DB6f4brV8MdMBSrogUdUzZ9vfZqAIveGcQW6z3bEPVIS8j4dzskLffIf1vk5vafS8HPShD6jg1tZ+63/tRW/r8uaK6FxjtCFI8Dy3iUVVaDkcokVCeS4+8vBxdMOQTt0rbXAFjYftmzNyMDjEV3duHG4seITjLtdaykFdhw2H6ExmSeP+ABon5v7RRKVg0qLmI/MZUXClEq+n2HwVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoxSo6n5OyRjUQ1Jz52s4G5ESzFfW2UgwEtOIbPtFZg=;
 b=jYxk4rfYb+zG9YdeoNkY0xYYRzWpYTg5ZKMc+aDrLIYjidx54mmgfQKFyNKsNKQqDXA3yJ7Sy0p0G8pdQpEK+SUzDoJ2u78ZRz9fVeVb2X5Z/vI2GLuNOmPKPc8Sl91v3GNwSXtvM60XioxbgW1z3KeBN7Hw6Cphgy6sqXm/j6CALDA/OUSD1O35Np4Hy7aF/cWgjXwBrnVW8WP06FSkG43czufQqynPa1j51vaSgVGRUJY+jAJvh+BzHar2zB/kl+D8+ny+2ELswZ8X8YDq4PmRqsZgWlgyN0HHgNp3Vm8rHEznZdVXrKSaoqwDyVLHI/mCmB7TlXyAQt1mQc+jSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=draconx.ca smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoxSo6n5OyRjUQ1Jz52s4G5ESzFfW2UgwEtOIbPtFZg=;
 b=tDTMFMgtk/BKu7m4konqFwpojVJHN1EYw9oZUrxVOn6FRc+VHp+aB7nH3W+g45Rb5i/E2Rn7B7Kd7wiCYzymAsk7YJwGwCmlu4WwTEtOapE0sslgqE1motXUcwmmmc4c1XPFreP+7p/PGR9Q3/Vaq3LEiPyecnuv5TC+yos257k=
Received: from KL1PR01CA0099.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::15) by TY0PR02MB5924.apcprd02.prod.outlook.com
 (2603:1096:400:205::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 03:30:22 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:820:3:cafe::9b) by KL1PR01CA0099.outlook.office365.com
 (2603:1096:820:3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 03:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 03:30:20 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 11:30:05 +0800
Date: Fri, 21 Jun 2024 11:30:05 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Nick Bowler <nbowler@draconx.ca>
CC: <linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, Baoquan He <bhe@redhat.com>, "Uladzislau Rezki
 (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240621033005.6mccm7waduelb4m5@oppo.com>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|TY0PR02MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: f7136f1c-a4d8-40d0-6a17-08dc91a27ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ue9R0KkAYSnDizo4T7une3UovIr9f1VxhT7g0mZQEkskw6xp39C7klysDpDg?=
 =?us-ascii?Q?BojaB3RiuPKeT+rZ0JDvhL5xk4pw3oaUS4qk5ML29Eql48mtnVFsa156bRvn?=
 =?us-ascii?Q?/mtE+wQnwO9e0sLR2cnjqw4eJt2YplRRlF+1qco5S60cUTRu7QS7/+0YpIAp?=
 =?us-ascii?Q?l1D1+eSr+dtx0KoHKVsSMEHA4sGmwO4Rf8i+m/v9gkXs9Ab5iZ6RCJEeFEso?=
 =?us-ascii?Q?IhvkjAjuWWjt+hHfQzFc58PEb4jxqAghI6r0ukvGsbTB8pPIbuAJ+5558WyJ?=
 =?us-ascii?Q?2o/5teWWaoIS8wuOQ/R2sg7wQYur3q96Ksj3J1nbbw3twRu3CnfyLxd3RJmn?=
 =?us-ascii?Q?SAKVkranrfOcl6Pl6lITTQa7wCtqi1+YB67IXLkJfv00VrPspIa7la2wLGky?=
 =?us-ascii?Q?VsgWBoUy7zk8hiK+UqyGkKdSUYTE3HtJTCfryaIGFYle4thFiQdaYDSATW/C?=
 =?us-ascii?Q?aIpLR5eJ6Qia4vLf+ctfVHMff+gsuie8PAmTjqTpm8aGkDt7B5TB8Mbd374q?=
 =?us-ascii?Q?TJw4Y2KeXWJTpi7dL4qfIHPN7Q4xThBvOKy9u1oMDkVzEmtk3DFfwM6mktRy?=
 =?us-ascii?Q?3czhkXKodE70db5OdzxjBmE/NU3bgxfKk6RtDRgU/Z/RDUVL0DNv6KHyeKXc?=
 =?us-ascii?Q?67rePC+Qccnjdf7onAk57RT84H0e2e9+RtTxWxYsvpPCBaH5QHLjvdbg5dLZ?=
 =?us-ascii?Q?ngmug5Zkl6SxURcrm221FpSpBsL35rWpYKzNSKLWSinyt6tpY8uIbc0SU9KK?=
 =?us-ascii?Q?+29cL5uU7F7nfCkO4hJcVmmfNt/JDBh/NnrApz2gNmbqaLxnrmmC9fyPf+Hw?=
 =?us-ascii?Q?b11WtjIxPrAOfUynvbj9m7qXmrvqjoqBV2dQroMqyJstZpXv6y0rPdOV5G7B?=
 =?us-ascii?Q?UDhAzaqhxUH1xzwRIz9ZKolNeaCtZRnIMFURNAjiis7sxUzL+OzpjanIXZiY?=
 =?us-ascii?Q?7XSYxbp6QzVhxUMC+NeDkv4kh2DZQOpqltG0qoMSorhq1UnQSYc2pJlrImyQ?=
 =?us-ascii?Q?oLbhSu+Zs/GP3PuyU6CABVdDIw5WmYG7WADryDg1q2N0xcUwzjnH59PXwZ7r?=
 =?us-ascii?Q?3x6KZYuGcSiDSA7fPcIjZvLV6pzQG62R1UU++oT/TQpoJj4prFAx8XnWpEhK?=
 =?us-ascii?Q?l6SNE2cbf2SBTs720cViXsrAK/aIFzTdziqo/EiO9zYVDAvf5mehCScZRH7L?=
 =?us-ascii?Q?792Bki2bG2a2hfIbkHtk6H+IsFoRY8BtNtp5VYH21SeRb6RE0jcbGE+FThnw?=
 =?us-ascii?Q?xa/AXUjDbfcxkg4tT58wU08HjbZsn08l6NWQ2Xdw8AdNQPeWzSnWR2Ts6V6b?=
 =?us-ascii?Q?5Qbb/MUiCt3qAcxMb49uY3sLRIjnnjlrqLpLDx/Q+dMIkudBH+vb4ZcHOe48?=
 =?us-ascii?Q?njcNPz6HmsiYt94U/zLxID56HM4ZyhHn9nZd/exCwqEoK1GweA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 03:30:20.9519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7136f1c-a4d8-40d0-6a17-08dc91a27ad4
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5924

On Thu, 20. Jun 14:02, Nick Bowler wrote:
> On 2024-06-20 02:19, Nick Bowler wrote:
> > After upgrading my sparc to 6.9.5 I noticed that attempting to run
> > xfsdump instantly (within a couple seconds) and reliably crashes the
> > kernel.  The same problem is also observed on 6.10-rc4.
> [...]
> >   062eacf57ad91b5c272f89dc964fd6dd9715ea7d is the first bad commit
> >   commit 062eacf57ad91b5c272f89dc964fd6dd9715ea7d
> >   Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >   Date:   Thu Mar 30 21:06:38 2023 +0200
> >
> >       mm: vmalloc: remove a global vmap_blocks xarray
>
> I think I might see what is happening here.
>
> On this machine, there are two CPUs numbered 0 and 2 (there is no CPU1).
>
+Baoquan

Ahh, I thought you are right. addr_to_vb_xa assume that the CPU numbers are
contiguous. I don't have knowledge about CPU at all.
Technically change the implement addr_to_vb_xa() to
return &per_cpu(vmap_block_queue, raw_smp_processor_id()).vmap_blocks;
would also work, but it violate the load balance. Wating for
experts reply.

> The per-cpu variables in mm/vmalloc.c are initialized like this, in
> vmalloc_init
>
>   for_each_possible_cpu(i) {
>     /* ... */
>     vbq = &per_cpu(vmap_block_queue, i);
>     /* initialize stuff in vbq */
>   }
>
> This loops over the set bits of cpu_possible_mask, bits 0 and 2 are set,
> so it initializes stuff with i=0 and i=2, skipping i=1 (I added prints to
> confirm this).
>
> Then, in vm_map_ram, with the problematic change it calls the new
> function addr_to_vb_xa, which does this:
>
>   int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
>   return &per_cpu(vmap_block_queue, index).vmap_blocks;
>
> The num_possible_cpus() function counts the number of set bits in
> cpu_possible_mask, so it returns 2.  Thus, index is either 0 or 1, which
> does not correspond to what was initialized (0 or 2).  The crash occurs
> when the computed index is 1 in this function.  In this case, the
> returned value appears to be garbage (I added prints to confirm this).
>
> If I change addr_to_vb_xa function to this:
>
>   int index = ((addr / VMAP_BLOCK_SIZE) & 1) << 1; /* 0 or 2 */
>   return &per_cpu(vmap_block_queue, index).vmap_blocks;
>
> xfsdump is working again.
>
> Cheers,
>   Nick
>
>

--
help you, help me,
Hailong.
