From: Pasi Pirhonen <upi@centos.fi>
Date: Sat, 14 Apr 2007 17:54:53 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070414175453.GB6300@centos.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


On Sat, Apr 14, 2007 at 10:26:08AM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Sat, 14 Apr 2007 10:01:43 -0700 (PDT)
> 
> > I'll fix the bug in the qlogicpti driver and post the patch for
> > you.
> 
> This should fix the qlogicpti driver.

> +             } else if (Cmnd->request_bufflen) {

Thank you. It'll take few hours while i do have possible window for
booting the beast as it's compiling RPMS, but i do get back again, if
the patch below won't cure the qlogicpti. Actually that is exactly
same solution which i was considering 'as if() hack', but from me it 
would have been just a hack, but from someone else, whom does have 
some kind of understanding what one is doing, it's a patch :)

The new esp-driver is still running strong, but ATM it's not getting
any real beating as the box is simply re-compiling batch of SRPMS.
But earlier i could not get is crashing even when there were heavy disk
activity on two separate disks and tape-backup ongoing while building
RPMS took care that there isn't any extra idle time.


-- 
Pasi Pirhonen - upi@iki.fi - http://pasi.pirhonen.eu/
Top-postings silently ignored
