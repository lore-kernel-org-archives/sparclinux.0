Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022075.outbound.protection.outlook.com [52.101.77.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39695275AB;
	Wed, 14 Oct 2026 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984899; cv=fail; b=oQpSAZb6gkqEWwVT/dKrFeI2mcuJw7cXyA6EDWfWiC87b6ULoSvzI8EIFZoiHUidm62xh8HUB3eF22hmuXCtDQLhhrzBAYq34ZW6gpHVza7eY3V/Lp6iTRNeQ6jDt4nLmHjr/xtyvsSSQTrpOpgo7Z68WH330J99ddCbXb0aiWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984899; c=relaxed/simple;
	bh=P2QSki46LjmyRkjnKGR/HOjxuXg5VjQLoGf8TuZA5bM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BpqRw0nNU8vC3LWZlGqYpNrsfOrhFd+0XiosH/UpLjOwbTpt3aj0dJIHspUuVOKxSrJSi4sTJ2dNBPmTUslgFcKB3uTsqYt7BC/xTKwNv5Un36u1JCcNI0Uxrw4XT3WeBO3jDa06V0jZrfhuI9/F12zHbvFf28WxxtO48qBVlJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=NZBseKHu; arc=fail smtp.client-ip=52.101.77.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="NZBseKHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8Mmugxo/vB6ItOtZC54hPopZbfHidZhIDK+0VSphbFwSXMx844pAkC7xgVloh1DwawhQO7NdfKR+/lrGNTvh3jw2cd83xtp9MhYT9BibiOc2eDXjD9WwWkBR0eXzV399TQSQrdcB9eimzU2FmzyEJLLvtvYJjpLiznPH68IobXUP5N3+p6WsdboEwwrJ9ninVICyNK14hzksvILmCjvrOP/eJktoUfubW5o0wFRtLduY3F3cof07EHgrQAT9Tss1JM9Rd3m3K48b6Dp4BMvzLJpEgJd2toIPxKfSNwecmTrFkp9w6rk2Lwl+5aLZ7Ftaj/NiTSY29+QVIJtJRH34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IeQSd4355cED/fQa6Y5W2XHjkCHm1D9jP1tUI5iL8w=;
 b=T9LA0qzxB136Df4McnrAyGTeX9jR+l606r6N0VhoGXKvhqNmRSewu6NVH5iqANm2Az6N6g2gthSEMS5dEBqgM96paRSOgqmMHo9MFVpoI7LBpj+IlCDvr30Pzx3dGUz/KhNzQNRQCmUifO4mevwmDrviXdRF68U9NIV+gH9ZrCdokQs9MIZQmj6G+vIGODT9ErKeAW5Z/mjhlY9qI8bEHs1871TvVUGQILo+3vgdfGSJFBTmMAHqTVnNGZenlClzJ/wYer0lcvzqsnZGtWBXRrG9LBk5nQrdLUeyAMaCnZZZAQw2jZ6/zJwVV640u59ZvvKuDgG2PJSV5z/83oPAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IeQSd4355cED/fQa6Y5W2XHjkCHm1D9jP1tUI5iL8w=;
 b=NZBseKHuMjmXshDSJH6p0zQzzyTY/hjFxYoM+QydTEETMq8Imgk27i+ypvkRuoi6W9sDNONgx2JUjMMlWt2NFBUCxfry3wW95038hSV+B1UYwvLrghYDthWboB2sbNnQv5elWtr+Tr10XGzkCxdhstHUSoEJi0cLPi6LPi8JoNNtHFsNP4lsOBlnj9fNE3vNuoye7BBlr+keFQEcSIkMaVdy47k0dPQAL+HQV0f/dMeZYTfQlPyaZN7RLvqnzBO81dhxYDOz7rYcgSnXz/VnaJL2DyCodXEfqAmgEjg87KUb+e/ESNvAKh3OcEw78YFJWVw24gHJqbFLPz7CLa9wDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::17) by
 GVZP280MB0588.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:49::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 13:34:41 +0000
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192]) by MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 13:34:40 +0000
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: [PATCH] sparc32: Fix pgd lookup in vmalloc fault handling
Date: Wed, 14 Oct 2026 15:34:31 +0200
Message-Id: <20261014133431.8003-1-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0001A334.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::699) To MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2::17)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB1058:EE_|GVZP280MB0588:EE_
X-MS-Office365-Filtering-Correlation-Id: acdc2029-6246-48b2-2090-08df29f7e64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|52116014|366016|10067099003|18002099003|11063799006|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	VWI1q+t5fIi18XTiDHEycNoWjtExgRP8tSgIhJO1jSf+ZqfrP0xn1IjE5iPZY4t4fLIE5n6Ocso9jqxn2+yAagd6s3Hf3xow1OHg8tuF1nW5zgiy2ZElgg8Y+yLgXEKnuhhMAhUZRWZCQdmOOUkxeR5+Crj0m4hsbIWvP4l4giQywb/7lCDhF0YhOhWoKw0Qj+xcNRHS811t7691/q8k+5WOhtVQrvYqP1H+7Qp2jtL45BeLLsYVwm6tKI3T7XQIMTNX/XUi1eL7Sj7nNa1N93RMhNb4j0oVNzTGdH6M0XOYIhFfaUmMj2sS0+zfyxfdRSpIUEkp9XljKjdgQoE616v6mh3bQt2AzhpN8MUqWhf252R2As9AcVq7hAQG2BLJNyKJrM66kYac8p8Sq27RkCHzEYmvgV0TGlDRGaJKft3RyCqBMh65RLe9OVweyhuMW44LDkGgd8pVdQItFL5l0fy7o93KaxMucZITzxJ9ujUaBpXbn/JeX7Q66oYJrGG4P4GMy8j6UbWQk/9VPH3dL0syZw914jjPywQx2mryKcCsVt29YUmOZV8fNdXMNgclxD+8s/1vmCUFuNOHJp/cQdVnDI2EzmSFbvVFKPLRUVVd5npyhceCJmNynu8KHI1NeqnH7eFV00ZupFLbrDC/jAMoXR+0E0pZk7Gzw+WFc2wGOmSJNYHCqF9qI/T7S76JEToDFqn9QuBSoIlQ9HM1Ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(52116014)(366016)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RJ7KtL9Do4rHuxhax0D1rBJRfSKRmk8EvwiXTceazoJgjUfP5IOnzAn0LcZ8?=
 =?us-ascii?Q?Vh/xyV2py6ucJDavoO31Ok/lzVHRglRcWWr72e7X5vClCLxFxEuL47MlGYdH?=
 =?us-ascii?Q?wAq6j71kVM30jET2kkDkMifUXW2EsYSPlnNi8bitXKb/7S1o2pIcxc/ZHOfu?=
 =?us-ascii?Q?VVo9vrgpjuRMwJ4+vgABtKln0VbDFacL7kOZmPXoVxhqzsGkW+L2lRkbAVS7?=
 =?us-ascii?Q?KyntKmTKdX2zoWtOBVAXUwKrg95o+LKEVSrlOURQMIkotpDmgiSyVgq/TP4m?=
 =?us-ascii?Q?bzPWBI/M54jTmI4T+DeaMc1XIUvat2ZsVQfLuRop2r7ec4XT2Yy7zNsrjfPd?=
 =?us-ascii?Q?QSjPt3iIFj4DoDacWsLC5DDgHBDDWffbpG322rmWKYncZBqa6oU/P/1YWRGd?=
 =?us-ascii?Q?OGv2YLJle5rBUzdhw5WMkEB13e/dmt1MnKl6fBtlsDgAppy9nZM3KeJqsiYI?=
 =?us-ascii?Q?Cs1gm9ri/XpFGiUkT6LHhH7NhujEwXGQMMJaI1jsKuXFQa1tEjN/T/QMqq3e?=
 =?us-ascii?Q?WLseKQx0eRsnNb26MJX2qWWt4JMrFjCpLBtk9i6o9p9u0pBEW6pmAfrFTliD?=
 =?us-ascii?Q?QLSmBh5W+fEn1wV2ltWfY7IKYg5TpUw+6eFeDDa7vDkReMynjdruDDUOCurF?=
 =?us-ascii?Q?im6h74pup7H/GqRuUT4Z7IjJnOVjdS1Fc5z2ifb5cU2NbQSX3PuqW9LBYiNu?=
 =?us-ascii?Q?S4tdzV1/QMOARn+kWyv0gT9KW6TqPi75ZXPF/3EIMxZyqhyvqtfqc9axqoqv?=
 =?us-ascii?Q?3D7pbEhRFfb8KlzN3XGPZK3jyUQW1Y8V5lLd1U8EZfKthB2mosyhl3JKUwdL?=
 =?us-ascii?Q?2elzS6x3d+o9/i3niE0R+N3w3e25bKjQdHDRi8gdemx90yyhwPNAyBqw16zv?=
 =?us-ascii?Q?M9iYpMfeInX7CwGPZnzYgw8fX2WyHNxWIvkBuL7zBd+u+E1WBRsHxgkQNRLD?=
 =?us-ascii?Q?Gj4juvcYlwuJS4PLND1RikSMnKyY3TztsrUwg2P8g4ksrENxkYuX1SsXHLuV?=
 =?us-ascii?Q?Ahvno35/jZrI4vLl4JftEAp8gx01iTQ24zeOJGldt7pEdQDPKs4TN1beBwVi?=
 =?us-ascii?Q?LM/G+6NdTyllZoGcWkhQYtvhQI4KzW5wT+9fQ4X5R/YbHn8gs7CVS8/QkYAp?=
 =?us-ascii?Q?a/FNYe6YNQiwUJSKRfTv0cOMUESQ3IOdeESvCZpE3iR7noPCa5hukGfH2Xur?=
 =?us-ascii?Q?6WSt6BGjcAKoljbgJ9+foHOjM0G698oqwGOS5EfpPqq+ash/tIF3Jd3mvxxc?=
 =?us-ascii?Q?IaRpe1FgbcIc5AoHzO9AivuDntUBoYgmmdfoixMTUqYIe+u4MooGIpisB6jO?=
 =?us-ascii?Q?7Zw5LHC9Y/lYyY/vQTg8iarhNvfbZ7LIMizwUTfFYnzi/WBuxu4VdxAosIfd?=
 =?us-ascii?Q?PWcq42r7YyiIXD5F3f/aQiuCUwtgWcxMbBxeX2cwoVrr4HDFCvfjjn+qljkp?=
 =?us-ascii?Q?2U3kGFdy67DPf0irjn4FzDP0MEyCfsHCvDN4zzkcXnNGJMmdmbNbjGkaDs37?=
 =?us-ascii?Q?6MeSoLrM+ijPNyllOEnNBJlFKg/PGlZWPZsgOgIbmFVbKMtm3iWzoxnHGfHV?=
 =?us-ascii?Q?4WkJOxObx0SarDegscoS6oEmVfQv7qNnZBLN+P4flPe1ULZvBJ5F9QD4hiX4?=
 =?us-ascii?Q?IsdKSta2tPREjhlig+x8ck3Xz1zWy/cJFvyOsSPq4a+XtU4JC+Jmady9+ISd?=
 =?us-ascii?Q?IGFcDNeNP8beACghq54OeFpnftTDjYTrlYgnOL1enrapHiGi28bg52M2VPQW?=
 =?us-ascii?Q?/cKWcR0JRPAeHuDUhlhxRmplvpCDJjU=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdc2029-6246-48b2-2090-08df29f7e64e
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:34:40.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH9vYLjBJ21a0Pa0QwdFsmvrFta5Un3rdMFQgGHx13GT2ZdK/UwTods+YXOt7oxGfBebHe2sW2MYFv+1X84M41+BNKn7VHH4TzrxYsMULEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB0588

