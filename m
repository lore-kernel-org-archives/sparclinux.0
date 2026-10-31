Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793446416;
	b=LJMY+hx8JlIymkebcyz4uCOGPijNLAMrkR5fvsbrrIg34CUNiMLqhaGY9YprMUVSv5SN
	 3YqKou0hNhfTvne12nBCPCGvp34Ex5jeyqqXWDU9sjLtOdoxGkFZyxa+vewesk+KHRWJv
	 sa8sU96MrXkwJapeg27S/EF9RZrueeCDfXYEZ5SjYcJtcdBEWl5x2iretmsDnj3ozpAT0
	 3Q9sz3vQ+eqY42zbWN052ehHpA8DOPfyKHthb1CvyQTYKMG0BvzB7GAxAZJ8dSOY4RtNx
	 JqO2cbYTfcVrTwF4CvW7KJDHtUSoz9MxgrUTavk7//MsSar4+MlhczLMah4DLAUApQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446416;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=oQ1vqjpFhtwCF9/L1xyJQ5vgnefyA6WIjaFOtlE4boA=;
	b=weVYmJHsmU9JdKF1/zBdNQcc2sGHbP09QLp9Q4D5DT7ZhHgUrIfdcNgCF9JPHrHyfGrW
	 ul1rDxClKu7YPkVOeFc9ScWnRg3nmatvWAChe+Jfvde28txR+8hOAorGw1OC710Xt2/4T
	 DAgFSunEi/lFV29C5kt8AkxZsMkNH9sUMjLhemuEKtFrRZnkPaaHgMeUS7SnCNA6EPmbi
	 n//vuk/zJ04EW4J+c2/I/TZ4+Esc/+vNme8k6e0MOm+hvXHpIl49AveIjXXc/mtuVhYXU
	 FKoI2wg0opxO0N1+dW0sgpu/44OwwTbSwyIT3Y4eU4EeZ4AvJomsRehPpyGcT36MPqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gcore.com;
	spf=pass smtp.mailfrom=gcore.com;
	dkim=pass header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=Le290Rb1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.140
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023140.outbound.protection.outlook.com [52.101.72.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC526606A31A;
	Sat, 31 Oct 2026 11:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC526606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gcore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gcore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=Le290Rb1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyvYXdXk9QkJHYZoxuFw3c86hs4C248E67OooziMN20CEJ6PaUOcHRBC5nZA77HANKIns2Zll0h8eOoBNfm6TcxlFOxc+8URNbmptwGrv6M1yhX6xC3xJFe8c5Dk0WUXhDo/WBOWjHkD2eCNfDcvn14x1F1FBpadBpCiNKIorIqe1C8bvFNen2D4PRrsdvIK9UgXX6GsQP5SkcgSeIIzuzYHjwIt+V4Q3g/oVeDpKJvtOwATe1Hebtft0azLnBYB3Eo30/z3C/TNfeaigatoYs9OWus/j3LhtelWIsf3JWdsdst33QopjzCH9pr+qQzM9RCe4DJWOLynCbCpGL9lHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ1vqjpFhtwCF9/L1xyJQ5vgnefyA6WIjaFOtlE4boA=;
 b=qmu3guOp5pbYZJFq2fsYl82vK8+5nfDX06IgkxIBe0n4LNltxodQG6l6+hCQmzOGE/cWPt/jK/E4ckGqETuNGDxN52XQta3F1i0odt9yVVxNuF6BgWEymgEHXD2YDyTuMo+i38vg88Z5heaHNP3J08kYrko7+WLwenhCxScOPz3lOpn3b2R1aU7mc5lur/UZVc5y7V3MhKKDTsMqm5hMpGcJH9h0Z+W7DEvbqRjY+z87KId6mdhT+M8uHbbgtfNHSt/BfO1aaWAeF6rClBDGewdY/Hno/wgGCz6jPcazNr9qy52EZtlmubcUFScg4LVjOMc6IWYcaLauMLcW5YE6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gcore.com; dmarc=pass action=none header.from=gcore.com;
 dkim=pass header.d=gcore.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gcore.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ1vqjpFhtwCF9/L1xyJQ5vgnefyA6WIjaFOtlE4boA=;
 b=Le290Rb1BaI7OcaudIYdmWoBhM7RYzOGEMSNjnXl4tkqR/pqHP7ia7FZgCyA1cs12vEbY6qcMEm6/QDoWnaLLlsRto9frjVu0YmXHQGsGJ80ESuzIHa+orFkPDoxj6mYhuml9+kWsQGgelGXZI+uWDF1uc0k8AFdII8FrmTx7E/iafeWkpT+P2tXP7N4oswE7LQPL+dOBOU21YDE/eMoyzSUnMrpj1l62NOVQz9YmEKwZboANcEMw3pMCWJkfzaL1ZAlKy7sUdsJ2OXgFIANfLvHb7zO3HsDoms7sr6HuqghuYtmjBcFxkd7VB6nRrWuqAMjo9RbPy+jPoxrxR39Og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gcore.com;
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com (2603:10a6:800:203::5)
 by AS8PR02MB7016.eurprd02.prod.outlook.com (2603:10a6:20b:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 11:33:31 +0000
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19]) by VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19%3]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 11:33:31 +0000
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
Subject: [RFC PATCH net-next v1 0/2] net: per-socket opt-out from RFS/aRFS
Date: Sat, 31 Oct 2026 11:33:28 +0000
Message-ID: <20261031113330.45704-1-vitaly.zuevsky@gcore.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::16) To VI0PR02MB10572.eurprd02.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: df9b4ae6-5916-4cd3-7308-08df3742ca63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10070799003|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261021135927099003|261021123027099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iiigWBwxbPPbtIFVmcKTkupfwP2UESxkWW7FBbYiUnqUSAwx/s1Pjqiy0rY6bpfQycycbyqIN/YX3P/DGMilxsyytl6emvFVuG9i7HC4icO+iGTL0EMzQwdST9jYdfNdp1AXrOxAaH95Frj8VFejuS9abRf74cu1/7dnKBRom7jpkSU20O0rW/WHBBRCk9jdHzdZh+AM9ik3WZueJlQDOplSCu2LwvsH0YXOyluyotbxH+3mzCYcLrHA23wuJq1d3QdcC/gV3EwaiCp5KZKkB9F3bdjI80ZJAGBqAKGVqaHZ1owdmX/ktkEMr72QYzjIwW8ctNT1JoV3f+QdiPpccN12CPliSyeS8yzDmFDGcSkPeys/N+MadyZiLlywA6gzclOESgSn1GuhAMw6ENKGllF4MeE4TDxW90LDeIJVtO5ktNrRM3wQPPBYjNrAmfrw4xPdqnGGuMD3aRASZQ00MitwRsHQ5EDXLHVRMPT9eAp0utvGxXE83yLLACFNKiMXKVz4zHrc6CdTTTQjtzzW0IlcmHpMHx2pHQkySMsImFK/Bof5KOhWnTneT64tSDdY3A50P91YPBXjL+HQLS5T0BbKPif+cqVZxOljrACk3Ter1vNM+Woq9RwbU8+0MPPwTjgnmxx4BAHBK4VuQKYRhJ67WktSOzaGVvuyBqjUqZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10572.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10070799003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021135927099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjrvoV4vfu0YCE7+3b6gEXIDZPkFuTs6gGTLTyJC5vWUcCqKBLw0uVVl8utx?=
 =?us-ascii?Q?m0D94iPjrEsPYkMOgua7R1oyru02KIP32g7LMdVwzAhk/rKuC19pcUxlHdeg?=
 =?us-ascii?Q?InHXV/Fm6VDYAvLqAKULtq2PaLZCKFwwPPaoIkoYtCgjcUlPcaF82ZQHY8DM?=
 =?us-ascii?Q?rDgC0VPDJitc2DgdiXshAV7Na2A9x4SkJQa1OIYodyX+SgJlUA4T0Rwuba7s?=
 =?us-ascii?Q?CSdQNXR1koZVyNmRTl0gBryAR+ElSjkqtPCyGo1+BeoYkWQAvP9bk38Y5nkt?=
 =?us-ascii?Q?wiQgTvyLQteejFfqpINCOpdqnVTIuZu8wet0iv5cupPvgK4NgpTYzXDsO8/0?=
 =?us-ascii?Q?78TeVDyXhylOWJm2J7DkEl6pgGNQbIj41SI1OFOJqzu6qIo8WMyJZYWLqXMW?=
 =?us-ascii?Q?vOZDyDwRFkFMKJHh935dRA85tlgSoSP5rk+Z4aw3C6Z9M75g9kNWaUQbaaPF?=
 =?us-ascii?Q?F51k8BC74SZo/+QUGsWmXHlYK8ouSQFvWzdMxFDGyGVduhuWJzTyF5ABERuy?=
 =?us-ascii?Q?rkg8Y4zvVSC8zsYCXHgYymNJQDLDnhMLGo3WjjqxKsH6cPognxwZsavzylyi?=
 =?us-ascii?Q?vn1IxED206Nbk6oqxmGWVa5P8iLAqJ0VDicTomQKatq0sKmCHE3lxq8J8Xkt?=
 =?us-ascii?Q?IfPC+CJdzr9EXgGfGC9j+yJSz73oGVODW7xgqAUdgW2BNyLaWqhzHJYg2Nyx?=
 =?us-ascii?Q?56lF7KEe03j5hQ74VxR9gE19tJ4G0PDkRuLYsShIA97q3n0tOUUA/uxEBlWS?=
 =?us-ascii?Q?m6qwANY/1goW+8z8gFbIm2XGOxMJ0458M6+tlZ1o03ub6ij8vNIFy8qQ4y7m?=
 =?us-ascii?Q?Fqf8x+ou3khA0331/JIfL1IF92vBiBHSOTbsxsdD9mN9GyP0FTGnB5rzXrUu?=
 =?us-ascii?Q?m//9EF4QwZWawLIiDNPZNZE8IjqLevTw0H+cYLfrgQjphx6h1K21+QJRQ8CW?=
 =?us-ascii?Q?ZFSbLjE06cbjt0Oi5vxoIV9uDCpCWlbkBtYseND/eLafjPZY7m5dbVVkt2w6?=
 =?us-ascii?Q?QxHAEp64lNiJnbWwMVkbEj4Qo/PjJplggVce0Wp70WJ3WSnWb4K2AltO7kpF?=
 =?us-ascii?Q?f8lPYRFKj0Ci3j8U85xiTyVHBiry22yrB2/rl0Q5iDAGjr7ch/2RbBCV2BvX?=
 =?us-ascii?Q?ZINy9YyLv/8hJ2d6mGYHXGqtOsdyFQ0KhPkkvnSOhuzmhKwvy0+hYrKBB/Kg?=
 =?us-ascii?Q?mgCpIprYHspH9FxiIViI3VoBFKGzmMNOL+ka7Or4AzJhq0CuuoFFBYJL7q4L?=
 =?us-ascii?Q?5qi7jbZq2/szI/p5Yjb57ohRf0s28hbThNYRRlunkXynVeSLDO2Xo+8bTVNo?=
 =?us-ascii?Q?s7LQYIhIfGpeE4yPDw0yFStrkwoYGkf9s4lLOqmPSm4UoG+U0TxyMLjOdPPM?=
 =?us-ascii?Q?CUnMMQsltu+ndqZIHpBlGit0d7dZ51xVeciKfLM4Ll35eKWYkKMMqCJoZzwq?=
 =?us-ascii?Q?TVYL/49Bpqv6f2o7JrIBA+JTcIlM1E49WHYLQPKQsEnsThIn63Qov5RFtQU6?=
 =?us-ascii?Q?zFVPHzfOFCGl4RPXV4cf9I31Yj4W8iuZ71zl2e9Qwdqbg/u7MnjwcfY6S4Ji?=
 =?us-ascii?Q?vRWdpll1gZgh8Wmb2UIP59aa8nZvResEbFtfzmYlXgtxQrEI28AZE3WOYxkg?=
 =?us-ascii?Q?FeihNOPEUStdnSLhr5RJzsas39MkugHh+P5DAcYmYqR2qrdiiZGQLWdSiwep?=
 =?us-ascii?Q?pNYPuFaAOHtqNVBae4hE3mkzwV0FfQZKuKRlwFb2yzSzaHjZpvdSr+xCyNdz?=
 =?us-ascii?Q?4yz1tpLeWV40DiilwntbG1O74lgbzL3rjs7rpBirFqdHQJbbFVZYJYEOPt9v?=
