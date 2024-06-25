Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2B1487D4;
	Tue, 25 Jun 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307572; cv=fail; b=GQIsNlDJyy4n7V1ejD6v9s5sXCP8GcTEyKl0rulvrH2CfaqxBfnE+rASDKSSjSKgHnxNhDS3VivX6iuYH3hfwnk7fsmbolj8nmvHDkD2PC21xRplm5DCpGIQgFsgx8dPosVKpgREq6YYsu6pSKsuX1EBy0Je0V0LMMaFW8Wbbyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307572; c=relaxed/simple;
	bh=RSDL5hBt8Fi1ZXPvWH9y8ycn+n8iYssGwdzzMyL6Mnw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9AL9QJWXW8uF59EdnNDBrjrS9gDWEeNQUa+Y0Lv0Z2umSNGsrOr8/fH0i8ljZifti/TAJ0l487AgF+Rs7rbJyEsr5qGCs/ODjmZSodwPtX9h/lM0PCuCucUat/49tRZUXoOi3CQ3/XFXqw81jBNC4GVMDGVQbgbE8xFPctCb3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=ZRk8uGMo; arc=fail smtp.client-ip=40.107.117.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="ZRk8uGMo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAUW/QUBCwqLz+Tv0DfSLnsd/ZqztK94Q6P8i5HQbp/A33W/5ULJO8yK6FPZ+EHYsiaNR2EYzaQx9LGrlbEMmZw8TlR1bkTe7MyoffRwQJkapd6yXR8js1bZc1UNG8pAMIUAeWo4BgELVYr+YRIAX4oP/jawUpA/v5hodQuAC80pTcPLnNwfQ3v6iZEkC+13il6hThgOZZkz4U2MhiU9eVzKaYF21HO+6Vht9h0oCfuLD3rO7h2qyGZq4WgkwL8JzFp+41lx0xbbWAZpjobB2wSVWZp85EZrZ6b5Kh1hhDW6CnKSrVg5+MWvgHirtG42GV+TAWUU9rO93Ncn4Torbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn5OfTdMtMQMGlKkSRIaWerEI8y0XVnBuW5ZQDzKdNo=;
 b=L6oMeJUUfuUniR7hTdOMgYEJ1ckgsJKNgaVxaTlaYXgqTuTdLS0MCUesrBDDxTbnrDsGe9bS7yNLiu9SzGXZgyas1r8s8k/ZCIKCG8s4qCMs0ZzWn2lS6DXQu+nuNM5AkpHUvvM8ITYMr7zypG07zdXA2kUXYVqT53M2XP+UKx7pZeqaFcjzaoz5VclkO/GGDsVEiYvFjTwUYyim6Ga4XTcaw/ILKiN9chUqaHzjAqYb+/iMNBr5hf9Qr0vQ8QGeykz+jVGUAZKs15gXzndUeglCN2unBi8OrNYO54QJ7JY3oc5RjlX5wLuw8Lmj1YfZeO9NLqsl0IwVyv3wsQ96/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn5OfTdMtMQMGlKkSRIaWerEI8y0XVnBuW5ZQDzKdNo=;
 b=ZRk8uGMo4PdePwNswH6p4UBq8+BfMF2z1IZBzSpw6+B7nMhxVmegHMNVJn6vpxwdiROyee0FnCFqYAr4HfOkfx8riaLO800HBy5GSBOicGwQL68Jw+oBp8lqbghKSGKe6DJIhNCsrXrYyvQwsjD4/QZM2E9dASVvOkFrRrPVBE4=
