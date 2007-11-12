From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 12 Nov 2007 13:16:16 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071112131616.GA22139@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Nov 10, 2007 at 10:13:28PM -0800, David Miller wrote:
> From: Josip Rodin <joy@entuzijast.net>
> Date: Wed, 7 Nov 2007 15:25:46 +0100
> 
> > I applied the patch, rebooted into the new kernel, and let lebrun run its
> > buildd, but the apt package fetching method constantly times out trying to
> > reach incoming.debian.org - that (unrelated) server is having a downtime.
> > So unfortunately I can't properly test this long-awaited fix :)
> > 
> > But I did the artificial tests, like running dpkg-query --search libc.so.6
> > in loops, and this seems to work well. Thanks a lot!
> 
> Please let me know if things go smoothly when the
> build becomes active again.

It became functional again a couple of hours ago, and for now everything
seems just fine, it's happily churning away, load hovers around 1, memory
usage seems normal, and nothing's getting stuck.

-- 
     2. That which causes joy or happiness.
