From: David Miller <davem@davemloft.net>
Date: Sun, 23 Sep 2007 06:00:51 +0000
Subject: Re: e2fsprogs conflict with asm-sparc64/types.h
Message-Id: <20070922.230051.41649573.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1190496068.3966.10.camel@localhost.localdomain>
In-Reply-To: <1190496068.3966.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 22 Sep 2007 17:21:08 -0400

> When building e2fsprogs, it checks to see if long long is valid on the
> platform, and detects that it is for sparc64. Thus, it defines:
> 
> #define __S64_TYPEDEF __signed__ long long
> #define __U64_TYPEDEF unsigned long long
> 
> Unfortunately, that conflicts with asm-sparc64/types.h, which says only
> "long", not "long long" for these typedefs.
> 
> Is the kernel wrong? Or is e2fsprogs?

The kernel is right.

Several other 64-bit platforms happen to choose to use
"long long" for the 64-bit types, but this is absolutely
not universal and is a per-platform decision to make.
