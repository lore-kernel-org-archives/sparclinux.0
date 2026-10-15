Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021138.outbound.protection.outlook.com [52.101.70.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0543F8C6;
	Thu, 15 Oct 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094517; cv=fail; b=c9IhDYg1vE3TXsVoXj42rRhL6oS3KregC+JWQ74ZoI0Z/g3QF/9qz4CEsnkwOD56VCRPY6AxkT/Jlwqawig/1TlW8WKCsLatSV2K0u6lD7rAIlbDfPgdQiApqPWz8z2/xiAHZgY9dBU8iwUaqKCiSb6pXyeD/zAGtkAZgIEy4MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094517; c=relaxed/simple;
	bh=cYuDeXydhm0BbFqGcOygrPu5DeegAb9xuP36PNiRxJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCFjoeCNQ2do58xqC/PyEw1G6TwVmSxqxMImtlSmn3UFDm2ojLDO50GoAraauVtuW8s3c/ZU9BLVL2ZqyU1xQ73O+OP4CAzkslT3kGW/ZRhuS3hDzJQ/smIReBdI6qYsRd661DmOYyJOBidgcGqwtW4s6Ym55yFlSPh8TV+kk0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=Q1Y4idDE; arc=fail smtp.client-ip=52.101.70.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="Q1Y4idDE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHWTON65qT7xM1IgfGkzC+NAxyy+ocZZoF0w/8kk4CdPRQhgy/PfPLRU/TwfpizFVVKMOkuj1gW7F/02kRRRVNVMHuUQLykkmuoBEw5RlRDj4xi9whsh84as1q24rI2xFayYwRW4vPBBLX5U96yxg5ur6qlFk3W3BiWwuOGhhWnKbGHOSGNjIu5GUmDONi6Cw7NI2INgdieNP1KhL1AHMfW6dthWfXsI4pi+3lXA/Un3aog0P+DKvpeqscAUBohPoziybBlCPvvyqYN86EcYyD4XPrkQ9HHmdsZKXuR3DS6utbipEb+3sGTjmxU3OZ55TvU7O1V66JkoTf/EXHnf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYuDeXydhm0BbFqGcOygrPu5DeegAb9xuP36PNiRxJs=;
 b=ZjGHisqiS+ZSivMJidZM/wgHXY0djKCVaDeleQ5SdpOiwSknBRXKBk7CYAHN5ItMCb5+e3r7hT3VpHQR2geQNzAHmgNY/T53/fig0TzQv4ewX0Pmoom1xZ83LfckJJay0pIYmohTVOwsBdv83wIOywFBX+uAG4lMUifJKzauu7fwKUTgNEMIA4VCC3SHdDg2v4n+BYJUWFgnPVGFT5edSUg+7RgS2XitTtEQ8m0nyy36Tf/xT9QJW3uZpeFEyfwDzUCDvgfOmDtUI+e/FBWwYoNw5F9deXBEGPOerYFYJrHyZEJ8OWtbmZp8V++a9jcvb1L4cRwrFGxieu3wpAzt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYuDeXydhm0BbFqGcOygrPu5DeegAb9xuP36PNiRxJs=;
 b=Q1Y4idDE5ALl6GQAEjxvKLBoeRYeYp8+P8rSrNIHpsPX5fN5Fjn1ugV2fBw+y/7lsfq/RQLWrxsz9nKEgt7ZiikFbytTF6WVYcpb7PCY1RFXTpixpotkaI7lgNKo85FvKW6w64YDGOIa1mG2JZnFafJvyOyeXVlvH4iBwFogWj/8MJbiNVRV5ZJRPyy359mPao529HCwsER4dRfOCiKqsAZfsWfpFmVwXQgQwmYGwNg2MR45o0fganm5Rvu+5n/WFwipGQtHuNhq7VBSrxS0FINPXQ88l2LpUD00irlkNNEUH8xNNn73gK3tDeg2myUOybpPAipHusPUWoK7AWHn0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by VI6PPFCC3BA83F9.eurprd04.prod.outlook.com (2603:10a6:808:1::3d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 20:01:52 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 20:01:51 +0000
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
Date: Thu, 15 Oct 2026 22:01:45 +0200
Message-ID: <20261015200145.3876395-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2de8857e-a5ec-a1b3-cc4e-a201457e1a9b@kernel.org>
References: <2de8857e-a5ec-a1b3-cc4e-a201457e1a9b@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::10) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|VI6PPFCC3BA83F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb3aaff-3584-4463-d70b-08df2af72773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/kp4QCGnRPlljQr9zJoPUofX5IwB0SHuaBdboo2gSNLfiovKTmQ/46oZstJguSpUxVZLGdRfTyFAfZrqwjYEdslgwfo6fCzJLIPmBRY+8rQv487LUWmokiyc4/RHbxS5G4gPC7QOeifOxkWeQAD5gJp5CPjoaGDsFi0WtZL88iVp/V+R7gZv6bl2dW9l5A9g4Sj4gIsGQXxPaUdhuDyjKWtffBfdhjaVuOUB9b1MNotbWEMuzocIJ3lxhF88M4+wCOCMCKuSdGBiVxVcwKAg9TzJJTmnQtQ/2QtPxvFekKK8UkEhkR/vBD1Ysy5//shYSEHT/2KoE7oEixDrVfyqcALiKblCq11JwPbWvXS4/7pFMHuVa73j6RwvGCVOr7xU79f64M2jK6x75LcA2L7DfY1jboDEalYxWnBTiJGmrv4bxxusERovNjvAJBFiTt8eGsQ+wfQomnNqYbB19Hur/x6Cq7z2uu16rii9uNomt5w7e6hDh/202l9RrHugmke3Ykq7P/Jm5ZQbF34c7fTetpMxYeeLWbt2h0zxQ/b/LCWq358x7AHPAwZlGx+s6f1W0S/g0vI7fGtNkS17u5kRQm7x1Lyn0sJVK42XeEz3t0q+olDD6amk7GRlnYDtmqtTteuRI4+enJzV8NnjyPQOFsaaOa/i7cisjxH2BMyp+rU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dOEk4TaYGXOr77UaWvVujzrM6WEGPDpIUyDNEkNezNezxLb4JhlsnioEe1MS?=
 =?us-ascii?Q?tu7tp1iETyMEL0ikCq+aJilsQxY8Rs22HyjNmufIcsPbUw1FaY1PTZdo63Do?=
 =?us-ascii?Q?LZ742huPTG1+VaTW1o9m6git91IaDcz/fqmCMMzr/AF3w5X6JFOu3x3YLfLo?=
 =?us-ascii?Q?2WRXcBWNQ/+/lUW4SJ1gKzcGhFic1pbC6sZAEWyOMFPF2kynvw//WPX/pXSD?=
 =?us-ascii?Q?L35bcIaJ/DlMfqM3wXo1p8dCCoHCnLArhyRdrN2w97dQ2U1ZTra4479B5Fwi?=
 =?us-ascii?Q?wZkpWF2zezSacdBaQwsp0a9S7CqrMmqZ+0SEwYnbqGeKggBUtMYPv55ydey2?=
 =?us-ascii?Q?uSAwSL0UEL+nKG4JOwGzIT59x5dwrGQ66dWru8VLQbc3WbF7TPKjc03It6sa?=
 =?us-ascii?Q?cDtVN4hK7qOT7TaU0r5lGNBMN36sWnVke4dsIkixqlrEeto7VyXCY3+y6yjM?=
 =?us-ascii?Q?1aab4cid6nPo/piPJQIp8KJTzbiNkPLoOeiw8A5YULCmNXirKmqeNKJ8UjDD?=
 =?us-ascii?Q?dldZzHoJY+4k5kQpn8y9u9dcS8oAvckWk6fevKTS+LWns+rfgSIBq1eZlA3Q?=
 =?us-ascii?Q?Zb5cTZVRhM7FPWu8sTZw7ILoebP5kcCq18cKtT452la8uyZ6oUcR6d6sjLYk?=
 =?us-ascii?Q?2OokQQ0AMBq0V6LfYVqkJ2+sGUAc/UvaV+jMqxRwBtNIQvX8WODnCtQVF2wS?=
 =?us-ascii?Q?gUIRLxi+4I046/BJGr6J1nfkJeeX4Efplh1dTikjuuy9gxOHoxvXDmsibD2x?=
 =?us-ascii?Q?aiBDSSDlvLfTaW+vboq9gR8c4tVYvUqouwSxC9PTEick++YP+O2KC4xueEbF?=
 =?us-ascii?Q?J+IQj6l3g2/JeRX28BXGQOz3xZoqdjlb3Sbmo8u7P2Pn0oZmhsMqKr/jGMg7?=
 =?us-ascii?Q?/KmKQB+cmZp8vgVvUIM3NfJCjazwkCha1JYWOMLFrVEixt305+Pk6QwU9hWE?=
 =?us-ascii?Q?a4NdwMq8Mu4sklBee28wWtHzI3zxLoNsl4z2Nlj/EywZwN8/uNwvsdONj8f6?=
 =?us-ascii?Q?3YCbTUB1ByknIrme1hswQiaNEdDNKFAjIbRDs5fEFlxtvjn2c1I30zbaJEjA?=
 =?us-ascii?Q?3J7Q4lZIw3xrdPMbFBErPmlz0qznqNSwg7F3BHLWSo2ijtMkxP8vmjYVgtaX?=
 =?us-ascii?Q?hpYB9N2P3TBTRGXlEXhRr/x3c4scN/vosTcMIQIfmPmfYcUllR+QMLsMgmq1?=
 =?us-ascii?Q?RBV2/wdV4NeJA4zoO/fR+Xira2LAZOKgufaanWgyPP9vEIjrezKt2rftjXes?=
 =?us-ascii?Q?n9h841JvO7RlZIVCRNCxxWrB2mbKu+Q3Nr9DE8mPqj/1tiJ3qF8fZalyCxIO?=
 =?us-ascii?Q?nnfhJ0tXWk/zAeI7gwXCk5KdbA3jVI7DbfHQRVeIKXZgVVsuaTqV0gPIL333?=
 =?us-ascii?Q?Yu719m6fBrfv9CY2HDF4OSTQMhiVrXRTFZRBqsc3eT3BkX56wmhdwpcAOlK4?=
 =?us-ascii?Q?9oXH0zemn0Aioankm5Ud82A5X3Dim45m1iAaVjsNfF7IdX3PtOKbKEc/nbF0?=
 =?us-ascii?Q?aYIT+HLEFj6gNe6tYXhSB+S3SR5fXRjT50sN5m3+AH6OER92gsqGSFTzXnUd?=
 =?us-ascii?Q?rJ3AmyNKEtjlf+tgp7KZYMHjEuMRmYSqe4Wj5ohg7AJljOj21gEhv0ziUtY7?=
 =?us-ascii?Q?zBqEmf4/sBHRdCXLWxJ0M/QjsZR5A1ymL/vgIBv4QcjRdHqS3Z/1kWojmryy?=
 =?us-ascii?Q?I22XK4K35KGqIu3mXmDy64ZIsjJrKX9MFYLWdB8rKnXR2okyeQPfxn6+u4a0?=
 =?us-ascii?Q?DXIlxU40mg=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb3aaff-3584-4463-d70b-08df2af72773
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 20:01:51.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVxU4Xie1H20CpuQE+540cL6o1Igoz/rpAKiQj8uK1gF0+7dBdr5RNHaGI61Z1nfh87Y7IvGd1nNM9fgjnnd7UM5W353waxTLfOG0De8i0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFCC3BA83F9

Hi Imre,

On Thu, 15 Oct 2026, Imre Kaloz wrote:
> A library that wants to keep its fallback can probe casa once under a
> SIGILL handler, and that works on every kernel without new ABI.
> Whichever way you go, use ASI 0x0A: it also runs natively on LEON
> parts that have casa.

thanks, I agree. For uClibc-ng I will go with the probe at startup,
with ASI 0x0A -- good point, the existing code uses 0x80.

The kernel version is no help here because of backports, so the probe
is the only way that works today. An AT_HWCAP bit would still be nicer
for code that cannot install a signal handler at startup, libgcc for
example. If Andreas wants one: on sparc64 init_sparc64_elf_hwcap()
sets bits by the index in hwcaps[], so the next entry there would take
bit 28, the bit Magnus' RFC used. A NULL placeholder at that index,
as for crypto, would keep it reserved.

Thanks,
Ramin
