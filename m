From: Christian Guggenberger
Date: Wed, 14 Jan 2004 07:43:36 +0000
Subject: Re: [2.6.1] still no working keyboard/mouse on ultra-enterprise 2
Message-Id: <20040114084336.A8111@pc9391.uni-regensburg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20040112140940.C4116@pc9391.uni-regensburg.de>
In-Reply-To: <20040112140940.C4116@pc9391.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12.01.2004   22:01 Ben Collins wrote:
> On Mon, Jan 12, 2004 at 09:57:54AM -0800, David S. Miller wrote:
> > On Mon, 12 Jan 2004 15:46:06 +0000
> > Ciaran McCreesh <ciaranm@gentoo.org> wrote:
> >
> > > Are you using the 2.4-style KEYMAPs? I don't know how Debian handles
> > > this, but in Gentoo it's necessary to comment out the KEYMAP="sunkeymap"
> > > line in /etc/rc.conf (or replace it with an x86-style setting if you
> > > prefer).
> >
> > I bet that's exactly what this person's problem is.
> >
> > You cannot load Sun style keymaps any longer, it will result in garbage
> > or nothing when you type keys.  You need to use x86 style keymaps on
> > all platforms now in 2.6.1
> 
> Yeah, either uninstall console-tools entirely, or do
> 
> 	dpkg-reconfigure console-data
> 
> And select an i386 keymap, or have it stick with the kernel keymap.
> 

thanks for all your replies regarding this isse.
Well, sunkeymap is not the problem here - I already knew, that I have to use 
an i386 keymap now.
This morning I did some further tests, and I found out, that my problem has 
something to do with SMP.

If I boot with the "nosmp" parameter, the keyboard is fine and usable, of 
course.
Well, that's no real solution for me, as the Ultra Enterprise2 is a Dual TI 
UltraSparc I (Spitfire)...
Any suggestions?

cheers.
Christian

