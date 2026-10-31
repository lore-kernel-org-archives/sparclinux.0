Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793446417;
	b=tm+fXM3MXo8lqa/kQf/1iE4vOQ5gQZVWQxh/PibgIpGjJgluW2jm1Us4vT+ecQvhDQWq
	 K3JBAG4306F5nKvkMnLR03O+3n2lSmidw1xK5NoMs5FhdD4UuwgXSUO9ecfNCdwAPq0Dz
	 ey0QRS97rKhpvnU7LuYoGc9Ye2wl77t4qsH53oL9E7JK57nc2xrMWvWzJKUtLU5true9y
	 PySfuYn7oF6CilzNlmzK93EgcsbAFfeLQJZPMz2AWW6jVJAkfZZpTKb5rp2vpePtZV+M9
	 tGRC6rvp+LxF78exaa2QXza/O7hPwAl1uXqdCGY49H0vn64o/AyjCvZGbvs7WtAeO+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446417;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cQ046sDmcG1EvOKYG0oOd8ertQ2Dya5aryHmbRAgqBA=;
	b=nzry+s+Cm36lqZ2AEi0XXX8AZcp0RuAKn5onGNbtD34SbOIeBo8T4pFaAfjT3/rkatSZ
	 YUsr4IeKztnOi4agdOgYJI8Zwyh2qsZCQ8fUsGDB/kbGwnxXuyKBENkoldskZcA1woTZL
	 nUTkMVSH22LwyquCpTvIlqjPB9/zaWnyj4gv9GRJeWLqNVJHrIYDiwDaMCqwoUwuixlAm
	 Raa5Ai4P3RExb/W2ZaeK2yTxbts2OUQCF75YIPPYF0nxcAQcshjS9FmvRna9QuXPGrvBR
	 CfGB71BkrHnx34I78tPH3yFcUcf2HBd+81QXU5CeZX4dXksPjBE3KpdMyD2Ce4jYI/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gcore.com;
	spf=pass smtp.mailfrom=gcore.com;
	dkim=pass header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=jyjCJ+yb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.140
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023140.outbound.protection.outlook.com [52.101.72.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A60606A339;
	Sat, 31 Oct 2026 11:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25A60606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gcore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gcore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=jyjCJ+yb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+Jh2AXyFoP09hk9Qb7GcbOP5xTzg19B5TOMUCC+ICN7mw/RP5hLroxu2sstcy6/0TVLWlVIJ4RuZrLp45QBcqu2+R89ypUGshYk1mn1rp9EUD2HZl4Hj9UmJNsEVgzzD9FInp7cbo4nTpr0sL4OPPjrMwzeD5Z/9eAynsbBlz7IyRxhD1sHBQiwbnD8rdYsyaLQSCyi27fKaTBgIaYmQgUqX6EYTmW8kUR/f3t68brQjWB5Np4mi7316Dx9GfVXu0IpE1vXId0ujeMmWHY+mzwCzDhr7adp/s60CApH3xwaPSqgSvTDWDuccXmmUShaYEU+Rbsrvmw91L5LvfvpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ046sDmcG1EvOKYG0oOd8ertQ2Dya5aryHmbRAgqBA=;
 b=LPHPfgpigSM4XJzvvX55Vk49t6VV0iAnJwM7e1NbMFblQjgWUIrsG88LUhPFYD88a3aZFKbi/q36CmMwyLx/cQWrDgJkh5Yxxz/UXhs8qTxw7M9Qv3d5XcJQIP911635b7UgeCmqUGTsBsEfo+2VYmPhTZxV5Xb4TS9+1XZzN+FMIRds3s3dIZk+znWoGaZPQThhW7vS8QkZ4P+tqxoqOpwTwVGv+s7COVpZu85uvdHHGfN0NYcIcvhfDux8uGDefX8mePX5QupGKPfyrgN3IIm+6U3X9uZJl0KjIzLbswmNzsFOssz+zNkYjsAYSQKGJMDQahF/k182lWrR0Qkv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gcore.com; dmarc=pass action=none header.from=gcore.com;
 dkim=pass header.d=gcore.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gcore.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ046sDmcG1EvOKYG0oOd8ertQ2Dya5aryHmbRAgqBA=;
 b=jyjCJ+yb6fvgz06+40dtnJF52u20Z2vnizokw5oMtrZpgfuCw6C9n6/FaVqGNMymm7/s7+fCiBTdB8OvqYA07RLjlMnfs5n6EAH2KnrXTtEL57ffS8ODOq6mLJF4qS21zSUzzqfMfnHtUV8BBKmZ554nsaTONLnWyKthnt06xWeGlwPuFCo3L46pEb4rpiys0oSxPsTO8o954rlLDlP04DJjff+3n9kPtwA7mzJdKifpcQF8chCKALKK3WGJ4JZ47fZRt4BmHQeFfZ4PtmaCzXy/lvxTRN/8C2pg7F3+NEscgAcdOky5byKR/kiY4w3LxC4RakYpC2F+l2je3EUp9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gcore.com;
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com (2603:10a6:800:203::5)
 by AS8PR02MB7016.eurprd02.prod.outlook.com (2603:10a6:20b:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 11:33:33 +0000
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19]) by VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19%3]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 11:33:33 +0000
From: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Halaney <andrew@amutable.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH net-next v1 2/2] Documentation: networking: document SO_NO_RFS
Date: Sat, 31 Oct 2026 11:33:30 +0000
Message-ID: <20261031113330.45704-3-vitaly.zuevsky@gcore.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031113330.45704-1-vitaly.zuevsky@gcore.com>
References: <20261031113330.45704-1-vitaly.zuevsky@gcore.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To VI0PR02MB10572.eurprd02.prod.outlook.com
 (2603:10a6:800:203::5)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10572:EE_|AS8PR02MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f814ee1-a1e1-4429-e530-08df3742cb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10070799003|11063799006|56012099006|261009223027099003|261026121527099003|261021121427099003|261021135927099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DqEZcQIkNbWW9nUBJDMjVTvT0H8fE3aJLR/kVJOEvlWzrTUVmTfED7fkcVFp1G+9+eG1Soo9jw/tpmskOdQmYFJlBbR2Sd7GCBN4dOVRKC0DQkHLYsqM8dlbhHZ/HT3mt6i3jU6LwGhfk5mTo/n1rjdQnNyjCHy/vbUcDvagCnLIGUwE0JHzRQGkK7wP9NTqPd+ke+aL0V/G5oUi/P6AlL5mMM9d051Q/sHq32GZYy6f1IueGaSjAKkoQNojmuiMj9L15otxN7yM2hyzkBQ05MyBkchmDP+HW2tUdskSfz7DGlQ/J7wK6MjCNQidhOYwd7ZYHMLvm21u1XaGTw2RqFAjyJJAPmZOne8ooFY0cvnXVd505HPFUZmnBfeCTGfYQmcVTFwwZchiDOYNQZtej5GNz7scLeKfynJa1Ny/LO3dBcMcRBCNWa1OxpRYwpCPmAqCXegLZ5rIWgNnv1SoFLV/9LQxj849+XkTysqQs02GKDM1Y/JxNagzx+beMVAoElvHPorn2hmcgkXro2+KN9segxzz1GF/eBlti3j5bBB3Prny7Vut6juxCinCSmQ/Nywj0ll9AMtNib4A2hejc1Y1fTbeqB+K0ZUgtbp0xVO43ERleZ9Iqxve//PL3FODozAK27bb/4PO4q+Z2HANKp2MeCudohlgSpfwYxgcd7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10572.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10070799003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261021121427099003)(261021135927099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6DazMCwdmFaeBuXnRRm6WpUgkCPsvzxd9Ra30B8HGuAT8S+1JSi8BMXxfy3E?=
 =?us-ascii?Q?lIvC70qsCNfSufXvfAVUJ7D+zXEyBTF7B+KmsKaVp15G9aH3hM9S/B66lO09?=
 =?us-ascii?Q?0wxgTcqyh/nyB2DFxlWQUxzYYmPia4d6uFeVN1nBaoUUbk4s8Ky2hiYftrjw?=
 =?us-ascii?Q?QlD5TFiPk9Xd8bdeFiszw/nvVFpHSuAVcIZfML9ytJ3gwKRF6puFqzJAJGGg?=
 =?us-ascii?Q?bm20xG1bM+UzUx7tOcdqvu5xo1d7ft+Zqw+kqat5VXMn0ACvBEY/6VI6pX3/?=
 =?us-ascii?Q?J2/guE6QxxMlmopqPznSDrnEeBty2PucKedh/zpalIw9OM3R/YoZqxW7nO6Z?=
 =?us-ascii?Q?zbeIoeb5R8w78o8SzmnQvj2cSlr4V/6oIsODkCiwUg2UAxhvTMiAEF7kE9wN?=
 =?us-ascii?Q?uCJjYqunmjUHeMhdfmeBTpxGr0m3IxcgH/hHIB/C+ZHeBeJdpiwaGSxrowSu?=
 =?us-ascii?Q?yVUw0lxzPoQZkwnFMtHEswcRf/YkAZbrGysFp3Q19yuq9U8Svh1msIF7gCQ3?=
 =?us-ascii?Q?a6+qALPNqE+Qm31XcSMK1OQAWN56VHLQXxwqHVPrsePp2R7WajfE2DwssZ3B?=
 =?us-ascii?Q?t7JbfzfNfEbm3ySNH8FKyMb4UAbPBX4dt0qg+gX/Xb9v+Q/zn7kiZ/Mvnr04?=
 =?us-ascii?Q?9c09EYhMKqJHYsYDabmzHttw0w1b/eM/5V3QeZ2wElpZBIMaD8oXrlSRQpbO?=
 =?us-ascii?Q?FAvRmsoVL7eMkgys5qyur3In2zgDO4/GgLYdpCAAJwqjXoufhiyEB0eNUmuf?=
 =?us-ascii?Q?x05MKb97aGpagUtBWGn7r4lToH/zryqR1niAqevhswso1WUFWB2UU6qgCUsl?=
 =?us-ascii?Q?Di8kwgl2GzW6yuQq8bPZFpPUt99xnu/U77bUmF4CHaUYDJA3wRMmzdHdy4/Z?=
 =?us-ascii?Q?egAtfhmnl2f0p+BKecZuiDcNHBTmzUV5D4y00HVwfMaX+nchWw/jd5eOvr7Q?=
 =?us-ascii?Q?nI6rEboskKnMKeNlKjNdvxHzi+CcLAHAkmwBNTFPvPxCCFAacJzu/JLtjZ4K?=
 =?us-ascii?Q?QKg2LLvCBjxZew8Anj7ZhP0DNMqnaKxrTSKjiHUfuzP5sq1K65AHXykcDiFE?=
 =?us-ascii?Q?9xAyU4do3gsIH8fk8SrjkLjNeXXQpBtrS2EWrw9G2aq7SmquKQyvbdwEi59D?=
 =?us-ascii?Q?B/MbygtzkKR4102wmTtD3Vgy2x7LdjVCsRDi01X1Upwh4r/rFXh/3tB0kcC9?=
 =?us-ascii?Q?Wj0tiAA6pE67NlWcRbmplDTo6LWfZcKAz7+ho6ezdDKOIWGT8MfP64PUYImx?=
 =?us-ascii?Q?TGjZoLKB8btidhnGNaYCDLpFP1ApT+w2LapE14aL+VUgr4+j1gBxTfFwtPkG?=
 =?us-ascii?Q?79ayC+haj6qdaDD2iu1jZwn6FtBOPLFDGkKCmx8FdzIrv9Qxof/EBuOpTrnt?=
 =?us-ascii?Q?/GrrhsDGZuMsYESAIorEN7EJeahV8f/iN8ZjNCJ7cpEIlm1TIY6nyLLswsjL?=
 =?us-ascii?Q?0saVOxVsgwVHvufFZBB4SonKZB8/7ew5ZfmDSyMm13Pp13o4Dq6y3hdWEFUz?=
 =?us-ascii?Q?O6OekCfyvl4SuJoilclUMxka3zTfjrB8WaYQpVslbgVGBMTm8B9zibMEVACm?=
 =?us-ascii?Q?7R7xIa4GP+A3TUvfFvRJd4bXU73OECugsY9b+673/P1R/hFhpwKKgYUhg2Vm?=
 =?us-ascii?Q?PhA7yqROBCyg3nd7NHnUfv4cds65nxL98AHy1Z1CZJzcoUP48JEsRk4Y4e3i?=
 =?us-ascii?Q?Fe//dEgAfv2HqaXd+CQzQC4C1JvxKISsi9EWCD1UNT3pfl6OTXC0U8zxafY4?=
 =?us-ascii?Q?MlClezQxYYF7bql5/Abxuz3/zRAicLk2UCShWeNkvr/YWCSrG5nK8BtEREhr?=
