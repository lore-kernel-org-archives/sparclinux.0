From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 29 Oct 2004 00:34:17 +0000
Subject: Re: PATCH to fix initialisation issue for GC3 (linux-2.5.64 +).
Message-Id: <20041029003417.GW12934@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10410290107100.1071-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10410290107100.1071-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: davem@redhat.com, ecd@skynet.be, jj@sunsite.ms.mff.cuni.cz, anton@samba.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, trivial@rustcorp.com.au

On Fri, Oct 29, 2004 at 01:27:51AM +0100, Mark Fortescue wrote:
> This patch fixes an error in the blanking code for the GCThree SBUS
> video card. Now I get a logo and black screen, not just a blank (no
> video) screen. It is a trivual fix that has taken too long to identify as
> it is such a small typing error during the rewriting of the code for
> the new frame buffer system introduced in the 2.5 series kernels.
> Given that it still exists in the 2.6.8.1 kernel, I assume that not many
> people have tried using the latest kernel on systems with a CGThree.

Yes, all my systems are headless unfortunately.


-- wli
