Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020092.outbound.protection.outlook.com [52.101.75.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D81A682B;
	Fri,  9 Oct 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556357; cv=fail; b=raxhLZiKJS4GHOwLP8xsEAUnAas+PyVM7GNzYh9/fAVQHaGOos6MVgCvpRq2742W+P2NE3gKbLHVik7RvgwX8FjiBFClXx24TnMio2dJJoqjn7z0giSXMzLsOF3aiKSIH37iw/o6hTzwzGZYlYxKtpmGFUA97M2gdgN/tux8q2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556357; c=relaxed/simple;
	bh=sPvP5z9iWSFcXoI8UOLaevwcDnAb+eOH+cB9WZ7ecnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OS4PouAA3Ffj4n1n2FYB9cjoTHPhXX9OtQvvlkfZxXH0toojrXgfmUrIPabnQbqOyOuwKAEHKH4FaqiIVkiPjVMjKcr3mk5DzPYeNlzMEQkd6b2v1mxvnclCXKl1fhIDccLRyalBbCTldanCwKZj+6AevcILSnRyMikWKeJexr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Tz5UyM+1; arc=fail smtp.client-ip=52.101.75.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Tz5UyM+1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stS76oeycJbnkA2BoqXA67fdzrUc++LvRdtv1arXc0WoerWjEwD8qDid+hCdukem91UaMAy7otH+cRMmAIViU9zfkNd9xnt+K+2IQTlyLZUM5vaGgloIV5dCi/n0uHGFe2y01IBBj4QO6bv/8TjjeIn1oRMHfL1EcljANSnv4IJuvm4DsPzXo7A4BTOw0P8LdtCp+XGB68v1zbRAWBHX/SX6nnbmIlz6JEwu1VJPh95OD2tv1REYcnILdgV1enMinjibtqLAzj7f6KQ1tfbi3CLq9fXKtBnMIzAhbFlHzLIEdXi/mplNAU7EiuarXsp4Tk43mgSuMuX5g4BrmYTwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vFp2RSX23nVxHdxhdn86Iyj7+JNq7bSELEXYtBybkA=;
 b=MEYFTgJk0CVsN0TV+gw+VZxyAypbSA1swHjjHExs6lXK4F8rsVOeCiIH8NehMbzwBs6dqtE8a0lCwisDU5gl+ceXZwRW/AaFBUi8KWRtOwkjDS21lZ44w4/z4QzaIrJuMZTp/zBNOXuh3nhWSP5bq6eOfzl982v+B2GC1S+jPbYou41VbA3OUkzYEnC4VlQhZY7v0ePk1/QMReGKPM4vmpQwDqkhCsO2cCS8cgPIJxrsqBoI8WrUCbwQw0znwJRca0jYzyT9+mjIhcF2YbChWV7RRt/FP0xlyG29cgDksqvh/vUjKPf3E4sEgTRZSUJg7zXbhUMlcCh0z2B+FTsq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vFp2RSX23nVxHdxhdn86Iyj7+JNq7bSELEXYtBybkA=;
 b=Tz5UyM+1DDbE/uDdfKhO1M7ozIj6iQlVwiB6My9TUuW1RUKtBe57+Z9HyJXEPhGkWxPUEeqWEQZO36scrgLxwuCcUFYAlbReyXmUj3Uy4oHT/sHkMRDRC4mHNrX2jhCTjLwGsWPa3s9JnojbYy3FnMdlvi8XnSrZqs1iwAt69R+Cg7h1qyVzvDIlRm+jlCTH1MGLjJXLKDRI5j89Ax98rO3k2e0xh7HRw1rYuFYpGQwQDk+Tq9cZkBYJZ2+u6AQ9mKr7UUZ1jkOWJrVQeKTIEKAueoAkSjpd+XGK4KEv+qKJkJR0SYt3V6Ig61MRVdLRSrZdGkIUngp7C6Vtteyh9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GV3P280MB1062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:32:28 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 14:32:28 +0000
Message-ID: <a379628b-14a3-4fe0-847e-aa48d16bc7a0@gaisler.com>
Date: Fri, 9 Oct 2026 16:32:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] sparc64: add seccomp filter support
To: Stian Halseth <stian@itx.no>, "David S . Miller" <davem@davemloft.net>,
 Kees Cook <kees@kernel.org>, sparclinux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20260902072745.3412940-1-stian@itx.no>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260902072745.3412940-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0097.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3d::19) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GV3P280MB1062:EE_
