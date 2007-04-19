From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2007 19:41:39 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070419.124139.124552203.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pasi Pirhonen <upi@centos.fi>
Date: Thu, 19 Apr 2007 16:04:15 +0300

> Hi,
> 
> On Thu, Apr 19, 2007 at 12:41:39AM -0700, David Miller wrote:
> > 
> > The current driver should not hit the problems you saw.  I plan
> > to post in-full the current driver as a patch in a few moments,
> > if you could retest this case with it, I'd really appreciate it.
> > 
> 
> Did add this 'new esp v2' to linux-2.6.21-rc7 and booted with two of
> those seagates, which did timeout previously. No problems at all.
> Ran quickly 'dbench 32' for sda and sdb simultaneously, if that is
> proving anything. Will leave those running in loop while i do get some
> sleep .... and hope those dbench-loop will be still alive when i wake
> up :)
> 
> Good job so far with the new esp driver.

Thanks for all of your testing and reports.
