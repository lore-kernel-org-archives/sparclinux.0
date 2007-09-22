From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 22 Sep 2007 21:21:08 +0000
Subject: e2fsprogs conflict with asm-sparc64/types.h
Message-Id: <1190496068.3966.10.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When building e2fsprogs, it checks to see if long long is valid on the
platform, and detects that it is for sparc64. Thus, it defines:

#define __S64_TYPEDEF __signed__ long long
#define __U64_TYPEDEF unsigned long long

Unfortunately, that conflicts with asm-sparc64/types.h, which says only
"long", not "long long" for these typedefs.

Is the kernel wrong? Or is e2fsprogs?

Thanks in advance,

~spot

