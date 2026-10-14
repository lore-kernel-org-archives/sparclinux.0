Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021107.outbound.protection.outlook.com [52.101.76.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410A5218BC;
	Wed, 14 Oct 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984779; cv=fail; b=Ntd3oZRrahsCaz9NV3Mfy3duuMFRGwuxo/q6grx3glac/ykqzf9Y7HKHtptEjz6SRYYZmI+Bf4HH8lIExKBgvftFGtJ8xeiNjmP3MONjdm+t9SzTd9RoYm1hrua2mqiJhw/qcGbCQguaU5r2ouyLXd6RtqEVjLOQaBuezeGKE9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984779; c=relaxed/simple;
	bh=tyF81cCyvuqZVT0jTFp3iXTXR/HzJ4+oVu3uMu7VTg4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XsXApbZoYYknCTJlJXr0EP136SPfl0YKVV2Eq0LvSaSgTRpfqe+akj7hBUQ0uamv+bTHxOgfi/rit1LbqkTQ670xkGia5/Al4prkeg8ujhvW8hVyKZi2yDKPyYJU4GvENQLn/8NZQYY0cAbHyvO0ajzweFxNZfR11asuihjftOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Y1pljAny; arc=fail smtp.client-ip=52.101.76.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Y1pljAny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAxj3tZkng9kryrWRbVsl2Vb3jBgNo9s5xfi4VCkCs/M47r+jJctyRRVcy9rtN/J0JUsRbChqIMKqQQ8QQWsPObwfOY5vC+FlF2B3Utxz5dRoZ595M+IIlZmhHwkVDbqjP7vf16TehQyHdgFYFyuiLePJWVACQZTsYxHDTB9p8uWiNSqcQjEWHK3cerHEB0HjQb6SLs4D0mBW+Q8EWDzONG5xP25y/s7RPUIcLiIvdIAMvc/QUa+0MKCm8sr814aFtPPDzQslqmpXXwjM0w3ufv3Z9nYxyodN67t2KfIDmb6JEKI4+ZFnd1DuwwC/LgSndET0Kso1IMfzY4/ZbIjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCx9jqORBU4gKAvjs8Nqt+zaATW+o34ltuMxCVgBqWw=;
 b=eEfpzXfGys4CcSIV49bOkrEZ/QjPuBMWlYgM2O3riX7qtg68tY1OMZyZX6WTgANmY2yOFBUi+8hZhmp5pwHJ6PfWGE5Anm4sSPhLlucLG2/qYfDA0/7egbKzuwjnpwMqeyUW2Zu+QAHlShQS2TsyXMvA9W2+r0CCyWSuDCzIavaFYFHc37bsnPpFBAwX8MYulp1Dr5OjeNqJ3lGl28dKLHNiHQkNO/+uTFkuK2iz8d6i52GfgrcY5IU0uHgwCP0gYQjJLpNeay/qmofK0CJ0kedt8u2SZmBwNi3KV2JrOrDDBTtqyzCkF4s4yIYOTn3zT6M3vHowdHx9eORVvkbs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCx9jqORBU4gKAvjs8Nqt+zaATW+o34ltuMxCVgBqWw=;
 b=Y1pljAnyJEQalaDgQW+OjXomxzC/WrBJixHAtmK/L0Cy55HcgtWsONT0m1aVi0GNOvADUHv62Jm/QHTexNLhYBQUT7rNr5DqWG7D+zOZqOyNcVTgLRZ+q796Ybz84SdCDZn5sOtBBd4pGXCTFNqsyF+PWZeFJAVQhqsXQaW2r9kYpO90NeA+PDu+S2FNfJP2ZJOzuuv8ocsSzAXVW6OJaEN1dZFZydVGY1RkzxjbkepTzD3AtQKjXczZ9a1/de4uw+jgM1xlweXvCIo8ZH2rKUYhpSBHf5EQ2/bsFz/tPa2wlmkj2eaM9Jxyy7AyOiMpYT7K1AnZ1CSIrTuSgY9JcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::17) by
 GV3P280MB1794.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:241::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 13:32:42 +0000
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192]) by MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 13:32:42 +0000
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: [PATCH] sparc32: Avoid NULL pointer dereference in fault handler
Date: Wed, 14 Oct 2026 15:32:29 +0200
Message-Id: <20261014133229.7841-1-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::20) To MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2::17)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB1058:EE_|GV3P280MB1794:EE_
X-MS-Office365-Filtering-Correlation-Id: 00097ee1-3179-41f1-a60b-08df29f79f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|52116014|366016|10067099003|18002099003|11063799006|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	VxHFAY8oV+d3QCGiA/LrJXd3eo3qeE4WlYBsLFF0SZ58iCKan3GXNTcWqmUHP2oZMtvNbm6+yf1omZHfSopO9mvCgvBYIb5sWF7e6pbfVgqmYEngl9L0HsCVROEO7brMnG2SBgGdCCotjy3JdvyRiRgeSTwKel96wtEIA++fcKm03765EaXD5onGzaNALm9xyWvAwdX9QTif5+n9e4OcGgU5nli7x8kpgQsAMIK5YA/eKo2N6AGCtVXHYYIR4yzKnG5Cp1D0wndBBvEE1+Emz5psxye8wrNUTArQYGFRjCf9zGXk+533Z2OBK0Pf72tI3iyonWmKYZXNx7k00PGrgOm5V7fCTUW265WsIZiQ1To1Z3y+uc3qKxFwJhcmzciP5rohRqU7O1D/ByM+g+6cBkdeml9J+Lb9PeHVytFOrxu4ICEkyi8wpHFcmyG7vvC5K4vDbiTweqnmlfbo76Pr1YcWATyu4rvJSe6+lWv/LFrRZADeoqTsXgEvAofhSb/WIlQtvkSr9wN6QDBNdoQFJQFQmZY0hgJE0Zu4rP5Zmq0nGz5ZTlkhjUGgxflhB5kV+NuX9PkI4nGZtTLw+BCmycMAV5nFd+Y9CKnKbx8yWANhcPXWZ+SBcX/HabFINPNX2bCIgHCjb/DK2eINTwzaZxqUDOdp9lwZ4KA/PjAzG2RNLJF6Q/wjwvcVoW0YBIayiqB1YYNONrbVerkh4loYFMOrIrxJGjO0+QUGw/QeNr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(52116014)(366016)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0BqdhLO2UfI92UCk1fdnYc+c4/hMcmaP5FjckeIpyXn5sRvmxM4W7KzpvD4J?=
 =?us-ascii?Q?yO2PeGSJlVmt+ervpP/6j4DAwJT1kVPjYnjdU4HrX/Y7tvCfWunmCpuWQ6DO?=
 =?us-ascii?Q?s5ctBqUtGdGIIRZJjtZlet2t/BAYVMisIAWZ/bCwGCtNdaao6PCVAdLJpVGU?=
 =?us-ascii?Q?qMEQW3xys4N/v+LzpKbbq5B4VfqNQvi0d+FXAgi9KQHidIjOAAVc/i+EHSnX?=
 =?us-ascii?Q?+LZrsK2n/0Q4iCjmZ+fgNj3EY6lz2X/DyUFXoilk4Cc/KFgTcMCRf1HsgJco?=
 =?us-ascii?Q?9CcmTHWKvUSI3rEtqExNbJAuBzwadY9oLY57uEGBo26X9WpQnUbpC0bnQpdo?=
 =?us-ascii?Q?gSRzkYAbF2UqFjhf3dXBG11VS/Yx3RND2m6QIMGDhe8oXXnsNjpH8cZ3Mo8Z?=
 =?us-ascii?Q?WptS6TlRRVz1iB228QDEXQqlQAbmrsFK6ie7HyaVKz7HoxOKxcfxYvQBpnP5?=
 =?us-ascii?Q?8K+IhW8iCja4Ett+So09d8ZqxT4uHBp7e2Nz6yG1BxGklQp5bCeuhmu2mOO9?=
 =?us-ascii?Q?f+e9tk27xBGhLmuC3ebZr/GTpT/AlHrz6CcXwlPlRGurLY0AA2HfFtRKiNq0?=
 =?us-ascii?Q?knQ1dFWhVrY/H7XaPGGIYmR7mrFyhKkOFiNV6XAitfg/nNQaVaao9NRbmGKU?=
 =?us-ascii?Q?X6Q0KG8fj31ilA/VJdcMiPPsrEAp8PqUlxjWnD/YFxyhLIrRWQCfOeWfc99+?=
 =?us-ascii?Q?c/4AVYPBOJbg5AvM5LlnElRQLo+NuH3eruqjX+rONo/frsecEp1ILXLYEhd2?=
 =?us-ascii?Q?h04wX6F7cd7zRjHZH2ykOmti/6LdVckCvld4+OQbWPwEZEdQhVHQfNgp2pDy?=
 =?us-ascii?Q?ISjNiMtQSfJuKMUjkm4g9qQ79jVbqqJ/TDN6HlMwcBoprUOgzw2A7OlV0Qky?=
 =?us-ascii?Q?LSp+CF4VtN/JIzG6/i7RW3IhKxLJY7bPEFpP33Ayj8EGQIW574o1gUBJFjtW?=
 =?us-ascii?Q?mv61rYa+JzUKVlgxyXUQ2aMnyobBQVfznltYEqNR+SHyCG8Dbhno+R7G3CIJ?=
 =?us-ascii?Q?F/EoUzsaA+845pup07oNLMHP9ISIPfxmPG1v902cXz5UjCwX03Lt44BJbBaZ?=
 =?us-ascii?Q?VBCYUQoxsDI4kwqtjHsyXELxwPVVOsxpcQr8B7925eOZKXfHYNfc5Wk5QANs?=
 =?us-ascii?Q?6IrJXg56qsnfBp6z1ieJRqOxGAPFSK3TDduK8N4VDOC0c7lsTv8WUjm4EOl6?=
 =?us-ascii?Q?GVctvGxCCPD186w2PcQ4KN0nZEsIcXEEKzUyiPr7gfD2THQVDhGDWqW2r0Zv?=
 =?us-ascii?Q?TEnRFYtsdE2HgNKPtX07kYjJ6rv49H6whwV7+iYb9/Eyqm8ay+lFR9HaeukU?=
 =?us-ascii?Q?l+uLNdoNeBIsYd19XwmTX3LWiIB4XPYqbaB2uYmj6CWryX+Ou0mhg744KfdK?=
 =?us-ascii?Q?kGLGDmbkcfEULVLRshneGXsh6w85A7nuisnF+iX1j11/90srvjS0ZfC896QA?=
 =?us-ascii?Q?1u8MdKdatmQeUxaTWfDbBsr0O1TsvpDqyJaTAWjfly9d98ybi03nhPykfRVu?=
 =?us-ascii?Q?IXwB8KldhM1WuF8JJJ0MhsrjmtfkuAOc3ksmc0K92Yx4jOCa2fGYiemz8BNx?=
 =?us-ascii?Q?4g8aBOXjGc3bVytAc/gdLTQouJVO2lpfBa05IgNHAxxjybgnwaab+utj+LCP?=
 =?us-ascii?Q?D5x5Lp+42wtfT/3OR4QPoFJD8QhFdbv/TbycZiGQ7gIRfF+BXoOZN4UhwaHr?=
 =?us-ascii?Q?kTw08DxuWcW/JoZD6ntesE7mbjs5dmaHiKIXa7jtmH5r6FDqjYySVHWJhHcs?=
 =?us-ascii?Q?aQ777EusyyWF7KqPDTM6gpSvcVX1nkE=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00097ee1-3179-41f1-a60b-08df29f79f63
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:32:41.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asZ5BkebTvG8ey3pgMSEjhabTM5TG6B8iExn0c0wDVeuL8/ZWZR6OD8RpD6D3N9cD+OxDg9yAL45S3Ng6Gu0eoPMhLPwV/rXZTaGiDTNQHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB1794

