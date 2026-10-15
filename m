Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020072.outbound.protection.outlook.com [52.101.84.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0EB453A44;
	Thu, 15 Oct 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071813; cv=fail; b=DhZ0dSDGI9t/2RUopDKQivRiLn1mYKjSAD6smWTzAmv5QMcmX2/32TU6gknWq5BlkMEillCl+UhJeJP/pDjqfXcCnBffVGo37UAQFgrO1ujvgUPfuKgNVXyQc8Kb/odqVFaN6pFci3/tJPtPJeetio3U44t3vSYPHY6mNDHcDlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071813; c=relaxed/simple;
	bh=EnoFa5iI5lUrHnNGMjp1yS1iXyvyZJoo+HXQEj8l/HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpn2c6ZliZV1cl9f3t/v6vRGMozFWFkVdfZMlW2ny4FJ5KtPBYv5Wltysfw2V4iQKcAZx6+NADiHLU84HTFSLOx2yCxlJs0OHvYYHVEY5ew/gNfAoU2iYy8iC39dpiq52l6/xlId66qRc0aqaPWGv9LqPO8umMBylxrRBjxvDmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=Zp+S3ZIU; arc=fail smtp.client-ip=52.101.84.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="Zp+S3ZIU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q41bIciAaIGY4Oc1sjd0p1aUxZw1IOTLeXgE7keYCgTxmHqMZFdHnziRqaR4jCp4wrFu3o/97kLaPBSU5OG5cE9xHpeu5JoSgBaHew5P3ZOKXa0O62OLH8MnXbSXkyVGf5CaxzfCEx3b+XNyMDd9194KM0+ePgkT/0dvKiPe80MZj2sOXf+mq2x8x9hMszHq2XWMX0dHb6RNo9r5wa+Nxhxasqc77hkow3jBNUp2lZduMKSCTLlAJjN9fPu0ZpNHpGOf2vD+bp3AGUDvK+IrA6J917zPUpx0gHtD3cafAdbBUD0HYQyCVB+6xebDMNxGNWj8qE0C5YcR5G43Du4gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnoFa5iI5lUrHnNGMjp1yS1iXyvyZJoo+HXQEj8l/HE=;
 b=XA50qHsjFwM/M25hSexovU8Erwootkw6jNMkibPjhYqhqUQzekyA6E8TlWyOIqc/cIvMynpSBSULtShGhFwETr9rgwZruQgLgCsQBbpHbAq00GnHRo3pj+pOF7Nq7htTKJNzNi6kC5KEuug2TGZUF6YNnJNK7kHsoVwiUFXkujt7krjhCru5YllIxc6f1DVOOffsn71XAabgF2Yifq4eMYNGcjqB7rfLXxmI00zXuzTX7DRRqE3LN2RVrMRk1COQ70oNq7YoEqSsqG2o32vcwDJIyMIt2Y2pLqjteVOFw5R6sZFqu5U/fAcffNKcDZdqR9avOanp4vp9+6lW2UMlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnoFa5iI5lUrHnNGMjp1yS1iXyvyZJoo+HXQEj8l/HE=;
 b=Zp+S3ZIUNu9pPP7IqYhCVoPJfXc8cYY/pRbFkrxEVKL+dWpy2dhPMTvZV0M7/LQD9YbY9UuPWozhN90LKHOx2wrVDTqUNPPSVO4VprRQgZlQFt6BNWG/SaJJ11+pV1D/YFkZsfhEk+dUzF++NgXlCc65uXOAuzprlFaS0b1iX6F7s6S7y5lx/uAYm21NGng7xgD5l8puN52RzXwX32YkLx1TwPG7EJYEkEITg1ADd2BF4h8DmtSiHMKQVVlZEQxaKjSWGl9E28Ys2eJKIYdSpOXGtKcCzwOUYIJJ8iUSLVwITlsRo6+L28KEKKEhv0D30rPjQtg9/qo3gMB+WCrHUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by BR0PR04MB654605.eurprd04.prod.outlook.com (2603:10a6:2c8:47::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 13:43:27 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 13:43:27 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Lindholm <linmag7@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sparc32: wait for secondary CPUs by time, not by loop count
Date: Thu, 15 Oct 2026 15:43:21 +0200
Message-ID: <20261015134321.3331021-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <26e4d054-c1d6-4422-962c-e123269d36a9@app.fastmail.com>
References: <26e4d054-c1d6-4422-962c-e123269d36a9@app.fastmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|BR0PR04MB654605:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bacdc28-5821-4524-418d-08df2ac24a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x5YwsiBQ9TQA4dUs92O1OKM6cLMSmPBuhSOwQvhiPZe3tZ55uSOmHgPjt0lshennqcEQ52VBXgZaJyEbA5CQBv8wDq+XHBdNrIt1JGkMXw/cyhiUv2orw0TQLAEma0ou3nmGHh4vJ8Wza+wSenS7ek/aBr9fF0FpeM2wuffQO2j3YC35ZzqYvPLNc0P5Jjgs1opLezpDobnBHEP5cuho4ittqHmVHqE/9t87oGbq7pkUuTDOVhwND6koHJChlMcXgNMLjPhhH9OdiTy72KhD8aZgFRxBRwS57/pfdDWfqT2E8roBdT5V9n2z3Z1vO1yOW8n1CQQ4noe0kPrnPwBQM2ghYAcQg+6+r0E4ivHQcZFkl66k+2t0eI1YG81i2cMYq5LPLS+Oa/LZqQXSKarsqoW4EXbv5T9AACmZnARhkn+eXFDqTe4+/YP7vYukqZdlTz1eh0Jpxa3P7aZyD4KROjoqMm/pNr3l0/Igb2GlclXwzEbSdksCIBdinq8Iq3FS6mYeCSZs/cfcm0g5T8xr4Flo0NRdfaBN6K0eNe2Zuwc2RGlJwuqFEKZQEYDnaQoo4Sm8NssV9rchOTSE0db/wpBlSO8L5n3efC8NIQCG2Pi1/JoV3da/ga+dO7ftn98SWMixmVMYRo0PqEi8YPZZSNjlS1Xhzu1wys9Zu1mYksk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JvZw8WdUI0E0Hxtb8Ntp0ibEVAwk7YoANYQl+PsVPZpkI7phWM9kdIuAEVfQ?=
 =?us-ascii?Q?5n/SXnF0c1hWbPeYaqvmLY7Q1+LIJwt70JIERMU29UTUAPZjxxrtkL8h9N3v?=
 =?us-ascii?Q?Ye9qOKrNxZ6+dAKh9FvvtSa1V5WO1/NmVVRTZCooY7njQ/EtLA/YEtP7k6II?=
 =?us-ascii?Q?EQcXdZZsHY3OiLgci0sZVxrneiqUpp4Sre8KWQG2MneFSmmvdWhBTzsZJU/U?=
 =?us-ascii?Q?lpQxqc80qOKhHLnqERzVdGKDLZ/Sg4aVJuHLndhRb4o44Rzl3bX3vOwVXv/D?=
 =?us-ascii?Q?tVV0o+WEsmCveU+r544aM9xySDJ8WpYr88zduJPMbeZspz9dntEUCPB+PX2O?=
 =?us-ascii?Q?W7oKpDkHBZbVZmRO39D7OWqXl7rro42pfgf3q7ET/ZvFNHJXr3w8ct2alb+o?=
 =?us-ascii?Q?7UzlVOtzg+XZ6v5EhwfSEirYAOTsjda1lPS1llCM6k6emOICBGOURqqOVyX3?=
 =?us-ascii?Q?uG/gapevcDJmNzWJqK5vy6XIXox2stHzA2OzovCa3s+kXY/8BZ+1R1BZ5Mai?=
 =?us-ascii?Q?UdceD9bkcwU8NSvhpQBWosW9k3TSY/gZMcfMjjCHff2spxnVYSYulrr+pFQ5?=
 =?us-ascii?Q?wMhRoSHengqVXci3rihAseK0GwVsJuc5ZDvTJO8i6iebmMVIBbccbyPB9+Fw?=
 =?us-ascii?Q?8Ze+Lua6Y3pvLmPeqlZXVgxG3fDPweVrvzkD2vCYxY8K3U6rgdqPc6H1ugc2?=
 =?us-ascii?Q?ni71bT1cUeFp6RPlaYlMmm2nFiPjFqxIGXT8AYW37wKTR4CGHPOTI+42tW7a?=
 =?us-ascii?Q?dqRLWho0wyErowz289J/P+o4e4a/pMNviWore62uTqGOowUousSPiDGguzI3?=
 =?us-ascii?Q?lJ9n7YYZ5ZfBI1xs7eP1xeoExjd1XmQQ2SXmKs9Ow/QRKJVJTvUmnq2kZnDU?=
 =?us-ascii?Q?ChMcP6H8c4tgKShwDIVW9P8h2STHqK4lc0Tjup+U4KV1SmVZoJKzmD9yw3db?=
 =?us-ascii?Q?OqoiAeVrtP14+/R5IyeW5IFn3L/mkBEhRRokarlRRn6pJNdtZ2/yxZ8Ly74T?=
 =?us-ascii?Q?nryMcbLJbWfToZhgwiz9m92iUyxsVuShqbWyOix/SX3rPrZDq95Ec8JB+azu?=
 =?us-ascii?Q?hSMfR97Pn3+6uJbCXga9iT8ile2uArcmJc3dhuy9FJlV9W4O+tDHXicOBxKX?=
 =?us-ascii?Q?klOQ41w7KjjEvIWvys382Wu6xG0TJotEWEh2ToI2m6w/5NhRI6vRGgguH8AL?=
 =?us-ascii?Q?WXiokHHw9l1IGxp73ZZCbQ+GOtUWbmFXSTDtFLeZnJLm4gPJXFUAMEJVyKnW?=
 =?us-ascii?Q?mXLHwLVNtckTKk7Ia+kELC9ETjE8r+P52zCRhKhvMYLCfVEDsqUOrCQZZAZI?=
 =?us-ascii?Q?NgMG8sSyoymkUqgp/+z4CiNwBjoQOBrpxlW2L7jJ08x/xygb5Ek9DL0eNifu?=
 =?us-ascii?Q?F6eU1SoQIsuWtCNqastkaE9JSF62J6ztFny99+4gV5fGGKdu6EEf0gxUNdYw?=
 =?us-ascii?Q?XbjR43Nj4XQK0E+SI+sHj/Zub82x2QywcSxdwGHB5BkznguGEQ7Q1uyc3+cX?=
 =?us-ascii?Q?is4zvH3ApEPcaNCPBSYywxReA0sLxgzxYRORJ5COEIPooFeLPq6MbhNSeN8b?=
 =?us-ascii?Q?yPZW5FXftaXqoMJyQdv2PdI5kL2cAZzTNStcLlG1h5xZzlSIelWWjhjF86Hm?=
 =?us-ascii?Q?ic5HbNAer1q8NWWmNGFLnZyB+oB+5GTw+44Xlrwt8c3EwOW2UtbJ89k2SOMK?=
 =?us-ascii?Q?mjaAe8H3M+sJEbi0vcw26oByC91A4RWMreldFf/N/bcw7tITg+Fi4txmOe2i?=
 =?us-ascii?Q?Sm5/NNpEfw=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bacdc28-5821-4524-418d-08df2ac24a92
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:43:27.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYtHeXH8CalNMJi3dbeS9aokOHpdMaB8tHaEU/6qKgK75W6xR+nJ5Z9gAMpIfs0hT5Tft/ht1SL7NtVHlNT3Vp+jX7/J24xSDDDcm9gurR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB654605

On Thu, Oct 15, 2026, at 11:09, Arnd Bergmann wrote:
> The patch is not wrong, but having a broken udelay() is still problematic
> in other places, so it may be better to fix that instead.
>
> On most modern targets, we tend to just use the cycle counter if the
> frequency is known and avoid the delay loop calibration entirely.
> Any reason that sparc32 still needs the calibration?

It could probably be solved with the hardware timers, the ones
timer_cs already uses.

I agree that this would be the better fix, and I could try a udelay()
based on a hardware timer. But I only have qemu here, no real sparc32
hardware, so I would rather not change udelay() for real machines on
my own. If someone with hardware can test it, I would be glad to do it
as a separate series.

Until then I would keep this patch: it is small, does not depend on
udelay() being right, and fixes the boot hang for stable on qemu.

Regards,
Ramin
