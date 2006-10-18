From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Wed, 18 Oct 2006 20:28:55 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <200610182228.56785.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Onsdag 18 oktober 2006 22:15, skrev Per =D8yvind Karlsen:
> Onsdag 18 oktober 2006 21:45, skrev David Miller:
> > From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
> > Date: Wed, 18 Oct 2006 20:36:16 +0100
> >
> > > I have to use a serial console now, haven't done extensive debugging =
on
> > > it, but now I see the topic mentioned, what is the situation? :)
> >
> > Unfortunately it's working fine here on my SB100 so I can't
> > reproduce your problem at all.
>
> oh, too bad, I thought that it was known as you were referring to atyfb
> things, I'll try dig up some info to be provided :)
okay, tried booting with display, got these errors:

SABRE0: Uncorrectable Error, primary error type[DMA Write:Translation Error]
SABRE0: bytemask[00ff] dword_offset[0] was_block(0)
SABRE0: UE AFAR [000000006fd7c000]
SABRE0: UE Secondary errors [(none)]
SABRE0: IOMMU Error, type[Invalid Error]
SABRE0: IOMMU TAG(3)[RAW(0000000000c6f800)error(Invalid=20
Error)wr(0)sz(8K)vpg(df000000)]
SABRE0: IOMMU DATA(3)
[RAW(000000006fe379ec)valid(1)used(1)cache(0)ppg(000000006f3d8000)

makes any sense?
--=20
Regards,
Per =D8yvind Karlsen
Mandriva
