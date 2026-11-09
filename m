Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794188756;
	b=BX+bRGl5aaLpmeoYDDENsy75HrpZTD2IexZpZXriISSKSN6GyMukKNIB26mwIlOe/0EF
	 A52rZV8FkFDCdBp+R+W5Y1zpT+S3bKz7ZVnoujs2FeegEG/e+7r12VsJ/GU9tJu21U/WM
	 HSTg2k2OEE9w1hra3sxcAh0UowDgo3GNYegocOEY9JKl25yVYdaw1JDGMJBuRAgpEJy7Q
	 ZIu+yS7GevHu5iAc+5Z/ABq8xlokNzEok51RQICdzaatE0LQiZ1fqnS6ZFR/FX3qoXxjf
	 nHmrBZDVpZEXqmwFOpnqhmsoscxZ4rSkBPrhCUrKxil6b/bLG+Sy5PCRQR73WH254Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188756;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DxDbexeunk4p9w3ghQrVtaqlK8EK9vztDUm6bodTXaw=;
	b=OUv+r1elfXB0C2ihvSBD+CLglGmvILZqUcTVlDFlhR8hxsb1J7kIh2ogoTvAu7V8DQt9
	 uForwPOr4BQyeKBEfaXub5h4UyumZTslYa/oXni9N9mfdFA4ivHMTsJ6zcjRp4rL7Yjsk
	 JjVoov9S7LzMjfAtg2r106FGy06oAHGrW1eKZJsR3BVOSnOI8g/wycHKvfDabvMt67L0e
	 yLGvHf4zzeAB7pbQBrfN4l+2moFuav/VrAel6lSKKzl4nyXcukqwD2kH7owU3h4AdHACd
	 jeRB/VLcDSeG6tAQ0R3x9jYFvAb6Pil3Ya6/GeAklIXPJy6amoFDSHgaCbK6z+ckDbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gcore.com;
	spf=pass smtp.mailfrom=gcore.com;
	dkim=pass header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=QeO0xJsW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.139
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021139.outbound.protection.outlook.com [40.107.130.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041EC606A31C;
	Mon,  9 Nov 2026 01:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 041EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gcore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gcore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=QeO0xJsW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3sr3YtIDd++TDWVbpbE27jgfA4coMiIHV2yBhU4OeBCBz/MrVTL/JGPHHyiHycokhANQOU87/D0+5cOIZrWuFBFfCY1m9jYtyVsDJzuSKukHx3ArCsoIPJEVfiBk5CY51D5K34VFYtbaj4R4cp5bB5MVRZhOVEh3IZrFBj+LKbrRKLsaMdCsMTjxyyUkR3/hd+Fm9twExemdkrkQetDhzwiKIsn2F9bChpggFn7AU/ejk7uj6/QgfY/6U38gOH5iXxNJPQ1YkwefD7iz6qLEThfHy2n8eO8yHAEc1cdfN4xrfAsqw3+4DPemdDGxAAzeAyIlBlBgQwwn7sppm5SLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxDbexeunk4p9w3ghQrVtaqlK8EK9vztDUm6bodTXaw=;
 b=Q6HqQAT3vZNo+19MkOz/KR0waZUeBqEKFo2WBEe8ztxEKUlLOrIcbhrGtpmU4XRa447EEgeD7X294OZMfP+jKxkxI9qPjZYWB6JjenuI3obJnWGRGlNl624wq70y3YwUAlyWioMriZ+bm4tT2INBT7dTyJ/g3UqXugvpUo4/aGr7R3gGuKwrl9P3lY3JVO/HhQUkHrG8is8eiO17lJA6PmTZKcd0L5JbEtgDm6NrtCJqd2d/4KJl7bA6C2wG1bvH67BXlSd76fhYKKlti5xNJ0X/cA6GKAD+ZnOz38PdjVrgvHZJa/qIwNNHosWF/Bqz+nPHCRRqtp7z23H576ChQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gcore.com; dmarc=pass action=none header.from=gcore.com;
 dkim=pass header.d=gcore.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gcore.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxDbexeunk4p9w3ghQrVtaqlK8EK9vztDUm6bodTXaw=;
 b=QeO0xJsWVsKplw0OLmDxpwc67+VdiI4BBG3pqQ/xvriEXfzvzkQUhBm7JYs0VRGALeIikCVQcg+07cccYOXXRE2Y+/JgUOENg4Inw19pCeFE0MeFh7YkNHvYnq0lHIRCzoG1kBebFA/uqasr69myz/UK3zLihQXI8X4CL9NMiB4vMsJL4q/S3V+ZaHbPcCuXLvUTCxltYIdLqdclRBcps8FQOqTYRcMtfxV/N4gIv/7CT12WLifev6dm4phh5UW+JMSJNYAyn82ksWpJq0C38QSsmZZpo/0ZE0owBXR5jqJUPxt5CgEl3xqJ7IJC4Bmn8y0fUdy8FzhfQRghU9FU/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gcore.com;
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com (2603:10a6:800:203::5)
 by DBAPR02MB6215.eurprd02.prod.outlook.com (2603:10a6:10:195::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 01:45:51 +0000
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19]) by VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19%3]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 01:45:51 +0000
From: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net-next v2] net: add SO_BYPASS_RFS to exclude a socket from RFS and aRFS
Date: Sun,  8 Nov 2026 20:45:47 -0500
Message-ID: <20261109014547.81555-1-vitaly.zuevsky@gcore.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::14) To VI0PR02MB10572.eurprd02.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VI0PR02MB10572:EE_|DBAPR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 1247c564-4301-4eae-25a4-08df3e032fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|261102123227099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|5023799004|11063799006|56012099006|3023799007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qXehpADReHZ4C01S6b0xMzE1zc9n2BW4WXZtBXlzPAm9bY2FGnho/OqHbrxPXn7zY40msHj5A2rS5HNjzoXkBosA4LHg6aNNAY9YhdW4IgE5jEvHr4bBqoFkT/hqBsmQY4vm5K27ULIrr+CQy5cRC89seq744zrDepZdpDbqNNHPxxh2HB42V5cL66ej2mQkyJUZqDHXRiiOibAoYRuO2k5ill8OfX0rVbv0/bYflQWIsxq+LpiemdS8aNiIT8lq1+a+/tsED5PDflaLposRgLk0ICQWZ7gMliOUQtCLdcfU6J1vqNzyjSWsVihvKSvvRbvIYRxWai83TdWjqZw+yllRI3KtOgug7G+o68B5ueXifWxfGQRuqiikxVYAuIwLuGicOw+DvQQv/JPMM5pRM+9KTK/wZAPkaPT8/DBawj2pYhf5NZimRkq77hh6IUygSSMKXS8DII6p23/vAfiBBpDeMSKP8Mw8ygjX8DRaa4vZQ9ZsFQVBAQZckNlIICl/4b7WwfuuOwmjLQHCu3tGUl6kVtKZhqr4K/F2TjVAW0Yp63Un3aXDxPGew7rAoWldMb8fAH4LEqXPKW14tusDv09+UMVrhIjcd5vB1XAuBvB/X+pCRUrIRiKc/atAh37v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10572.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(261102123227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(5023799004)(11063799006)(56012099006)(3023799007)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3RH2jFoJJNITsYYmcyZbXQWoR3ZmdmDvGxhu2h1JoLizWLkukOTE7VZQ4KTF?=
 =?us-ascii?Q?rhl5dMn/jXEPSxnCzl/Hej8dB92SF0HfkZQ/AWBgN4La8+sb2+TIJv7Mut8K?=
 =?us-ascii?Q?VqPD6z/kJ/bonwMFWAxfkFr2FnwsQBNyzqjnraTpmtOYvUr0/7pD/68FN2CI?=
 =?us-ascii?Q?yNT9OOt4oJFdiZKmPA1WXJb1Ok4lmUn+nJzNvKzxnli4iDVSJy0uZFLeR6bz?=
 =?us-ascii?Q?zrGfsfyNultuUfWkUIfw/wPhXwXP5ccGlL42S55nPgp9szBpDCRGjXfX/yeW?=
 =?us-ascii?Q?Av2B6oi/2LXwlI+HNzRFe/w2xg7MLRERReufUSwMkgcvlQx7VG3xae8IQLYP?=
 =?us-ascii?Q?9BoJPB8bUuH+Ncpf+boLXk3iePPZYiJobEeqhuK6u4eqOGx9axkScilk0HcI?=
 =?us-ascii?Q?742Ag3cGlqzIZpDWZBqFFyjfwbPZ/ETi/jI/QJfgHK6B/9e11bcMbobCebJ7?=
 =?us-ascii?Q?CrNOhxOtBpSWGTzqyqG3OXPh68Dif93zHIsKmBiJeLdt/1sSLlWvZyWg1pOz?=
 =?us-ascii?Q?/lVIG6egvhD3mii0uCsbozg81leyhAElUhdnR45QdtSAvRtQ3PujOs6z2BsZ?=
 =?us-ascii?Q?l027doRgz+ONEZwYNQBo12wBf3xa4HYBsZVB5+egMKW7+M6OH3Nxku6y/CvS?=
 =?us-ascii?Q?4BMF9HkL30/jfFd7/mmdsMLfRd/6R6dDd/O8vi8mrMYw1IGNmB8PwkpgUoz8?=
 =?us-ascii?Q?HWOTpH48WGLl6BwF99bFNRNg+pAsxaOmNsrIVaTH7lReB0TvhSzB7qmAf44V?=
 =?us-ascii?Q?eHsb/5bUXdUnuHJ7hmtiyg9c4fq/AtGmsQoaQNMImDZaJgczBp8tEH7WDwp6?=
 =?us-ascii?Q?/C9vtPkvciNElIj2rFKhyJ+hA9OnNSfiB0FdeCnO3SRzVKtUNOOnHeQxTCRm?=
 =?us-ascii?Q?JmrtDwIHbwcoKV5O1q18iRxKDQIWB4sx5k9LI2iHa8k68fUdIenlRBBu1xLu?=
 =?us-ascii?Q?QY2sXt0RLj/TtkuQkjcmffsXD2D5z1/qBEC9HrTQ/76HFUCRxQAzL9ZT6RjJ?=
 =?us-ascii?Q?79BXrQGGiANoEM0x7ehDMylo/NsJVChte5J2RfxAHQ6csY+d80SHxuJaEcXF?=
 =?us-ascii?Q?1+5SFECD7vUdPStqqvpe4WaMIioVV94mrNcnjMCwPZEWcDmVjJxZjw0zNBNG?=
 =?us-ascii?Q?anp1KOq5lhuDEfwyz8Uytn19EpkyqjJLODmN2SGWRvm7pzW6tAALUy8Ym07Z?=
 =?us-ascii?Q?wV0nwXUpat/gmBooaMjrs9nczsxDe/XSbiVzY9fSRWRdmwziGCXXcClRx/o3?=
 =?us-ascii?Q?0+dVO5t7K2J0e8kuzaZcxKb9E+akqPafPCA5DFbtmN8X2B9AwvOPWGWl7zpy?=
 =?us-ascii?Q?XX9D0Oxh9mxfSQCA9y4CHDlUyrKGoct0SYHfDCBoqzaOng3yXo4L7UTRt3rp?=
 =?us-ascii?Q?ET9HutdMR2dWEgwB7yZCzcf2R79sx9vVdZPnanA+KA3lh2u8GBbAB3JJr396?=
 =?us-ascii?Q?RlzgG37FroIYt0XAo3cC1o2NN/J134ZQmkEG8SR8gxiaYlh8pe1SMJyxceuW?=
 =?us-ascii?Q?QdgCJYprmx15VjXnvYutxNpy2tM4bD+lRhba7YJAiDOr/Zc6Yuc3dC410FEu?=
 =?us-ascii?Q?N4fK8TfU677NYiaX6ZRuspT400rpQ6pdD1orq6vHWUAXKdItt35QfvcQ2pr4?=
 =?us-ascii?Q?EZeVOHir/ZoBobT35hGLMzyvy15MokuJL9LFANRs15d2nusfLsNA4s0o6951?=
 =?us-ascii?Q?cwFxWV3loM/1niA5Zq85p6KxzquZ1Bh4kbPtx0pk5h0CMKBMUNMqlnpngiA7?=
 =?us-ascii?Q?x/mk4OWbYA=3D=3D?=
X-OriginatorOrg: gcore.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1247c564-4301-4eae-25a4-08df3e032fb0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10572.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 01:45:51.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fc8b6b47-53ef-4529-aea4-8c6c20a851cf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE9GdC+rThoQDBW+UNOlhGDFkgTC4Y9jz8V4FQXucbbFHKhzBBqRUY7efD/Lp/yMpqiIBQADehS886DQ0Rc0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6215

RFS and accelerated RFS are enabled per host and per rx queue, but
whether steering helps is a property of the flow. A host that carries
a few long-lived flows which benefit from steering alongside a large
churn of short-lived flows which arrive on the right CPU already has
no way to express that today.

Add a boolean socket option, SO_BYPASS_RFS. While set,
sock_rps_record_flow() leaves the socket out of rps_sock_flow_table,
so get_rps_cpu() finds no match and neither software RFS nor
ndo_rx_flow_steer() acts on the flow; it stays on the CPU chosen by
RSS or RPS.

The bit lives in sock_common next to skc_state, in the space reclaimed
by commit 13df9cc6fc0b ("net: Shrink skc_reuse:4 to 2 bits."), so the
test shares the cache line the record path already reads and
sock_copy() carries it to accepted children: setting it on a listening
socket excludes every connection accepted from it, while sockets the
same process connects itself remain eligible.

Setting the option clears the socket's entry, so a flow recorded
earlier stops being steered with the next packet. Closing a bypassing
socket leaves the table alone: a close clears its slot without checking
who last wrote it, and a churn of bypassing sockets could evict
the hints of the steered flows.

Both tests sit behind the rfs_needed static branch, so hosts without
RFS pay nothing.

Signed-off-by: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
---
v2:
 - fold the documentation into this patch
 - rename SO_NO_RFS to SO_BYPASS_RFS (Kuniyuki Iwashima)
 - keep the state in a sock_common bit instead of sk_flags (Kuniyuki)
 - test it in the rps.h wrappers, next to rfs_is_needed()
 - clear the table entry when the option is set on a recorded socket
 - drop the comments and the unlikely()
 - guard the sockopt with CONFIG_RPS
v1: https://lore.kernel.org/netdev/20261031113330.45704-1-vitaly.zuevsky@gcore.com/

 Documentation/networking/scaling.rst  | 15 +++++++++++++++
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/net/rps.h                     |  4 ++--
 include/net/sock.h                    |  5 ++++-
 include/uapi/asm-generic/socket.h     |  2 ++
 net/core/sock.c                       | 15 +++++++++++++++
 9 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 6c9836000a8d..b23c87405622 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -428,6 +428,21 @@ queues. So for instance, if rps_sock_flow_entries is set to 131072 and there
 are 16 configured receive queues, rps_flow_cnt for each queue might be
 configured as 8192.
 
+Excluding individual sockets
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+RFS is configured per host and per queue, but whether it pays off
+depends on the traffic pattern. SO_BYPASS_RFS keeps a socket's flow
+out of rps_sock_flow_table, so neither RFS nor accelerated RFS acts on
+it: packets stay on the CPU chosen by RSS or RPS, and no filter is
+programmed into the NIC. The option is inherited through accept(), so
+a listening socket that sets it excludes every connection it accepts
+while the sockets the process connects itself remain steered. It may
+be set at any time; an entry already recorded is removed. This suits
+a host carrying a few long-lived flows worth steering alongside a
+churn of short-lived ones for which the cross-CPU enqueue, the wakeup
+and the filter update cost more than they save.
+
 
 Accelerated RFS
 ===============
diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 5d3524c26b2b..4df4e1c520fb 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -161,6 +161,8 @@
 
 #define SO_PEERPIDFD_THREAD    87
 
+#define SO_BYPASS_RFS          88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 245a43f52fb1..e1e9d34afdb3 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -172,6 +172,8 @@
 
 #define SO_PEERPIDFD_THREAD    87
 
+#define SO_BYPASS_RFS          88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index f23710e1c671..c38445422129 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -153,6 +153,8 @@
 
 #define SO_PEERPIDFD_THREAD	0x4055
 
+#define SO_BYPASS_RFS		0x4056
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index b35b25bdefc2..f0cf0a3d2916 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -154,6 +154,8 @@
 
 #define SO_PEERPIDFD_THREAD      0x0060
 
+#define SO_BYPASS_RFS            0x0061
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..7c62ae607d18 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -149,7 +149,7 @@ static inline void sock_rps_record_flow_hash(__u32 hash)
 static inline void sock_rps_record_flow(const struct sock *sk)
 {
 #ifdef CONFIG_RPS
-	if (!rfs_is_needed())
+	if (!rfs_is_needed() || sk->sk_bypass_rfs)
 		return;
 
 	_sock_rps_record_flow(sk);
@@ -159,7 +159,7 @@ static inline void sock_rps_record_flow(const struct sock *sk)
 static inline void sock_rps_delete_flow(const struct sock *sk)
 {
 #ifdef CONFIG_RPS
-	if (!rfs_is_needed())
+	if (!rfs_is_needed() || sk->sk_bypass_rfs)
 		return;
 
 	_sock_rps_delete_flow(sk);
diff --git a/include/net/sock.h b/include/net/sock.h
index 9bba1e793f1e..a52db61775d8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -124,6 +124,7 @@ typedef __u64 __bitwise __addrpair;
  *	@skc_ipv6only: socket is IPV6 only
  *	@skc_net_refcnt: socket is using net ref counting
  *	@skc_bypass_prot_mem: bypass the per-protocol memory accounting for skb
+ *	@skc_bypass_rfs: %SO_BYPASS_RFS setting
  *	@skc_unused: unused bits
  *	@skc_bound_dev_if: bound device index if != 0
  *	@skc_bind_node: bind hash linkage for various protocol lookup tables
@@ -182,7 +183,8 @@ struct sock_common {
 	unsigned char		skc_ipv6only:1;
 	unsigned char		skc_net_refcnt:1;
 	unsigned char		skc_bypass_prot_mem:1;
-	unsigned char		skc_unused:2;
+	unsigned char		skc_bypass_rfs:1;
+	unsigned char		skc_unused:1;
 	int			skc_bound_dev_if;
 	union {
 		struct hlist_node	skc_bind_node;
@@ -395,6 +397,7 @@ struct sock {
 #define sk_ipv6only		__sk_common.skc_ipv6only
 #define sk_net_refcnt		__sk_common.skc_net_refcnt
 #define sk_bypass_prot_mem	__sk_common.skc_bypass_prot_mem
+#define sk_bypass_rfs		__sk_common.skc_bypass_rfs
 #define sk_bound_dev_if		__sk_common.skc_bound_dev_if
 #define sk_bind_node		__sk_common.skc_bind_node
 #define sk_prot			__sk_common.skc_prot
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 56fed7ab27ab..6f6987cb8a53 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -156,6 +156,8 @@
 
 #define SO_PEERPIDFD_THREAD	87
 
+#define SO_BYPASS_RFS		88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index e2401d735c5a..00808217aebf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -144,6 +144,7 @@
 #include <trace/events/sock.h>
 
 #include <net/psp.h>
+#include <net/rps.h>
 #include <net/tcp.h>
 #include <net/busy_poll.h>
 #include <net/phonet/phonet.h>
@@ -1597,6 +1598,14 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		reuseport_update_incoming_cpu(sk, val);
 		break;
 
+#ifdef CONFIG_RPS
+	case SO_BYPASS_RFS:
+		if (valbool)
+			sock_rps_delete_flow(sk);
+		sk->sk_bypass_rfs = valbool;
+		break;
+#endif
+
 	case SO_CNX_ADVICE:
 		if (val == 1)
 			dst_negative_advice(sk);
@@ -2118,6 +2127,12 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = READ_ONCE(sk->sk_incoming_cpu);
 		break;
 
+#ifdef CONFIG_RPS
+	case SO_BYPASS_RFS:
+		v.val = sk->sk_bypass_rfs;
+		break;
+#endif
+
 	case SO_MEMINFO:
 	{
 		u32 meminfo[SK_MEMINFO_VARS];

base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.34.1

