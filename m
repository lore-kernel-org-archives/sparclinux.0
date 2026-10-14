Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022084.outbound.protection.outlook.com [52.101.82.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA13EC832;
	Wed, 14 Oct 2026 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965275; cv=fail; b=t9A86OWUk0oWGor+jNY8KQff/nI/kU2IL5IEHVQdIapSvHPtCni3v7GAqb82qD+GG0WCAH0aBQRbSV9PVVIEquaWBfp+HKq47WoUHnajibjG9sBajKAphm2+eahYXNZYYKkY4aMVTEIWBy8pkiVE//cT1oHC/ILJFCDqjRKD4Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965275; c=relaxed/simple;
	bh=oBtmcv81IvsP/QQP7MJdDLe44YCpIYfdynqodEJ7BgU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QwHjIOlI0EJET0arBJ/h4eaL4+HHdWhUqcn0WrhbQ2RxR6yLsjYuM11oqdQ2V0Je+MxxhEiPGod409LE7gHFII1ANO3CvkoigFrSALeZOe1kE67uZnSertEEnm/nIlJRo+UTJyNwXwR1lDWPp7P649ZpoDF8EFMsw426Zrdme4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=YOoYyQ1z; arc=fail smtp.client-ip=52.101.82.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="YOoYyQ1z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQWtzpeeJRkc4K3blgLHfJ2MWHLRocEyr/r60MyrIdeE5jBICb7yOOG0WokeKf/de7aHKhVlr+5NNIgBADZk9NPKstcG1L93nwmfYq1W6b4k6qdpkcjt3GhNCTi6+DgCsFkWIkVok/xydqtz9iDuZhaVGplY/b9sgONF4H/8w9nKe7KQUZXlmDPcoIbGkQlWw3agXlNtUxE0o4Cw5QRkVWG0j1mD1GFnArREuXzUmD0Yhs6HJanYvGAxVwbx556Ef6fJOBiB5/KlVyUR+mjrqw0QMoGyIe2dM1JMC79HUj2ctqzUY0QAWJn+SV2QA0KygvGeta1cZrQ78P/ZJvtCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgvB0EzaK6LpAZ6iFRAyEdPEXTguS51kfxrW4Ngn/2o=;
 b=hvVgZDXnspWiQ0+86Vu5oJUyQz/8Gb4nGb8YAIIeqWaK76bOSRNzjsUWab+x6CJ5OwYbd0DFj9/B+5NLdlskBo0L6CCmyoZok9fldovyCQsj8vZi4xm8ztyzAIMYkjRap1mP6K9lBWvg7HIKiirj6TVVSgHGgH2wzFs8cYBDWf+dzkvV3tkiLuRU0AZ5fZdS4SC1DdRoXscZv3equMSaYyUswXP6TwmWkz4tqmxl9JhBE/0AiEyqBPgqe2F32SldRch4qpBpB+ZqKFKhwAcwxjSV2h0VcapAJ3KGiysNceOW8NJ9RUtWM8kUIUURCoEchkEQYFItwNeE6l3VT/r+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgvB0EzaK6LpAZ6iFRAyEdPEXTguS51kfxrW4Ngn/2o=;
 b=YOoYyQ1zsG3VoUiMTILkEV/ARLQFCpRKxGBVII1HnSzsIJxhhy6UN0thv5eVNt42xPoZSKM4c4yqR+s88Hi9cg/92g67i8uSUq6GNHcdQdbKhebyTKiDm9N0bWJGT6kjpF0XPKIszctun1DX6RKc/CR0TgPtMBj5oeLp6OakLETUZY6O5JpzyyuMGlUpQIY18dwB3CUNVBF+Em5aaO+hehiVbOnz/fjFevweVEf8ScHCweH+B+CvR0f5v8AAPi5ol1uhnEm3rPPt4t/okxYZEnRDg4REMMOcW3NNvAz/5IpZOnmAc67axMh0gxI7DYzvl3yg+aniXDQYXEWen10fKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::17) by
 GVYP280MB0208.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:1a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 08:07:41 +0000
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192]) by MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 08:07:41 +0000
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	sparclinux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Stian Halseth <stian@itx.no>,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: [PATCH 0/3] sparc32: add seccomp filter support
Date: Wed, 14 Oct 2026 10:07:27 +0200
Message-Id: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0132.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3b::18) To MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2::17)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB1058:EE_|GVYP280MB0208:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a21250-af93-46c5-82a3-08df29ca3823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|38350700014|56012099006|11063799006|261009223027099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EBYpfcSGlQBFnq6jpUt3XJ4Nx1PugPk30QZHYQQOtmv+v2HTgKiNAKvr2p1iPg9qRKkMVsFviNZwrnn0mscGFDb7VUKQkLNV97NumrIqF/FdF2ehNDF0L0ed7AAeBUihknOt3l1V0H7kXHC3jmzkqekvFJuC3t4t+L+A2qC2Ez/jtkRgncCosJMp9Hml2W98ehximBITOvPn+WigbEf8FYMiXoEETcJTXTXkVgoDepExEC98idTsN25uu0WpTo3lzIqhXNdFVtDYWIQSeLEOwhUFMEWHm/oyfV1kqYzXZk92X7jJkfMBRypCNtEzlnWXmYu3p30yI5z2uzJavjIzajfqmMX/BJU7BT8yCWo9OB/OyWiYcVEmkW2qR6c+l6y9/SBQgT+6VdnQTKKGg0sr514pjWEqPq3el6Ap2fHTkDY6PXN1sMnD71Rn0DtaDaFCvRUviS+ncMH1xWbMqrkq8/9xd71i6Ui3+2/sqAw+Q9wzqE+/fe6tYhFhW33AMi4+iF0O1uaviiRBZsLr5QbaxdXgmireWZJ1GnRpyDNNvsJkA3H74dTxoNkdD7m0jHFeq8sbJu1e0OZoH7X+Kx+dfZdKLOYdoMW32zOLoxP13KIdoK3zS1cMnrARGHH7GdMZhAml79Tr2XX0WOoBYQuCW7zWpGOJfqSkmvPBMQoHs+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(38350700014)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJdTiN0VpElTsSQrp2zZGTsj2G3eqlKsHQE4o8I/M26f+zx0A/AkrAwb6Sst?=
 =?us-ascii?Q?A/WMJtnOFloCKUt1A/ZUc84SbADuKKDoo9Jc7nzBKMmMN/C9wRfftQKJV7tE?=
 =?us-ascii?Q?5gFv8UJV5RXgODEc8QWnaExyX0R6AIrum35aaPC8MlZz9xcXMuvQiPRd6CNx?=
 =?us-ascii?Q?wNEvehRfpN2Q9PasyLCCGyfsTHJBcc0erwr2bX+GHDrF43ntE/CgBifCIyTw?=
 =?us-ascii?Q?7vyoKAoh26ytfUoNOP2vX7nDs4JN6LEKM8RTBKvb9b5tJFEwl8atL90kfkdf?=
 =?us-ascii?Q?pKBv/3/VjPXTjv29i2x769mmmzCoQnRIe/8L9C4KmmCWzRiqWTwsr34zIknj?=
 =?us-ascii?Q?vmMJ5JfYzYlM+nNBY4NcHA5YaJTBgkMX5sy28JbEY+JZqg/Grbs5B6d5VXkn?=
 =?us-ascii?Q?wm6cJ7CXiTTyrypoI3xdfgI+duw3tgU316KmVkT6f5WFRuqXNFc3yrUau3wj?=
 =?us-ascii?Q?Cqp3CKbB8pSmXJMCMbfY6VgoKs+TD8A/TwnTe14/iTCArJ9bXDyPEQASlWQz?=
 =?us-ascii?Q?i1zwOeeCs4eO0yM1Qjjx60m/1YFPXgD1P/hOKxab8ZbSddMn+iM7JIrGO0EA?=
 =?us-ascii?Q?p58g47PPt8Vg2Jkf7maNvq0OuGZJfrvOgwkz3XMeC7aCOcRubRgkWVT0S/zh?=
 =?us-ascii?Q?TUmwf9UEIsSNfP1fYOeHt7RVRRneVBeQkAOpRzVrHOq7o3SEHiR0vAtCA7l1?=
 =?us-ascii?Q?WUYHHMrgRFD+sKUpjLyy5X2NKMoh/5k/BtZS37WREXTgI777VCmDl3NyG+Qr?=
 =?us-ascii?Q?+ZigRMjOTrTZTH8IuvQ39WPFYvztNvxVe0A8jFcyvA+PgS5glBmB6isyyIIg?=
 =?us-ascii?Q?J6zyGSpjausdGVJmETvGrJOd1a1anKqGyDXRv6OB6M+KNWQqlYwNy172m7fS?=
 =?us-ascii?Q?mfkcMROWEiA0165lHk+ALI3vAbAYo2UIP0eMiviPbMGiYGEoGJwHSGh/+c5+?=
 =?us-ascii?Q?cT3tdrgiFCy1hIup8la9mv1fOdjBzEMw1lKm2xqefQ5l3hePOSbnG4J4e/8t?=
 =?us-ascii?Q?wcnpr5BWPcQf+ZyenVdj7DcAQIoYwiFkaphtXas2s5QD2D8+tJyo8GJUHZuH?=
 =?us-ascii?Q?HcgNg59QKYll5eQArC5ctcgStsG2sXAJ11JII4b06YI1iH26/S6wscKNOxao?=
 =?us-ascii?Q?JPbxye8zlRv+Q1u0URj+874UE2kjlouIqJy1mcWoAN4yuWPBrLKGCyzqKDAa?=
 =?us-ascii?Q?eiEQd1F3DbIH1QBe0OQgn+DcSfm8TUD73NIr/DkPwMEayvOnpxTBLQUQWT6L?=
 =?us-ascii?Q?B6UQIEyHM0dCjAl6V4NkdVEiTj9l7rl1C5LuJTkR2WQUCpliE9sXk3pc9aBF?=
 =?us-ascii?Q?LIVtscktY8b0vNFy9atj0DCuG16IvV4VfHSVjfIXwh8e+Xjyv7bF8y3ay7Qb?=
 =?us-ascii?Q?1a2wPIP5HLEv3YQOG221CukT6LMf/2qtzopTf1pgDv72YR93gZOwOq9JpC8/?=
 =?us-ascii?Q?xDhFtXwjmORF/5OyR2rD60MHgzhLQwr4YGqByGiz7YoNLMJxWci/tiisLj6S?=
 =?us-ascii?Q?QzcLJkZ9kzEkFZL+PSaAMiTFermFWLmQE4ckkACBFOWsFtWQW+PY5CcOtVN5?=
 =?us-ascii?Q?Up+FDu1Wjpt+fedaWgevq0QtPJ2n3KfjEUXz1CX5ElbDsY04rkzk0N9UbCsD?=
 =?us-ascii?Q?0sZoljcc+49PmbXWgZ7Zjw0FU4TH4hKDl4xG5T7+esLCBOf9yYK5ACf/IeQK?=
 =?us-ascii?Q?WR2KUc2wBojj/CotOjfrZPaRkZqLU/mhvKNexBLyD26DJTRSL7H5X9dmx5BR?=
 =?us-ascii?Q?XUbt/Q8lYClDc90QfCEdaGAPS+c/8vE=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a21250-af93-46c5-82a3-08df29ca3823
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:07:41.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HLmfjZwke6UbRlocEs6EpFLlZ8GqQkDjX1lyxserHcqJN5cbeFcGf0UcEkL/A6lHjekzAAl0r/LtivXTrCxvU4uIRBKRMCxg78vz7jmp7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0208

