Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023125.outbound.protection.outlook.com [40.107.159.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5D3B27D1;
	Thu, 15 Oct 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073736; cv=fail; b=G8uc5jU3PkDIb71PXBspjFHWF3hWB3Dn6W+O1yY4TZ7ZD7Cyik36x9vwsLTSOIFML5jMRYdoM96Qeu2oLNOFrDD3NSdbxTcpMHLEOXAoZGqdOEbYG2UN87cIt+uWoCbJmH/Y81BNxImLuL2zTBSlnKK9xSG0FKntPdRkaB8nVmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073736; c=relaxed/simple;
	bh=eiMDdUX5Hm6XjOFl0P0KOi9KHfSJxhhIXWJm2A8BG44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eN8xz5t4eaG1TDOwiB0FYqNJWFToS685IHPW72e/wLv/NDhnCZPvyy6RTP0uEIIBAiiVH8NqxXcBRtGHnr416P/u3rg5FCEs12HXGDja1lYNXAkm4R+C7gJ1X8zsZfFmWCZGne0oR0ZR6B2j91qVRa7GUqy3VfLB/Ca9zMOp+48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=B3aDdflj; arc=fail smtp.client-ip=40.107.159.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="B3aDdflj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQbQYM/ZdbaqFLzairlBtgQK53/4E2AAmjPncs2CYSFCWNDWyF57gSZYUz4rtjJktYNkbFCYzJ69hFFOfxczCFfZpWMAfXyysbjDf49W/L02eXZVEE7UyZ86+v2swVL8URKC6fbhFzwInSz/U/BKv+fwa7Afx3o1n3DrB8EJlJW+XLGFrFhlVjukJvyLcOGyhPeI3psZmguMthXgTvCJ57MOi9oNOaybgM2V6wBOoIPfvDMQLcaqy3IFjRyL1/eVf/BpONOGaR6ImE7wvyjlRPGNVo2+cD8lGjeiiJs6JQdROLqfY2yoDfk4Q3ej11ws87xaCJ6ung5kRQZSsLxxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiMDdUX5Hm6XjOFl0P0KOi9KHfSJxhhIXWJm2A8BG44=;
 b=s1g7mSph4v8AekY73uI7h0C9FqNaMo+OzhKsR0KgFhEcgDnmnCCgC5T9bsWC3+l23/xIq8XdohOkT52UqeZyfaS8jKwlRV4FkNDzeQzBC0Yvvx3mqDKtAjOIMrXkgOtULitbx+M/+1mENN+D9cvMKlJQEtz2t1NJ0aWHAD63dthC5gDrzzbDqxCbQJmsMBxvm5YWlQ3emyjfE1vlgobJnaObgL+xZ+HWUSC3+H8Z4XeD0LZIiau8obWmQyx3Hzm2Nm+C2cgBQnT8qIIB9DcVGccPbDXfjOsWvfUYRt4EBc6BAccIcw4ebkw652T1OJkkdQednWUK3VdLUC+tjV+VmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiMDdUX5Hm6XjOFl0P0KOi9KHfSJxhhIXWJm2A8BG44=;
 b=B3aDdfljxZhS0XVmlNhUtXThH468IlecVaFtH2Hi63PEODg0PYkBkV/69jCGrjchPzx0sw7pDQpziF2RGKrJw7vrXuN4r/+7i5lCokdPudsQ8RlLoj+TtGtw8Tq/C78bSN0MqPeTmTcDAbjyGfMl5L0Ajix9s2dnMDYKcCdzZKxFMajcsM5SRvHSAbrc6LVh7QN2pRSNc7btQCyWjKbpx26BdPU36msLeQEeDrylvpEMnTHLXRwkLD5rLS4EZ/8eDWdSHOZdMlkqrWeOn9FS++PlEvCIqWdrDLIXR35kSHUcYYCvbJG9SSCmaAwqfRdw30avMafhZAod2KhYKHxXeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by DBBPR04MB7755.eurprd04.prod.outlook.com (2603:10a6:10:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:15:29 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:15:29 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Imre Kaloz <kaloz@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sparc32: SMP fixes, futexes on SMP, and a cmpxchg system call
Date: Thu, 15 Oct 2026 16:15:23 +0200
Message-ID: <20261015141523.3335959-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CA+=Fv5SqcMT4TLUVSnR1j9WxCf_iMn7Pr3vm9ZRKtkzqZoO6eg@mail.gmail.com>
References: <CA+=Fv5SqcMT4TLUVSnR1j9WxCf_iMn7Pr3vm9ZRKtkzqZoO6eg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|DBBPR04MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfc5f82-083c-433f-8f18-08df2ac6c469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	z1CsCUhH0qRJF+FHXfxEj0MfYJ/bD5xeD/6QxU+2C9KpIDxIs0A0H93ZzglNWLNIYjmh0VGgywRnN2nr3akrY39d9aYZ1bApIzSA8J6CbwzPvbIEzMUaNBCnDcYjERYIIi5mk4VG4LOrFwx58sVVK4No1e6FTNuCOEYRZur6/uZPAWLkI6HOgrLuEtv0TW5xymMt6627hfUJe8zDhnAxoUwxcZteFrO/9/oN6MCEAUoPrgGsWHkuy6QDXEVCQcvwuBfWaBqMb9312S61YYDfqLLSJY/6NINQzweqP6iBKBk0w92/N8BWKIBekkunCq46C+fES4kHxBwmK75gRln8Rm2yThpRs5NujIJ9hrYG0IJoI22c+s74BhaWU5uQG0YjfIqgJ7C1UP1gVIsDJLJDYTFhsqJYciH/+dhKu7sQJeBMruGl4itOK0Rr1fhfYaMz53KZ9NjW869B1fJegElAp7IQN98KW0zidylUWA1n18MdDnH+OMxBqy76lbDDxoDk6RLZxY3jSkzLAQPq5+F9beyL1D9U+3PHKcHOVQURg9bo5A4bQs6deGDee5APhsylmJI9CrfQgmxypwIsvTOb//ZtNuRuue00V1bkpAtoEZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtYIgGocnBsukvv2Wmn+kPRiikOW/xcK52zWm9N01McnQvZsUyLiNf3Dh8GM?=
 =?us-ascii?Q?qG+3rOM7W7GiGEw2yIH94PhdM/eZ1GawXIp5H/JWxG37T80fZR7fEEPgyFku?=
 =?us-ascii?Q?X2A1by7EH93g1GJGiQue/wwnmrp4bhzHNMXRE+Vaj6fbi8iS3CPWmdCxuUv6?=
 =?us-ascii?Q?JRt1/nPnRi8hsOAlXqAsN79blJtNdtNIuT0jwnB7o4o+ZIXbPdNWUtzlRLIf?=
 =?us-ascii?Q?7eg1OkrmrTb+M13SmeCmxMP/7tN3n4ADjtvF3a6J8zGqCdDHuvYIHk4lxetD?=
 =?us-ascii?Q?eQJrwHqHXUz6265t+l/Xh6G2G8Qse6hQ2ZcrlVNtJhKOAqJALKZ74UduKSCz?=
 =?us-ascii?Q?iLCtoS4L1OiK2gQIu5hFVEst4JoOwC2IrOsCKmBJoICSElhPzPdq4mKIolmI?=
 =?us-ascii?Q?9Zwh1se5oGhIUaQI/A/5Oub5/qngwaMo5sl3qnqHUXRTtVkf4R+Sp/GzkNYI?=
 =?us-ascii?Q?dHMGL16gW0E/81xu2HJvqSH5XgfUnwAufBHaN0GYwCB9y0On68nrt+o4edVe?=
 =?us-ascii?Q?kTetQAvGUDRvdyK+qR7nZPYURhCPQ75Q5J+HXpqSH/t9mXOJQG9qgRWypOg4?=
 =?us-ascii?Q?fNzy2n/I/CxzhPw0JY4OALbXAIdSwr27kT38fRH57wtuzcu/0XmeOVN9qOP2?=
 =?us-ascii?Q?N3iDXJVw1tsUxHI1QLEVaYeQ8uJka8rLeJhAF2hkSm9cFCE+6LDTsZOd6aIZ?=
 =?us-ascii?Q?naVAVBqrgFhAkySGccSlx2Udp77HpQs5DhLwq1r9OpS7aQjshn4KRS5D/814?=
 =?us-ascii?Q?v+O+a8O8GDm6M9+pvstJEtyN2FTr62W/T5MIGXxsTDTq/zUQhsr4I2EYQXJC?=
 =?us-ascii?Q?daneojzCcuHYUl9rGgQ1/f+yGS3eQZfQEUziYOJAAvl/UFYvxzQciByQT+qL?=
 =?us-ascii?Q?SgqKCGu0p5572wARoWqkIo7z6zr9hDWT6eAhi+S3hOn97KjbtelH+rzViv8r?=
 =?us-ascii?Q?Zgf1LuXeeew0y9MiA8BnwX7IfoKp+6LJmi+QZfslwZETOiqbDu/u3SsM6T4f?=
 =?us-ascii?Q?1cEjGgMYuZSt6gg3RgLKIa7DcpStd8Yew/qCmoEeKJtgCXF/2mfRwwaLkd47?=
 =?us-ascii?Q?gsP4VHCFlKAFBKvTslQVMjaEvOh0Vd1eUk3xBrRfengkBUnMLJ/QuWG8CIk+?=
 =?us-ascii?Q?V5WewUOcj9Gcij4ckPoW2Mx8pPLDnqzxDObjyKhOcIzWX0Gal/DrPTk3RAtc?=
 =?us-ascii?Q?TYEFppUlN2uJJokcsG6wUEyVbVVXGRSCozXFUZr2Y27tc2ErEs1U6XFhLiQD?=
 =?us-ascii?Q?Y5RMRhWR4gyjPXqCcIZBn9e2Bmi9Yg10v4wqsjADwGg9LQWW3AtLY7CK7OpD?=
 =?us-ascii?Q?vNJhrsy6WRzcadqaC4fCX+1wGd05YFTV9/VoeHyDU2sr+t8KfgLEXFTujv/e?=
 =?us-ascii?Q?zn9YrVEv53kKHrr1n0EmwxWRVWkNx26BEjqjV9wQRCSRoYa4VDs6HllRvNgv?=
 =?us-ascii?Q?YwCCVCxPFIU9MtmtkCLiX9u+dAStcdCOU/B6oCZqeS7e6NYqmDEJPhKrGFNB?=
 =?us-ascii?Q?wvbLeH9n31DXUdv01UgdHqhTFWFxht3+dFoshaqVBZPgqkZe8HU/i7GR9I3F?=
 =?us-ascii?Q?ug2pBSxfb38BgMyxqDixJxoE1TZwHqCvkGn8o1AhTrWJv5jvgwpesNSLcwP+?=
 =?us-ascii?Q?/vLRNuZ+1Kqn2CpTEEQY9Xy0/mNpIE9FVpY9FgO0pUMHf3pJV1/2ABcHEvsh?=
 =?us-ascii?Q?CVl0tXUE8ErDIGW9ImtzCaxxU5y2jTDfc/7n+EXvMlYSMPUHKY96BH+otZSu?=
 =?us-ascii?Q?FkWS/oEKQQ=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfc5f82-083c-433f-8f18-08df2ac6c469
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:15:29.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfRLumk6J/Xa8fIdAwlS5qaHDqBdQihyu910XsEkqHYNqYz191BBI/LtG8nItlhy0fU/phaijTWLQnbe7zzcyVCl+oCV6f+SnmBEcfZbxik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7755

Hi Magnus,

On Thu, Oct 15, 2026 at 11:36 AM Magnus Lindholm wrote:
> For the futex/CAS patches, have you seen Imre Kaloz's earlier series,
> "[PATCH 0/3] sparc32: SMP futexes, casa and idiv emulation"?

thanks to you and Adrian for the pointer -- I had not seen Imre's
series, so we worked on the same problem in parallel. I have replied
in Imre's thread; the open point for me is how a C library can find
out whether the kernel emulates casa:
https://lore.kernel.org/sparclinux/20261015141508.3335785-1-ramin.moussavi@yacoub.de/

Patch 1 is the same as Imre's PIL fix, I have sent my Tested-by there.
Patch 2 does not depend on the rest.

Regards,
Ramin
