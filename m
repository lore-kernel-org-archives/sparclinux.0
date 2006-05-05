From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Fri, 05 May 2006 12:28:00 +0000
Subject: Re: kernel oops with 2.6.17-rc1 & 2.6.17-rc2
Message-Id: <200605051428.00250.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200604280042.08024.pkarlsen@mandriva.com>
In-Reply-To: <200604280042.08024.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Fredag 05 mai 2006 01:07, skrev David S. Miller:
> From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
> Date: Thu, 4 May 2006 15:21:25 +0200
>
> > This didn't do the trick, it made things crash at once, spitting out
> > several pages of  errors.. :\
> > A lot of these with tracebacks..
> > BUG: scheduling while atomic: swapper/0x00000011/1
>
> Thanks for testing, I'll try to figure out what's wrong.
I responded to this one yesterday, but I noticed that I only responded to=20
myself :o)
Anyways, I applied the patch wrong, tried it again and it seems to work now=
 :)
--=20
Regards,
Per =D8yvind Karlsen
Mandrakesoft becomes Mandriva
