From: "C.Newport" <crn@netunix.com>
Date: Mon, 08 Mar 2004 01:44:31 +0000
Subject: Re: auto poweroff - keyboard dependency?
Message-Id: <200403080144.31009.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <404BC52E.60502@usa.net>
In-Reply-To: <404BC52E.60502@usa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 08 March 2004 12:58 am, Eric Brower wrote:
> Janos Sziliczi wrote:
> > Hi All,
> >
> > I've compiled a 2.4.25 kernel.
> > When I'd typed the 'halt' command as root, the Linux shutdowned and the
> > machine turned off automatically (no 'power-off' needed on PROM prompt).
>
> This tends to hit the list once every few weeks.
>
> In both sparc and sparc64 the kernel will not power-off systems that are
> running with a serial console-- instead they are dropped to OBP (2.2.x
> did not act this way).  I believe Pete was going to remove this "safety
> measure" in sparc a while back but I don't believe it has been done.
>
> If you are running a sparc kernel, remove the check for !serial_console

But be warned that if you tell an E150 to power-off you will have great
weeping and wailing and gnashing of teeth getting it to restart.
Rather drop to OBP and pull the power.

