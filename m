From: "Small, Jim" <jim.small@eds.com>
Date: Tue, 03 Feb 2004 12:37:23 +0000
Subject: RE: Problems with bridging on Sparc64
Message-Id: <564DE4477544D411AD2C00508BDF0B6A1CD0E440@usahm018.exmi01.exch.eds.com>
List-Id: <sparclinux.vger.kernel.org>
References: <8AA870658244D4119AF600508BDF0A361D4BF107@usahm014.exmi01.exch.eds.com>
In-Reply-To: <8AA870658244D4119AF600508BDF0A361D4BF107@usahm014.exmi01.exch.eds.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David,

Please excuse my ignorance, but is there an easy way to build the bridging
tools/library as 64bit binaries or are you saying that the dependence on
SIOCDEVPRIVATE makes it extremely difficult without redesigning the bridging
software?

If that's the case, I guess it's back to OpenBSD...

Please let me know.

Thanks,
   <> Jim

> -----Original Message-----
> From: David S. Miller [mailto:davem@redhat.com]
> Sent: Monday, February 02, 2004 4:20 PM
> To: Small, Jim
> Cc: sparclinux@vger.kernel.org; jim.small@eds.com; shemminger@osdl.org
> Subject: Re: Problems with bridging on Sparc64
> 
> On Mon, 2 Feb 2004 15:18:04 -0500
> "Small, Jim" <jim.small@eds.com> wrote:
> 
> > I understand that David S Miller and other Sparc64 Linux networking
> gurus
> > hang out in this forum.  I'm hoping you can help me with a bridging
> problem.
> >
> > I am running kernel 2.4.24/Sparc64 on my Ultra 60.  I also have the
> latest
> > version of the bridge utils - 0.9.6.
> 
> Unfortunately this is not fixable, unless you rebuild your bridging tools
> as 64-bit binaries.
> 
> It is nearly impossible to translate the 32-bit versions of the bridging
> ioctl interfaces because they use the SIOCDEVPRIVATE ioctl numbers which
> do not indicate the type that the application is passing into the handler
> (and thus we don't what to translate it to/from).
> 
> Stephen Hemminger (bridge maintainer) CC'd.
