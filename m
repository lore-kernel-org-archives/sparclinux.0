Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793446416;
	b=jV5LSnkhmiMjuFgS6wV+Q97DRwNJA44ub8uYh7pacDO2jm1NhTs8Sfq4m1dY2sIvR9Yb
	 obqzC4D+EEy0m5Mq7kD2Igb4qD8mFfsALqakms8N8UrLSEeCTJsRKLL4Zhq3J0CRHWDIS
	 IFU/u82V6ZcoWsL6kzA5MrdV6NkCyPk1wGvAtv2bKvHgao7TLM8N769kRJcv09WqCqU7G
	 ZZtajLu21APmMTymh3NjDdgJdn3TR98JzSIJRgSa4mOl1y/z8MkPumW1P3ARKv/ZQXW2U
	 An+Tr8wudgXsRkrzuQI9koCgxCCKI9T7l6evDuZB14Ij8WD1kj2hFE/8Vpv18oAAQWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446416;
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
	bh=WRkgvBHHCGFyPu3zdda4WAELeMLek0a75AuuwlHZ+GA=;
	b=3yfbOiIK8cVdu53im98dvGDS96i9vEayoberH0wvXQh7wqxZFuIu4ZhW4rcToIuGhqfO
	 1XTd+uypkqFyN0EYMicYHPMz3Dxt+rwUi3tJiuopuQ+pv+QjKA5a7bmpGzRs7WZ6s9O3k
	 UFm3kRDV4EBm41EzT9eZCN7tLrNPX4pkTsPkpjedN0WnLwp3ttuFDHJj4d4vJJstO5vqX
	 nZ8Kfdod2RZjkSev4XLPGKTAXEdpyzBtsZDUjN49KKzs1H9VYFhANIXMDADtHiUA3Du3X
	 4mKmWYryRYUgmcbEAvIaLV+abFqE4bEUxJn5sFKl3f9fFxSLZjpAMheR8sM2W1Kx0fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gcore.com;
	spf=pass smtp.mailfrom=gcore.com;
	dkim=pass header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=YDP0sosi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.140
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023140.outbound.protection.outlook.com [52.101.72.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A659606A324;
	Sat, 31 Oct 2026 11:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A659606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gcore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gcore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=YDP0sosi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhMOTRlzM6RxjvAd+/lDbAI6mm++7snLxsNGWmWCnCODcQifp4VXA/nWfmM4Nx5WvON7wda51krHrdM/Tc8SQabcbRofjbYOBymEvqClGNxvA3jO16X/GfuY8F+t+r6xJgpbkrOQJlaRo4cgGyF6IUjFeVH60XlFTp06IwTdtB3i7YAIerrmfEe7I3wGz7ryKzxt3FwP0fh7RbHmzkDCMo0vVJx7/VnUkmejTFTG5waG0RYgY9X7UL45DoMfGlMjon7mEvve506kQknL1eIxkWjzQZepEXblOsV27kmkOnWypf+ZLXFdDuabLopOqHDFompROd4UgACHmfEWIDdb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRkgvBHHCGFyPu3zdda4WAELeMLek0a75AuuwlHZ+GA=;
 b=xFgw892zvpQyhsrtI1VoonHCFrOEJ3hjY6lKJYvdBLIt2KMlmxRPf+ZGSDru6zZcVNtVQ6xDifmU+FrB8AVccF2n8/Krq6NiAN95rvzqOiXDEeLv2PyIHZPaz+wYIu6r47JdqDcygaU1cELaRMHMDdmg0c7sJiB60EuawEc1biYCCUKURzuzd7msyWCX4diBz3aj5J6q/Ky6HxRVY9f1ctCFAPNEEA0n3SewCW6/wcf+LVFb4JTCATBEeBEgvOkkChI9rnAV4WoK+7FwLiZfdRzPJ42ea+vBLP8vfL/HHY4bep4mOURxCIw4AkO0uhIv7ayVMP9BSdpli7CsUSfniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gcore.com; dmarc=pass action=none header.from=gcore.com;
 dkim=pass header.d=gcore.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gcore.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRkgvBHHCGFyPu3zdda4WAELeMLek0a75AuuwlHZ+GA=;
 b=YDP0sosi2xV0SAT/Qr0UfqB6ijnEzeQ2NiDofI1MxgnfO3tGQmUeoufPeVeviAIdjjX7Zb1L2YqqFWMn6iccCIHpas/EixVC9c0BHopl4nEBtYXLhXN1qTU0r1aXaR0B9ZsaROIZlSmKMecibKUc6aD8mEZjX3kGCS1G16GEfZovns30RHMrmszF72OfMtF5AqwdAgJ9rrqg0BjyQJUPlG8Klmt8w4cAbhB0i233MIhku9U9HdolJkx/ybHYX04uzfOo1uT9Xp7ceDeAvY0Y2PcY5QqhenwluJHG3mQi185CAb+bdx4Mv3OCo8Em8UPIPHPQIHx9SoNBUqkeKUzMEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gcore.com;
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com (2603:10a6:800:203::5)
 by AS8PR02MB7016.eurprd02.prod.outlook.com (2603:10a6:20b:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 11:33:32 +0000
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19]) by VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19%3]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 11:33:32 +0000
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
Subject: [RFC PATCH net-next v1 1/2] net: add SO_NO_RFS to exclude a socket from RFS and aRFS
Date: Sat, 31 Oct 2026 11:33:29 +0000
Message-ID: <20261031113330.45704-2-vitaly.zuevsky@gcore.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031113330.45704-1-vitaly.zuevsky@gcore.com>
References: <20261031113330.45704-1-vitaly.zuevsky@gcore.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To VI0PR02MB10572.eurprd02.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d4729560-f747-4491-4100-08df3742cb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10070799003|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WEDCZ8nMhwEdshvoUN3/Teht2OdjksrEo675Sg5RwvBv6EIV78iReOrbUrIMULwtByLZsqivrA5ujymY6STsCn3t7o+UsFS9MEYc2RkjLkiLRNHhU2GzXEQ/AtrvaHMTctyGyO1nPCdUmfDVe9Kkb82Z7/kJ6UZsrJM0OGeSS92JdFIGQyx/jVIzMu9rP5y5pmf5ou5dmkOTh0H/khyMzRJylf+LEhGwR1hOQ2d9mFbNFwaSfUc2zEzXpkwX8oQUWyYAOsVII/J90sSZb2d3K1rx5UdGHNWDaCkKcUC8mVlLXK1loGxjO4r3dsItm8uPHzk0+y9FymXxEcSYXGM0I5Qt70wvNsoo88d0cWh2ZxH5H3V+wiT9fSeHOsVkU79fD1956LcpKgS89PmSk9DQznOZkfB1A3SPe/kB+fFc6mCZx6mjgST9QlssmnoM9BwcDK8dI/y1gzfKUOB9HPdAUSKw0kks05Itl+v+yQqsdDrJoHDSYPprX4FjgFI1M8xmrnXlSgeHzpp81i2N+0JF/trO0NolMU1JzkIUhxgvM1IZmclr9zXpsGPLFDC71WeooknXacYo9zvDpI469PWjoX+lh2J64++oY0N1SARo6ryTUN+viY20y9KF2G3hQ6LWTYdaDYvhBUb75/8kitP98ozesFjZ94rpQd7mAD17g+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10572.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10070799003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZ/7cevC2Y9GHFVGkI97M4f6Z6/lPvyp17AjdL8EV9afBU4ZmcvDLuiilyLF?=
 =?us-ascii?Q?gh8pguW5+9GLDblLAMR37UJn6L9aW45RgJcR8BrmAnap/3YPvPUNWuPyQnMV?=
 =?us-ascii?Q?eHpBE4H/X9Uqr56rzbzxuqJ4rKHwzHW/V+9f+nOwhTKOid3tlzY5z1GljE5c?=
 =?us-ascii?Q?ZOu+UDfF9Woxh7fork1GvcyxZp0OQzuF4xO2gVsFdkiMr/SjVb0ezhznC50D?=
 =?us-ascii?Q?wsAiK38X6ewQ6iGTsRavPVYMpzu9vKM8I976Q/nsjms13wUdy6O/GCnPyidw?=
 =?us-ascii?Q?+G6vdgvqT0CCguYt9r243igw0n9xmCGc187kZda+c2Relee1TMFSyLJpsDgz?=
 =?us-ascii?Q?tfpP20+Qqxp+cfTylMEMYd2Nqq1LdkUZkHd74IFGaAfu9d2YMFH+YHtcjKjz?=
 =?us-ascii?Q?xsSEVQHwnvS3FkuW/GiCSRRxgEcRMa14eIm8wiBlemErbBT2/MkGT21n1cxQ?=
 =?us-ascii?Q?Wuy/dg91HgljZMIUnlS6IGHLCodruh0ErjCH2pDUPqVdHS49gjJ+ulgYDD+j?=
 =?us-ascii?Q?8Mfbs6e28HX+p2mF7QOqjeMp5f8nzx4Z8758D3MaGt6xfFBrQSJiNkLtNyaY?=
 =?us-ascii?Q?zcCKe1zv+PP5BvZLFHwx86CC3qWyzk/3fDE7Oc2KXZQKre1fGvwf2AY2AlyU?=
 =?us-ascii?Q?44spg/UP58DSJEHc5PBaOYAG06ro346jR/hlMakNxMb7uNwIWeNO6OsT4PHZ?=
 =?us-ascii?Q?dzlUAgvfmsyIT5/r7TZUKumqr9Ov9Gy0VpMVDdHc9t+gkacADwE3GMCvetfs?=
 =?us-ascii?Q?qH6Z9PJWToPHncA4yI9hdhXK2NsCvM/yphcS9ZaYywkyBvoOFmd4fJmZfokz?=
 =?us-ascii?Q?WcEPfgAKDhvc6bbBm2fMuQDmZq1x89eKyCJc543RW8gfnL81ZN+384XeCKSp?=
 =?us-ascii?Q?IDkKcrx2cgJq1z754M+Yd39jV/pXW7VMRhfWwldAKIxNcxgFNApX3KYrpm8x?=
 =?us-ascii?Q?qg3aqM5V041o/zupXoHrKfpRuHxIgm1NyiHwFpDdsOGak5tAxJLmTDWOhgGl?=
 =?us-ascii?Q?CQ+D2sIaeRtWmXPU6Zjq6sGUPyGwwrgGdc3CqaLq/0l5oB3Fni+5Bo6+jOMt?=
 =?us-ascii?Q?PZW6ZQUJ7Hew4yhxZFpoW+CtZUi/qNs6wHd0lLm2C4+7mRvUUbEJXZI0Oxwa?=
 =?us-ascii?Q?5NGz+6diBBp9mF6X1MyfAEuyKUq235aU5oT9NBnylW2fV7YXGMJSpI2ZOr7S?=
 =?us-ascii?Q?dK6zbVl7zH9pBfYzjeRCq44sfthgJLr1rcOR3oSSKvKOfe45slG42v19DPJm?=
 =?us-ascii?Q?Cy29UysOmT7+Vx0ahW3yQWFp8X/uqbwbKuUEXUOlnO7OKC1CTYyoICbw9xDe?=
 =?us-ascii?Q?4O3nm7bPNbVGcNL/gMhIQ/NI+ul9S9Wis+YGlqFkoR5OoX4W8lxyxRtQE5/E?=
 =?us-ascii?Q?Ii01zMnMvOin1XFZLE2iLKwNVimZsGnb4qKA7v/GXrV56JF83PAWh4UyYUav?=
 =?us-ascii?Q?PNqvL1nB8nSAUxnnD6ON3tXSXzEWbUJSmu1e4xWv6KwxgmINfZIbE2ywPlQw?=
 =?us-ascii?Q?hqUTxoJcy2+WtfNUdYMHFXePIbWlhmvfEalSheCzgd80Pv9236bKyZboxY++?=
 =?us-ascii?Q?yM2BdBKolORrK60EQAGzxgXy89uwZDbYU+4LDD48gTV7oM6DYpYn9CrnRzRY?=
 =?us-ascii?Q?089WyjxtuAu40pszLewUHSK2tlxfmP7eGdy+qRbSyW22TaGneaihzOshB44Z?=
 =?us-ascii?Q?gi1vErEz69H1dOJrShAXE9VSacun4ZAcIrT3VAKlatXc/K8T8iEYoPHNJ3Y2?=
 =?us-ascii?Q?nUfnEv0b+aLW9xunUiXIkBVggV2Xbh255WtC1cwWQDDhqE5NxzRHwG2pJBCp?=
