Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.76.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792680870;
	b=EGXDzietUudwobvGjQzsM7Cny8JeNqShwPSSW1SKn03zsp7qKmInrsJd4aZE2sf7RF8r
	 KM0NNTICZMqHpek14N7XgpUuL0bwMwvcwY0wT2iYjrALX/eqRkolvPVSN4tM1gJjW/osA
	 xhlX4c5U+hQW/ILGlzypKKZHTmg9TfjVFk3vubAoANzXad2MJhZ/KmWOzTa5/WoXkg9Ds
	 vizz8HDpFTLCeqZ4Ac/z9CQQqT++ULGj+f9tjYs23xvchK64aKxbNZGt4+Ja69kzOPdHt
	 1add31FShVDNk9sUIDJ9be9CGEnWM30YwHdED6sCiVudg8ZiCM3omtCt04gSGWdk+SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680870;
	h=DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UpBbaaYQy1kqAjN9iOwDUzlV8nLgpc/2D+7aL3TPYl8=;
	b=L93HQ8eHzFQNHz8pmkc7KbafLaCvn94TElXB81+NQhzCQ8z4jt6u42I2VpKyUAEhAsJ/
	 f2Vlbe6+PRKN/gDgJlrh3s0Rnuvp7W1qs6MMiV4Dhzc6YYX9pVoCT0UV7pv6fNeypDzES
	 uCohyImyTzvVLBEapU9as8wNW7zDPGkvDx9OND1LS3rAafBH7GhHhAufHBur6CJ14XO7a
	 sbSA/u3cRFnHxy7cEtEE5vLJ/iJDH3BGV657kG8nI5mKSqdfxJaVzWddhRJOeY9nxldC5
	 mBkRDV/G/Ez3VnEGjDtFnB0tLEdYlidHhGgGalcSqCU/Bn2GY5Wp8G5R+vnKsPIOUaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=ZbEGeEXp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.76.134
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021134.outbound.protection.outlook.com [52.101.76.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90EA606A336
	for <sparclinux@vger.kernel.org>; Thu, 22 Oct 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=ZbEGeEXp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quPiCNdvdlaHU5dCIld9orT92SEcr7JKoR6xt+EgwBP0Vj0ju31BKTFJBHoRXnmDCsd0rnys49nbRj2o7KdNtacro3872lxY1AP2iSBa04X8K/2KNdxHSr1xKqn5wv+iWqrRyy10v/jTbQ4MNNliTKx+OkqZJYZHrYJ1M4Ab0Um2XvMJRJbhy2Ws3r+zqmgWW5V87nmc5DnUT7g9uvLQk9Pl5GKNau3jTh6WdOt6+ll9VXQ9sPu4kL4Sd0RclZ9TqODbJ3zF4rnkQMOoDitKpxWu128UiyzZQ5aNvrQ+NZaDbnf2GlSyIBp2a406QyHn7wYAWhmhYiL/H1IilnKByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpBbaaYQy1kqAjN9iOwDUzlV8nLgpc/2D+7aL3TPYl8=;
 b=sV1w1zJMMKHSMacWK89vMkgzgIFCy9Bz9Ykf359uxepokN/5CWjy8tQHxoy/ixikV19dkV9eHzI2sYEiBtuEB8GwM+YsuTs669oo1PNoGAhRGsWcHPfgf8OtNSVhYetdXtfV4PV3oVAa6F3dhrjNUzpaeeX3PL4xtE/Y6cBwD+fQaVC/D3q67CjK+RApjF9ViATXM3pXwsKb0YZLxbIrgOf87pJMntxQO/pmfD9cO6BSo0N0ThE2OxZZeHWm/sZzWzNHvDnCwWxkgr+nv05bwD2J5ReG6zlZQTylQYy5m9iuoX4NoDAEAfk36QiMJFHp/RumQXo881up0RkRVvWPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpBbaaYQy1kqAjN9iOwDUzlV8nLgpc/2D+7aL3TPYl8=;
 b=ZbEGeEXpbW0NwdtS6v9BFAqRX1xIEmKwyByWxA7MqhaWronratl/+tSACzjVivo8Xe9SDFgKOtD8o71ggRS4pdGh3AbaNXxqtw/LpjeTk1ZTo6g7uA4i+mYgg+zWPs/5ugTUdgn6iflkIQBbY43adj1rINN38KkNVqqSoZyAW8rC5ZWWg38vFyPTBUr+v/SFldZSOvb3FYVHGENe//totB+KbJpDiMsKtw8sEwKg8twkPfZigavlMMd8E044QbTq19Pgjzbt+/cZYiQc0TB6AnT+ydtqT8e5W/ut9g+V5NFQcpTDypz6aXbeu+qxETTAQUeeGWFtyVXfLPZssNg+Nw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by MM0P280MB0730.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 14:54:18 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Thu, 22 Oct 2026
 14:54:18 +0000
Message-ID: <a08430ed-9e39-456d-8863-3fa478368134@gaisler.com>
Date: Thu, 22 Oct 2026 16:54:16 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: sashiko@lists.linux.dev
Cc: Roman Gushchin <roman.gushchin@linux.dev>, sparclinux@vger.kernel.org
From: Andreas Larsson <andreas@gaisler.com>
Subject: Enabling Sashiko reviews for sparclinux mailing list
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::30) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|MM0P280MB0730:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f3878a-7991-4ff5-6af8-08df304c5900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|10067099003|261021121427099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	RmzdMoe9xoyHGbW0uGavCS5XOgCMn0yc8sCyVRgX4i07HjCdyhVrNEAwrVuH2p8viktsd0TPKx2aVuauuFbOxV4aT/+qDKKjyHe0alUXksM31fteo1pPASBY5B5PVrZAVNgZ3B4m82iZp8BBwr7JjiW7dKeODmraBKNmTuCIWf40E9I0WJ4z8yGBqQKS8XZyb9tf5/6sflMLBd2bfWlYEcYq68eQGmi/GK8h8s1sK3cwPID2zJ87g1lxq0wM/hnor0k9ncsKD0/ZLVJXmnQmG8XZCu1HWU1fyooOE5HyDcFdUb9piOYIE+/zZwsWOwTbhc4G38U6Nrt2LKY8VetzMFClv1l4e4rEq3ij5daHQD/x8PMkywX785YdL4nisenpeTm5kbIO0YNYtVGDcXmoUQCUllQtnzMhTbOQ0eiYhiioCWr4TGt7RdbADDnXQCPbMt0HWo9sCNDO7QCqyo3Mt+4Hk/0gSJzBUVdcwXmIRD7HVmrQIGbNF/2M3qS94RtaSYO/VluhnqMaQTh+8VAvIyAtmVrmLFjFwpbXO4OmZAsmTY+UDBg4h3iQ7QBjJPneds2YMsJb4WW4PIFBXp5FLDNVVoiLJqCX+eiDn5TIB9rp2JUmPEpS1ykGd/MjbXiLs2qOf42H2vU7k9ZZ40vjR3oIuIJNC5SiUPAUWBOU4x4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkUzNmRZaGpwN1pjNjRweUhZemRVSklwL2x6RTBBRnhXRmM3Tkk0R0p3THJD?=
 =?utf-8?B?ZTNheERaaFpKdjg0OFFONXBheWNwZVVINDVCb0YxWm5GUDBORU45R0tPQzRR?=
 =?utf-8?B?TzVKdkJENHZGM0RhWWNNTWgyeUN1SzRITllzOWpmTUoveTJaVkJ4TlZlU1po?=
 =?utf-8?B?a2l5K0hjdWV4emE5cFh2d3Roc2h6K1JNRlBVbnB3UEcyb29VUkN4bzluL2xF?=
 =?utf-8?B?cldhaGNNdS9iY3lTakNIc0t1T0FVU2RaUEVMOC9PZWkxOThlaVUzNkx1STNv?=
 =?utf-8?B?ZmhkVU5qdU13RUlSOGtBSUNFV2pqODNkU2llbEptai9qdEh2S0x6THJHK2Nx?=
 =?utf-8?B?QStSVE1hbFNvV0FuaUhPZ0tRRXZFRUFHbEgzSVZSTEs2VkRzOHlyVFp3QVBN?=
 =?utf-8?B?ZURYK21zYmx6NmNheE1Hb1g5cUg5TU8wWFJPeXh4SUdVdnhxdFc1ZXBOdXZI?=
 =?utf-8?B?djBLcmpSUmdZekxvY2dYNVBtbmlENnF0WDljYXM5elRhTGtYVmpkWHJYSkgw?=
 =?utf-8?B?Y0xqVFpsT3g3OWdNMXNLemxhU1pFbXF6d3pYTHpDaGdiSzlGUkk1QW1XVUFL?=
 =?utf-8?B?eVhnamF6blM2SjlDeWNDNFBMNGU0cWRPYmwzUUpVQWdYQW5FME1pU1Fndjdn?=
 =?utf-8?B?Nzd0YUhFRU01RTVYelZUYTBEZVRGK05xUVQvS0JkYmFqTXlIM2EraXlTamti?=
 =?utf-8?B?Q2o5eE5iY3I5cmZwcVgyQi9EcDNHSjBHd0NPZ3FlbzQ1dXhiQS9MU0ZjcmR4?=
 =?utf-8?B?WEVDa0R0ZlVrTmRNaVgxTitLL2kwbDB1UUEyQUZwV1FwVzRQOXY2SENoeGZ3?=
 =?utf-8?B?Ukx5VVk1ekZpNTNrVGpLRnp5VFN6Zm1SbHpERllxSFJaWlJWUGJhaXZPZFFk?=
 =?utf-8?B?L0ZnbDlkLzFDU3huQjZCUVZmU0k1bytuUVliNkVhWXFhdVd0Yk5DT0gxY1dF?=
 =?utf-8?B?K1RPYjJyb0J4NE1SVkV3dk9kZGtZMzdzcFNsb1NZZWVVREtjNW9RNXFwUmFD?=
 =?utf-8?B?RW8wcTFvbEpnSFBsQllSK21zak1aYVFDbEZXQi9tcEpGc3NZUnBSOHJvWnB3?=
 =?utf-8?B?N1g2SDdNNmRlcHA5UWdhMjFnSk9iTHJXMUl6ano3VWZocmVGQ1k2SXhvUllP?=
 =?utf-8?B?cEtVVFZZZyt5dk4zTnBOSlUxQnJCaU1lK1Z5a0xNVVBUblFlQTdVQXh6K0F5?=
 =?utf-8?B?MSt3OExBK2RrWlJEd2k1a1hDVHBlaTVkNzlpUTF1NncwR1RqaVpYU1lBSE5q?=
 =?utf-8?B?QVdXbThRVnNUc2hkM2FHVncvQ2F2U1RFM2M2V2VCWjJpRldHSnlVM1lwWjJR?=
 =?utf-8?B?NHp0ZC9taGdPdm00OHBWTDhrZkdvUHpJdVFVYnJqblFHek5DWGFxZkQ4VWZH?=
 =?utf-8?B?S1krRmVoU1JwZ1FEaXh2RWhPYlU4eGQzd0x6WlUyclRsZ24xQnRoZzUyZFpX?=
 =?utf-8?B?WXIrcjdUdE1iOUFHU1FPb0NaNjBsbFJlT2JzcVZWM3JhYnhLNHIrL2ZCRm13?=
 =?utf-8?B?d0tvK3NWZVZnR0hwM253RXZBRDVTbmJCTjNlbzB2OFlweEJuMThvbzZCZEJB?=
 =?utf-8?B?cWhjZXRhQ2pzM0ROb2RvSklyTXAxQW5RdnZVa2pmSklYbU53TklDcWNUM21p?=
 =?utf-8?B?WXZlUmpzZmtJaFNwd3YzMUd2Q09xMmtMOEpRVlJBM2FoQ2ljRlZEU1Zwa05E?=
 =?utf-8?B?VnJHUlIyeFV4SVJoblpuT1ZvM1RxZ1hwbjFoa0RzNkg1Wnd5M29hTm1vc050?=
 =?utf-8?B?RloyZFRIRUp0dHpaVTFJaCtFY1g5Zk1FRlUrWTZyVVNpbWRLV21DQUhJakh6?=
 =?utf-8?B?WTNyN3ltTmlFZW5BdXR4U3pkQzd6RnBoTndQdG5TSHBKcW9kb3FjWjlwNkly?=
 =?utf-8?B?T2YvV0JFRmQyeW04UUVLWTVNYTFTUkpsTkJhVWIvRm0vRS9aQ3BIazFSUTU3?=
 =?utf-8?B?S3VBUU8zVDhCcGpRNVdvUWVaRS9JYUhiNmxKVktESnZHN2U1aFR4MzVLTEdt?=
 =?utf-8?B?NDBPaU9VazB5NXVwT1dSdktOSjNXaUMzWlcyR1JOM0d0Y2JydVFTMStwMEFP?=
 =?utf-8?B?YjhmcjJuTmp5ZUNocXNDNDVQYUQ5Y3dWTm5HaXN0TGxhd1RHb2xwOHNQS0Vp?=
 =?utf-8?B?bHBXcmNRQkluNDhuVytNUldYK0tQMHJqbEVkOUhmWU5VUG1QWnl5cHI0bGdV?=
 =?utf-8?B?QytZRktTcGd1VkhBSmJTem5Gcno5TGNNYTJncDBxbzdVWW9FSFhwd2h5NS9V?=
 =?utf-8?B?cHoyS0ZkUHFyTW80NGhzYmo4VHRVZFdFdmVRRmR6WjZ5SnJrU3ZacjVMSXFC?=
 =?utf-8?B?NXFybCtmcGRTVjhHNGpCaUxSdjhsampJcGdob1dsUHBiZ05PbEExQjRvVzBl?=
 =?utf-8?Q?ELLUT/ukLhkt8BpA=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f3878a-7991-4ff5-6af8-08df304c5900
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:54:18.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3iTvwbbsTMktoGZV+g2ZmgjgRreipw54VwRzvTo/9vEo6hSPNg5qzuAu4Xhl6S+/Icuj4OyJ/BhT+a94cWydDNQS8VQIcC9g5EXowg0oLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0730

Hi Roman,

Could you enable Sashiko reviews for sparclinux@vger.kernel.org?
Preferred configuration:

reply_to = ["author", "list"]

Thanks,
Andreas

