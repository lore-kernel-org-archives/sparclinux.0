From: "Eric Brower" <ebrower@gmail.com>
Date: Tue, 08 Aug 2006 20:57:54 +0000
Subject: Re: [PATCH] Fix E250 console with RSC
Message-Id: <ec7cefb0608081357y1002d4f1h72c37a9e1e1d1360@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
In-Reply-To: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 8/8/06, Daniel Smolik <marvin@mydatex.cz> wrote:
> Eric Brower napsal(a):
> > On 8/6/06, Daniel Smolik <marvin@mydatex.cz> wrote:
> >
> >> Eric Brower napsal(a):
> >> > On 8/5/06, Marc Zyngier <maz@misterjones.org> wrote:
> >> >
> >> >> Would be nice to understand the protocol between the E250 and the RSC
> >> >> (so we could have proper Linux tools to manage it), but I'm not sure
> >> >> Sun ever made it public...
> >> >
> >> >
> >> > I don't believe it was ever made public.  Eddie Dost did a bit of
> >> > poking at it a short while back, and I've considered taking a look as
> >> > part of the "other end" of SUNW,envctrltwo but have not yet done so.
> >> > The envctrltwo driver can dump the static configuration of the RSC,
> >> > which is a bit of a help for "lockouts" but not sufficient for
> >> > management.
> >> >
> >>
> >> But you say me  that is possible craate or delete user account for RSC
> >> via
> >> envctrltwo and piece of software. Only one thing that I use Solaris
> >> was creating
> >> RSC user account because I get E250 without RSC user account. All
> >> other thing I
> >> can do under linux.
> >
> >
> > With the envctrltwo driver and the rscinfo utility you can view the
> > static configuration of the RSC, but you cannot modify it.  Currently,
> > you can only modify the configuration via the RSC shell or Solaris
> > rscadm so far as I am aware.
> >
> I uderstatd, I mean that is possible write software that can do this.
> I mean that whith envctrl driver is possible write some data back to RSC memory
> area. Am I right ?

I am not sure-- overwriting the static configuration data may not take
effect until the RSC is reset (I cannot confirm this; I've not tried).
 It would be preferable to determine the interface used by rscadm and
make use of it.

Thanks,
E

>
>                         Dan
>
>


-- 
E
