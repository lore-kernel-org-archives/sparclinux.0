From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 23:01:22 +0000
Subject: Re: [PATCH 7/9] sparc: use piggyback_32 for sparc64
Message-Id: <20110101230122.GA17624@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1293915632-4596-7-git-send-email-sam@ravnborg.org>
In-Reply-To: <1293915632-4596-7-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Josip.

On Sat, Jan 01, 2011 at 10:45:52PM +0100, Josip Rodin wrote:
> On Sat, Jan 01, 2011 at 10:00:30PM +0100, Sam Ravnborg wrote:
> > diff --git a/arch/sparc/boot/piggyback_64.c b/arch/sparc/boot/piggyback_64.c
> > deleted file mode 100644
> > index a26a686..0000000
> > --- a/arch/sparc/boot/piggyback_64.c
> > +++ /dev/null
> > @@ -1,110 +0,0 @@
> > -/*
> > -   Simple utility to make a single-image install kernel with initial ramdisk
> > -   for Sparc64 tftpbooting without need to set up nfs.
> > -   
> > -   Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
> 
> Presumably you copied all that code from this file, so you should also
> move over the copyright statement (the year in the other one differs).

Thanks for looking through the patches.

I have based all the work on the _32.c variant.

From the _64.c variant I used only small bits to redo
the same functionality.

If this warrant to update the copyright or not I am not sure.
But as you brougth it to my attention I will do so and
add my own copyright in the process.

Jakub - you can see the original thread here: 
http://marc.info/?l=linux-sparc&m9391542615466&w=2

	Sam
