From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 03 Oct 2008 22:06:13 +0000
Subject: Re: clock_tick printing in cpuinfo
Message-Id: <20081003220613.GA29092@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20081002212059.GA13635@orion.carnet.hr>
In-Reply-To: <20081002212059.GA13635@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Oct 03, 2008 at 01:40:17PM -0700, David Miller wrote:
> > Maybe there is userland software that absolutely depends on the old format,
> > which would preclude applying this patch? That would be pretty strange, but
> > I suppose it's possible... Googling found me
> > https://ssl.drqueue.org/project/changeset/2027 but that is an open-source
> > program where this "regression" could be easily fixed (also they could
> > probably simplify their string handling).
> 
> GLIBC parses this value for the clock timer interfaces, be careful.

Ok, that's probably a good reason not to reboot into this kernel :) Thanks.
I've just skimmed over that code there, and it's apparent that removing the
old output would break for systems which don't have openprom in kernel.

It's not really obvious to me why glibc cares about this only on some
architectures, though - sparc, i386, powerpc, ia64, x86_64 have
__get_clockfreq(), but others don't. If I'm not missing something,
the others are defaulting to a stub which does nothing...?

-- 
     2. That which causes joy or happiness.