X-MS-Exchange-AntiSpam-MessageData-1: /Qo/NZeZcoZjOA==
X-OriginatorOrg: gcore.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9b4ae6-5916-4cd3-7308-08df3742ca63
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10572.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 11:33:31.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fc8b6b47-53ef-4529-aea4-8c6c20a851cf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmtRTLFnXzZX3T91P44bML50Cpf8NysHslmWtYp3pcajVhxKzrLinrOG/S4FsnCOPgcQv8VtiOVb8/n7TlRw8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7016

RFS and accelerated RFS are enabled per host (rps_sock_flow_entries)
and per rx queue (rps_flow_cnt, NETIF_F_NTUPLE). Whether steering a
given flow is worth it is a property of the flow, and a process using
the flows of different traffic patterns cannot express it.

Motivating workload: a CDN edge running nginx with workers and IRQs
pinned, with deliberately more NIC queue -> CPU lanes than workers.
Outbound connections to peers and origins are long-lived and benefit
from aRFS. The larger population of client connections is
short-lived, arrives on an RSS-chosen CPU and is served from there;
steering them gains nothing, yet each is recorded on its first
recvmsg() and pushed into the NIC via ndo_rx_flow_steer(). On mlx5
that is a GFP_ATOMIC allocation and a per-device spinlock in softirq,
a firmware command on a single-threaded workqueue, and an O(rules)
expiry walk under the same lock. Enabling aRFS on such a host more
than doubled softirq CPU and, as traffic grew, ended in softirq
livelock and a forced reboot. Aligning accept() CPUs with RSS through
reuseport does not apply because the queue:worker mapping is
intentionally not 1:1.