X-MS-Exchange-AntiSpam-MessageData-1: IQh0m3SJGEay2w==
X-OriginatorOrg: gcore.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f814ee1-a1e1-4429-e530-08df3742cb9d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10572.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 11:33:33.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fc8b6b47-53ef-4529-aea4-8c6c20a851cf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfoHuKgTu4s5BTRuCegFu+tlBApyfVZCP/G8CxDI80lCD7q4c9Ap3rR0OxF63deGlCCF36bczSVamSjSX0YsRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7016

Describe the new per-socket opt-out next to the RFS configuration
knobs it complements.

Signed-off-by: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
---
 Documentation/networking/scaling.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 6c9836000a8d..54c7a72da563 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -428,6 +428,20 @@ queues. So for instance, if rps_sock_flow_entries is set to 131072 and there
 are 16 configured receive queues, rps_flow_cnt for each queue might be
 configured as 8192.
 
+Excluding individual sockets
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+RFS (and therefore accelerated RFS, see below) can be switched off for
+a single socket with the SO_NO_RFS socket option. Flows of such
+sockets are never recorded in rps_sock_flow_table and stay on the CPU
+selected by RSS or RPS. The setting is inherited by sockets returned
+from accept(), so applying it to a listening socket excludes all
+connections accepted from it while connections the same process
+initiates with connect() continue to be steered. This is useful when
+one host handles both a small set of long-lived flows that benefit
+from steering and a large churn of short-lived flows for which the
+cost of programming the NIC exceeds the benefit.
+
 
 Accelerated RFS
 ===============
-- 
2.34.1