Add a null pointer check for the return value of
search_exception_tables() to avoid dereferencing it if no entry is found.
Without this check, the system will crash silently without providing
any fault information to the user.

Fixes: b4edf06c8aaa ("sparc32: switch to generic extables")
Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 arch/sparc/mm/fault_32.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 86a831ebd8c8..4cfff3d36a99 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -232,15 +232,17 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 		const struct exception_table_entry *entry;
 
 		entry = search_exception_tables(regs->pc);
+		if (entry) {
 #ifdef DEBUG_EXCEPTIONS
-		printk("Exception: PC<%08lx> faddr<%08lx>\n",
-		       regs->pc, address);
-		printk("EX_TABLE: insn<%08lx> fixup<%08x>\n",
-			regs->pc, entry->fixup);
+			printk("Exception: PC<%08lx> faddr<%08lx>\n",
+			       regs->pc, address);
+			printk("EX_TABLE: insn<%08lx> fixup<%08x>\n",
+				regs->pc, entry->fixup);
 #endif
-		regs->pc = entry->fixup;
-		regs->npc = regs->pc + 4;
-		return;
+			regs->pc = entry->fixup;
+			regs->npc = regs->pc + 4;
+			return;
+		}
 	}
 
 	unhandled_fault(address, tsk, regs);

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.35.3

