From: "David S. Miller" <davem@redhat.com>
Date: Fri, 07 May 2004 22:17:32 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040507151732.31637f1a.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 6 May 2004 15:40:26 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> patch 4: use $(LD) -V for NEW_GAS check.
> 
> This bug crept up because I have a bi-architecture (32/64) binutils, and
> unreasonable defaults sent my build to hell.

Applied, how did this ever work?  '-V' is what you need to use regardless
of how binutils was configured.
