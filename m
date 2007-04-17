From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2007 07:19:59 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070417.001959.54787241.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Mon, 16 Apr 2007 23:35:56 -0400

> David Miller wrote:
> > Let's see what the heck smartd is sending to the device.  Please
> > reboot with smartd enabled and post the logs that get output
> > from this patch below applied, thanks.
> 
> Here it is:
 ...
> On one boot smartd actually started correctly and the system booted 
> without error. Here is the dump from that success case:
 ...

Thanks for the log.

Good news is that I can reproduce this locally.  I simply
start up a disk thrashing benchmark like "dbench 32" and
then run "smartd -d" in another window.

I'll post a patch to test once I can make it stop happening here.
