From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Wed, 07 Jan 2004 06:29:56 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <200401070729.56891.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Torsdag 19 oktober 2006 08:38, skrev Jim Watson:
> On 19/10/2006, at 5:30 AM, David Miller wrote:
> > Are you sure you're enabling ATYFB video support in your kernel?
> > That's a common error when folks build their own kernels.
>
> Success! I used the later patch [0] and the config file from debian
> 2.6.18-1-sparc64 as mentioned by Jurij[1]
> which includes - hopefully relevant ;)
>
> CONFIG_FB_ATY128=3Dy
> CONFIG_FB_ATY=3Dy
> CONFIG_FB_ATY_CT=3Dy
> # CONFIG_FB_ATY_GENERIC_LCD is not set
> CONFIG_FB_ATY_GX=3Dy
>
> Using LCD Benq FP767 here,
>
> I could only get it it to boot this way:
>
> boot:mylinux18 video=3Datyfb:off
>
> which is what I need as it also gets rid of those pesky red dots ;)
>
> I am happy to report anything else that might assist...
>
> thanks to David for the patches and thanks to Jurij for guidance,
>
> jim
>
> [0] http://marc.theaimsgroup.com/?l=3Dlinux-sparc&m=116120447318793&w=3D2
> [1] http://marc.theaimsgroup.com/?l=3Dlinux-sparc&m=116120045100433&w=3D2
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
I'm left puzzled here now, will your display work correctly when disabling =

framebuffer with 'video=3Datyfb:off'? And if you're disabling it, why do yo=
u=20
need to compile support for it?

My experience is that I need atyfb properly working to intialize display,=20
otherwise it'll boot with not display (openboot screen will stay and no lin=
ux=20
output is displayed, while machine is actually booting and serial can be=20
used).

Am I missing something here..? (I'm fairly new to sparc, so please have=20
patience:o)
--=20
Regards,
Per =D8yvind Karlsen
Mandriva
