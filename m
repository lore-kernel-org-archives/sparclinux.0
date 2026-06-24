Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022127.outbound.protection.outlook.com [52.101.82.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003B276038;
	Wed, 24 Jun 2026 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286293; cv=fail; b=eJMcqov8BeeAd49clXWb/Djc2V4jszR/dmm/8kOBku58VHr6PhVo5PNCZIyyhFarGPf0sRuVg5tDCDi+SSbjwduIwMetct7NLYBmC1ngkwe+JvhXs9lWKnxWu8dypIu3YaacYpzDJuezc2ee2+pP7Qc/APd8mxif/3g/vq3EAUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286293; c=relaxed/simple;
	bh=HY3Ysg1OhyJk6iFc/M4rZFDDcQh6P1DPusea5D0kBMg=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=VfdiUptSy8cvjGKT7Rxy6NbNEzVfHcv78DFAiezScc8zph5fTlrtEvbQp+D8FzKAd4QnYnyA6kImpVN4pNQrkx6H7lkvNBy+UFblrzt+9W+QHCb2yvvfkbXr1wpVQQcAWn1SmGW3BlAzx7IgI//kPQ0KZDkpL0V7IKNavP80/f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=IftE6pqL; arc=fail smtp.client-ip=52.101.82.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="IftE6pqL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rkr8umM8tYxFbeLAUP8VOedCJwvl/jDwB/b41phB1iMYdbt8TG/k2TGWSRxBmBDPM+pyayZkA6B/tYTDi1hT9vlts4bgO2V8o+/vWQihZyAsewTkWwGW0bQlLZ4oztKCjNYc+WC7L/mAzKbzf2f+R7xtx3O3aHFEbPwMcC9Y1NJJ5ixmlJw4QHW+4VjopNBvBHA6dGAlitc2jCSwPPWcciU5d4GXxEjYNkg8MwTJjSOTY2x2TcwS+Bo2SenjseBmcfTTSXExi9B2lWFkGvDlO1aXcwBlzwePQ+ibUjgBJnnTFo3INqp6dlNskUZoqDnJn6B608ySxWpqQk/yaqbhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWptlhYMwdO1y//b55KhIjcoMeADTtqxnBrNLq7CALk=;
 b=PZSEUMM3p2abWyhwK7NMOpbLk+ENrVG1brsXayM8xuUuellpEwokBEf0U5vJtaXrQ3zovxrDdNh/4VT/01ngLrb7GBqOdyp3giWr4RdwKJPZN3EDAzHrZPiwg3Joa3amz0FcHyRCKQjKzwad3nOn4OZt8hOmvevchC+Ohh+tnTD8AK/zXesUykPHNWmiXnJpCzC2nQPdpL+ZABRXGBeiEoSuqn2KA5IRrXpV4U4fHdlDCVE/U+5m3lysj3jsky1YbUOJZVZTW8cRQLKWVIMWQAKfX3g35/4gXiVhMqXSTgXN5w8h3yIyfzZkq39OVGIFOra+pzFsA7qtsdiDjpvcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWptlhYMwdO1y//b55KhIjcoMeADTtqxnBrNLq7CALk=;
 b=IftE6pqLAkw4d2PfUYNUzuf6xEGwPgjDLQgqejmE1Kgyfjj1BQczWQvvkvzWP0TnmJtDGZpcqNLjoY9Vgtd4bXmVakC/Bwt/4XMRZsZO6XAM0LFBYYWJ0YkWknIAyPUskvMQNwlU8Y8cIqdECyGVBMRkH4IY0c3kDe/b7pN/xK+OQqzXscsK3QmLJUc8nKQ6QKpOf1MfOlSfgPbQ2wugj7OoAorxwLkVVAOlpIemKUbXvOCedkxhhH5TZoqJC4Lw2EU3UkiG56WkWrnOc0+SitUabI4NH9y5PQ6gB8Q/YJ1TJxNh/ysTpyFWjqNNdVScF5fVM2AwWjlPIRir/ejfHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVYP280MB0763.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 07:31:24 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 07:31:24 +0000
Message-ID: <09df8a7f-758f-47cf-9720-0de31e4dee36@gaisler.com>
Date: Wed, 24 Jun 2026 09:31:22 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Andreas Larsson <andreas@gaisler.com>
Subject: [GIT PULL] sparc updates for v7.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::17) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVYP280MB0763:EE_
X-MS-Office365-Filtering-Correlation-Id: e6621a83-cc2a-4d30-f665-08ded1c297ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	71FuvViSh9d4lIiKDP2Cpce9o2BbFmYMoCMAuaw3C13sCOXHTl0qoWoT071jmCal60boLZf5LRVyx44DlnHSi6NhVeKw7zPTwU5XOabP+mfF9emvbkViDNiYsQIH3NCNjQmVZCdcwE2Rlq+Sq0b+0cAq1B230ep+ORNI6ET3fmCEygBog6BJ/C5t4lZYumajlrRKoMCMCnIAy6s9/5ihmQGL4+XXa/pRtmxZvgzyogNYNx2Slp1eomvPYjnlj+0IB5pZqdCRSoT8XxThmFTTVGC2DGNHVz7twb9mH5gCRRTn8tMXw4CgYc02UBc5d7MnSHLsj6meXAAe6jEiqnDaLt2niGOxv7la381AmaQQnGFfW9WlWCN5gZYITOJPKKS+RlqLLC9JrsYDgGl0YavXKPE/L6YfeLDkzaexFjlSRK7cpa+j4+CszKExHWBgnxWo1vKKfMfMYm0/+9oNkOE0v3OE7KFEtbyVA1+R9XBz2+aLtZWzx1Ql/RueMoQXngfLhFQyoANhMrsIGuTHC6c9/ETUAN28r8TYd1Et1ll5cjLTk394oULvyodkUJYBh0GO7YxEMNQvOddQc8EBPDK3jUl+adcxWUIu2Bh3CPurBxQ/pzwekcZj8FQPtFH70VPlgwLzH6Lflmbpt76CW7xXkt0rpgfkEKR7rzsRE+YXTNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVRrU1FyWG5qMzBzejBLdzZWQ29VMi9LY3krbStnMjRTaG1qbmxBVWNJZ1Ex?=
 =?utf-8?B?MGxLMWdXOHZFMzVPMUhYSCsrWXg4YzJSay9oU0NwbDVWNGNJTWh2VEtxWXFM?=
 =?utf-8?B?b0dxaTdpUm5MZ2RvUHphTHhlUDE0RSs3UFJBbXJHanh2a3hvMjdwVWpjRFYr?=
 =?utf-8?B?elFnYjNrU3U0NnE2dndqdndnajF0dlg2djM4bERYS0JBdlhQSXNnU3FkK3Vw?=
 =?utf-8?B?dmtZV0o0STJWcDhEODBOeFhZeGZCY25malB0UityOWNaT3Frd0ZoWmJHU0RQ?=
 =?utf-8?B?NENjUWtFdUIyVzJlRG1EWnNlVnd5TDY0NEZrVXlITE1uRmtHSDdxMnBjVFg0?=
 =?utf-8?B?NEphalBieHBaUHJVNTBZSHNpYi91bUJuTU5TVDh3QmVqTFBSeStYTURuc09u?=
 =?utf-8?B?blN4WFhucW9sUUlaaHdSOVB6Mm1GaG50YWFUVlBxcVU1MnhrbUFzZHVKQmhW?=
 =?utf-8?B?elVPSzZJYm9OZFFWS1k0UmZlcUkvOUdXRE5vTEJUdXNmLzVFYWtkYlZFVllF?=
 =?utf-8?B?Rm42cWRPbjBNSGt4UW1uVk5jY3dmZVhYUVd2ZlY1bXBjUno1OE8rZzAwenNa?=
 =?utf-8?B?YitjSUJ4UGZ5TjdZalRKeFJudEs0MkhzYWRQMW11SWhGSVZNdkdHWlVMZ1R3?=
 =?utf-8?B?SG1nSE5tbEFmZkxhZjVieUtlTnZpcnBNaEtHQlNtZDM1bmppVytscnBMU2J4?=
 =?utf-8?B?R0FUejAyemtrbG9rdCtpYW9BY1B0ZUpWRUxYVC9zTlBHYWlrZDVsUWZ5S2lS?=
 =?utf-8?B?L2xnWE5ZRlhzS0xiN1BSNzh1Wk9lQk8yYjU2RGEzYUttMFBhSExLUHJseFFh?=
 =?utf-8?B?SUJIY1c4Qk9seFBrSEQzOFNLZW8xRGZoVVZ5RVhPM0RmaHkyUGc2WVJjVVN0?=
 =?utf-8?B?ZWFOZmNyWkJpc3U0RjNqVGpFM0NwT29NRDcyY1U2aGFvK2xWc3I2VWJzN0xh?=
 =?utf-8?B?dVZ0R0d6Ym5OUER1SUJabk1kRGVNMnNaWXVsV1JJekJpREpJelYxZjBHSHJG?=
 =?utf-8?B?UDZkVGRCaWxwaEN0NmQzMENMWGptaHBhRjM5ajJkaGJ5Y1AyU3BGYVV6WkE5?=
 =?utf-8?B?TDhaR1BiWmZVSC9UK29zQUtoWTZGVkxOdk5zNmozN242blArVGhINnV0aGNM?=
 =?utf-8?B?Wm9WYjVDLzVQQnBXZU5HaTQ1SkMwUHhrWUxhNlZ1RUpDQU1UZXp1VzZvdmxI?=
 =?utf-8?B?TkJGVGRPUzZ6SUxrYWJFOUo3UEYrVWd6YWpuYnRoUlhQUlYvdEJFMStmOFRX?=
 =?utf-8?B?bjJmeU92bTV1N05xeTRJUG54b0cxYkRYT210THRSbzNqQm1zQTJRNW42eTVv?=
 =?utf-8?B?eEJ4V0VvUkJkZTRIYVp5RFprTEZXMWZObXZEb1hMMi94bEJRWDE0bGx4M3pT?=
 =?utf-8?B?dnpMa1BZWm1lMjROVEZtYjM3ak5iS0M1YyszL2NJN1E3SEJ2Tm9NaFl0a01j?=
 =?utf-8?B?eFE2WUxlWFc5STdManZ2NmljTHkrYk9DWlBrL2xXZDU4bVFmenI5VWFURko2?=
 =?utf-8?B?aTF6S2pmaGkrL3lhTnFyL2hTcjRKTXlrZHNSNnpod2pqYlc5THlLeEdCUkdx?=
 =?utf-8?B?bzB3YzlrRFVhMlRMRkh4c2hBTTFZNmJrYTkxR1pFUTl3SnN0VHRTU2tNdXR6?=
 =?utf-8?B?aUVoZm05UHZPcWdPTzArUUZFbGsxc0NPN3RMbENQUlh0Q3Zoc3RxZVBrVmZi?=
 =?utf-8?B?Ykw5WUM5UlVNTSt1Wk9jdFJnUjFBSEowczdUS1prQUJHenZtTlNjQkJVODZW?=
 =?utf-8?B?T2FldmU2LzZPcXJCTzVnYnVDSEVHbWhYOHdXQncxYTFYeUpjcGtCMGdUS2sr?=
 =?utf-8?B?ZUJSdUN3bXk3dGMzcjBDWWNwN2tPQ0NlSitYbTRhRmJiTFRaWFdkWS84aU1q?=
 =?utf-8?B?VkRXNHFsdUJTSEpzNHdsS0dUdllucnltaEdmd3JjVXVVTy9BeUduc1UzcHRp?=
 =?utf-8?B?YW94eThtVzR1YWgzUUp1dU5GRHFPSjBtZEpVd0hGeWFuMW9JaFFDbjUwMVFx?=
 =?utf-8?B?Tm1IUGZJOGo4TkdKZ3c3SUF1ZkROak1jTXl4M25keVZTbnhpQlIyaDZrWFlu?=
 =?utf-8?B?dFRpRWplWjFjVHo2SHpYQUJoQTlyakpQTzhkOTFMcENpMDNySGhtcHdsK2sz?=
 =?utf-8?B?OXNaSitWSERwN0JXNnBTbG9ST281bFRPSmJTbitlMUtnNTZwaFFwWkpDU3VV?=
 =?utf-8?B?czQ3QU1aTVYxTDA5cXZ3OThyZC9MSjFUOGRBNVBaditNbmZiQlZIdFh5cnE2?=
 =?utf-8?B?Nnp1b0FCa3cxY2gxZE9BU2l2bllLZWgyRThwbFJGL1hsYWlmbUxDQmJyUW5X?=
 =?utf-8?B?VENjL1dNMlBhSzR2YmlkM3VUR1J2NWhraDhTREZyNlBRcGtNaDFoSWdFYXlk?=
 =?utf-8?Q?lhEmwAPaNQtjxSBA=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6621a83-cc2a-4d30-f665-08ded1c297ef
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:31:23.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3OV6LkQbied38N/lobUYALacOyKXPoo1id1o0MuecORq4IfTsvCyo/SJ5WH9WqqN2IQknbzOWgw0YC60uDCqifCcvoPgMr2itZ2JELTpJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0763