Check and synchronize the level-1 entry with the PUD accessors instead
of the PGD ones. SPARC32 folds the P4D and PUD levels into the PGD and
pgd_present() always returns 1. The PGD accessors therefore skipped the
synchronization and the handler dereferenced a PMD pointer derived from
the missing entry (seen in this kernel panic running v5.10.194):

  Unable to handle kernel paging request at virtual address ff780000
  PC: <do_sparc_fault+0x20c/0x3c8>
  Caller[f0007ed4]: srmmu_fault+0x60/0x70

  do_sparc_fault+0x20c/0x3c8:
    pmd_present at arch/sparc/include/asm/pgtable_32.h:193
    (inlined by) do_sparc_fault at arch/sparc/mm/fault_32.c:358

Fixes: 7235db268a27 ("sparc32: use pgtable-nopud instead of 4level-fixup")
Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 arch/sparc/mm/fault_32.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 86a831ebd8c8..f9befdbb3e72 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -276,21 +276,21 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 		pmd_t *pmd, *pmd_k;
 
 		pgd = tsk->active_mm->pgd + offset;
+		p4d = p4d_offset(pgd, address);
+		pud = pud_offset(p4d, address);
+
 		pgd_k = init_mm.pgd + offset;
+		p4d_k = p4d_offset(pgd_k, address);
+		pud_k = pud_offset(p4d_k, address);
 
-		if (!pgd_present(*pgd)) {
-			if (!pgd_present(*pgd_k))
+		if (!pud_present(*pud)) {
+			if (!pud_present(*pud_k))
 				goto bad_area_nosemaphore;
-			pgd_val(*pgd) = pgd_val(*pgd_k);
+			pud_val(*pud) = pud_val(*pud_k);
 			return;
 		}
 
-		p4d = p4d_offset(pgd, address);
-		pud = pud_offset(p4d, address);
 		pmd = pmd_offset(pud, address);
-
-		p4d_k = p4d_offset(pgd_k, address);
-		pud_k = pud_offset(p4d_k, address);
 		pmd_k = pmd_offset(pud_k, address);
 
 		if (pmd_present(*pmd) || !pmd_present(*pmd_k))

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.35.3

