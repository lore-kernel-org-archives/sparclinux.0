From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Thu, 01 Apr 2010 08:46:57 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100401093831.GE5207@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329222132.GB12254@nowhere> <20100329.153208.190256896.davem@davemloft.net> <20100401090608.GD5207@nowhere> <20100401.010903.05627158.davem@davemloft.net>
In-Reply-To: <20100401.010903.05627158.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, Apr 01, 2010 at 01:09:03AM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Thu, 1 Apr 2010 11:06:11 +0200
> 
> > I actually can't. It works well on a backup 2.6.31-rc6 kernel
> > but when I build a new one of this same version, the problem
> > happens again. And I don't have the config of the one that works
> > (and no /proc/config.gz as well).
> > 
> > So I suspect this is something that happens with some specific
> > configs only.
> > 
> > Anyway, once I get more clues about this, I'll tell you.
> 
> I was going to ask you if any of your compiler tools changed
> recently...
> 
> Check the gcc version printed by the working kernel at the top of the
> dmesg logs and compare to what you end up using now.


They are exactly the same :)

gcc version 4.3.2 (Debian 4.3.2-1.1)

Really I think I need to dig further as I don't have useful
clues to provide. I need to check if the segfault always happen
in the same place, etc...

It seems to happen with ld as well btw (not sure this is related
though):

[ 3366.005962] ld[19041]: segfault at 10 ip 000000007010248c (rpc 00000000701023f8) sp 00000000ffda87c8 error 30001 
in libbfd-2.18.0.20080103.so[700d8000+a0000]

