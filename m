Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022139.outbound.protection.outlook.com [52.101.82.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7836A352;
	Fri, 16 Oct 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160761; cv=fail; b=GW8bSSyU6uNOn1p8L70Mp8m9S1YF2HSkWRpi4L8K2zugI59V4E4Pe9/PQBPdVE7vKOSR2eihsHNZ889tIBW7FZcdW75loOQaGDpiOl0W07PEgEbcAGcKeIgUTVDLpIDezy4uap/JCK/FOhDwg0EnqKJZU7OHeNShnrn77IWOxkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160761; c=relaxed/simple;
	bh=mA+dB5144OipzKrg1ncAJdmGl3LN/CTtj10IV7kqdxM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FZg22PuKXY+DV2+RUi91RgZgYPEVF01fQlZjLhXBdB2AnDTuGV8PT0nUawdtBQaSTxqxnCikrxu4lu8u71NcbD+PL8fnU3agTlPw9Wh57fpfciY4gq2/muySbKqTH0wbUSQ2khKuKRw3LBsvNZ10JJrjQItTkYr7Xb+iI3eoX8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=VP7tDdt0; arc=fail smtp.client-ip=52.101.82.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="VP7tDdt0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oATmxb+1a44kiLvaQYeTzg9+kLdOj0Xu7eXDeTV4G85BJWGbzJdVT9xzd4+0/vjhzZ/B9+C//8mKifkHYld0TpYk3VrWa0cgv5cPVt3clldkkUw8/leDznRWeQO10RyAV858yKvTjS0VBH1w23fAhllVBgOo7il6pSnxWU//2jI4Sz3kpy4IbfdZPJfKl1yXtD+17fVewiR+LVsm/rTWrgnVMzk24V4jIuTHVPnW1ikDQpEzHMI+lq1VW6qI5uQg6VCxFCzEBIm55ZhBDsyk8BsFqYPyVHZoRnKxWdOmbHMsBWUIrd32LDl7CVHSfRwc3lxeGIJJFGt0z1UhXv8pWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYMReY3tGrcptnG5Di3eG+0/yFkr3irr2/HDe3nOhcE=;
 b=fM01TXmrvyiZLxmAPzeCgbZKZjUho+kCuiJ8I1r8811WEWRi9nKrzTsS/AfoGvVoWM24osXbI5h/AWyUf6XtYbKXoBZFjLGqJkz/NSi8QRo7peypwzjM3ddZJ7fFEzkpBMqdn/w05qQXR1ZgiejwzZMn/ImMY/Ts4kwOdxu1GlmG9MIHibca1VU0fXs1kaUNjMfEIIyo0HdU84Rng/nZQof4a1TuKOov+zR3C4BU5kSR9OskN+b9+2T3glz2Z3577isk3I1EYRiv19YAp/5BGdGvHj5DFAPU4kI4EQ1WWtHoE2+qeEMnRiOAb3xdL3jkavZhqvGcfkEBUXO5HoMMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYMReY3tGrcptnG5Di3eG+0/yFkr3irr2/HDe3nOhcE=;
 b=VP7tDdt0MWvs5P1cLdSp/x/JU/jzTtpKUyKez0WbKret6VSg158rbuKOweXVefNwWxxgBjQ6yaTyatwnwXgIBDQvU3dFOHhqilsHgD+oV3UAubOrW6TyJMl48KvLYsLfhB5+YkbdK6mQzX7+haEQiPXxPcV2SPWU4OGmKhCD9HQWyJeXoec/2z0z0Op+l6MDYHAKGa3CWwZUasws6KweN5nrzUsATSSA8mOSQa68Rmc2Eh0/ZqzQylS4d+JNfI5+O16LnZNy/iFryfQxDmb6fba9VqHCOoLXHKEcVWQ3prMSpmyitO5vPozDe+dN9dWIgFbYLnGQujkYpAw/CAeWWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVZP280MB0666.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:25:52 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Fri, 16 Oct 2026
 14:25:52 +0000
Message-ID: <1728a567-a271-4da8-860f-7c7d971eb02c@gaisler.com>
Date: Fri, 16 Oct 2026 16:25:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sparc32: add seccomp filter support
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
 "David S. Miller" <davem@davemloft.net>, Kees Cook <kees@kernel.org>,
 sparclinux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Stian Halseth <stian@itx.no>
References: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0022.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::14) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVZP280MB0666:EE_
X-MS-Office365-Filtering-Correlation-Id: a880c654-a92e-4e09-94ab-08df2b9161de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DiTs5gmmfXoN6fm5frNLZw4CUKGqRDVuWZB4K/ajFo72nTUeqC7bcBj+/Jk0rOB/5Na8sveIxrmvl9xdCSdg0e6jka+gDl+S28xGb96zjfa4XNEPT5Dl3cKv4FV+o2FSWjyg2lRYis8FCWUBZeC9rJgHYVXAdm5+BtXfQJxCxTFy/jBXnTimvd3rmglE625dbU3/18PQDo+KfnUwFyt2kY+5ryWQKQLr/hrkbOrNsI5jHF3kN+635CyKeuioO5wsrnj3LF45i3XyFkZQCP8p6OPWuUctm5HldbhP9p8LOEipFbJTMLVRF+uUa/bSxEatdGQVU2eZc9HDJmIiua52ObtIUj71xk03pf6zsqCXEHT8LDUR50kF5e2Fy0ZZ2Znv8iMTedBkWyqQDwENviX4u1JDQD23liEgipBr+9bK0QtwvM8HVDBqYx2EIDGzYwe0XiDShuvd9eq652+Vw7nAc1upzdOwEOXTSTs2yl67VZFpfG35p+nECI+4VrhmA5/BN6L+hCWo7dsRevCroynmQIKGIUNccgxTS36trbJr8Ws5s3ZPYZbqvYcnq1Xg/8i/MbacJfrQONYMRmywiMxS/Z8Y9NdUzayxcRyLW3XsinUlzJHTMx/NqoUnpsyTaM64
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWIrdlRhT1kybTd5cjM1d3h1cFVQV0VJa2p3azhiRXVkM051RFAzemxrdU1q?=
 =?utf-8?B?ajZIaFpDN1FLeFVyVFpFdmJEOUMzMGN5MVRYRkh5RkZRSkZRTTBmRDBpUytE?=
 =?utf-8?B?WTJSbDdQZm9kZDZjMWxKTG4wdUY5NkU5UlcybmhaVE5Canp1YVRZT3dkRWZj?=
 =?utf-8?B?U2NyYitvcnlkdUNGNHJmc2xDNzIxTXZJeGFyTlNnUE9oSmE2UDZGdFFXUGly?=
 =?utf-8?B?N0orbVJpZTNNQlNtNGdUTTRJdGp6WWxnUFcwRzludFpFUFg5cURYT1hDSUV2?=
 =?utf-8?B?YnM1OEx5YUJ5d3JpaUR1Y3RsaGw2WWVCSXhXYmdXeEliSUV2Z0dtemNicUp6?=
 =?utf-8?B?S3JWNmhVaVhaVFhwSzR4Rzdxc056N0ZZUUl2VkZGMWdTZzN3U1dTK29LaW90?=
 =?utf-8?B?bStIUG43b1pmbmNSNUVoWGxZdTFKbmJrSy82V2pINjcvcnJBbkd6cHlxeUh4?=
 =?utf-8?B?UzlCZmNCaHE0d0NSR2hyNE9YeVlmOTZIdEdlY0owcVVIdnNwTGVLdTE5aHV6?=
 =?utf-8?B?Zi9aNWR1T2RyTnBRdzJySXRTdlBVdTZaaDNWR2FIS2F6eHNZMmFhZWJmdElk?=
 =?utf-8?B?Q0NRamNnVUV5YmhPUzRKcXJPYUd1MlpOTVovUUZTaHhJL1JBNnVRMUFQcmMw?=
 =?utf-8?B?VW5aWmtQK1pBNzExMmR0WVBaM3N3UE9lZEloQzNYSE1UQStxM0pyZVZoQ09O?=
 =?utf-8?B?WjFVT1p1ZkxJdy9SQ3pDK1hoM3c0MVBBYkQxWFJFeVk2Y2JmTldXUGh1TlZ6?=
 =?utf-8?B?cDAwVk5sM0poN3ExVXRHNWdpb3E5VjBOeURldHZUNlJ2TTFiRkgxLzJXU2Qw?=
 =?utf-8?B?TVN5VVRSbVlxYmZ5RllGaWJmdE9nZVhSbzZtaU5ZUEo5a21FVU8yeXBacURF?=
 =?utf-8?B?Qm5xeVB5QStrTURjZ0hWMHRkMGFrR2lMU0YxZVJ5ZUZHMzUxSnhxRHBwYWln?=
 =?utf-8?B?QzVzS2x5WXV2L090MVNBNC9mVWIva0ZaM21lUElBNnhNUWlDcHd1dUwzcUlQ?=
 =?utf-8?B?WW1CRHNiL3djZ2ZqN2YzRlFGbm5YTWpzRGYzNWd6ZmlET1ExVEpuRkJkVW1a?=
 =?utf-8?B?Z2NVVm8xTGZkYlVsWFJXSklIQzBrRUNyNkptWG5aS1VjbzBaNTUyTzhZMHln?=
 =?utf-8?B?bllwVzBsa084dzg5SWtiaG5lbzFyeXpQTWVNS3puallGbnhSSGk3bGY2dlFm?=
 =?utf-8?B?QTFIQjJzbFBnZ1ZuRk9sNXcyd0IwZC9tY0RMVEhncS80cldPV2E1ZlN6TXEv?=
 =?utf-8?B?eXgzcXRkSmthWng2Ujg4b1BreldZOUZoOEZDT0dzUkt1VzhuUHJDQ25BMEZG?=
 =?utf-8?B?bUN6NUd3YnNjUUFBek1oNEI5MHVXaWZUbTZPVlRXemh6ZFp0ek50b2YxTDBt?=
 =?utf-8?B?WFhoTE9NK1pFLytlV0RQbHpsejQ4eUdQNXJnRDQ3Ym9iUEQ2c3JHSmZBUDNs?=
 =?utf-8?B?WllEZktPcjBsNjFCNXhsTXlpMml6NERvWlZaalVlaEpCdHdDTmpocWRmdlRB?=
 =?utf-8?B?S0ZuZkRuU2t4bHBac0ZlZ2Nid0p2WE05d21qYndOcnRva0k3dVk5ZjlEaG1o?=
 =?utf-8?B?bG9ZeXpyaklSWGxpaGE1d1RMRlRBQ1FIRTRsaWpQcUZxQ21pNndZQVpVSmpO?=
 =?utf-8?B?dUp1VEpRdlloalVGNTNveHFYdzc2bDRNdzRIMThNbWpOUlk1cnFyajJZd0hL?=
 =?utf-8?B?Mm55TDh4amxHdjkvaEpqL3dNYmhrSDc1VlJHVGhLSEFpQUV5VHRvU0crUVFR?=
 =?utf-8?B?WENQbTg5ZGhHU2laZ2t1dWRHTkdtK09oV0hNYjhyMlc4V0dxTjhTRjA2WGpk?=
 =?utf-8?B?bU5Rc3FMVHdSeUpoTWd5MVRMVytPdXdMbzg5QUNPNHpJcnFpT2djcjExbWZp?=
 =?utf-8?B?eWkxMENGcitiVnpCNzJVemc4U1pOMG1JdTVwWllFbXhoK2QvQUFiVEg3YUNS?=
 =?utf-8?B?VkE5RE1NTzdmcE5qNnArZFhoWUxIc1djeUFmMGxpelZyTUJDSjVNcGlYaWFT?=
 =?utf-8?B?NURFUHlZUHpDQzdxOGZ4dTZiZUI2NHBpVXFjT2ZHNHp6aG1KWnhhV3B0MFJu?=
 =?utf-8?B?VEgxUEpEVlhLV1NxQ01HNndkbmRmcDZSZDBiYTltWDdIU2pEYytkRWltdmNq?=
 =?utf-8?B?UVBlRUJ6RUthcjQ4YWdIa09QS00rMHo2N1VFTktIL1RaUkRNRkdoQUlqdTFt?=
 =?utf-8?B?cy9raFVVQjVvcXd0aEt0U1g5dngzaTUxVjJ5c0JVWXBEUlYzR0x3dlJ2UUFE?=
 =?utf-8?B?aDhuaGt4L3RqVGEwN0NLMGE5cGljQTJwNGlmeWFQUHNEWGIvZ2pMTldHZEk2?=
 =?utf-8?B?b1Nud0pYRlVRbWxiQ1p1MTZCRjN5R253L25FK0tBVFNLWkJWdG8rVWlEWGQx?=
 =?utf-8?Q?jk2+nTrlsngWYpEk=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a880c654-a92e-4e09-94ab-08df2b9161de
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:25:52.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGnEuow56VYof0JR3Z29JPfjMC0rf+SImE9uTY9Vtu2+S5DOR7gHexZpJMs5mv9YlMFNKGjxhQ7Xvg6S5WG4P5T7KZko7ZgQn0R3zkf++8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB0666

