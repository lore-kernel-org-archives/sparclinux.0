Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F72BE03D;
	Sat,  9 Aug 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750004; cv=fail; b=TVn5EV4b52W9ZWSes9vtWmMOx+oeANnzpGyS96bZqNayEAHvb7hVbOgFHkPYlKo3oNQjHUdRmg3rzaP7QIZsB7IXnAaUnKoT5Q9Oz7MF5UiZ3Xa9iF8TZDx0N0AG09zY6/apKD0IDDs79ah1cnK6zUWoPRuXjZmgbIGEj+jCQ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750004; c=relaxed/simple;
	bh=SMa/0IweLMm1dfpNahOs6ipOY7EYMWZSbTzQ4nxdZwQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oIz9x9lC3nkeYL+ZHc6uVFI3Sn8MEElbwjk7qZXD/1x15BgZ/O06zn5ICNcLu6k08BWF3/6dFaD2DHcwR+CMwBNAXHTz/KBjeXP3wrKV9as9ApiCQgT+tV4IdPQXIqMsEnDSayeZGkTTPIQZGx0VLRBbxdkkeMhtLRARzGq3c8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bsIWIuqo; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bsIWIuqo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bsty33c0zUfzAZLT5xUNzhOvvuoV58K5ttGnngmXj24eGCq6GfUKQ7x0bYOeRMX807hkPnPEnNP80oXhXEImZs4NFSnx/hnMCFjAZR246t9pd6KTjahCqQlbBoUuB2Y74Xe5TS2m7Ignn1Lz6J3mOLDZ1zLkID4potu7ya6mIv/cbeYyMlCRRlUazyqx3+8e6m7TA+GVteMTAZ7xUnKv9dZKVulQ4V8ni9Qyw9RzDj7Ql6i4r+F/ovu43nv4XXWsf84rKbBOGmNQGuGFFyNmFtwrm7MmcpeQgg1C7djOl611mKwO7mVEzAcl5VpoOP0y/dBn7Ghp4t1c0msy57B6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoeUEGFDoISBecn2dNs0YQ6yxlZog6AXlLOmvGuc9D0=;
 b=Al20TAyfcc6PSGiOY1q7eLQj85GToH7hsRR6M5RAnm77uuJ5wyrnwKTqkppkmA558xtNsTxIAd/fB1/ZgvlGZnyZPFjsfYdwaj043ZKtEM35g23IRq42zxejQrdH9Nkfs90lgGXsIIgv5LgAYkEikB2UwZnU/NqRtevWPKfzhk14EZzeUZlIBO8ZmDJZnon3bCEsHWhs/8XTJP3gWF5i1x7r92ADVPFakhJ6StuUzLvao3BzI69shFAEURL0S9DtihCz07qsTpLKzNU3W7hMOSbtnhtjSnm42nEnqn5hxq9A43/pP0SzK18qGllTJ25SHsyCQLJ5ldoz0cUnZsaxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoeUEGFDoISBecn2dNs0YQ6yxlZog6AXlLOmvGuc9D0=;
 b=bsIWIuqoEZLgERXuHkM4i+3NhjbQS6PmGjrHf5DbBfQ9gsK2r/dDMLXwamr9URyfHwBXfL/quMR4/sAjwyCsVNwafsYodfmj1i0GI3dKXOJlR4CeBEarYSeWCiJ+nCSD75XUjTcjLGes99SnNGdnyghGheRwwo8RfWXflb4GfLgTQyJ235hNRSObCoSPZxrRLHr7I/vof1QpqaNaLQy2tITRJ59vP7cb63TDCWuNTfhufCv+uDPzI8t2EBR0+MMcxj5G+zdyYRgVI2yWMgt8GGYeYqCTwjJ0ZINn2DWvlSvy2seOadEVvDsKsdNahB3zULpog5s/k5xUpmoIG9G1gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6135.apcprd06.prod.outlook.com (2603:1096:820:d3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.20; Sat, 9 Aug 2025 14:33:17 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 14:33:16 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64: Remove redundant __GFP_NOWARN
Date: Sat,  9 Aug 2025 22:33:01 +0800
Message-Id: <20250809143303.179922-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdaf9db-13c4-4d31-1255-08ddd751addb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RHPTgxwdQf9vjDeu9R6Pj6TQYTW7zTETpKpyQ0Q9mIYxc3/6S0TC6UQ+vxDS?=
 =?us-ascii?Q?/uMgTPlLpLlXtZBNCaMlju4vi50Lv8HDktqnH1xEjX5wlTuEALOVdJI9DulC?=
 =?us-ascii?Q?zhTkqLg8eofKcc6OIbSBbtTArWS/Rgm5SppZD0DEMkpiIjVBSHkojngrinLl?=
 =?us-ascii?Q?7xF4LBSt3WFEEaN3adMJZ56S6sPRb2iTZ8SdTufpPO4PWWnUAyWf43caQGcJ?=
 =?us-ascii?Q?o26jrnpc1fG45/pfyMwnnKl+RXnwLu2G25VGeZpMp7397NSJF3BnDIuFbVTv?=
 =?us-ascii?Q?z20eMHFRWZ6CSBTnYL2mPZtDtKwNV+zXCmGT4eM7zO5T7zC4E7Uu2ZEn7c4G?=
 =?us-ascii?Q?pQDIZj3zmZS9lLN6Lb4giXn+la8qNM/NESVWjC7QivG0qqWQeABvpWwVLcG/?=
 =?us-ascii?Q?fDK6HszMtkxuRQ90Hej+x3QG5nexYvXiOmJNQTY4TyN2SYSwX+ah1dEdSsRU?=
 =?us-ascii?Q?ayFzs8iBL2TE3pcKUhV/jCL067X0PgghDWTAxisJVYw/Aga+3z7O8O6VXUoc?=
 =?us-ascii?Q?nfR/ZebQwTwoB/fA6TT1BcNMaU5Cuzd1/KCrODpqme/qStdW8LsT6hldknKW?=
 =?us-ascii?Q?K5E+jW0URvzqZRc5iQGM6Bb44/zBB1rFd+nFWAQMORxEnFT971C7LgaXwYZ8?=
 =?us-ascii?Q?AoXqlTJZNQi+XURaWyVhpJUDKjLMs1Zpgo/hvfoJ0Eamj79lvDj0kKgkfonW?=
 =?us-ascii?Q?y8T5eMYELt70qV8170uGbenb+Xg0rMWXlNM18IURYLBrjVeiCFXG+tknE7oW?=
 =?us-ascii?Q?lYbm9jadG8BwrJEKQWkfUWY3rjMdy9qeCMbIZkp7Fk65Y9HxkJWzb/197X3u?=
 =?us-ascii?Q?EL2mB84lGjLlEA33evP+YVgI/SO1juiIg4pxH85w191Oy74Ca2m2XKR4BTqu?=
 =?us-ascii?Q?kEOx2xsftJoKEU7Ua9xo/At37Vt3d2QBZCzPIn4yXwlZ+o3Zd6+wIsEad+Wp?=
 =?us-ascii?Q?A2ZDclxNOW8SauYzUAxqUye7HqCRBLNf5zXUKSfcD6SD1B7ClGHs4N8cfg3e?=
 =?us-ascii?Q?2dPlhjfMZ+XmUzsZzBMRugOLSap0tnAfGExdQY44vkzAUEPQ+BEYEQb5VuUn?=
 =?us-ascii?Q?dxWlij4vRQMefgtfRlJryGvd5pSsdXncYlZFitV8qB9m7XXxrKiTZH+VFZs4?=
 =?us-ascii?Q?Y0hxiqlAbikzuhr+oDbV+ewmgF52bejU3+yjou+awv2X0nYli9ipEjcMlblA?=
 =?us-ascii?Q?/Em52Y6aahq+aeBxWkA6AifRzQWynCVw0rcmoZiFPx/zZS5jeOZj3TOPWoBC?=
 =?us-ascii?Q?4amMb0GSWQ4Lwpy6UD23fEDXXEPUTAO4azZpYGd4IsOKa/86Sk5XCAN9JhOV?=
 =?us-ascii?Q?q0SRvCuW/Spm1X7W2gWUdCcK84DKEhk2A0GjPfAR/nvmIDE5Py/7l/O8E74d?=
 =?us-ascii?Q?mWum1JFwFLzwH1lglMh0mzdaE1DS1ls1lQlod6ghx8QCnsc+/ZIUPY3mMkHi?=
 =?us-ascii?Q?BmosuUOfR6TOOUjDFEWmH1dEa8rPiXKYXDsHLqfc5I4PBJmm4U46jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EwvE1cnYaj26updqn/p9pTMTubD20a2JUppLF/xetPLHPMisnnuWOPsiA2hr?=
 =?us-ascii?Q?HzPKzwVfRheOYcuQrSbMnkrJqWshmcNljOWolNFEWycia5E8DitRjDM1QPs1?=
 =?us-ascii?Q?8Ieo0861U7bcO6I5mhDoKBPyosaZ9C9ovc6xw31M+26Ec/Es9gQB1L/biPfH?=
 =?us-ascii?Q?rXkIhxoZfxAyHwmjN6aAvDXNsQK/CEos2MJ5uuFwWlfRMv6cNXqO+D8vGz0w?=
 =?us-ascii?Q?eEr1P+4RPuZtnTcg6wNPkjeL7c7SDZXpicEIJOYviOLsfULKQLpnWUMu38Z9?=
 =?us-ascii?Q?xVtrdcG2GZzOeyAKyYQRlaQVxsA8jSMiDh+lqhOREsU2dTO2e3thZqENzFTB?=
 =?us-ascii?Q?n80ooz35JMBrXugPks7St07IHL7jvSKTZ+7QYZlEyZfMfPRvWlPqp440ZPqe?=
 =?us-ascii?Q?y90NUrPlUVQPtUcBnbcAoVzFy/LaIZxAYJG1vL9Me85H5xI7X8iQeY9izmNZ?=
 =?us-ascii?Q?K1Y8I6O9RjEtZmA0yIhGO+MzgjsoVK0uXiNTJWdk+jqditSRd6v4bXlcfYbq?=
 =?us-ascii?Q?i3YuPndzKN1cHhzHBHeXRVRh/d4VIZ9vyh33dSv4TUX0ucJYewpsOmYs1sl5?=
 =?us-ascii?Q?5Pmzk18V3ITVpVrJSyss27OhJNINFStlwVJE+YkiQdsd57gHzj4W4w2APt8X?=
 =?us-ascii?Q?OvK8qRjk4m51PtZLr3alQql5ScFgkjAXVnt87xJGyZd06NJ66z4ujB4e8TpK?=
 =?us-ascii?Q?dM2vNmsFEVsuAZuf1BOphf/e2RNkxjlMxBDVl2CnFo5fXv6e8+l5CyYWZ2US?=
 =?us-ascii?Q?4NGF44EJmABDbwk3MuhaJ9UGeF+/u+v8sVmHQodDFT2XR5nU0bOo6UPMUm0+?=
 =?us-ascii?Q?TjTFtd9YJzpfTlrsmMnlL47gBnLI87gU1rd4/DApdHIWazCTTtbpoZT+oEs7?=
 =?us-ascii?Q?V+P7xO8G9eWp/FIPuKVtlmjhjM2f8k7ZxM7vwHNBZrWG9zCkP9qdNSzVuk1c?=
 =?us-ascii?Q?RzithaQxKrRgTl/AyLQfwcyffn73mlOf9BQnoMTE1qUYHJwkyAgdqvyqHbqI?=
 =?us-ascii?Q?1ZLr9G5WqGEM6SqDSsHalPeIa8Dyi9n4BbqrWAnm/QH/sCSjlgOUebzeq5P9?=
 =?us-ascii?Q?y/RlX2RIxuiOfI3ED5pURho1clpgK5xwQ9WiHGkuRLNVqPN3DW+yUQNyv4fD?=
 =?us-ascii?Q?6HtHNiLud+8Z90oD+MRLgxNL7W1heTiNMlP8iqzJ2hcPihYq7PQpjz8E3pgP?=
 =?us-ascii?Q?E0kNDn+6tGiydM+Nol7g3JsvtBy9J2DQ0kFteShM6qqSMODIyzWA8dxSNNHb?=
 =?us-ascii?Q?GpfVdJpbyUBDZ9j6gAiQu+P6j+3FH1St20veafmFvIf7U/dq/4vKe2bSDvV0?=
 =?us-ascii?Q?OD3B67Vcapr68Q34JUCjc0YM0NSR5LP6+gioeGZNL2BCamRtYC9YpGiiz8Ee?=
 =?us-ascii?Q?0Cm6v3Ls1/HdUIZF0WHXa1IlqbuPyKS/EWk3xOowddqXJ6OJvNqnMIYNVvAE?=
 =?us-ascii?Q?2roU12OFBl65VvwUcWjDfQMbd7uZjpBjeVavM5GP1sojUkqoqDr8JVUVcc5h?=
 =?us-ascii?Q?hGVj0CJCNrby6ZdLgjfTJf2ddrIdWF3lURCfaSKmS8B18tixp+nvQKr2VjMu?=
 =?us-ascii?Q?XvERjTCyj3Uly/40BhgLVjfu/IRMdV2oFCCkIa4M?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdaf9db-13c4-4d31-1255-08ddd751addb
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 14:33:16.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeITPU7ce6yu6yM4jnw6KQl/fYH5n3Uu1evx5CsmAqblclgw2Qeo9fWvnucTuDdfG7Qp8vG5uw73jl5xb9wtQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6135

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
`GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 arch/sparc/kernel/adi_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/adi_64.c b/arch/sparc/kernel/adi_64.c
index e0e4fc527b24..18036a43cf56 100644
--- a/arch/sparc/kernel/adi_64.c
+++ b/arch/sparc/kernel/adi_64.c
@@ -202,7 +202,7 @@ static tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
 
 	} else {
 		size = sizeof(tag_storage_desc_t)*max_desc;
-		mm->context.tag_store = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
+		mm->context.tag_store = kzalloc(size, GFP_NOWAIT);
 		if (mm->context.tag_store == NULL) {
 			tag_desc = NULL;
 			goto out;
@@ -281,7 +281,7 @@ static tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
 		size = (size + (PAGE_SIZE-adi_blksize()))/PAGE_SIZE;
 		size = size * PAGE_SIZE;
 	}
-	tags = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
+	tags = kzalloc(size, GFP_NOWAIT);
 	if (tags == NULL) {
 		tag_desc->tag_users = 0;
 		tag_desc = NULL;
-- 
2.34.1

