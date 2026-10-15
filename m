Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023082.outbound.protection.outlook.com [52.101.72.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FE51D525
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070988; cv=fail; b=JqH0qEhdbd7ZaCUBFXP+IPKfdKyZDUOA2ntU6g0lYEUVownyvCsZrBA+kjECO8SUVSgOm2Gj9s5CUuVdYLMU0aamIfx3DxvxnjLmQIzdwtaWeNY1TrZtrwynzCeHrViFgqYBSihq6prdLsJkeoFbzIVEapPknmXI8/Wy1KvhMXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070988; c=relaxed/simple;
	bh=Gk3TD+iAv1hEqDTKbZ4p5kgSNPnVuWHPOpTIBNo1w/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CeLUbcpnDSPSdb72dQj7keeV/PUuL8ih5mMX2Q9WrDihMdWn5qcYRkcCRfAIRLzuyItBMJYu1n6yao1d0Etmny3S0tTWFxJO0B5QM7e4XOqbOoRkKwjGaHV+XM9HfXe3/Jw7avljAeivW9EmjvALyG2ORWO+sI38a5EOYJwOJHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=Jag4Mtzv; arc=fail smtp.client-ip=52.101.72.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="Jag4Mtzv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/vMRrKY4bSQ4XO/Q0jqr3C1KLQWY1MqkWq5e87VCeTZm67HElqMLHzfft6C+9q7df3LyQzzfi5SmmzHHAU6SW8PmGjdTbphJSm5eH1Tx4crL9UJWmdTs5SpFZqbhpwACqU6FlT0smdHkNiEqB4ca/CJtxclrIwkS6SiA36m4DeNoH0t02rP9RWpz/r9Kz/4Czycq8eNxK1vxyyZm5jba4Uqmy/COGy+AVMLitDGqB/9DO/1qFneKFp0BfN1XBWdykJARpNXJbwbcoeafr9yrLN6CIN/vsmVuwYotDIeWfsTJTWaNEYxMfrF4oijnd9x0vFUosmvRUqMWm7vhElVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk3TD+iAv1hEqDTKbZ4p5kgSNPnVuWHPOpTIBNo1w/0=;
 b=aKOEEzcDbuharxghBvQSqK3TiTnaLfjQyzHLaDrYQaBaHqZ1YQ9xSyrX+nrr2JWHuf4Y/xATryD0hBMG5CT4SHvW5RfHeUG8Ieap73BUHtlgRlDiUVGiahlgHdKlSI4CQLNPITznniC98vQSYXWm8B/YcoXPpacZJVgJpDEStVztcWSbd2WpmchwzMHXofWZ7kU4/BOBOaAHCjJDJCmMX7r/BmiinJVIC6Wkpb8eO9bIKgAMKmkrvmOSBUzesPRfWsiBWS6tfCYEX1/PbfvPy/0S5h1xV/pIiQZMIgM/XVKT53UhBVjSfBQjtuF9M8h/GBdwVPQQH6LtWLSQ7g9psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk3TD+iAv1hEqDTKbZ4p5kgSNPnVuWHPOpTIBNo1w/0=;
 b=Jag4Mtzvblia56/zZNsi5QaDpGsPJOoSDiUZnBG1F/+vLckjNWPrIUF8IpE1KKtR90XFwKzwnogCSD9dt4U31MfGSi8qcv8dbIg4LdazMB9gz9KMlE4x1yWsvy97OuM+/Q/PtY89meo21JsEbFPb082eaud8TXastb8rR9ODwZzkcslLw2+aEi0ifPHLBXdnJejSPyyX4kerxLo6paPmjXVvSma+JzP32CKzLmuetLe8TzeTCKsxelWnadntzUVAdpYyyoSAa+RiC259J/crNaZMKLn+TDFJWHHKF103UX/92kddQXEkc4lB3Gl4RDvubTMa5koLrjbqOMQzJZF2DQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by GV1PR04MB10332.eurprd04.prod.outlook.com (2603:10a6:150:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:29:41 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 13:29:41 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc32: keep PIL raised on the SMP ticker and LEON IPI exit paths
Date: Thu, 15 Oct 2026 15:29:34 +0200
Message-ID: <20261015132934.3327814-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927005658.8242-1-kaloz@kernel.org>
References: <20260927005658.8242-1-kaloz@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::20) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: f7673261-b076-4476-fa43-08df2ac05db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BROmelxO41LhBr3zX8i7e8usfUinqQnsmKkIrgSKsT2zKhXB+DvGHfymxkNwlTAPaOfVmFYPzMbzU6C2wQ0Zuy9rW7c9rye0YdUZquzcUOt4v6q31H/5BQHnlilZ2b9DevmRpEJ+DS5okD1jXVxQ+BlgRvouXVVvMl1+PKZbMinT+mZqq0xF1YcUs68ePjVOQP0kKjT6C4RCI9L8nyB2AO/2uEf7/SLK8NmShnjlT3ID+2/K8rmRSrMaTJyAcvkgtkTifn8NRDrQX2be7btXlzWgm4BKsQMr4rl3eGun0yXfmvSzNjCawgShu8wDYUV6joTgzR+4pDWfOuNc2exUFpb+FTHvpEx+UJi5W63Zw2osZN9HmeTy8qhhEGEy9V8wAr1z3NVSDofg8WIae7DXNHcEBJPZn1TX+NosYDGrxZnictkBuFWXX8jnLjMgIIpk8b5IHpWwgi4JTEm+q5E6XSmN0eBemoirzF7aTZak7pzoFB7++caHmxFSNYtV998W758d6WTLZ0EbXH8ZZrDwd7AFe/aZyEIOfQxrSUUqUs+493TtnzPxbYmsuuUtKgknTNAACltWsSUd0saOU/3Fu5154NwlutBSDZT0yRSekVgvjTURxKL7R1pboyS5Ob1c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJ02ZOmsJSjd2q8n/X73Np5Uj4nYDQyvAQX0VcHfrJKY1dLbplZxC0Upqzfl?=
 =?us-ascii?Q?IMW1+TdQs7KD5sdfa8Abhbwr53bj+mXQHIGDDLLoNzX6AY9C0VCqusZ/Pcc+?=
 =?us-ascii?Q?aQwGsMhsIrg5gOOvNpmjYCTKvL8Ffd2qp75kst4evsjPBy4UlHdVAQrz0Kib?=
 =?us-ascii?Q?fMbM428F0Erw3vFSqPPrMiuV9E282kAa2ZrvSthtx8D2+EUctm08e6LYNPni?=
 =?us-ascii?Q?9AmJJy1t18fyWo4LQrKy/xM25KR1ca5kEoj+WDwaLmpiEwXpNGnHvy5dLoPr?=
 =?us-ascii?Q?qvidTgO2bV2McF+6nDXNwnopPdBftsKMVvhTiUATBnKdRar1ctRY7bqy9IoH?=
 =?us-ascii?Q?ClRp+6Uw4iKjAMkaVBr+2W8Gmo+2vj1OAAi0snZYgKrkHfoa2zDjLh2OPw9E?=
 =?us-ascii?Q?Ra8Tb/hquoLR3NeO4OGgNl5xArCHS3asV9qJs0VK5cyqxHomnSHAuC90bvMj?=
 =?us-ascii?Q?Q3Egc3ewi3EWkLxl5dMqyjIUcGp5dFEt0w5NBKj2aqh3bYZJcjvYWZADknr7?=
 =?us-ascii?Q?rQ6UFpwLJdy/kEjjJ4jsaMeZmwnHwLc66OPMZLIbzAqhiIPE1tS02k/pJ2jN?=
 =?us-ascii?Q?58S9JaUWRY1YlinThScM3/6NmXgTIWleiNRKVoVf6DlwOLfcOy2rsPD7/Ycf?=
 =?us-ascii?Q?31eXgVHThQla4enavSf6kPi5Kr72CMS9HyKFbgiGBrXixIWKReLltVa+CVri?=
 =?us-ascii?Q?ZmIW1ZoTwl0S5DRf7g1GLgguSMQcsHPBW4lKjxlRD8WniIMRbxiWzDQtrtMB?=
 =?us-ascii?Q?TIgLH8TzykyFGoW05qG2nMQ9MdhoCsZgnHClECRsc8qDWTk9sl6qzcGF5vug?=
 =?us-ascii?Q?YrDRe/hM4OA0j44AcIWvJadanBG4mPoemNiyDbXDsuReaml1KKfrG9zJyqbI?=
 =?us-ascii?Q?nVP2Ga5OQsIiNPNksGX4XOBckAykcT/IljSPs2VZLadxnLOZ1PeynmN2s4qx?=
 =?us-ascii?Q?PpT0diI4TewDPApAQO40AjBBUuauUVBUMkLqul2LLwD7deTwErXkGSbajhWU?=
 =?us-ascii?Q?UhvGKGkbJxe+VUV0JnxZv027ll103AXmJ6C7Jz3kZgiHMmCdLn0qL84BnK2u?=
 =?us-ascii?Q?dLSnZ2MpVzGy3jWe7p2d+zZm5cgG6j4+7SN5Ka84d2J8qNCiLJcfRTJhHzEi?=
 =?us-ascii?Q?hC9pqVoNy2ZMBggIzr09TifZr9r+mnVoYExFrAxQeNbthgrrZOpEkMIr2syD?=
 =?us-ascii?Q?keEB7MZH8DCdz5QxN6kh/KUayS//YCcSOQfk+EWyrX0CsjBk863JsKRp2P82?=
 =?us-ascii?Q?LqxKmeZr7j+Nt3Jsrc45cr3a+qbnBEz/tj2V5YDvujDz0y+KB6Q/QBAQ0GU9?=
 =?us-ascii?Q?Jp9BbwTf+hFCjfOJfOJMciElURVniC90BkyETZ9ZItCjuC6hWDDpLvUbg1Pw?=
 =?us-ascii?Q?XbaZQDMYW0TgGgyO94ebszg+8/E4AoZ8sBPDMs6YNYdgVZiaIvW+IC1BtBaH?=
 =?us-ascii?Q?BHZ6npu+K8kHK8U2DXp0vLTfoz9wpO8tXHqWDqirxkmfeml0oTgS8UuwndDT?=
 =?us-ascii?Q?YRrl/kPssVKXqFYC8KQuj441bwgw+wm1kV3c0ESL1YKEYFVSgDV0Q9LoAqPM?=
 =?us-ascii?Q?vaflVZSRN8hC6pXCg1qeiBcXI6VQHGcawvudign5FKyvIInks6sI6DR2Vw6o?=
 =?us-ascii?Q?ihrmB+es+m7Mk706wShmHvAg93GizUu757dtEoZeO9X4Jj74II5k0AdzA1Y7?=
 =?us-ascii?Q?+l3hqIbaB1s3T6NRn7zCedqgG9ApgjyBoS0Qv0bptSfbfY4EaItg09ZXV+x3?=
 =?us-ascii?Q?S1Dwdfb9Ew=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f7673261-b076-4476-fa43-08df2ac05db7
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:29:40.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0MwASDWO0p36765cn62JO5b1rXqQtNfbLIjxuSmuvxr+DZpLZ++j+4zYQrrjX8nMlreGkAG50oyyrulG66FRbm7+fZ9p4ElBwG05EzN8N4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

On Sun, Sep 27, 2026 at 02:56 AM Imre Kaloz wrote:
> smp4m_ticker returns from smp4m_percpu_timer_interrupt() by writing the
> interrupted %psr back with traps enabled, which drops PIL before
> RESTORE_ALL.

I ran into the same problem independently and sent the same change as
patch 1 of my series, with a description of how it shows up under qemu:
https://lore.kernel.org/sparclinux/20261015085545.3246951-1-ramin.moussavi@yacoub.de/

Tested under qemu 11.1.0, SS-20 with -smp 4: a multithreaded process
writing a few hundred lines to the serial console sent the kernel to
error state in 4 of 4 boots without the change and in 0 of 8 with it;
two full runs of the uClibc-ng test suite on top completed without a
crash.

Tested-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
