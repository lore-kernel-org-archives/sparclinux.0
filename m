Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2043.outbound.protection.outlook.com [40.107.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD12B9D6;
	Thu, 20 Jun 2024 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865472; cv=fail; b=dA7mDuw/QTFEhdp2TprFgSb/W3OGJZ/bH85h8CEn8bhYhJZxgbcI1EzrcF08cQaYx6S4sNWR6+65e4seCanEZJHxd1ZT5oKod+1dZ19E5m1gx/qlcxax5HllNUfaUGgcJyWZ80lf8MNikltXj6wIEe30cYkDLDohjPT9df68LIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865472; c=relaxed/simple;
	bh=o9MiHyEXhw4sTHHoTm3qvYXanYEFxgWMV7tM5Tq1dRY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVCjJ6BTfJaKWW09l18+GJ+nWndu9Sx048/ZZ8LgEJpz/LTYyN0F5218SVK8TtflQjlWrb3JFbC2E9PcdxkAF/uxn9lBIdRcWu/BRGhFFoHbhC0JajZDRfL8jiCmG+jDw0tsqXp2TMxDRSl/dgylKnG5oYP3Wc83akK2c0eSwlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=s9yo794l; arc=fail smtp.client-ip=40.107.255.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="s9yo794l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWPeavYbdnOSHtrJX2OmeVYNXPN2n6fHPCwK+UOX+67hjy3dO0/LiDBPbpW4OVHXhl9dZf9VNj7m8C8DPHLC1C8kd5MMZjXmwWfyAF9zMy0MTrTKaPEigtM3htFHnUn2RWmSS1tJl6mIOVtkO3gpj27jmyuBUbzhJ1v+0f55alTlfXMF1X4R3ZiuEgo1zPTxTuh3bFF/yx43xuJUud7IKTp0vbSVL44xCz1j+QZpYluF4BaV8AOqA/KuENorRP62GlRGVL2958Kw4yUwerGVMyLfRYnyZwVvTd67Xx7+JpYf8neAJqyRkJ0gH3PKbTBbSw0+408dPNuXhCV4NKx3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmDArJGpA0cWcDqC2g2sGxL2DYTZ1IaHCVmVBxbrkfM=;
 b=jnDbWjsm3kVeHW/isfBZbd/kKWGTaX+49K0LeV1VUfepPlNAYahn91KqCZiq36EhvWfGzGiQ/KtKyVAXs8wAqZuwtZ2+fmPZDewu2nzmSpJo8nsbTIiEWdMm/q6NrfWl3sfAOzu43IX3pJ5GsT11Ff1yEK1g3JLOusmTHpIWfZec7nYfgnRrwx24+T7udZDbxRK4lb8zW0TnbQYmcLb0hFAWUQFLKNYEvUNjeDU3yyp8NkII8VBeXpo/bZXtChCH0cwGytx7iX2a2v85ZQHS430en/UoeRpei127YaK8BIep2D/rxUpjFS4nwM3T0gPmHjZM3eScMooAhbbl3msxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=draconx.ca smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmDArJGpA0cWcDqC2g2sGxL2DYTZ1IaHCVmVBxbrkfM=;
 b=s9yo794lSvPbbE8gmBBM1nU4t6dS1gXIINSLqJnmha55+cQMIXe9nDnRpAfp5q7cA9sjbAxJape2njC4x1t5rCpfh4swKDnw1838+M2FS0psfy5J2Ef2tKYW/VzWDAEUbA1JMT2Q0QOvo5aL/zva8w0xGhwfML5wWBLXJHlCvmo=
Received: from SI1PR02CA0024.apcprd02.prod.outlook.com (2603:1096:4:1f4::12)
 by KL1PR02MB6353.apcprd02.prod.outlook.com (2603:1096:820:e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 06:37:48 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:1f4:cafe::b6) by SI1PR02CA0024.outlook.office365.com
 (2603:1096:4:1f4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 06:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 06:37:48 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 14:37:47 +0800
Date: Thu, 20 Jun 2024 14:37:42 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Nick Bowler <nbowler@draconx.ca>
CC: <linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240620063742.7qugmebodtlogn5r@oppo.com>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|KL1PR02MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcb97f3-7150-44ec-c056-08dc90f38054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YgbWPOndJ18Lt79qgC1w90i/6CHuUkShk8EaltFjXXKUy826PYv2Mv0bRsTq?=
 =?us-ascii?Q?nz6Fq7kp7y3iypiaaXH+r7wqUfo8Pf4olYp8mh+t6VCSONqEmvJ0cMfTj3rh?=
 =?us-ascii?Q?iRH/K73WHsJs1FjPdf4f2LQJQ5uQblJcMEO9rEFXIyxfZEKzNfljcC+B1UOR?=
 =?us-ascii?Q?/XdsBlhucG+ht9yx/kLcj8of7OufEniLhxubctJnMHgrxwtboZKq/7RyFE/W?=
 =?us-ascii?Q?YMAWV8BO+1xD3ISWdAnGho82nTAboB48FKU2RufS3DMLqn6YEU8fADmz6rNr?=
 =?us-ascii?Q?ShiT5i9IIN4zImnGUEAmvC0FNgoUfE2T8LmgbkVWXDTke36FfpG0PU0mgs1S?=
 =?us-ascii?Q?+1FadKtn/9028dvWV/h/ocBCRIuYg6iVlfQe6Mqr7gw7o095H5qLW27C3mrB?=
 =?us-ascii?Q?n+MknzqG/7xXit72Swm/fY3NOJvzlRbgH3PrzYXloe2ia1FqFAYbQUchSfaj?=
 =?us-ascii?Q?NHjoZGCbtseW0Q3Fc2jkBFpskW8LQ3+zBVvTAzx3Nl5L1KYfVBSGBp8yNoUM?=
 =?us-ascii?Q?wF9GdYPqJJekdlezCGdX2rVNkz1S/HhFFXYQiDyiHefRJSRkw9ido+A6XiQh?=
 =?us-ascii?Q?DF6Z+iaxn2i7xaOlos02ZPpIiyfBd+Xs25I+pla/GQiVRh5Ih9XNLweDTKbt?=
 =?us-ascii?Q?3EXTub0wZGm4Q22/5wONmlo/FyuKtCNIMwy+/XQxVuq8GWsLYzUagCAdzWQG?=
 =?us-ascii?Q?BRxP5TS62gN4+KRDtpMNuPyItbxg4d2ITjEv15eSGhzGIK776hT4vky3qicI?=
 =?us-ascii?Q?OEhGyrdF4o9F8PqxoteUak5Kf5h3zKBfLcc2gkOFuGEJwfUz7p3hZffblEcP?=
 =?us-ascii?Q?03Xx7je24RJmRPvIgkwqmYIT0jiosUCQ5w138v6TRTobFfi4BkEvI4+rGEWp?=
 =?us-ascii?Q?GS8+fdwkr3/1/E9EBh2HZk6th3oz32oc6SNfbh+3rBza+fRhZQFp3IUIh8So?=
 =?us-ascii?Q?0P8WI8F629QXeS5qJsT9nSr01eok1W4oL2S1hdMmI3AEV2hl8u4FIdlkki87?=
 =?us-ascii?Q?DSU5kLBjuLKrYywJ+eTs/cqJIl42cMNzH4cPu94+DDtNX9UMSGVkiZH9pc2H?=
 =?us-ascii?Q?rQcvPBWF+jBWpeCnUYIqggp6iVIZhuRDN2ujeovAryhNpRFhKZtAMmKbQPJt?=
 =?us-ascii?Q?X9XBpH2EQWBYL0z7c00Qvr4tehVkcn+XYPFPWTH0GL2DL9QFQVejg8K5WClP?=
 =?us-ascii?Q?xQnCwPV2tmcjvVhGHLtZB2eMLd5AR6k6krGjwY7ePx6k6FiqJC/uaBOrKWKH?=
 =?us-ascii?Q?M9Pmu/vUTtHbPnaQrIkVU1R7cidGF7D7XFnj0P2IdMl+SoWHF7gG9ZxoWfhy?=
 =?us-ascii?Q?S1KYxx3U6vlpJEqWHFlkcV3YJIFplIOrYlaa/WAqwf2UaLxa3EtJPYy4ZWk9?=
 =?us-ascii?Q?1nQ1P5s=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 06:37:48.3164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcb97f3-7150-44ec-c056-08dc90f38054
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6353

On Thu, 20. Jun 02:19, Nick Bowler wrote:
> Hi,
>
> After upgrading my sparc to 6.9.5 I noticed that attempting to run
> xfsdump instantly (within a couple seconds) and reliably crashes the
> kernel.  The same problem is also observed on 6.10-rc4.
>
> This is a regression introduced around 6.4 timeframe.  6.3 appears
> to work fine and xfsdump goes about its business dumping stuff.
>
> Bisection implicates the following:
>
>   062eacf57ad91b5c272f89dc964fd6dd9715ea7d is the first bad commit
>   commit 062eacf57ad91b5c272f89dc964fd6dd9715ea7d
>   Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
>   Date:   Thu Mar 30 21:06:38 2023 +0200
>
>       mm: vmalloc: remove a global vmap_blocks xarray
>
> This reverts pretty easily on top of v6.10-rc4, as long as I first
> revert fa1c77c13ca5 ("mm: vmalloc: rename addr_to_vb_xarray() function")
> as this just causes conflicts.  Then there is one easily-corrected build
> failure (adjust the one remaining &vbq->vmap_blocks back to &vmap_blocks).
>
> If I do all of that then the kernel is not crashing anymore.
>
> A splat like this one is output on the console when the crash occurs (varies a bit):
>
>   spitfire_data_access_exception: SFSR[000000000080100d] SFAR[0000000000c51ba0], going.
>                 \|/ ____ \|/
>                 "@'/ .. \`@"
>                 /_| \__/ |_\
>                    \__U_/
>   xfsdump(2028): Dax [#1]
>   CPU: 0 PID: 2028 Comm: xfsdump Not tainted 6.9.5 #199
>   TSTATE: 0000000811001607 TPC: 0000000000974fc4 TNPC: 0000000000974fc8 Y: 00000000    Not tainted
>   TPC: <queued_spin_lock_slowpath+0x1d0/0x2cc>
>   g0: 0000000000aa9110 g1: 0000000000c51ba0 g2: 444b000000000000 g3: 0000000000c560c0
>   g4: fffff800a71a1f00 g5: fffff800bebb6000 g6: fffff800ac0ec000 g7: 0000000000040000
>   o0: 0000000000000002 o1: 00000000000007d8 o2: fffff800a4131420 o3: ffffffff0000ffff
>   o4: 00000000900a2001 o5: 0000000000c4f5a0 sp: fffff800ac0eeac1 ret_pc: 0000000000040000
>   RPC: <0x40000>
>   l0: fffff800a40098c0 l1: 0000000100800000 l2: 0000000000000000 l3: 0000000000000103
>   l4: fffff800a40081b0 l5: 0000000000aeec00 l6: fffff800a40080a0 l7: 0000000101000000
>   i0: 0000000000c4f5a0 i1: 00000000900a2001 i2: 0000000000000000 i3: fffff800bf807b80
>   i4: 0000000000000000 i5: fffff800bf807b80 i6: fffff800ac0eeb71 i7: 0000000000503438
>   I7: <vm_map_ram+0x210/0x724>
>   Call Trace:
>   [<0000000000503438>] vm_map_ram+0x210/0x724
>   [<00000000006661f8>] _xfs_buf_map_pages+0x58/0xa0
>   [<0000000000667058>] xfs_buf_get_map+0x668/0x7a4
>   [<00000000006673e0>] xfs_buf_read_map+0x20/0x160
>   [<0000000000667548>] xfs_buf_readahead_map+0x28/0x38
>   [<000000000067a4f8>] xfs_iwalk_ichunk_ra.isra.0+0xa8/0xc4
>   [<000000000067a8f0>] xfs_iwalk_ag+0x1c0/0x260
>   [<000000000067ab08>] xfs_iwalk+0xdc/0x130
>   [<0000000000679fc8>] xfs_bulkstat+0x10c/0x140
>   [<0000000000695528>] xfs_compat_ioc_fsbulkstat+0x1a4/0x1e8
>   [<000000000069572c>] xfs_file_compat_ioctl+0x8c/0x1f4
>   [<0000000000534ab0>] compat_sys_ioctl+0x9c/0xfc
>   [<0000000000406214>] linux_sparc_syscall32+0x34/0x60
>   Disabling lock debugging due to kernel taint
>   Caller[0000000000503438]: vm_map_ram+0x210/0x724
>   Caller[00000000006661f8]: _xfs_buf_map_pages+0x58/0xa0
>   Caller[0000000000667058]: xfs_buf_get_map+0x668/0x7a4
>   Caller[00000000006673e0]: xfs_buf_read_map+0x20/0x160
>   Caller[0000000000667548]: xfs_buf_readahead_map+0x28/0x38
>   Caller[000000000067a4f8]: xfs_iwalk_ichunk_ra.isra.0+0xa8/0xc4
>   Caller[000000000067a8f0]: xfs_iwalk_ag+0x1c0/0x260
>   Caller[000000000067ab08]: xfs_iwalk+0xdc/0x130
>   Caller[0000000000679fc8]: xfs_bulkstat+0x10c/0x140
>   Caller[0000000000695528]: xfs_compat_ioc_fsbulkstat+0x1a4/0x1e8
>   Caller[000000000069572c]: xfs_file_compat_ioctl+0x8c/0x1f4
>   Caller[0000000000534ab0]: compat_sys_ioctl+0x9c/0xfc
>   Caller[0000000000406214]: linux_sparc_syscall32+0x34/0x60
>   Caller[00000000f789ccdc]: 0xf789ccdc
>   Instruction DUMP:
>    8610e0c0
>    8400c002
>    c458a0f8
>   <f6704002>
>    c206e008
>    80a06000
>    12400012
>    01000000
>    81408000
>
> Let me know if you need any more info!
>
> Thanks,
>   Nick
>
I guess you can patch this
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-hotfixes-unstable&id=00468d41c20cac748c2e4bfcf003283d554673f5

--
help you, help me,
Hailong.
