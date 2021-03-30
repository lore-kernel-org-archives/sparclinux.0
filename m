Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA8C433E0
	for <sparclinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DAE60235
	for <sparclinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhC3Rem (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:34:42 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:56199 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhC3Re2 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 Mar 2021 13:34:28 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2021 13:34:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1640; q=dns/txt; s=iport;
  t=1617125668; x=1618335268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DLlq6Eg2HUUvE9Fdg0Ebob6Tw5pX5R4uRXQoNV4sDwc=;
  b=YD6hOFjT4nT7yKyRURbYH2p7ZA+EIkn7ViGFqE0grJphcRE1Cx+J1b7b
   jgi+o620uozhL/ijEjQBF09qlmSZWnK2EtPCOPJ3EI1TUuWA0C6K177BI
   m/B0bK/1XmrW7K9hltVCpq00DNSmXarIk9USeAvhDr1JRyjr9zwX26TP4
   k=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AoTmckqE8NgKcaaN3pLqEVceALOonbusQ8z?=
 =?us-ascii?q?AX/mp6ICY7TuWzkceykPMHkTL1ki8WQnE8mdaGUZPwJE/035hz/IUXIPOeTB?=
 =?us-ascii?q?Dr0VHYTr1KwIP+z1TbcRHW2fVa0c5bHpRWKNq1NlRiiNa/3Q/QKadF/PCi0I?=
 =?us-ascii?q?SFwdjT1G1sSwYCUdAC0y5cBhyAGkN7AClqbKBZKLOm6sBKpyWtdB0sB6zROl?=
 =?us-ascii?q?A/U+fOvNHNnp79CCRnOzcc9AKMgTm0gYSVLzGk2H4lPw9n8PMF7XXPlRD/6+?=
 =?us-ascii?q?GFtfy2oyWssVP73tBxhMbrzMdFCYi3rvUtbh/oigquee1aKtq/gAw=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BhAABKXmNg/4UNJK1aHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgTwHAQELAYIqgUwBOTGMZYkukAgWikWBfAsBAQENAQE0BAE?=
 =?us-ascii?q?BhFACgXoCJTQJDgIDAQEMAQEFAQEBAgEGBHGFboZFAQU6PxALGC48GwYThXi?=
 =?us-ascii?q?rInWBNIkLgUQigRcBjUkmHIFJQoESgm4uPoo2BIJHgQ6CMCyeTZwigxGBI5s?=
 =?us-ascii?q?2MRCkQrgSAgQGBQIWgVQ6gVkzGggbFYMkUBkNnQchAy84AgYKAQEDCYkfAQE?=
X-IronPort-AV: E=Sophos;i="5.81,291,1610409600"; 
   d="scan'208";a="880406225"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Mar 2021 17:27:19 +0000
Received: from zorba ([10.24.8.123])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 12UHREPN013894
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Mar 2021 17:27:16 GMT
Date:   Tue, 30 Mar 2021 10:27:14 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     will@kernel.org, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
Message-ID: <20210330172714.GR109100@zorba>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
X-Outbound-SMTP-Client: 10.24.8.123, [10.24.8.123]
X-Outbound-Node: alln-core-11.cisco.com
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
> This code provides architectures with a way to build command line
> based on what is built in the kernel and what is handed over by the
> bootloader, based on selected compile-time options.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3:
> - Addressed comments from Will
> - Added capability to have src == dst
> ---
>  include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 include/linux/cmdline.h
> 
> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> new file mode 100644
> index 000000000000..dea87edd41be
> --- /dev/null
> +++ b/include/linux/cmdline.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CMDLINE_H
> +#define _LINUX_CMDLINE_H
> +
> +#include <linux/string.h>
> +
> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
> +#ifndef cmdline_strlcat
> +#define cmdline_strlcat strlcat
> +#endif
> +
> +/*
> + * This function will append or prepend a builtin command line to the command
> + * line provided by the bootloader. Kconfig options can be used to alter
> + * the behavior of this builtin command line.
> + * @dst: The destination of the final appended/prepended string.
> + * @src: The starting string or NULL if there isn't one.
> + * @len: the length of dest buffer.
> + */

Append or prepend ? Cisco requires both at the same time. This is why my
implementation provides both. I can't use this with both at once.

Daniel
