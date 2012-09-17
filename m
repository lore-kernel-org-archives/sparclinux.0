From: Kurt Roeckx <kurt@roeckx.be>
Date: Mon, 17 Sep 2012 16:35:36 +0000
Subject: Re: Random segmentation fault on UltraSparc T1 based machines
Message-Id: <20120917163536.GB17409@roeckx.be>
List-Id: <sparclinux.vger.kernel.org>
References: <20120917100700.GA6459@ohm.aurel32.net>
In-Reply-To: <20120917100700.GA6459@ohm.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Sep 17, 2012 at 12:07:00PM +0200, Aurelien Jarno wrote:
> Hi,
> 
> Debian is using among other machines Sun Fire T2000 machines for
> building the current sparc port and for the development of the
> sparc64 one.
> 
> We are experiencing random non-reproducible segmentation faults when
> doing parallel building, calling make with -jX and X > 1. This seems
> to happen more and more as X increases.

It happens with X = 1 too, just a lot less.



Kurt

