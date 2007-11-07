From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 07 Nov 2007 14:25:46 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071107142546.GA7603@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Nov 06, 2007 at 09:13:56PM -0800, David Miller wrote:
> > [FUTEX]: Fix address computation in compat code.
> Here is an updated patch:

I applied the patch, rebooted into the new kernel, and let lebrun run its
buildd, but the apt package fetching method constantly times out trying to
reach incoming.debian.org - that (unrelated) server is having a downtime.
So unfortunately I can't properly test this long-awaited fix :)

But I did the artificial tests, like running dpkg-query --search libc.so.6
in loops, and this seems to work well. Thanks a lot!

-- 
     2. That which causes joy or happiness.
