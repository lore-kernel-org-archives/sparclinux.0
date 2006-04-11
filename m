From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 11 Apr 2006 06:52:28 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <20060410.235228.110579785.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Mon, 10 Apr 2006 23:42:31 -0700

> With everything I've discovered, and not my team, tonight. The problem 
> is actually a util-linux issue and not a kernel issue. The issue is that 
> util-linux doesn't generate a proper sun disk label, when it's built 
> with GCC 4.1.

Ok, that's a great set of datapoints.

There are some things you can try to narrow this down further.

First, add some debugging to fdisk/fdisksunlabel.c in function
create_sunlabel().  Make sure it sets "other_endian" to zero.

Next thing you can try is to build just the fdisk/fdisksunlabel.o
object with gcc-4.0, then do the final link as normal.  If this works,
you know for sure that fdisk/fdisksunlabel.c is being compiled
differently and we can narrow down our focus into there.

