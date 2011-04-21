From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 18:03:56 +0000
Subject: Re: [PATCH] sparc32: avoid build warning at mm/percpu.c:1647
Message-Id: <20110421.110356.98902973.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1303293448-13168-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303293448-13168-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 11:57:28 +0200

> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

I find it amazing that this patch builds, yet with current tools it
does.

It seems that some time in the recent past, binutils started accepting
constants in assembler that have type tag suffixes such as "UL".

But I know that older binutils do not accept this, and we use
VMALLOC_{START,END} in arch/sparc/kernel/entry.S

So please use the mechanism we have in place to handle this problem,
include linux/const.h and use the AC() macros as we do in pgtable_64.h
for this.

Thanks.