Received: from SI2PR02CA0040.apcprd02.prod.outlook.com (2603:1096:4:196::6) by
 SEYPR02MB5509.apcprd02.prod.outlook.com (2603:1096:101:3e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.28; Tue, 25 Jun 2024 09:26:03 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:196:cafe::e) by SI2PR02CA0040.outlook.office365.com
 (2603:1096:4:196::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 09:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 09:26:02 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 17:26:02 +0800
Date: Tue, 25 Jun 2024 17:26:01 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Baoquan He <bhe@redhat.com>, Nick Bowler <nbowler@draconx.ca>,
	<linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, <linux-mm@kvack.org>,
	<sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <20240625092601.uo7266gp5joluyg5@oppo.com>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
 <20240621111545.awvgrap2nscgehxv@oppo.com>
 <ZnlkIy4XuzGBKinQ@pc636>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnlkIy4XuzGBKinQ@pc636>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEYPR02MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: 8910929c-80ac-4a12-e3ab-08dc94f8d52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S5gLv4t29S/h6LGpJ1YDFkcIZcIHbCKUxOYKOlVQ2TQsEhdTYx81spJTZcqp?=
 =?us-ascii?Q?jHMJERHDk0o4cMycBzAnngILrJ8i8crFzPnkfM7Xo1GOQhhcTp4GllB5JUXD?=
 =?us-ascii?Q?vLYgxK/Pb2fNCMTE1SHpsTKk+xrrV1owbCeovvwyC9EDsPfgKoZ+/M1GKuWM?=
 =?us-ascii?Q?G6pPhn5n6JjaiGy866TN6H0KN0+BTplIiOBJYpsjSIyNIGmT5uARhO61vcGs?=
 =?us-ascii?Q?ZtW0VGJJkzReeY+O9CAFMFfzushdUIZQPyZW7QOKRMF2ted1aKyIE9pLS/m4?=
 =?us-ascii?Q?TMbpudD2RqtjCzb6OUWkjp5vAez7LHN3Z7xodEvPSKDDDF1Q1eQi+M0Fp4hS?=
 =?us-ascii?Q?jIni++6e/YTmRCB5S4gPVn0yLAW4EGl6IO/Ha2R2njf8NCoG+AO18MI97F5o?=
 =?us-ascii?Q?A1cVFFbCR1OYJosIP5WA5MBvoF0EzdMZ8RKOR3tu4bko+I/pyoaohJJbS616?=
 =?us-ascii?Q?pdo5Y0YxxlboRSzel5pgyjfGpaeD4jnOUEKHW5dESUMYkiEeERznbATVFZAm?=
 =?us-ascii?Q?rIoi33hEyo8GyN2kbUwtDy+oxqubt3GFsk9A0O+jM0D0xczHUvdT/EmaLFVK?=
 =?us-ascii?Q?vWVpjvI23K0QpAzGzv+PVuTkn6t2lPAYCPo9knaeR8j5i7MMfT7teWcHbJDp?=
 =?us-ascii?Q?wsIDP//bx6dd2lfHcEhRH8kt1hxMVKrnK6ZhyRzWD4RC7eRpCmbEU8tYfL+l?=
 =?us-ascii?Q?zsfiGXb6cuN7fjyT6UUstkKO5OCU7QMHjA9gKclsFN2CPDRBVRWOU+QGrK/v?=
 =?us-ascii?Q?+Rlhu4+89fWkZosVwFgl2zV6PDJDObUH1VQqUx2/seqvj+ugzXkm28RC8GIa?=
 =?us-ascii?Q?pYi7Wg3VgcZDFnWJaaBni8ZlhjS3lAih8gAxaDFbVzbYOV+ceYD0SzqEoMAa?=
 =?us-ascii?Q?51pwi/SWYgEQdQHa/MiNPnblLbahzl5Cnmhey0L2mnx7rmVvM81OpRJc9HhF?=
 =?us-ascii?Q?PMM2swqZ0ogTKk1C52EtBZ8szyRXa9gzywIbADEW0N73Q11dQiWX5c2eOyrg?=
 =?us-ascii?Q?JWlox4eblk/CddEZ9w7hG+x+QPNw1p1lM/dbm0crhWND0Xgsq+5k+2Yo7Wgj?=
 =?us-ascii?Q?QNC5TlVEIPf84w9UQwGASG2nshBFlJZNK6ErFvdurD2zMcSsk96TSGJ0HFkU?=
 =?us-ascii?Q?8SljcKzUnLH8Gx4KCIDX8CihdQuENmsx2Sf3eIRtlFasMzGnmQefxIo5EIZX?=
 =?us-ascii?Q?+9zkC5mO1k6HU5a/asStMXPZR46prDCAj1J5E146Ep2Ulk0fKP33FeWi6wZb?=
 =?us-ascii?Q?SsYS6a/nIPRk4CNo9+V2wffp4r7qIiW9CUZ5ZoBT33J403v3FPhhfjpHPdoX?=
 =?us-ascii?Q?kNypBvRhvkRL0CExshDUxY2XFZnAeWNUzDql5nzuvelxl1rUkZiPDkW5FGNx?=
 =?us-ascii?Q?NOH23Q9DPB0GdVAG9MkvWzQ9TU5ICAUswjPc5G1liopSfxCiOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 09:26:02.8316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8910929c-80ac-4a12-e3ab-08dc94f8d52f
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5509

On Mon, 24. Jun 14:18, Uladzislau Rezki wrote:
> >
> > IMO, I thought we can fix this by following.
> > It doesn't initialize unused variables and utilize the percpu xarray. If I said
> > anything wrong, please do let me know. I can learn a lot from you all :).
> >
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 11fe5ea208aa..f9f981674b2d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -4480,17 +4480,21 @@ void __init vmalloc_init(void)
> >          */
> >         vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> >
> > -       for_each_possible_cpu(i) {
> > +       for (i = 0; i < nr_cpu_ids; i++) {
> >                 struct vmap_block_queue *vbq;
> >                 struct vfree_deferred *p;
> >
> >                 vbq = &per_cpu(vmap_block_queue, i);
> > +               xa_init(&vbq->vmap_blocks);
> > +
> > +               if (!cpu_possible(i))
> Why do you need such check?
IIUC, take this issue as example, cpumask is b101 and nr_cpu_id is
3, if i = 1, There is no need to initialize unused variables here;
initializing the xarray for the hash index is sufficient.
>
> Thanks!
>
> --
> Uladzislau Rezki

--
help you, help me,
Hailong.
