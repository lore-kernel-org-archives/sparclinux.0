From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 02:37:14 +0000
Subject: Re: [PATCH] sparc: unify posix_types.h
Message-Id: <20090102.183714.255924844.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Dec 2008 21:25:11 +0100

> >From 58d4d2e49a0da963c2237b1a835a069ab9c97a17 Mon Sep 17 00:00:00 2001
> The posix types differed so much in their definition
> that they are kept in separate blocks.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.

I added this change manually because for some reason current
git wouldn't take this "rename+changes" part of the patch:

> diff --git a/arch/sparc/include/asm/posix_types_64.h b/arch/sparc/include/asm/posix_types.h
> similarity index 70%
> rename from arch/sparc/include/asm/posix_types_64.h
> rename to arch/sparc/include/asm/posix_types.h

It kept erroring, saying that the destination file
(posix_types.h) was already in the index.

Anyways, the change is in my tree now.
