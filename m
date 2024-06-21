Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2087.outbound.protection.outlook.com [40.92.40.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD94A20;
	Fri, 21 Jun 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977356; cv=fail; b=gqtMZ7OomjA8tEEROjRjMFx6g6V1Nb6SBLjZmCm4tT9DSKK7daJanox1RDXddbsp1xI9XV5xBiCEZ6qbCheI7SziyR3rpC8ZVunGt4gzzk6/t8886r1w6Z9Ad/bX1xgs8vvTiY59HELOmLZx3dRwtO6U70s6pd1AMyAnmQlcOPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977356; c=relaxed/simple;
	bh=qXVfGhOqlNQ8w4QFQCpxSgDfyZibpieAfx6iwZlWHCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=esMK0AJVuidqqoLbXj9jtNU8emnheoVjLz2YAPX0hcCpXDX8ZUZTwtqZ5QBeo6i+361Z0cdEG0HMAjrviyu535tSOR5cwDY8w4LsWDa/XVhZ5okZq3AGl0O+2DCdEKUBhNQuyym2xY7nO4dGmy9OG6TFbYXC6eQknSVrW9Q88+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nTRSHD2H; arc=fail smtp.client-ip=40.92.40.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nTRSHD2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZbBpLEnJS01EhVEgVfAzhlIqIL+AxEpys0V2QBmV+bCL1/7Mlu/RTTM7owZB2/Dg1lWINrSi7GMc9DGStOAI9rQ0OR3iIK3DmBhx8Nw14vMNtPo4u18By0s4J2rvAA7r2ZK6gM2vaL2xOlwLHnYicjil5+B9EevEhMTl2or3AmPBvmgWz9Rqlyg6JXGc6d22gyNxbzmFVibg4hGMDjFgwvgxP4LhyJ7hieUik8B7L+prrDEFuXCAHXyYekPsbgi1WacQFmWXUpoXRukWFqWi3Gx+E0W4pwrrcFWVmamloJM5cr+W0YuENXrCUqlMMenQG6qIUGVQtdRLqAtapoeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUZgccDBajCPqCrNCASngQZt5NjWw7Cul7izXmtfbYo=;
 b=PVCpBz6qZCmtIwjeMw2JgoqYC0NK+lo+fjsoiVjbixHIO6BbA+e5OhcaSPwg6ii1IXR+X88IjstJ+tAbxXtSPmovYt2TI4cz0TZZQ0cLAlHkPYVxWd8tprb0hfS7YY7gqGj6JX31zC29uymU9Bk21ECKQ48RrdG2a1kobOMUJhV+1l2WXKsPw2wvpcxkOHIYtaZLITo8W33ypv/vYI4d9YvDNuTYYwzkKO9cpgAJXzpLizS4NfkYNSIAx6NSorJmbE5+icxDp+SiPorhIRZZBkGpb7fmynh20G7Lx61TYQq3WM442hPNY/2ePhsn1O9IFCA9ndXKtymeX3FFz5KT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUZgccDBajCPqCrNCASngQZt5NjWw7Cul7izXmtfbYo=;
 b=nTRSHD2H3fw76O5uOSWKgJPFrJSfx9F0R2+L//WBv1nW2nEckqsNLYhBFIyhHCGmLW+z2CyKO1rKQEc0dounR1JBMHKZsamaD985xmf8y+/GBxAjoeqvfd34W+XicnAB2JyNin+P56NHouno1T9WzMsu4lqdLQegdCADfMHLfMHTnU5jvyo3ErKzd4CGMsiPHC+PpFcLTdqiZTvXLbXkPYyIRw9mLFZzbVIWil1YQV69dCPZAIyjwZwFXn2wF9Yl4N31oNemRtiJCUEhCvaAz0vL9J5l2+RJxgigG/kdykJwK4F5/PTnN2Z1rB77DIJkJwfvVcGOgMA5hrUpBD6uEg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9161.namprd02.prod.outlook.com (2603:10b6:610:149::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 13:42:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 13:42:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>, Nick
 Bowler <nbowler@draconx.ca>
CC: Hailong Liu <hailong.liu@oppo.com>, Nick Bowler <nbowler@draconx.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux
 regressions mailing list <regressions@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: RE: PROBLEM: kernel crashes when running xfsdump since ~6.4
Thread-Topic: PROBLEM: kernel crashes when running xfsdump since ~6.4
Thread-Index: AQHawtnrc06LbdhSHE+ecA7fkOO5n7HQ8m2AgACefICAADyuAIAAK9kAgAA8h0A=
Date: Fri, 21 Jun 2024 13:42:28 +0000
Message-ID:
 <SN6PR02MB4157D2FA39A5491C915D186FD4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com> <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
In-Reply-To: <ZnVLbCCkvhf5GaTf@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [jXT8ZZG0JkpKNaElLE0mn84FU+xhiJ5+]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9161:EE_
x-ms-office365-filtering-correlation-id: 07d5aed9-7a57-4d9a-a171-08dc91f7fe1f
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|3412199022|440099025|102099029;
x-microsoft-antispam-message-info:
 E/kA5aj0dVkPIm9yhgA6BttdPOZ6S4mszBo79cUYExF3tRl4mwEuJwoJ3YDaoS53VCwdtEdVPZsQdHplb3u1AoPJOYiNs/XEosWpE2+K/eVWhilee718/TgCbSr4es1MBDgKqyiTkDUED5MMsCO+PTXVUmstdAaFBvghZbR5PyPQVZKwK5Dw/+0bvtq0qoWGmapdCPe+o8xjwiFWiFfMjG18ITQBhZYgJQwNOimt1PhUnYvgKwjsyEe2ZgFPcwk3wfx0AxC06CEU388TUYf47RCllN8p4yJdoq+SiQaSEWncWt3+8a7Hxtcb7fOnJLh9LIvaOy2zlpVjp/dQCzZunYc9IMp017kq/8H8AmovDZtruj4ABYNMQ7I35ID1mJbXx90v5WfLlRcN21g2LrnaGmjTJ93uu2F1RiX7Y+xXDzi0WEPoQghsaSUPBvsCVsoJ/XingTEEGFaKnIE3CyS2N1IzZ4l2c9MDnSb57MZVV3m6jBuZ4DkyjHSH1KIJSnVRBSbRdsOX4svj/gcOiFWS8CuvgUb89FLgYGJAATbF5Rc7tJlKZxYpIGtc1Q+WG50J
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V2JOU4VlnOB6dXarRSSvB5QwKRkFO4sdixUcQc+LRUOXZe7ULCavcN0L9mqM?=
 =?us-ascii?Q?HefJU8I3XkdgCpH66bjEhQdFC88MGWrrcUjtXtzZlFFcDOgUPCtPCYmnfs5v?=
 =?us-ascii?Q?gXuhfbyDuvF4KvkhuKxhNz8nF3+c5JchqWQN0L0SWWPcdVY07OEZRcICwogT?=
 =?us-ascii?Q?2r8fgBPTpT3CaFCRXa4pXFpODBsw//4QS10oCtERx59O7jJHh0g1o9voOUds?=
 =?us-ascii?Q?1tjwbKYI0U/PAeegz6sfSQ21OYfEXedLTg8T+T8nYfSMCLjj3wG6MaPkxhnu?=
 =?us-ascii?Q?setjCzv4G5wl5GARoJ07//sw03+82wKpc2lJxgF9x9QLN+MFgiCVE2I+an/8?=
 =?us-ascii?Q?0M4OxkdQ3irgzEJAtgXESNW/3NthoejyBDjBLbF8P7Tei3yG/jHxLwUZ7hdE?=
 =?us-ascii?Q?j8QsoMojgvjsEgCko0fIrYJbGOA/tQ3/SxvFr+1K4D+y83dGP/jgWZtdSOx0?=
 =?us-ascii?Q?E6NGa6Nv24qtZraaIg9N6mU+F6HGj0lbok4pqBwuVeRIdjAWKAflWyYqAhkc?=
 =?us-ascii?Q?jHBIgQWMQP2ziKAfe8i3y1rsCPCw2Sm4R1F9i9CDMV8lvWvi/MlXn6VwXvSH?=
 =?us-ascii?Q?6t9Qa0leybW3tR17N7PPRnfwfp6RfSsBo4hPKnHKaZBMj++IfacwzKE1g1oj?=
 =?us-ascii?Q?WOEbITgdYNx3nRixt7TI0DF8y6YheY5XZrI7iopnmM7GMzkUm3rueLea7Ppt?=
 =?us-ascii?Q?AyERdx8jefSby87vWzOgKUt9dYPqqOBqVl7fix5xSWmURkFVkBdJdDI1xE2F?=
 =?us-ascii?Q?3fbIBy2lEtW0x8gRqNVaGp+2UUQUigF3H25Gj0swD/2PecXaE1216QEizEIU?=
 =?us-ascii?Q?Lphmm8ZZtLCktouzPvvxf1kZYkvr+wxRIAQaado/MmSHlpHJVpQagzUKQIQM?=
 =?us-ascii?Q?A1+jHTs3ALGbFXJvrvudjK3bRZ577+YRcmJdYU2W0BpRph4BORNakGTHUT2m?=
 =?us-ascii?Q?3amJAUm8SfD/ltQG+uOnkx7sMtcGo013ULBWIq/PQ6PPmLldImFNsNf1NLMo?=
 =?us-ascii?Q?8cKvKM2asLoecnHkXoiisRA7OWmUqSXMokw8oaqykelFVLHFsR+9f01dS6yz?=
 =?us-ascii?Q?tu1NpsuBW7D28rWI+RUikfmUKIwDV35T7ar20JOtOH4v+PueVXQYxNTT698K?=
 =?us-ascii?Q?rgTNnWecHXQgSKwy2EM+rJ8/EdQamFlbu4aj3RiyAwut3mdYMGbwJjRA6ZZZ?=
 =?us-ascii?Q?05RTE7XvbMj6kKaarMrJpN41bkGwBiASG92e5+iaPzUUMVn9EaLczhitbaU?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d5aed9-7a57-4d9a-a171-08dc91f7fe1f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 13:42:28.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9161

From: Uladzislau Rezki <urezki@gmail.com> Sent: Friday, June 21, 2024 2:44 =
AM
>=20
> On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > On 2024-06-20 02:19, Nick Bowler wrote:

[snip]

> > > > The per-cpu variables in mm/vmalloc.c are initialized like this, in
> > > > vmalloc_init
> > > >
> > > >   for_each_possible_cpu(i) {
> > > >     /* ... */
> > > >     vbq =3D &per_cpu(vmap_block_queue, i);
> > > >     /* initialize stuff in vbq */
> > > >   }
> > > >
> > > > This loops over the set bits of cpu_possible_mask, bits 0 and 2 are=
 set,
> > > > so it initializes stuff with i=3D0 and i=3D2, skipping i=3D1 (I add=
ed prints to
> > > > confirm this).
> > > >
> > > > Then, in vm_map_ram, with the problematic change it calls the new
> > > > function addr_to_vb_xa, which does this:
> > > >
> > > >   int index =3D (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > >   return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > >
> > > > The num_possible_cpus() function counts the number of set bits in
> > > > cpu_possible_mask, so it returns 2.  Thus, index is either 0 or 1, =
which
> > > > does not correspond to what was initialized (0 or 2).  The crash oc=
curs
> > > > when the computed index is 1 in this function.  In this case, the
> > > > returned value appears to be garbage (I added prints to confirm thi=
s).
> >
> > This is a great catch.
> >
> Indeed :)
>=20

+1

More broadly, throughout kernel code there are a number of places
that incorrectly assume the cpu_possible_mask has no gaps in it. The
typical case does kcalloc() or kmalloc_array() with num_possible_cpus()
as the first argument, then indexes into the allocated array with a CPU
number from smp_processor_id() or a variant. These places should be
using nr_cpu_ids instead of num_possible_cpus().

I'm usually working on the code for Linux guests on Hyper-V, and
there are six occurrences in that code. While they probably don't
have immediate practical impact because I don't think the ACPI MADT
in a such a VM would have a gap in the processor enumeration,
I'm planning to do fixes in the interest of general correctness.

Michael
