From: "David S. Miller" <davem@redhat.com>
Date: Sat, 08 May 2004 20:03:45 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040508130345.4f311105.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 7 May 2004 18:18:16 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> However, it does not seem to build, for unrelated
> reasons:

It is using "-m64" so a sparc64 build, but for some reason the
include/asm symlink is being set to the sparc32 header directory
include/asm-sparc instead of the correct include/asm-sparc64

> include/asm is indeed symlinked to include/asm-sparc64, FWIW.

I really don't think so, line 433 is only a place where a compile
error like that can occur in the sparc32 unistd.h not the sparc64
one.
