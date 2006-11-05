From: David Miller <davem@davemloft.net>
Date: Sun, 05 Nov 2006 23:25:11 +0000
Subject: Re: Strange kernel messages bootinh 2.6.18.2 on an E4000
Message-Id: <20061105.152511.102573800.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
In-Reply-To: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: andrew@walrond.org
Date: Sun, 5 Nov 2006 22:43:11 +0000

> On Sun, Nov 05, 2006 at 02:21:15PM -0800, David Miller wrote:
> > 
> > I've built a native gdb64 under Dapper and it works just fine.
> 
> Ok; thats a useful datapoint. I'll see what patches they are using.

You can build the vanilla sources, both the Ubuntu package and
upstream have essentially the same sparc bug fixes I made over
a year ago.
