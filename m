From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 03 Apr 2012 22:35:57 +0000
Subject: Re: sparc32 - keyboard is dead with v3.4-rc1
Message-Id: <20120403223557.GA25330@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120403204455.GA29433@merkur.ravnborg.org>
In-Reply-To: <20120403204455.GA29433@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 03, 2012 at 05:37:30PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 3 Apr 2012 22:44:56 +0200
> 
> > I have just tried out v3.4-rc1 on my sparc32 box - and keyboard is not working.
> > I type my username - but nothing happens.
> > 
> > I see nothing unusual during booting the kernel.
> > With the same configuration it works with v3.3.
> > 
> > As I have no prime suspects I have started to bisect it -
> > but wanted to let you know that there is an issue.
> > 
> > bisect will take some time as my build-machine is not exactly
> > quick - so I expect no result until sometime tomorrow.
> > But the good thing is that it is easy to test :-)
> 
> Since sparc is one of the few platforms with a serial based keyboard
> I think serial/tty/input layers would be the places to investigate.
> 
> Unfortunately I can't help with this since all the machines I have
> access to have USB keyboards and there'd be a loud mob if those
> broke :)
sunzilog was the culprint - so right you were...

I managed to complete the bisect today (getting late here).

It said:

d4e33fac2408d37f7b52e80ca2a89f9fb482914f is first bad commit
commit d4e33fac2408d37f7b52e80ca2a89f9fb482914f
Author: Alan Cox <alan@linux.intel.com>
Date:   Thu Jan 26 17:44:09 2012 +0000

    serial: Kill off NO_IRQ

    We transform the offenders into a test of irq <= 0 which will be ok while
    the ARM people get their platform sorted. Once that is done (or in a while
    if they don't do it anyway) then we will change them all to !irq checks.

    For arch specific drivers that are already using NO_IRQ = 0 we just test
    against zero so we don't need to re-review them later.

    Signed-off-by: Alan Cox <alan@linux.intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 e9f4b547c07e96339c1ea04b68c64b10ac576bb5 aa27d6cda463cfacc254cd74a787f68fb4c2f678 M      drivers

This was also my prime suspect when I looked at tty/serial.

I assume we have some inconsistency in the interpretation
of irq = 0 somewhere.

In my first post I said that nothing unusual showed up in
the boot log.
But the following line is missing when it does not work:

    input: Sun Type 5 keyboard as /devices/root/ffd31a40/ffd31cf0/serio0/input/input0


I will take a look at this tomorrow.

	Sam
