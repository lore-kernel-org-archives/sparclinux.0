From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Thu, 19 Oct 2006 11:18:56 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <200610191318.57642.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Torsdag 19 oktober 2006 13:07, skrev Jim Watson:
> On 07/01/2004, at 5:29 PM, Per =D8yvind Karlsen wrote:
> > I'm left puzzled here now, will your display work correctly when
> > disabling
> > framebuffer with 'video=3Datyfb:off'? And if you're disabling it, why
> > do you
> > need to compile support for it?
> >
> > My experience is that I need atyfb properly working to intialize
> > display,
> > otherwise it'll boot with not display (openboot screen will stay
> > and no linux
> > output is displayed, while machine is actually booting and serial
> > can be
> > used).
> >
> > Am I missing something here..? (I'm fairly new to sparc, so please
> > have
> > patience:o)
>
> Hi Per,
>
> i am puzzled too - lets wait and see if anyone provides some
> explanation...
>
> There are two issues here:
>
> (a) i chose to use the debian config file to build a kernel that will
> run - the explanation is that I have no idea what to configure, but
> the debian config is known to work
>
> (b) the kernel that I did build that way, will not run, unless I boot
> with video:atyfb=3Doff
>
> This is on a sunblade100, it may be different on other sparc...you
> need to report what you are using
>
> regrads
>
> jim
Yes, but what I was wondering about is if you got any display at all or wer=
e=20
relying on serial console or something? Is it possible to have display=20
without framebuffer?

My config etc. were working fine with 2.6.17-rc3, don't know when the atyfb=
=20
breakage occured, but in 2.6.17 it was broken...
--=20
Regards,
Per =D8yvind Karlsen
Mandriva
