From: Frans van Berckel <fberckel@xs4all.nl>
Date: Mon, 03 Jan 2011 08:52:24 +0000
Subject: Re: [PATCH v2 0/9] sparc: unify sparc/boot/piggyback
Message-Id: <1294044744.1549.30.camel@deblnxsrv222>
List-Id: <sparclinux.vger.kernel.org>
References: <20110101205701.GA4544@merkur.ravnborg.org>
In-Reply-To: <20110101205701.GA4544@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2011-01-03 at 18:31 +1100, Julian Calaby wrote:
> I've found an old laptop with a serial port to use as a serial console
> and resurrected my Ultra 1e. I decided to upgrade it to the latest
> Debian Squeeze, and it now won't load SILO. *sigh*. On boot, it fails
> with the message "Fast data access MMU miss" before SILO even prints
> anything. Apparently these messages are due to things being too large
> according to the ubuntu forums, but this occurs before SILO even
> loads, which makes me suspicious. I'll have to investigate further,
> but that means I'll have to take a trip to an installer environment -
> and given that I now lack the machine I had set up for installing them
> off, that's going to be difficult at best. I'm thinking a complete
> re-install might be an idea, but I've had persistent issues getting my
> Ultra 5 to install in the past, so I'm concerned that this might not
> happen.

Have seen this happening on different sparc boxes, several times.

Boot the install cd, now in rescue mode. Chrooting the installed
partition and run # silo -u -f again. Next reboot the Ultra.

Thanks,

Frans van Berckel