X-MS-Exchange-AntiSpam-MessageData-1: vzn5Pj5fGtgDkA==
X-OriginatorOrg: gcore.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4729560-f747-4491-4100-08df3742cb02
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10572.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 11:33:32.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fc8b6b47-53ef-4529-aea4-8c6c20a851cf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhRPySoUMJo4syr8H3kPVgKtSQydpXM3d/O1hHVfMXHO88E2GpKKDiNyXmMJPKoxbt6GuGjCzIAHP0Rykge/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7016

RFS and accelerated RFS are enabled per host and per rx queue, but
whether steering helps is a property of the flow. A host that carries
a few long-lived flows which benefit from steering alongside a large
churn of short-lived flows has no way to express that today.

Add a boolean socket option, SO_NO_RFS. When set, sock_rps_record_flow()
does not record the socket in rps_sock_flow_table, so get_rps_cpu()
finds no match and neither software RFS nor ndo_rx_flow_steer() acts
on the flow; it stays on the CPU chosen by RSS or RPS.

The option is kept in sk_flags so that sk_clone_lock() copies it to
accepted children: setting it on a listening socket excludes every
connection accepted from it, while sockets the same process connects
itself remain eligible.

sock_rps_delete_flow() is skipped as well, because a socket that never
recorded itself must not clear a table slot that may belong to another
flow.

