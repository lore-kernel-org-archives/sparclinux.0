Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F72AC433EF
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 06:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3D36054F
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 06:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhIGGRH (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 02:17:07 -0400
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:32097
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230286AbhIGGRG (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 7 Sep 2021 02:17:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FthDBHbRVE6tUnHZEzzPwDvi2Mr3OIBDritdWhQRi8Je5vGotjxZk7I0atXjz8tsZrKNUWQWxz5fggxwpH3QzrV/HCcl/++FqXZ1749WlkczQGa5cFJCsCNbUxk8B/Q10TOFCyetS/aTeBB+nscfkwSc5/g9u8+BZrYKsry43JYlJV8967J+OqgUwNtZ0pVxyPCRPGLfiDreif9J2KD8sj7j9sT8vzc08y6TFJQ2GE8KjbZXeGYhy4JyIoFHFRVgiGK1iFcnFveiqziKoJwejjZPL+VfN8RrAo04Vo2cROqY1J0C9jAsXXdM5bhUJ5K3vt2veff7NG26w4lrK655wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ueErFGUTvOS36MOhig1XO0ME6cU8Q2Zxy250LLlkHwA=;
 b=n85qWFFY9kGn9jZ4vjgH3jdGBoIKMuG65iLUVgYguk0yVVTpbXyGXApxc4bk/CjXJwkKck6Nk3b81RkhZmArAGuONr7j/cGQK617kyUiSZosk1Kpz+kMfaQC9n4LhTRSRlUI7zszykJi1W4D0e8k/K6zBj4Bjb3IHiWjoDIBiJHtAmYIyWVCDVbcci7sGvcaUJY52eMgbDKOd+PrxEFHSW8YZD34fNaKTaJsWeYWcp/GHPCmT8oc+rxMVmFD7qK9u6f9IkyWc/EMQTtSmcG3kEvDmGNjYhbdjNi/2MMUud9EBc6WrxX1OKG1eRygYnkumy+pUXDh6GbMskKg1MX/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueErFGUTvOS36MOhig1XO0ME6cU8Q2Zxy250LLlkHwA=;
 b=MgLINUbMT3DMsTRgqpMtmKcnZD0sxc0hZVXvFSqk2klljhDEmSJ6Sh/WmlaXptWQDHtS9Ioe821LSQVs9ay9409FPkk6Dklfwysf6vsSZkAMMLwB36Kqum+sJA6zh2Z/VAfwcgXLrCnM9f8242l7s8p1NUg+3NV6dYRWiXYx8Ak=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2516.namprd12.prod.outlook.com (2603:10b6:207:4e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 06:15:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 06:15:53 +0000
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Huang Rui <ray.huang@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210907053236.GB3271077@hr-amd>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0d63f82c-7bdc-1bf0-f64b-8331291e2d4e@amd.com>
Date:   Tue, 7 Sep 2021 08:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907053236.GB3271077@hr-amd>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0099.eurprd02.prod.outlook.com
 (2603:10a6:208:154::40) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by AM0PR02CA0099.eurprd02.prod.outlook.com (2603:10a6:208:154::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 06:15:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec2c97ec-980e-45af-f00e-08d971c6f235
X-MS-TrafficTypeDiagnostic: BL0PR12MB2516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2516029A4CF832CF5FFD0CB083D39@BL0PR12MB2516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scgu5XDFutUkuMchC9MoyOOMqW7RQaGdVoKAnXOdctHizp1OC+P1BQQ9Qvc410CZhKHeqKXsBWVbWf22z50TjRb7wKs5yk/bwPYFiRxm3yXKEGGm5N/9kgulIJ1Qc05CTyb3nmw+PuNAZfXXoaRhq2kvOFNM9P76eg17X5Nj1Ili81BRLFOOCaJz0rCeKPy1hjNqIX5Dnad8kj1i3d7Wu3mDSM0rp7AvGDM1edHxVENK/npJ5vCvodIfiCIO8MuMdFTtZCmJ4T9h9+50Ba6rHej+vcBWC1wGBseIjulK74IvC1LSJ2rLV1YESDrgNiKhNzgpxeN+qpbk6cUbkB5b14Cy30eJ6Dm6tsLYGuLEiN0I3vHtgULL662BBQEKEwnv9KW90+X1et9UBSObFVmMAgo09s9HoWD69swrFhs3zLHES41pj2T5RsNQo5mBa6hVJ+1WMnBnm++/pHT7e+LsY18+uxyZXnJNZKvlVQJkzrSQgh3vLDx2NmWPKyVwKC8BlFOO18DkNrjs+7LeVCCMZyeRjdrj6XfiND4jILTPHaIVNFVmiXAaM4trqherwqVsquyc2A1+E1ljDcXeAc6V9ETicC9tp+2Tge9rkgNm0miMfZzlGkld07ZN+904u8Lkuqlrv68WN+kCcEj/VkLagk6Ide3JolX4HPndIROxxiSzgOFtyYGmZTJ1+QhE+U2zm5dKv+CNh1e4uwDwuPmJmJIXp9oIUriF0iaqgXdYBNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66556008)(66946007)(186003)(4326008)(38100700002)(53546011)(36756003)(508600001)(83380400001)(86362001)(31696002)(5660300002)(26005)(8676002)(316002)(956004)(6666004)(16576012)(110136005)(2616005)(54906003)(6486002)(31686004)(66476007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?bGVVcG44cW9lRHNhWE16Zmg5djRPc1BlWHRGQnNFa2x6WUg3Y0VBUlE2UTN5?=
 =?gb2312?B?Yjc5OTNMYzF4Q0x3OTFLRmdPQXE3OEtRRHBLZUNIcG41bHVoOUM5YnRna3VP?=
 =?gb2312?B?RUdtZ1Y0L3pVTDJmZU84VHNUdGY0RkJHMW9KTk81VzBOQmRmbUhMa0NkTkxv?=
 =?gb2312?B?NUprKzFmZ1IxZnJFY2VuUDBVSUp1ZDNMbVpmYjlUYWRiSitBWGVmVXhtczZX?=
 =?gb2312?B?bkxaQlpXemVzeTRadnlqWm9WMnd2TUdsa21USlkwc2tOL3VjRDAvcGV4Rmwy?=
 =?gb2312?B?Q09Mb01oUHFtbm9PTldmaG8xMXEvcWxxbExJaW80TlY2NXQzN0tQNTFKRE81?=
 =?gb2312?B?bTQ4U2tiN25iYXo2dUk3T2YzZUtvL3dYY2pTRXdiRnZMSWdPVldqSFFqQlkw?=
 =?gb2312?B?anhlVGRMME9TRkE4L3dvY0JOL080SHlISDgwSVBMYi9ueTl6dEJtNGc4c0h1?=
 =?gb2312?B?emdhelFsdkRxRXRoOFFaRjFVWndldGJhMHdJWndsbkE3WkhlczBKWFJzQWZX?=
 =?gb2312?B?UXhpWnFWbmxGaHQrMjRWb1c1Y0EzU2ViMm1PMUNvUFJ6SG4zZTF3K0dRWk9p?=
 =?gb2312?B?d3R0dzBzb3ZvaUJFa3VnL2Zrd3NQNlQ0cHN3SzNoS3F3YzFlSm9xVUFFUDRF?=
 =?gb2312?B?MUYzWVIwQ0F2cjhUU25NcVdsNno2eWFVZG1Jdko1SDJnN1grWm8vbWZQMUhW?=
 =?gb2312?B?QWMxdkhsTUMwWFJzMDdQY2JJeEhnbkVxdDJFb25YYW9CanlYeXdZeWhhZGRJ?=
 =?gb2312?B?WFRCL0pMM2hiMHNUTjlCZFM3ZkJIL2pmWC84MGRERHkrMjJ3eWZtVEhoeCtD?=
 =?gb2312?B?QVQ3WElod0dLYXA5MmtjdzRReU5SVmc4QmR0UkhQVjZLYmVJQy9rdldZZ203?=
 =?gb2312?B?ZUJ4d3MyRldWMitmcVlXS1d3NDUvOUl6K2xqOWFDbmpqWlhqQWkyMm1HcVk4?=
 =?gb2312?B?RDZLZis4R3crcXkvWXdUeWNiU28ydEFmMkhqRVdQbldKTWoxREVQQzBFRFJy?=
 =?gb2312?B?dm5SZnZnR3U0eXI3RlVNdlQ5QWQ4akFVOTJDakVtMkFRTnAyS3VyZTNWR3o1?=
 =?gb2312?B?WU9IZGpxdkI5emhRSDJkZG5WR3RYWHl2Zzh1UzhxallVeGdYRWhaRWtkK1FQ?=
 =?gb2312?B?LzFtNENZRWtUSkphUTRCVFBKa1BXSzZVWGhLSmNFZ0ZlQXRCWm5mdm5BUjRr?=
 =?gb2312?B?WlJhd3RtTjFnSkY0ZXNPQ24wOEVnalBMZVRObVFVU2VhTlJJUVlPeHhTMFBu?=
 =?gb2312?B?THM1UVZJekZxOVVBeWE0MDVBMGx2ejcxbXpCQnBScDF0ZG9EWkVuMjdxaXBL?=
 =?gb2312?B?MFdhb2I3cGVhUU9sYktRQjFnTTk3NitRSlByV09HdlhtYkNFVVkwajJtNkE0?=
 =?gb2312?B?WGhZclc2L25TSUlCS3dsZG1yeGxYc3pVVFNnQUticFhjVmdyWWRwZFJBNjdS?=
 =?gb2312?B?SE5ZcHJjWWozNHBRU2xZWVdISHVEYVNHU0F6b09hRTd0bXA4Y3ZSeU1DU0c5?=
 =?gb2312?B?OGJWbCtMczdEd1RlM3pUTUxGNTM0am1sN2Rabk9MakZ3MCtzcUJ6VFdoTnBv?=
 =?gb2312?B?TUlKWng3QWhpUmYxYnkyUFIzQVgvSnY2cmZ1R2c0YTdPb3JCTHQ0emtjQXhF?=
 =?gb2312?B?c1RmZHdxajdENVlGcVFXU1hqOHBHSEtDTDRjM3pENWU3emRGRXVZT0xYSlpV?=
 =?gb2312?B?MjFsSlBIWHI1NDRCc1QyeXZicnYrM1RFNG5VOW1LRUNreG9hWVdhcEwrWUtG?=
 =?gb2312?Q?1336JwhY0KUSaC8SoTWhsMID+VpFLTNWZW9gN7V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2c97ec-980e-45af-f00e-08d971c6f235
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 06:15:53.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wadj8hQffCx9yZfXKTbmUwbxhyUpmEoHHWAuAuenFHxLi0zrxQMH7xwpU9LJdBCC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2516
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Am 07.09.21 um 07:32 schrieb Huang Rui:
> On Tue, Sep 07, 2021 at 07:06:04AM +0800, Linus Torvalds wrote:
>> [ Adding some subsystem maintainers ]
>>
>> On Mon, Sep 6, 2021 at 10:06 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> But hopefully most cases are just "people haven't cared enough" and
>>>> easily fixed.
>>> We'll see. For my testbed I disabled the new configuration flag
>>> for the time being because its primary focus is boot tests, and
>>> there won't be any boot tests if images fail to build.
>> Sure, reasonable.
>>
>> I've checked a few of the build errors by doing the appropriate cross
>> compiles, and it doesn't seem bad - but it does seem like we have a
>> number of really pointless long-standing warnings that should have
>> been fixed long ago.
>>
>> For example, looking at sparc64, there are several build errors due to
>> those warnings now being fatal:
>>
>>   - drivers/gpu/drm/ttm/ttm_pool.c:386
>>
>>     This is a type mismatch error. It looks like __fls() on sparc64
>> returns 'int'. And the ttm_pool.c code assumes it returns 'unsigned
>> long'.
>>
>>     Oddly enough, the very line after that line does "min_t(unsigned
>> int" to get the types in line.
>>
>>     So  the immediate reason is "sparc64 is different". But the deeper
>> reason seems to be that ttm_pool.c has odd type assumptions. But that
>> warning should have been fixed long ago, either way.
>>
>>     Christian/Huang? I get the feeling that both lines in that file
>> should use the min_t(). Hmm?
>
> Shall we align the return type like __fls() on all the arches?

I think so, yes. IIRC I was a bit surprised that it returns UL on x86. I 
mean the maximum possible value here is 63.

>
> But it looks OK for me to change min to min_t() here as well, I can file a
> patch to the update:
>
> -       for (order = min(MAX_ORDER - 1UL, __fls(num_pages)); num_pages;
> +       for (order = min_t(unsigned int, MAX_ORDER - 1UL, __fls(num_pages)); num_pages;
>
> Christian, what's your opinion?

The "MAX_ORDER - 1UL" can now be changed to "MAX_ORDER - 1", but apart 
from that looks good to me.

Thanks,
Christian.

>
> Thanks,
> Ray
>
>>   - drivers/input/joystick/analog.c:160
>>
>>     #warning Precise timer not defined for this architecture.
>>
>>     Unfortunate. I suspect that warning just has to be removed. It has
>> never caused anything to be fixed, it's old to the point of predating
>> the git history. Dmitry?
>>
>>   - at least a couple of stringop-overread errors. Attached is a
>> possible for for one of them.
>>
>> The stringop overread is odd, because another one of them is
>>
>>     fs/qnx4/dir.c: In function ¡®qnx4_readdir¡¯:
>>     fs/qnx4/dir.c:51:32: error: ¡®strnlen¡¯ specified bound 48 exceeds
>> source size 16 [-Werror=stringop-overread]
>>        51 |                         size = strnlen(de->di_fname, size);
>>           |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> but I'm not seeing why that one happens on sparc64, but not on arm64
>> or x86-64. There doesn't seem to be anything architecture-specific
>> anywhere in that area.
>>
>> Funky.
>>
>> Davem - attached patch compiles cleanly for me, but I'm not sure it's
>> necessarily the right thing to do, and I didn't check the code
>> generation. Maybe it screws up. Can somebody test on sparc64 and
>> perhaps think about it more than I did?
>>
>>                 Linus
>>   arch/sparc/kernel/mdesc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
>> index 8e645ddac58e..30f171b7b00c 100644
>> --- a/arch/sparc/kernel/mdesc.c
>> +++ b/arch/sparc/kernel/mdesc.c
>> @@ -39,6 +39,7 @@ struct mdesc_hdr {
>>   	u32	node_sz; /* node block size */
>>   	u32	name_sz; /* name block size */
>>   	u32	data_sz; /* data block size */
>> +	char	data[];
>>   } __attribute__((aligned(16)));
>>   
>>   struct mdesc_elem {
>> @@ -612,7 +613,7 @@ EXPORT_SYMBOL(mdesc_get_node_info);
>>   
>>   static struct mdesc_elem *node_block(struct mdesc_hdr *mdesc)
>>   {
>> -	return (struct mdesc_elem *) (mdesc + 1);
>> +	return (struct mdesc_elem *) mdesc->data;
>>   }
>>   
>>   static void *name_block(struct mdesc_hdr *mdesc)

