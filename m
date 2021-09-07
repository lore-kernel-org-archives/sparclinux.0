Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E47C433EF
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 05:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B0760F25
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 05:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhIGFdw (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 01:33:52 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:7265
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230486AbhIGFdr (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 7 Sep 2021 01:33:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDgQAIPjktS0LtCbIBXE+NmIkE+6f2LIHPJE9f8Dpy3y9yfqCtw6IgqolPWoPWTpvUfwjenxZnKcNEj8UO3F/WI+2H+YIsIsUBOv2s3ZsL5D5mUh2UC2R6wf6836khX/6WP191dfUVBG9OzFtHtG4+nWiqjz/1F9kjGE5moeOrErXn57qN3j51JmNKo9jc7XrCuAj/Rocgp16BJmp4gIwJNbGURBbV3pBADmLtr5EqqZz5AnFt3TUC+C7AHSk6Q5N7Rm7aIicr+fqEVN7WJwql9PODFib7EdC0k+7+VuALxCREb+c9SKoXQJxuEZkHx4j8LaVimgM2uCvZjH/+JX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=472Y6pFj3P4VLP+EVFeSRGwSymyg1b8QMkkMEA1xzH0=;
 b=gjRQZDeqftAWbDKMkDFbwEk6Mvgn20GZGXoz2KAnl7ZcxgZGxCVtYKAnYiYfd1S0+EgqvD1Fc7Pa3MHCvvy0hHSn6qJmAQ9ikpsWRmUWId5FWFnF3fKA4wqP077SwPi14hvZLa1xt/9I9Qeoo239beI2dhBKv9AGotDsAhsi5vRro9A6HL6uPy6lAwBKdGGTEs22hyT3bZmIJcUx3wIvfi6y0u+4iUMWnrBeS2ZbgVSi6FMafaowUG9TkrLGsk7lqQDVRF33UHeRKdyDVpmbbxCa7nnX3fijRcmRTdfCd0jdOjlUIlBT/zNiiG8Zg567m+UjRIeYtMphTQ8U9VtO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=472Y6pFj3P4VLP+EVFeSRGwSymyg1b8QMkkMEA1xzH0=;
 b=fYit1JQ/FwSWvY6w9CfOosOUDL6Jos9t24U5Ct4yew3ehnZy94nNvjIs7Y1u446KzJEBi4Ewbbca1LQMdLpOe/k+sGGD7JNnSVFH5iVh1rSevqFT3SRyOQ5XOlhjJSUCMKru7kk5wkEcLAhuvf4BJo2qpv+fHLcrrxXUDG1GBk0=
Received: from DM5PR17CA0062.namprd17.prod.outlook.com (2603:10b6:3:13f::24)
 by MWHPR12MB1630.namprd12.prod.outlook.com (2603:10b6:301:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 05:32:39 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::19) by DM5PR17CA0062.outlook.office365.com
 (2603:10b6:3:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Tue, 7 Sep 2021 05:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 05:32:38 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 00:32:36 -0500
Date:   Tue, 7 Sep 2021 13:32:36 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <20210907053236.GB3271077@hr-amd>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56edc5da-832f-47fa-2ac1-08d971c0e7ee
X-MS-TrafficTypeDiagnostic: MWHPR12MB1630:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1630911A7F73166A47BBD8E3ECD39@MWHPR12MB1630.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lgCpglwYbN9zliC+fc7qmawBp4NWrYrHxhIOeEaBPx1qlIHHnAaRQT+gGc0ixi8C6U5Fj86+JpbJAJH7ARlp/Ofa0Mvu/R7+CzcFryh0Ll1EvqQ6GXuXnZSFuso+nSOzWbbn/hNB72yjxMtaKEryEozf7Zt0rAh7Y4Em3r+ZmSiGMzh5Jopi8Cb3eM8FfGxUchAnpjze+UOPSY7g/pcCMm9HjKy/kvT6sOIzlXBToP/Oa037PQNAZGDsrvrDKdkl0uKgCfazhdvG99D0d5+8EWX3d138gpvM8Bx7mJqb37IIaNG+Z84DbLnjJvpK1is+SghZjQ7L7UZCE0B7gMk9+8l4hTV43RXevOn+9oEx+Lc4CXv1k6G+DpjtqGJz4zXxAwUugcMpACaqovOMMykmYlsbADUDOHSmraruoiucpHRr7NsjdSluoEGUDjuXfBZPXL14owY1ug9tDHLOr+LfXT5nrTkfzgLZ+4WBBjh5t2HA9n0/etCCSkVJfDLke1gLnRteumbUEDoVZjbWmco7i3vwXTZ30KEi2PKiGVytF44BRIq3SSQbZGGVelZW2mPMGEtsJrnl/qgAygsuTADPifOD1V9X3Yktd24N29Ryz9MZ500iEcMsv2wcFEO20ngg+/7gKBKJT71hbzXFts8p1SuuUmw9Bgl/nFPCWvAJadBaIuEn5PVnHe0eGILb5Hr6QOP5OfstCuRMsacFaI2bYKI8KpNptL47naqFMM2d1z8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(16526019)(186003)(33656002)(8676002)(26005)(81166007)(9686003)(8936002)(2906002)(70206006)(5660300002)(70586007)(83380400001)(82310400003)(356005)(54906003)(336012)(47076005)(508600001)(1076003)(4326008)(6916009)(86362001)(55016002)(33716001)(316002)(426003)(53546011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 05:32:38.7581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56edc5da-832f-47fa-2ac1-08d971c0e7ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1630
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 07, 2021 at 07:06:04AM +0800, Linus Torvalds wrote:
> [ Adding some subsystem maintainers ]
> 
> On Mon, Sep 6, 2021 at 10:06 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > But hopefully most cases are just "people haven't cared enough" and
> > > easily fixed.
> >
> > We'll see. For my testbed I disabled the new configuration flag
> > for the time being because its primary focus is boot tests, and
> > there won't be any boot tests if images fail to build.
> 
> Sure, reasonable.
> 
> I've checked a few of the build errors by doing the appropriate cross
> compiles, and it doesn't seem bad - but it does seem like we have a
> number of really pointless long-standing warnings that should have
> been fixed long ago.
> 
> For example, looking at sparc64, there are several build errors due to
> those warnings now being fatal:
> 
>  - drivers/gpu/drm/ttm/ttm_pool.c:386
> 
>    This is a type mismatch error. It looks like __fls() on sparc64
> returns 'int'. And the ttm_pool.c code assumes it returns 'unsigned
> long'.
> 
>    Oddly enough, the very line after that line does "min_t(unsigned
> int" to get the types in line.
> 
>    So  the immediate reason is "sparc64 is different". But the deeper
> reason seems to be that ttm_pool.c has odd type assumptions. But that
> warning should have been fixed long ago, either way.
> 
>    Christian/Huang? I get the feeling that both lines in that file
> should use the min_t(). Hmm?


Shall we align the return type like __fls() on all the arches?

But it looks OK for me to change min to min_t() here as well, I can file a
patch to the update:

-       for (order = min(MAX_ORDER - 1UL, __fls(num_pages)); num_pages;
+       for (order = min_t(unsigned int, MAX_ORDER - 1UL, __fls(num_pages)); num_pages;

Christian, what's your opinion?

Thanks,
Ray

> 
>  - drivers/input/joystick/analog.c:160
> 
>    #warning Precise timer not defined for this architecture.
> 
>    Unfortunate. I suspect that warning just has to be removed. It has
> never caused anything to be fixed, it's old to the point of predating
> the git history. Dmitry?
> 
>  - at least a couple of stringop-overread errors. Attached is a
> possible for for one of them.
> 
> The stringop overread is odd, because another one of them is
> 
>    fs/qnx4/dir.c: In function ¡®qnx4_readdir¡¯:
>    fs/qnx4/dir.c:51:32: error: ¡®strnlen¡¯ specified bound 48 exceeds
> source size 16 [-Werror=stringop-overread]
>       51 |                         size = strnlen(de->di_fname, size);
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> but I'm not seeing why that one happens on sparc64, but not on arm64
> or x86-64. There doesn't seem to be anything architecture-specific
> anywhere in that area.
> 
> Funky.
> 
> Davem - attached patch compiles cleanly for me, but I'm not sure it's
> necessarily the right thing to do, and I didn't check the code
> generation. Maybe it screws up. Can somebody test on sparc64 and
> perhaps think about it more than I did?
> 
>                Linus

>  arch/sparc/kernel/mdesc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index 8e645ddac58e..30f171b7b00c 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -39,6 +39,7 @@ struct mdesc_hdr {
>  	u32	node_sz; /* node block size */
>  	u32	name_sz; /* name block size */
>  	u32	data_sz; /* data block size */
> +	char	data[];
>  } __attribute__((aligned(16)));
>  
>  struct mdesc_elem {
> @@ -612,7 +613,7 @@ EXPORT_SYMBOL(mdesc_get_node_info);
>  
>  static struct mdesc_elem *node_block(struct mdesc_hdr *mdesc)
>  {
> -	return (struct mdesc_elem *) (mdesc + 1);
> +	return (struct mdesc_elem *) mdesc->data;
>  }
>  
>  static void *name_block(struct mdesc_hdr *mdesc)

