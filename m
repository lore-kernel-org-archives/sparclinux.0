From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 16 Sep 2009 12:49:00 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090916124900.GA23181@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Sep 16, 2009 at 01:14:35AM -0700, David Miller wrote:
> >> I thought I messed up between patches and built kernels.
> >> I realize now that I had the explanation under my nose.
> >> Duh....
> > 
> > I had just recompiled and booted my SMP kernel without the dreaded
> > PROM_CONSOLE, and yet the machine got stuck in the same place in the
> > NMI code. I then removed initcall_debug, and it still doesn't work.
> > What am I missing?!
> > 
> > The .config diff between the working UP kernel and this one is:
> 
> I put up the kernel image I booted with your config (sans PROM_CONSOLE)
> at:
> 
> 	http://vger.kernel.org/~davem/vmlinux-debug
> 
> give it a try.

Yours works fine... I've reverted all the interim patches and rebuilt mine,
and it still won't boot, hanging in the same place again. I don't get it.
I'm attaching the exact .config used in my last attempt, just in case.
diff says PROM_CONSOLE is the only change. I'll be going over your image's
config (extracted from /proc/config.gz).

-- 
     2. That which causes joy or happiness.
