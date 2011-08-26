From: David Miller <davem@davemloft.net>
Date: Fri, 26 Aug 2011 01:39:56 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110825.213956.1506607934023206694.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Thu, 25 Aug 2011 13:48:55 -0400

> Yes I agree that there's something screwy in the detection logic.  I get
> a "console [tty0] enabled, bootconsole disabled" when I don't use the
> keep_bootcon kernel parameter, even though I have the
> input-device=keyboard and output-device=screen openprom variables set.
> So add bootconsole detection to the list of things that are screwy.

That's not the problem, this is a known issue.

Early in boot the firmware based console attaches.

Then the generic VT layer attaches and takes over the console, but
because the framebuffer and serial layer hasn't probed devices yet you
get a period during the boot during which no console output occurs.