This adds SECCOMP_FILTER support for sparc32 on top of Stian Halseth's
sparc64 series (v2):
https://lore.kernel.org/r/20260902072745.3412940-1-stian@itx.no

Patch 1 splits syscall_trace() into syscall_trace_enter() and
syscall_trace_leave() as on sparc64 and most other architectures.

Patch 2 adds a call to seccomp_permit_syscall() in syscall_trace_enter()
to filter system calls. A denied syscall skips the call and goes
through the syscall exit work with the return value already set.

Patch 3 extends the seccomp_bpf selftest's SPARC support to sparc32.

Testing:
seccomp_bpf on v7.3-rc1 with the whole seccomp series applied on a
GR-CPCI-GR740 board from Frontgrade Gaisler:

- UP: pass:99 fail:0 skip:12
- SMP with out-of-tree patches that implement the futex atomic
  operations with CASA on LEON: pass:99 fail:0 skip:12
- SMP without them: pass:89 fail:10 skip:12.
  FUTEX depends on !(SPARC32 && SMP) (see 3f2bedabb62c) and glibc aborts
  with "The futex facility returned an unexpected error code" in the 10
  tests that use threads (KILL_thread,
  user_notification_filter_empty_threaded, tsync_vs_dead_thread_leader and
  the 7 TSYNC tests).

The 12 skipped tests need the UPROBES which sparc32 does not have.

Ludwig Rydberg (3):
  sparc32: Split common syscall_trace() to syscall_trace_{enter|leave}()
  sparc32: add seccomp filter support
  selftests/seccomp: add sparc32 support

 arch/sparc/Kconfig                            |  2 +-
 arch/sparc/include/asm/thread_info_32.h       |  2 +
 arch/sparc/kernel/entry.S                     | 33 ++++++++--------
 arch/sparc/kernel/kernel.h                    |  3 +-
 arch/sparc/kernel/ptrace_32.c                 | 26 ++++++++-----
 tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++++++------
 6 files changed, 66 insertions(+), 38 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
prerequisite-patch-id: 5772aba3cb572833df13529ec6bb03ae9e848e25
prerequisite-patch-id: 70a54ba398c763e45f9332ff4cc06b3f2a3e7825
--
2.35.3

