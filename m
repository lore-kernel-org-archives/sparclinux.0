From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Dec 2011 22:20:46 +0000
Subject: Re: [PATCH 1/1] apbuart: fix section mismatch warning
Message-Id: <20111227222046.GA18990@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111227212253.GA8161@merkur.ravnborg.org>
In-Reply-To: <20111227212253.GA8161@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 27, 2011 at 04:35:22PM -0500, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 27 Dec 2011 22:22:53 +0100
> 
> >>>From b82ccce349dee62fe5acd3167a19490bbe9a7e18 Mon Sep 17 00:00:00 2001
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Tue, 27 Dec 2011 22:07:23 +0100
> > Subject: [PATCH] apbuart: fix section mismatch warning
> > 
> > Fix following warnings:
> > 
> > WARNING: drivers/tty/serial/built-in.o(.text+0x7370): Section mismatch in reference from the function grlib_apbuart_configure() to the variable .init.data:apbuart_match
> > The function grlib_apbuart_configure() references
> > the variable __initdata apbuart_match.
> > This is often because grlib_apbuart_configure lacks a __initdata
> > annotation or the annotation of apbuart_match is wrong.
> > 
> > + 3 more warnings like this.
> > 
> > There is no guarantee that grlib_apbuart_of_driver.of_match_table
> > is only used at __init time - so drop the __initdata annotation.
> > 
> > grlib_apbuart_configure() is only used during __init so add __init
> > to this method too.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Daniel Hellstrom <daniel@gaisler.com>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Applied to sparc-next, thanks.
> 
> Taking a look at the output of "git grep of_device_id | grep __initdata"
> shows that a lot of drivers take liberties in this area, perhaps assuming
> that they are built in or something like that.

I took a quick look at this.
In the places I found the of_device_id() was passed to for
example of_platform_bus_probe() which was only called at __init time.
And the function did not save the argument.

So at least some call sites are OK.
But I did not audit nearly all of them - so some bugs are lingering here.

	Sam
