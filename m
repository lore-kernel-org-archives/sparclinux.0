From: "David S. Miller" <davem@redhat.com>
Date: Fri, 07 May 2004 22:16:01 +0000
Subject: Re: [PATCH] Major warning fixes for sparc64 [3/4]
Message-Id: <20040507151601.36eb2ecd.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040506223752.GC29131@triplehelix.org>
In-Reply-To: <20040506223752.GC29131@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 6 May 2004 15:37:52 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> patch 3: Fixes a pile of lvalue casts in asm-sparc64/pgalloc.h.
> 
> This is a backport of DaveM's fix for 2.6's pgalloc.h, which is slightly
> different due to the different interfaces used. I think I got it right
> though, and I've compiled a kernel with this patch that seems to work
> alright.

Applied.