This series adds SO_NO_RFS, a boolean socket option. When set,
sock_rps_record_flow() does not record the socket's flow in
rps_sock_flow_table, so get_rps_cpu() finds no match and neither
software RFS nor aRFS acts on the flow; it stays on the CPU chosen by
RSS (plain RPS is per queue and unaffected). The bit lives in sk_flags
and is therefore copied by sk_clone_lock(): set once on a listening
socket, every accept()ed child is excluded, while connect()ed sockets
of the same process keep RFS/aRFS.

Cost on the record path is one sock_flag() test, reached only when
the rfs_needed static key is on and sk_state == TCP_ESTABLISHED;
sk_flags is already read by tcp_recvmsg() so the line is hot.

Status: compile-tested on x86_64 with CONFIG_RPS=y and =n, not yet
runtime-tested. Sent as RFC to get agreement on the interface and
semantics first. The "before" state on the motivating host is a
production outage and cannot be re-run; testing on comparable
workloads by others would be very welcome.

Vitaly Zuevsky (2):
  net: add SO_NO_RFS to exclude a socket from RFS and aRFS
  Documentation: networking: document SO_NO_RFS

 Documentation/networking/scaling.rst  | 14 ++++++++++++++
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/net/rps.h                     | 13 +++++++++++++
 include/net/sock.h                    |  1 +
 include/uapi/asm-generic/socket.h     |  2 ++
 net/core/sock.c                       |  8 ++++++++
 9 files changed, 46 insertions(+)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.34.1

