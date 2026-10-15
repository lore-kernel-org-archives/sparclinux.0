Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021112.outbound.protection.outlook.com [40.107.130.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9F3B05AA;
	Thu, 15 Oct 2026 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073723; cv=fail; b=F4aCCxmqJpqGpxUSaOJz2y87EUtOdIcy7LeQ+UU9N6l1dVLXbUOCNvdTeMLe7Abffs6r0uNM3Fc112fGiwmlSl59xTbVFYvlk2udd3Jx+ZTZss02jCWDqKoydZqqDESiUTfmLJWLQbCegb3y3DMWz2xByQwASEePftD+6I2zprg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073723; c=relaxed/simple;
	bh=WO7KBR0qEqtUrd98j2kDsG3NMHIZB67jeIr7uRbj0uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxBH1j+qmD8wPG8VZESP6JuAXTRPMCoBNDsDttu9WUbjBAHavlRgM4YF6aJue+zA/FiVk+VKtG36RP2tYcx2W7JGCVF92JxQ/4EVjT84GUvhllt/P8wq/HUkd9sp/s5OU4CNsqb+4NExatSRs5q5Pz3mkzRdYLfqZUJsYi6TD6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=kDba1QWp; arc=fail smtp.client-ip=40.107.130.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="kDba1QWp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNOp2Q+C82/0NmZOAXZDMmNfwZkliQCT7pLtM2o0+vWrCelqSQS/rLYIYZkBo3ZYxFKdbMLwSp2wDYcEg7I7X0ILCN3ln1q4N5qjTSFmPHpRQuDoNh3Rv4NaheMl2nKaVL18SKIivaLnkZEySgKHMqza4T4GN/KDV3bSboq2Kt7D5tl59SXpPKrS1b6LFRcmFsKLu2bc8F4PqhW7Vx38HtgXL+uULgU51sI9l3cw+3Bc4/H1VaQSqK1u6GuM8DDWWdko90LX7UmAXcgCN1Z2QIgn5U2F2qiHBHLWci+hKKpTkp300mJGJo3j/sDBOxUrc4vPn36lDARGmiyG8X65fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pZXFhNFCCCoLK7bLGsPWAqFXK1ZAXnRiwJu5YoHy0U=;
 b=gojc7qobX9s2cA+HtN2KRYZYFi1FKe8E08/jSoXbnwCGwmUv1aTGM7Xf4IlpV1EKXaGHNfj0cYD+LiRSZny/HK5pZG4oEEoUpHD/EuCaA3braKAy4EbT4mtHzc+1f8ZLvNtIZuvONk4pFWrJ1asAp4NhBhOXhld0HMhDDGYwV/O6oZFS+z1sYrnZWsN+JBSRIbLBMnzoxOIJh/zxqKVahzp3ZmEMZ5SzKaVB1zgDK8JRbRPldiaZM5RJF2hL5I7FFFklSvn5EXAcoYRJbLtyP4EeDL4IYoIirm8siYnsC9OswSekGCSesc++F6PkXWnENXaXecIrFIPb3pptRP20Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pZXFhNFCCCoLK7bLGsPWAqFXK1ZAXnRiwJu5YoHy0U=;
 b=kDba1QWp2NKyUFojgzhZ/OlGBHDfdsvaX+dqEfREpFmhnkZ/PueYNbvkb0Pc9snHW/4EyyebTCzokoMD2+La8RBkRGb8cOu6M612aRRFPvJ1finl6zH979lKlhlbBsRHcO6wWa1aGTYeszsUq+lowWQFRblGI077bmSjjboJrP+cAd1ig+69B2SohAH4No0f4jJIbol2VoFKKIvnXR2AYHCLXenWKVJYQMhezpRM1YA5ae5Iu13S//q8ecENnS+tZfBGWsPJsGuSZTVkXa69Y3usJUyjpehz3CAsFZ0t32BiElawZlgybJ6uOjFjSKD3Y8n1paFG0gKf6mK1bh160A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by DU4PR04MB11385.eurprd04.prod.outlook.com (2603:10a6:10:5d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:15:15 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:15:14 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sparc32: emulate casa on V8 CPUs
Date: Thu, 15 Oct 2026 16:15:08 +0200
Message-ID: <20261015141508.3335785-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927005821.8369-3-kaloz@kernel.org>
References: <20260927005821.8369-3-kaloz@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::6) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|DU4PR04MB11385:EE_
X-MS-Office365-Filtering-Correlation-Id: 8914c8ac-6f3a-417c-3097-08df2ac6bb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|41320700013|23010399003|261009223027099003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mXfVewtZKPV+81VHfoWuy+voD8UUbxx9eaGAl3lLKGEW6Bb5Oxm0ORoUP/k88W77U9Jrc92aajq57fGQ9Ddktl2o3W0pQf8U8Mkkv1HhbLQX3mohlJ/L8ViQl6QKr0Mkh3H/Jtaxch2n4z65PNhMt64udPaF7XgYok/RlGo7q2/gaHIgPLe9a51nsMhln9r7Yg7U60XAJpRyIqyAQdlckn2Y1j77lz2tT6mPcs9puKLUhlkX5DdrML9an6PylcJfPTH3r+rObGZq4NMadx8nZxsJj2UiKgLtCq729iHopC38HWJqolRM6oYhA3FSNwR/9w4Ehtiszjgstv2aK5Ff7g8T7SZMPfMtu17Uwy4RWFGB9uHwaDj/W76ucjNkRGDhDYjuNqwX9idzcGAKtqCtTvnEycGy4NvFvJc7wqjOviWNmBB9PMSUphMCQC9QF3JslE8zQbPiIi6RSRInNi2xrl5d1VqlFIIAAPAw+6qMnm4W9LKGyvItlfMT6jVrC4gkAIgzzB5Bfh0f1HzwoFzpaEpPXeGDXCPmatBAHGqSZBqWgYkvfSsGtUQ9SNmkvIqk63GGPXR83k3nua+otJj36Eqqcega+MnYT2MsUgAcg/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013)(23010399003)(261009223027099003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ft6m8F4r8MHaaH70Dp0PVTbOC5BZiIIJNKAs69H4rnTWxM4s59b0C2X+VFy3?=
 =?us-ascii?Q?YBu27mN2f03shPJAfjF2SI0Am6lHFYMBnFBLgq/JtLsKmOmrQW5zmW3+5A+D?=
 =?us-ascii?Q?Pxu7GLyau3ttrAZ6IfZBQ7ZfGdw4o4rZdeEg9gifRgTwAcoyOxMOC1dCB+Zd?=
 =?us-ascii?Q?givkgGBxqfLQcdkNBvnxDMXbE6nWmVa3CK11YrpZZXH6le45nIqZMCweAt18?=
 =?us-ascii?Q?2u8dGaFRwyqTzn6GtyRdwVJGs2l+ImdXoXe7sgAr+2blbHX9LKrgWsNsEsEF?=
 =?us-ascii?Q?Krxi8fJ1AZ3BvLpLqf8VOqMiI6eNEfZ9CaQfTQSZWEK8bp87YX2AMfFooYqU?=
 =?us-ascii?Q?S9atgMELNxQPSVR9SJ8I3SqS03XJXsab18u+aORR0+hUBJJ3yeD0+lVB/PYR?=
 =?us-ascii?Q?0G/PGVkY7lH6hNZYwBDuWpD0aPywge4jNImrKTiWb61r82PtXatRXI+I0e2R?=
 =?us-ascii?Q?mJQgBPZ8CSuhFD9MRgaH+N1fj3RvW5xueCaZxi9O7M9dVKo5SIxQ1xoTQ7pk?=
 =?us-ascii?Q?/bCnTCnMlYg8rYd2JjSmgCOUUOVhA42PgoZ12QS+hiesD6lgWzE4CjiMYjrD?=
 =?us-ascii?Q?iug1EV8ul7qacigdFd700BdMQh439gk8XkZzqiPDCtiPKBlRMA/osPhgLRxN?=
 =?us-ascii?Q?IA5XSsBSTAYuu82KON0Lwod/b7kaTa20aERgqQG+wwAL6CFZR3MYqN4fJRky?=
 =?us-ascii?Q?4aMBaMCkq+VPi670AukKBoCH1Q/ivfRu6nOME2hoEQarMPu/wYtIZFU8T8VF?=
 =?us-ascii?Q?eMB+V6tX0Fed7SKuQbyvPEuXMOF+xY1gF9pIlJDcCdA4ajkXx0tpucajLxqT?=
 =?us-ascii?Q?vTlamG6XJ3CIKfo2FXn4Va2mchaDjj1XuoJtKn4VsKOmGp69PqF+o918P+LU?=
 =?us-ascii?Q?Td0P+2LO/2pPlj5dlps2pcQEtLFmXy1X73k63VbXdsvqmqFAbfNGs0GCikoh?=
 =?us-ascii?Q?EKBrwGWZYvc67/mygrV08ozsCFG6rMH2nvwWJ0Fu5NflA5izWtgf+Asuec67?=
 =?us-ascii?Q?No6A9EEzCuE0QLTAgRGlenNKRBTDqlppayBUb6Si0Z3gy/rF3nBDBFZTZ0J1?=
 =?us-ascii?Q?mp6IMDH8fREc0PIDcQNLI3l/Jp4KenU7bLsmJQnrs/YBGz8RUnzOwO59qnc9?=
 =?us-ascii?Q?FUS7m/nna10oGj2RoSu1VSt1v0hRLpNn4BXbookP8DbVMetIkUJn4Vx1rrnB?=
 =?us-ascii?Q?DO19RCNbRyw7JZJbMnyre+xgjh6zjrOu1p7khKpF8ilFtPxjuGm3kC4+jJEa?=
 =?us-ascii?Q?Ou7StdJ/kAxAgMk5E35q9u3isZ4cWh6LvKA6ksHqk0oXDuDIztp29Ade9Gnl?=
 =?us-ascii?Q?u6RnAPwt52FIeopQbtMBLJPkmfndR6AXVw04mgHiV2DgGQylRo+I5HLkaXI8?=
 =?us-ascii?Q?l3L7nyYo51vvvNgSMwpU4I05lM2s7TBGmnE/W6aue0w8yGvALOaYCdWQrYRx?=
 =?us-ascii?Q?c/4AhQyEqDJqgoDc1SHmDu8E8rCVuylLnPOG9BfDIFsNGTgHAi6QXc/xI2ke?=
 =?us-ascii?Q?j7SFAZvKevjrP+qXJ0oe9YgYw8T053vny8tGsnnQKYL4zZA4Oz3H8JBp+i43?=
 =?us-ascii?Q?JHh8Qr1fSjEZZFBirZwI2T2SuDVw1kaEvqu0HAliGRFdpsT8/dtqCcdpef8V?=
 =?us-ascii?Q?578mLWdbUrxMLShT9De5ccRbRBNxcYeTaliJ1M9tXpu7yj4YEeo/A7qdN9w3?=
 =?us-ascii?Q?4LwYsX4ZXz1lhyOPsOsPoQktRUTY3wMVYCXw8mDKCxwi5uGDABNsQyR/H1n5?=
 =?us-ascii?Q?74Z0pIDFow=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8914c8ac-6f3a-417c-3097-08df2ac6bb73
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:15:14.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBb1+4Zh/aBrZacigf9AQb+Q8ep2VJMr56istwjvreIApIliUhJ/rDQsyNI22wPZAHIhwceUHixxJgja+ya+1v+HtdC9PLu8YUpsRzcZhLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11385

Hi Imre,

On Sun, Sep 27, 2026 at 02:58 AM Imre Kaloz wrote:
> so a C library can use one casa for its 32-bit atomics on any V8 part.

I sent a series covering part of the same ground, Magnus and Adrian
pointed me here -- I had not seen yours, so we worked on the same
problem in parallel:
https://lore.kernel.org/sparclinux/20261015085545.3246951-1-ramin.moussavi@yacoub.de/

Your casa emulation looks like a good approach to me. What I would
still need is a way for a C library to find out whether the kernel
has it: a library built for v8 needs to keep its own fallback for
older kernels, and there casa is SIGILL. I see three ways a library
could tell:

- an AT_HWCAP bit, like HWCAP_SPARC_CASTRAP in Magnus' RFC but meaning
  "casa works, in hardware or emulated",
- a system call it can probe for ENOSYS, like patch 4 of my series,
- or trying casa once under a SIGILL handler at startup.

I know glibc does not want arch-specific atomics: on v8 the compiler
turns the atomic builtins into calls, and glibc would rather have
libgcc implement those with casa. But libgcc then faces the same
question, unless it simply requires a kernel with the emulation; and
uClibc-ng in my case keeps a fallback for older kernels. So from the
kernel side the question how a library can tell remains.

Regards,
Ramin