The test sits after the TCP_ESTABLISHED check and inside the
rfs_needed static branch, so hosts without RFS pay nothing and hosts
with RFS pay one test_bit() on a cache line tcp_recvmsg() already
touches.

Signed-off-by: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/net/rps.h                     | 13 +++++++++++++
 include/net/sock.h                    |  1 +
 include/uapi/asm-generic/socket.h     |  2 ++
 net/core/sock.c                       |  8 ++++++++
 8 files changed, 32 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 5d3524c26b2b..256d37f5b9b0 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -161,6 +161,8 @@
 
 #define SO_PEERPIDFD_THREAD    87
 
+#define SO_NO_RFS              88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 245a43f52fb1..5b477de463a3 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -172,6 +172,8 @@
 
 #define SO_PEERPIDFD_THREAD    87
 
+#define SO_NO_RFS              88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index f23710e1c671..b3a4cc2cbc50 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -153,6 +153,8 @@
 
 #define SO_PEERPIDFD_THREAD	0x4055
 
+#define SO_NO_RFS		0x4056
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index b35b25bdefc2..ba5ed7942570 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -154,6 +154,8 @@
 
 #define SO_PEERPIDFD_THREAD      0x0060
 
+#define SO_NO_RFS                0x0061
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..5afa48868236 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -98,6 +98,13 @@ static inline void _sock_rps_record_flow(const struct sock *sk)
 	 * [1] : sk_state and sk_prot are in the same cache line.
 	 */
 	if (sk->sk_state == TCP_ESTABLISHED) {
+		/* SO_NO_RFS: application asked us to never steer this flow.
+		 * Tested after sk_state so the common case stays on one
+		 * cache line.
+		 */
+		if (unlikely(sock_flag(sk, SOCK_NO_RFS)))
+			return;
+
 		/* This READ_ONCE() is paired with the WRITE_ONCE()
 		 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
 		 */
@@ -111,6 +118,12 @@ static inline void _sock_rps_delete_flow(const struct sock *sk)
 	rps_tag_ptr tag_ptr;
 	u32 hash, index;
 
+	/* Never recorded, so never clear a slot that may belong to
+	 * another flow.
+	 */
+	if (sock_flag(sk, SOCK_NO_RFS))
+		return;
+
 	hash = READ_ONCE(sk->sk_rxhash);
 	if (!hash)
 		return;
diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb..4472dc4ed28e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1024,6 +1024,7 @@ enum sock_flags {
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
+	SOCK_NO_RFS, /* SO_NO_RFS: never record this flow for RFS/aRFS */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 56fed7ab27ab..9bf415b0d470 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -156,6 +156,8 @@
 
 #define SO_PEERPIDFD_THREAD	87
 
+#define SO_NO_RFS		88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index e7405be8941f..02b8cc4bc1c4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1597,6 +1597,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		reuseport_update_incoming_cpu(sk, val);
 		break;
 
+	case SO_NO_RFS:
+		sock_valbool_flag(sk, SOCK_NO_RFS, valbool);
+		break;
+
 	case SO_CNX_ADVICE:
 		if (val == 1)
 			dst_negative_advice(sk);
@@ -2118,6 +2122,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = READ_ONCE(sk->sk_incoming_cpu);
 		break;
 
+	case SO_NO_RFS:
+		v.val = sock_flag(sk, SOCK_NO_RFS);
+		break;
+
 	case SO_MEMINFO:
 	{
 		u32 meminfo[SK_MEMINFO_VARS];

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.34.1

