From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 05 Feb 2005 06:06:19 +0000
Subject: Re: Xorg does not work on sparc32 in 2.6 (except on cg14)
Message-Id: <20050204220619.6a690547.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1107553760.3951.211.camel@localhost.localdomain>
In-Reply-To: <1107553760.3951.211.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 04 Feb 2005 16:40:27 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> My SS20 with a CG6 (TGX+) works fine in 2.4. When I attempt to run Xorg
> in 2.6 (specifically, 2.6.11-rc2-bk3), the Xorg.0.log claims that it is
> running, but the kernel has actually oopsed:

> Removing the if (srmmu_device_memory(pte_val(pte))) check stops the
> oops, but it doesn't make X work. The screen goes blank, but the X
> session never appears.

Remove the BUG() instead, and let it return ~0.  That makes it
so that copy_page_range() just copies device ptes over instead
of trying to lookup pages and stuff using the pfn.  The idea is
to return a bogus pfn so that pfn_valid() on it fails.
