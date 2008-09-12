From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 01:51:34 +0000
Subject: Re: [PATCH 0/3]: sun4m timer rework, try 2
Message-Id: <20080911.185134.176228961.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080910.235547.243605729.davem@davemloft.net>
In-Reply-To: <20080910.235547.243605729.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Thu, 11 Sep 2008 20:37:13 -0400

> With all 3 and with just the first 2, I get an OBP Watchdog Reset.

Ok, this approach isn't going to work.

We can't use the generic device layer until much later and
that's why it's crashing when we try to register the OF driver
bus type so early.

I'll have to try and figure out another way to do this.
