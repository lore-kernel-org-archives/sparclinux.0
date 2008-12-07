From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 09:34:32 +0000
Subject: Re: [PATCH] sparc: unify kernel/cpu
Message-Id: <20081207093432.GA14382@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206210237.GA27594@uranus.ravnborg.org>
In-Reply-To: <20081206210237.GA27594@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 07, 2008 at 12:05:53AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 6 Dec 2008 22:02:37 +0100
> 
> > o use cpu_32.c as base
> > o move all sparc64 definitions to the common cpu.c
> > o use ifdef for the parts that differs and use cpu_32 as base
> > o spitfire.h required a CONFIG_SPARC64 guard to fix build on 32 bit
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > ---
> > 
> > This is build tested only! 
> > I need to get a sparc system soon if I shall continue this...
> 
> Applied and I'll test this.
> 
> Sam, if you want I can give you an account on one of my Niagara
> systems which is very easy to reboot remotely and does allmodconfig
> builds from scratch in like 12 minutes :-)  Just email me privately
> if interested.
If I continue to do sparc hacking it would make sense.
But for now I was planning to take a quick sweep over the
sparse warnings produced for sparc32 so we get close
to the sparc64 level and then be done with it for this time.

I need to do a bit of kbuild hacking soon and m68k needs
some love too...

I will keep your offer in mind.

Thanks,
	Sam