Hi Linus,

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-7.2-tag1

for you to fetch changes up to 5b2a3b1a98fb47c593144c2770e012d463952b70:

  sparc: Remove remaining defconfig references to the pktcdvd driver (2026-06-15 12:54:01 +0200)

----------------------------------------------------------------
This includes the following changes related to sparc for v7.2:

- Align sparc to other archs by providing ucontext.h wrapper

- Fix buffer underflow in led driver

- Export mcount for clang and disable compat when using lld for linking

- API choice improvement for sysfs code for vio

- Fix build warnings and notification of missing prototype

- Remove dead code and dead configs

----------------------------------------------------------------
Andrew Morton (1):
      sparc: add _mcount() prototype

Catalin Iacob (1):
      sparc: Remove remaining defconfig references to the pktcdvd driver

Ethan Nelson-Moore (1):
      sparc: remove unused SERIAL_CONSOLE config option

Kexin Sun (1):
      sparc32: remove deadwood swift_flush_tlb_page() debug code

Pengpeng Hou (1):
      sparc: led: avoid trimming a newline from empty writes

Rosen Penev (3):
      sparc64: uprobes: add missing break
      sparc: Disable compat support with LLD
      sparc: Export mcount for Clang-built modules

Thomas Weißschuh (2):
      sparc: uapi: Add ucontext.h
      sparc: Avoid -Wunused-but-set-parameter in clear_user_page()

Thorsten Blum (1):
      sparc: vio: use sysfs_emit in sysfs show functions

 arch/sparc/Kconfig                      | 25 +------------------------
 arch/sparc/configs/sparc64_defconfig    |  2 --
 arch/sparc/include/asm/asm-prototypes.h |  2 ++
 arch/sparc/include/asm/page_32.h        |  2 ++
 arch/sparc/include/uapi/asm/ucontext.h  |  3 +++
 arch/sparc/kernel/led.c                 |  2 +-
 arch/sparc/kernel/uprobes.c             |  1 +
 arch/sparc/kernel/vio.c                 |  9 +++++----
 arch/sparc/lib/mcount.S                 |  1 +
 arch/sparc/mm/srmmu.c                   | 29 -----------------------------
 10 files changed, 16 insertions(+), 60 deletions(-)
 create mode 100644 arch/sparc/include/uapi/asm/ucontext.h

Thanks,
Andreas