X-MS-Office365-Filtering-Correlation-Id: 376dfa3a-a3d6-4079-645d-08df261224cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	npr8uT+Az9nHC2YIiB+n5/3XYWl9GXiW30wWwziVGWjduHrl34/aHaOSAC91MrD9LFreaySws/Id5B6ELaZpmKTZyHiqIAPqsJIKCBt9adwYsFvRLx08v/AyaowvE5ikGTJdVUAmnipCXXKs1F+OPG3T7//R3NukSCdeNKE9NhgQszLpUXO33SehQFbxp5gBbXdulxbNyZ760NZyfa1KrKc+T5fWi/6ZmGBxVvnRL75SK0BU0l0LVZJhWHH0Mj6H0pJxahTPymMJtzoknJKYCqT313fNzqs6yuTzexIBVx9ih26dC2ZKh4vo9JQIYnkfuNBWcH0oYbXwqgDM+U73+wJzxVo2wbqQ5CcczQp2jagolm0n0I/eoVFUYCmhOjl9FgjC+pj7nf1sWrZ+37SZ2P5kTdaqhNYcjl7rly7eI+eZrHrz075BXE7POGWcLFTgHvfETuyCxWr1nVDIpyZt85UD1GhKhMGt1Xj9kzYhPESQaPDu8FZQDMg/B4CaV95zU0yOYK5aoPZjjbCWZfxaHVm7FgB6T0bY1UHH4p2bbYi2X/iAhNH+qHyrk+lWXNZTqj6mtQOSD7+d/IH2AkGE1LPYmoeTnx0IfqRcX3NADZDeCbH+l3U+pIOvTyfYHjNwy9zbWdYYbum1ggFRsxnOfPnHXIthrgTU2GXoW7B9ZFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXZJT3djc1RjZmtIZjVzTjNTSlR2WTdlYUJWbmRWTmN3dXZUVUdKT1VYT3Uw?=
 =?utf-8?B?cmJLS09wT1VpY1lxaXg2L29xMzBCeU1BUFhUTUt5a0puUDlWUUlUZ2xVZzBS?=
 =?utf-8?B?NVpwdXB4M1lPVm1PcDNBWmowWFN0U2xqc25BbFMwQ04wbSthTUI2ZlhsMGdu?=
 =?utf-8?B?R2ozMVlnaWFROUFETk5DeTFSQ2pEbnJYa0hhZy83VVAxSGMvbUkxVDl0OGNK?=
 =?utf-8?B?ejN4dTFlenR0dTh4THA4ZEZuYS9XL1Y1VC94SytMazEvSEhHKzcyQnJUS3pK?=
 =?utf-8?B?dVozWHpiRHdLa1BERGl6aWpKd3FXMm5UaDdRWHVKdThlT2ZqMzdpcVdhVysz?=
 =?utf-8?B?NDVrcnBuUk9tTDQ3aG1remoxcnlkSGxIdTR3OFBYSU5EUU55MEZHVDJDRmtr?=
 =?utf-8?B?NmdXVDZDck1LSEdxMzhNTTc0WWZmOWE3ckVPY1BPSjlPci90aHg2S3V2a2lo?=
 =?utf-8?B?Z0pBdFd0ZGJGc1lNTE9VR3Q4bGJyZXU1d3h1cTRJMldmUDkxWEZPeUJrZ1Zh?=
 =?utf-8?B?UVAycTdSbHhFTEJRanVZNFdOTWdOVGZCanRLaXAzcUZzQjVHU1RhMzAvL25i?=
 =?utf-8?B?RmxJcFE4cW5sVCtzdzIzMjJ2b3QraDFnaEp6aFlIK1g3UEdKSXZzZi9VM2hq?=
 =?utf-8?B?N041OU1XckFtRDhDZi9RRStGUkh3cE1PS2lreWROTXpqdDJQYWxjTUpKUlhZ?=
 =?utf-8?B?LzAzYVlhc01QcGlSMUlLTWorblQrMjZHcHd5c01CdkUxWU9nd3pBcFA0dS9n?=
 =?utf-8?B?UGlkNy9PdzZjUFJMMzJtSmtYRGFqaklmNTN1MXYyMXBlRWR2QXlWNGVYeVFh?=
 =?utf-8?B?N0xERlo4Z3JibHNWYzVGNDVhbW5Rb1JWN1NNMVJwY3NJaHFaaWpvckdld2RE?=
 =?utf-8?B?QkNob0tKbkhhYmF3V0c2eTVWMm8yNXNFenFDcFhmdXpiQXMwR2NSZGFWbWYw?=
 =?utf-8?B?VE0yYm5MNC9MVXJub2ZmYWU2M0xrZWxvVGlYazFjOXgyWW1pb1RreTNyY2Zu?=
 =?utf-8?B?WXJkeGJlbHJXL3FCdHJtaTNpQTFVdXNNZnhxdjVHK3JoZjlwbWI0dEEwSXd6?=
 =?utf-8?B?U2lIeEMzM2RPcDA0WGhqWVA1NXp6bk5iVmJ4c1d6VUd2a2daNHFieWxOSng5?=
 =?utf-8?B?UTFkN2hRNyt6TFdSdkFKMmNZOUh5YitHQlNCQXlIOUJkVVY1UkhLVmtFOXNt?=
 =?utf-8?B?WWdBeUwvcmdFQ1dFaU5oNmVGdkVtQ1FPL0VSTDJpNXhXMFNXOWlZOGV4SUY3?=
 =?utf-8?B?QWNTQTVvTGI0ZHAxNGVnWHNqWW5laDJkbWk0TTkrM3duKzVseDlTcVQyTU5n?=
 =?utf-8?B?eC9UZ0xjdHBob3VTUGZrRXd5RDdId1M3MnR3UUNBTCsxSHk1TUxmZ1JaYUZU?=
 =?utf-8?B?V21KMm92S2d1VHM3UE1YWXAwT1dwd2h5dzNlRVN3cnhRVU9rcDU1UlJXOXhW?=
 =?utf-8?B?VEJIbTZCT0hZZnVsREpZaUI3UkQvZFpqYWhkNDBndFBXeFFVYkg5QTczV1N2?=
 =?utf-8?B?NGdTWEtRTHVUWlNRd0ZTNUlDRXFEK1MxQlpueHRnQ2QwSlIzN1NNYWlLR1Bn?=
 =?utf-8?B?Zk1Jdlc5ckZoamRMQmF6eEpTZUhUbmZLc09iSHBrakRQRjZxblVsMU11dk5j?=
 =?utf-8?B?cks2UVFpVGpjNXZsVkZHd1MySC9MMTdZWUtjSXZkV0dXcnErZlgyeXRXdldt?=
 =?utf-8?B?bUpLMFF1M29lK2lDcVRYS0lBWDNiUGVwa1NreG5XMlJJR0lxQUZVcTh1eXJs?=
 =?utf-8?B?aWR6NXU0dVhUKzVYWi82aHRLb2YxamJ1NEYxbWtxcXFkNmQwQXprdi9MNFVn?=
 =?utf-8?B?VThNbk1FVFdHV1FkaWhUZ0VoZ0dhK0pTSzdGMVJZSkd5ZjRRREFsMFA3bWRF?=
 =?utf-8?B?MWtZUGo4R01qSlJTaHo2aXdYTmhDUi9HRmNCWnF3R0RBS2QycEJDK1VDUHI0?=
 =?utf-8?B?cEU3TmpmWVYxSGFZSzZsaWJxUVdSbUNqcDI0bCtYWWZuTEF5L2h5WEhIQ3k0?=
 =?utf-8?B?UjRlMTFLSUhFbEF1OGZxaEVadmEveStMdEdjZ3hTYU0xYU1HNUxQelhHb2pU?=
 =?utf-8?B?d1pybG9SM3J4UWNmcTNOeFhqL1NrRy92NzlLMVRteFZwWDYwajdTU3N2NUFK?=
 =?utf-8?B?REY3WVJVUkNiUUIrY0xrYktWenN4RjF4NVJ4SWdQalEweVpSUGRvMmFhbndx?=
 =?utf-8?B?SXEyZ2p6a1Y1YVRyOWN1M04vTi9tUEZySjZlaTc1anRBTlgweldRU005blIz?=
 =?utf-8?B?NjJYNmdvcnpKV2RYSklzRkd6NlpibjdXcTR1TjEzUkVITWc4K1IvSmNiYVBn?=
 =?utf-8?B?T3hRMFZaZzRSVGpqdnNkRVUvVGRwQzZvV002cGFhZXZKMkVlMlR2c3B0b3N0?=
 =?utf-8?Q?AB91rwwCqjeRATFI=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376dfa3a-a3d6-4079-645d-08df261224cf
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:32:27.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z363wGJ5Ep2YXaGmAWGUWtvky1sn3uR/wDY+RVFXUXhTcFygOo1Em9i4TreM96ceVbueZFpQmscFtb8HjIqVdVDg2BEMfuAuaIDgvRH69+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB1062

