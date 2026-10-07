Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021099.outbound.protection.outlook.com [52.101.76.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32443F483C;
	Wed,  7 Oct 2026 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353651; cv=fail; b=h037A0xGiFfWyzhPC3FfqyWajmGHwVOjyeco9gKQwaOaoTNiVCUlMyO8hpFfsUWVcz+ECsr9IhTvWiCCdT9mmaEfAcMMRKJA9Yxr5Nw6zKZyIc5hZgLpwnhPZIKT45d0BqF86w3osXcan83ih2fwGpPfqDvs0WchJ8Ss4O7miZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353651; c=relaxed/simple;
	bh=qiDHoYzxAYqBEa2guzqPGUZD2AKCGfo0LQGF+EBotdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7/zPt7xg8XCADU1Wjk546XHZ2a49ROZUSVYKlnjaRiy/w8tH/Tqiq6nrudQ5iBO/09yWQ/qwJnq+ak8njpyaALn+bnx8DvIHB1O9HoGEshqfY1jcQFF8hZKYatCyhzACaElkkOhl9NDKTDCSXaJFz3rTnZ7bf1Ttrih+ku50aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=nwtZ8IB3; arc=fail smtp.client-ip=52.101.76.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="nwtZ8IB3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrOGTod5tYm9FFW1MhEpqicWYtVgrUdrPvkDsL5cm68KyDaajfKyZUaKBILsz5Iol+E6Mu93uKjeA2bDujW6VP6ekwxasgAPDFclLAAG5xXMBwAHdZjkRmAq8lFkIEOHyebPEBOYaozv+zdxv3HT+Gsjrv1BR3HmmHtlKz44cxpG13iBoDhKEzWDEPst0mTYbJUs6jGbfMTYMtm5QWAWu1ijL0ZobvH9rNtlkF6aw34qneu848FLUT69k71x4vZprOVRgyNtpbpewHa7S+XGj1DptbKK2X8lUGMWn5LOFhIMRdDFyYqw9gosUtOrDRGjLhQZ5z0+XlPr5ZXZrkZEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc85+L0FurgD9zWyyIOuDUOYkCbM/k/j8YTMvLlDTBc=;
 b=sdp1xJSl3ywbo24zyB4zct9VGpQ+H0djwTthWq5rbKGGv0peMFTP5g7GSOg1Rr3qsYUXMwDOCWC2n1zvVfAVnN16AIl4m6wYEFgNEYW4a+RP8CdNr21kNkVuDRRpj9cp3/eYHHmpfYzEPc9sYQw3GacbAFYoovHwW7xl05J2YPalqUbxXHv+EPGN19GHMI3PphR0nmDTb3ORIqIdnnRosXb+RyhMy2hybJvFoJkZjOp2uwNtjbmIyS9crmxK01h0HUlCETk9he+avIEi3CF9ZKnl7nZqcJpaIIiR7SDkX5o5C+HWYF4EmTqMmGipA0AlZ01gSgsNAUTIOklq/OUQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc85+L0FurgD9zWyyIOuDUOYkCbM/k/j8YTMvLlDTBc=;
 b=nwtZ8IB3cr0DeWbX/sUHQxJGkq0eVrSVu7tAIoapYmL3XzxwbAAr5nV6hSWQvBJ1Ku+9YIaVHpv3+PWoT7/9x7KODod8HIh6xkJPlbR9MdP02dOkTOCqf1K6y3lnjHSixQbpxcebMH4iw48nGZ+6Sj5Mtf8GIqjh35NLT06f7FPoZQPj94ggqWrbFqJPX/Wmm/btkXuW6a63Q1gCY+BHKjgLGXmHOHbb8w+YQRBX29O0vNFCvgLLt9IYwZmYD8HiS0cAs5gbxt74fBqXoyHNX774IUQZ/DYR+6xIciCk2JY7BXZx37OyoEOevJO4ehlqJeGH9WpeokVpChtJ5lfHVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by MM0P280MB0166.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 06:14:03 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 06:14:03 +0000
Message-ID: <f32e114c-718f-46d7-9388-fdc5c382ddaa@gaisler.com>
Date: Wed, 7 Oct 2026 08:14:02 +0200
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
X-ClientProxiedBy: GVZP280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::9) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|MM0P280MB0166:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4399d7-03a1-485d-a7d2-08df243a2f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CwwnDstVdWeI8VWfKn0KlllPnJA5UuCECD7+rXNdrnOyD2PVJfD8F3v6QZEcdYGE4aBf6/Mvj6RcExLNQu6RyicvPoXzY5ubQUgoGNub75ZPAj2z6CGNrdDiClhOqrSNmpIDyK1souwNe0jrNAXcFjVkw0rzFYSu/o8a7LgJTtvJOOij6rEz5rVidSZaBk8y/6jz3vL6Fq+ifNCmuvG2pOY1DcC0JMwucnGzq2yHJOCFjGG0htnGbUWa/n4m4D7mfSX1summKVBReo3m1OaGMOcI9OxD499IYZTU5zmgj0zEtJZdcqTwMj2jjIW1X7M2CtPv5APtZzBPbXZReGvlRnCvnlgYCTmJAo47umS3q6pAP+4WhEvPKTDFR6xipluPi52fdB+risz8I1vfz57tul71D3u3JkkxLMJ+ENlysB31B5nK8IbTGCNl/bVmfyGU7iLnPJ6H/V4KutPF2JUCL3sP2e2tQrN3+z/KBBxSeUzvd8oAPZK+R5mMiHq0Tuy8KMxKx68VKHjVE3G9go910WOh/8deNQsPbFcf5HecoGTtC8YJSdJgWmqqQ9JvlnludxAE/xy6W949k24syVRLyrNhN9eMEwpMJyaCSqfwr3xOmO9VAkTtYTROwitwhiEU6Bi1NHgVsdDAZ9YXKjDs191T5tNCg94eY1j12h2ILJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjR4V1JORExadlRVNWRWVWFxWWl1elplY21Sc2dWcGF2cGU4VlkrSHdLeHU1?=
 =?utf-8?B?M2QxTmpvZlJpT3AxWWJTQVN2ZU1pVXFrcDNyMFZFSm9uMTE3dDFKT3Q5SGpu?=
 =?utf-8?B?SkNtZE1TaHhYUk1vWG1xYnJ5QnNlOHRxQ25JS0xBeUM3bFZoem1LbkNmWW1k?=
 =?utf-8?B?RTRwZ09jY1E3UDlJQ2ZOeUpmS2U1ZmxsSXpZY2JBTG9ReGZydUUrQi9wNnVj?=
 =?utf-8?B?K0JFSW16d1JySTFvbjcrQmo1SHdJK0IvKzFsSC9JdG85VUJuMHFXSjFudE9m?=
 =?utf-8?B?bjNGNkZRTmVkMHZvN2FtVjQ3cVRUc1hQNFpHUnBUTnR0RE5OSldkTit0RTA1?=
 =?utf-8?B?UE5IcWxad2Z1Y0ticWZYa0FpVFRJR0t2OTVGOU5TdmVQNXRTTkpKZ2Yrci9Q?=
 =?utf-8?B?R3BHZyszTGh2WDJCanNOWVZScXN2ZEdBVkZtcGlWMStHaDh3YU54Y0U1bERz?=
 =?utf-8?B?N2xNMDJhbHMxYXcrUkRWOGtJcno0NDNUQ2lpdjNNRDg1c2tjbVVmb2F4MzNp?=
 =?utf-8?B?OWpLZFkwaUFVZENMRkRnZjMyTEdTbVR1UC9DL3pKL25SeE9DOUZXamdraVda?=
 =?utf-8?B?NTIxWkxFSmo1OEp3NkREQWZEZ0NyWnNkNFhpc2RzMHoyelhZa0VYVm1NUGZT?=
 =?utf-8?B?U3FlVHVOUG5zeGVlNXNPT0tHZEFEVkJWQXJtMzNoL1Q4b25ONkxxdHdaUG04?=
 =?utf-8?B?T3liSjU1MFdhSlV2eGM0M2QxWTdMdGxsbmVqYzcyS0JQcUFBRVd6MThEMkF0?=
 =?utf-8?B?TlcxeDlyUlQ4Zk1rTUw5WkhGY1RvdnpQRm44TjF5dGJxRHhnSjB4RjlZV0tl?=
 =?utf-8?B?a2YvWEFESUQ0b2hkMDlDOWZnNC8xWi9ydXhHTGQwUjVzOGx2N2xhS3V4cDhW?=
 =?utf-8?B?UWVEb1dlc3puZU85RTd6NDg0NlJsZDFmbzQ3SXB4YlR2elY3U2FDQi8yaG9M?=
 =?utf-8?B?Y0g0TWRvY1FVOGZBSHdyMG4wN24wdjduNVBiaFpNQWpEemFITVMyRWdISk5L?=
 =?utf-8?B?eG16QkZkdDlXYlJ3S1FmNXBhY3VTY0dSN1JJZW92dHdwN09SMW9mQ0RxTVFx?=
 =?utf-8?B?SElHbkJoRnNOV0lYcUhTMkVVY3BneG4wQlpJWmhQUCtqNmlwOGkvQUZFbDNM?=
 =?utf-8?B?MFFURVZIZk1zNDU3S2ZhSjVaZzlnOWVTTGE1SXJ5WkFOcEFDSWNTT0xIWjh0?=
 =?utf-8?B?bEduVHpUTXljRHhTOVFTb0NEcWdYYjlHdVZZUUZDaWs2RkExYTVMM25UOWFM?=
 =?utf-8?B?R05PQmhxaDErQUR0YUM0SHVFc1k2ME9RRWhBcHNJZFRXekRHWWt6VzF4ZXJF?=
 =?utf-8?B?M09hdG5pS2NJTms5Rm05K21jbzcrejQ1ejhBdjdMQ0dPK3hWV2hoTDYzN29z?=
 =?utf-8?B?YlRqQ1NPb0Uzd2RicW1oWXFseE9aN3pTSS9NOFhaUzc1TERXM1FrSDV6STJk?=
 =?utf-8?B?ejZLamtQYVplZ3lIRndUZmhhRDgxNU0rRnhqdkdaRVVGWWtBN0lOZkZ5Z0Ni?=
 =?utf-8?B?cFhuNStqQ1ltdXYvRzg1blFHTk40dURXZzZsVi9tbGVoa0JEUTVNY01iTWNK?=
 =?utf-8?B?WjZ5bVU0THYxeGQvdGw1RCtGMERySkZNU21TM0xvQmp1cW9BYTQwdEtxK0Vz?=
 =?utf-8?B?UWZkdVc5THlEbTJhVUh3U2NmeDAyMEZwR3E3QWZSNG5hUW5LckE1b201TWty?=
 =?utf-8?B?RVhOUDZaTUVJS1lJZi8wcDdSVStJMzJFTXY5OWh2Qi9NbTJnN2ZkUDVSZmtT?=
 =?utf-8?B?a1NMaTh6MS9ONEZUUmhKMmxZRFJSb0ZyZlhTeUUrSjlsQThWcTkvRUJCKzdw?=
 =?utf-8?B?ZklsSmlsb0toNjlpcGpaV1lvQmdZTm5RVVJjMUY0eXFSR2JmN1RIaXdMb2Ft?=
 =?utf-8?B?WnVOK1VWbll4NS82dUw4eGRTZ1pNdDBmY2VqKzZyK3I2TTZ0dkxFbzc3VkZn?=
 =?utf-8?B?b0xBREo5V1lZZGRIYVVtTTEwazBKNmhsazhuS0xySWpFQjBpYVI1OU1SRzRW?=
 =?utf-8?B?dlBmVFZ0dFBQTy9BdDgxUlg2YjBDVElJWDgvekw4ZXl6ZzF6WllQMXFWMUlv?=
 =?utf-8?B?TEt6M2FKMUlTeTYrZzMvdk05ektXMnQzWmxxdTVrUjNhdEljQkN5YTBhSXZH?=
 =?utf-8?B?ZWFtWXg5bWFXc1VSTVRRQ2JqL0duQ2Q5WWJqRUNuMnNZRHlxMFVMUld5V3BW?=
 =?utf-8?B?VjVZd1hzbnp4dy9nK0V6eWNqTzJLdm82UWM2TFg5YnRKQTliNFFKT1MxYzJs?=
 =?utf-8?B?T3ViTWIxaG9pWVhtNUZIRVpLeEJ5NkhJREVmM1h0cElOZ0E2QStob3B5TjVR?=
 =?utf-8?B?MmRYYnNtUWRxQy9uTlZ4Y3pPTVJ2SEk4THJJWWpqNGNCWS9IV1hkT2ttQlNp?=
 =?utf-8?Q?ZvyTgkV7Ry5cH6t8=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4399d7-03a1-485d-a7d2-08df243a2f6a
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 06:14:03.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+xAc+N7A5yas3LS9aM469dHvnL6CodzsDYE1+QAIlhswwLCVYJgyBd5/8srZt/0s88/7K0YmcrY21AncG7vvzyG2bHBy/bSoCfT86ydIKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0166

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
> 

Looks good to me, and selftests runs fine for me as well. Thanks! We have a soon
incoming patch set adding support for sparc32 as well on top of this.

Kees, are you ok with the selftest changes being taken through my tree?

Cheers,
Andreas

