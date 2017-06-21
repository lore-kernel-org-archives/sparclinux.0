From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 21 Jun 2017 16:07:34 +0000
Subject: Re: [PATCH 1/3] Adding asm-prototypes.h for genksyms to generate crc
Message-Id: <20170621160734.GA22654@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497892130-875525-2-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1497892130-875525-2-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jun 19, 2017 at 01:08:48PM -0400, Nagarathnam Muthusamy wrote:
> This patch adds the prototypes of assembly defined functions to asm-prototypes.h.
> Some prototypes are directly added as they are not present in any existing header
> files.

> +/*
> + * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
> + */

Ahem, why are you submitting this like this, how is the kernel supposed to
be distributed when a piece of it has no license right grant to anyone?

-- 
     2. That which causes joy or happiness.