On 2026-09-02 09:27, Stian Halseth wrote:
> This adds SECCOMP_FILTER support for sparc64.
> 
> The arch prerequisites have been in place for years, so patch 1 is
> mostly about the missing piece: letting seccomp veto a syscall, and
> returning to user space with the return value the seccomp core set in
> pt_regs rather than the -ENOSYS the assembler stubs used to force on
> any denied syscall.  Patch 2 teaches the seccomp_bpf selftest to
> drive sparc64's registers.
> 
> Tested on an UltraSPARC T4-1 (sun4v):
> 
>   - tools/testing/selftests/seccomp/seccomp_bpf: 95 passed, 0 failed,
>     16 skipped (uprobes and other optional features)
>   - libseccomp with its pending SPARC support (libseccomp PR #471)
>     passes its full suite, 5190 of 5190, including the live tests
>     that require kernel SECCOMP_FILTER
>   - docker containers run confined by the default profile, and a
>     custom SCMP_ACT_ERRNO profile denies as expected
> 
> The libseccomp side is https://github.com/seccomp/libseccomp/pull/471,
> and the tracking issue is https://github.com/sparclinux/issues/issues/11.
> 
> v2: drop the local regs-struct definition in the selftest in favour of
>     PTRACE_GETREGS64/PTRACE_SETREGS64 and the uapi struct pt_regs
>     (Kees Cook); patch 1 unchanged.
> 
> Stian Halseth (2):
>   sparc64: add seccomp filter support
>   selftests/seccomp: add sparc64 support
> 
>  arch/sparc/Kconfig                            |  2 +-
>  arch/sparc/include/asm/seccomp.h              | 15 ++++++++
>  arch/sparc/include/asm/syscall.h              | 11 +++---
>  arch/sparc/kernel/entry.h                     |  2 +-
>  arch/sparc/kernel/ptrace_64.c                 | 28 ++++++++++-----
>  arch/sparc/kernel/syscalls.S                  | 28 +++++++++++----
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 36 ++++++++++++++++++++
>  7 files changed, 99 insertions(+), 23 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