On 2026-10-14 10:07, Ludwig Rydberg wrote:
> This adds SECCOMP_FILTER support for sparc32 on top of Stian Halseth's
> sparc64 series (v2):
> https://lore.kernel.org/r/20260902072745.3412940-1-stian@itx.no
> 
> Patch 1 splits syscall_trace() into syscall_trace_enter() and
> syscall_trace_leave() as on sparc64 and most other architectures.
> 
> Patch 2 adds a call to seccomp_permit_syscall() in syscall_trace_enter()
> to filter system calls. A denied syscall skips the call and goes
> through the syscall exit work with the return value already set.
> 
> Patch 3 extends the seccomp_bpf selftest's SPARC support to sparc32.
> 
> Testing:
> seccomp_bpf on v7.3-rc1 with the whole seccomp series applied on a
> GR-CPCI-GR740 board from Frontgrade Gaisler:
> 
> - UP: pass:99 fail:0 skip:12
> - SMP with out-of-tree patches that implement the futex atomic
>   operations with CASA on LEON: pass:99 fail:0 skip:12
> - SMP without them: pass:89 fail:10 skip:12.
>   FUTEX depends on !(SPARC32 && SMP) (see 3f2bedabb62c) and glibc aborts
>   with "The futex facility returned an unexpected error code" in the 10
>   tests that use threads (KILL_thread,
>   user_notification_filter_empty_threaded, tsync_vs_dead_thread_leader and
>   the 7 TSYNC tests).
> 
> The 12 skipped tests need the UPROBES which sparc32 does not have.
> 
> Ludwig Rydberg (3):
>   sparc32: Split common syscall_trace() to syscall_trace_{enter|leave}()
>   sparc32: add seccomp filter support
>   selftests/seccomp: add sparc32 support
> 
>  arch/sparc/Kconfig                            |  2 +-
>  arch/sparc/include/asm/thread_info_32.h       |  2 +
>  arch/sparc/kernel/entry.S                     | 33 ++++++++--------
>  arch/sparc/kernel/kernel.h                    |  3 +-
>  arch/sparc/kernel/ptrace_32.c                 | 26 ++++++++-----
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++++++------
>  6 files changed, 66 insertions(+), 38 deletions(-)
> 
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> prerequisite-patch-id: 5772aba3cb572833df13529ec6bb03ae9e848e25
> prerequisite-patch-id: 70a54ba398c763e45f9332ff4cc06b3f2a3e7825
> --
> 2.35.3

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

