From: "David S. Miller" <davem@redhat.com>
Date: Fri, 16 Apr 2004 19:33:39 +0000
Subject: Re: smartctl & ioctl translation
Message-Id: <20040416123339.650b5686.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0404121100260.28876-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404121100260.28876-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 12 Apr 2004 11:01:56 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> smartctl -a does not work on 2.6.5 sparc64 (Debian unstable). Does the
> kernel need some more ioctl32 translations or does smartmontools need a
> recompile against newer headers?

I believe the former, can you look at the smartctl sources and let
me know which ioctl command number macros it makes use of in
it's ioctl() calls?

Thanks.
