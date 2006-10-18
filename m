From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Wed, 18 Oct 2006 19:36:16 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <200610182136.17529.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Onsdag 18 oktober 2006 21:30, skrev David Miller:
> From: Jim Watson <jim@amarooas.com.au>
> Date: Wed, 18 Oct 2006 21:50:24 +1000
>
> > David, thanks - I tried the patch on 2.6.18 but it still hangs up for
> > me. This is not conclusive however as I could not get my build of
> > 2.6.16 to run either. The output from the regs remains as before.
>
> It should remain the same.
>
> Are you sure you're enabling ATYFB video support in your kernel?
> That's a common error when folks build their own kernels.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
I was meaning to post on this topic earlier as I hoped it was fixed in more=
=20
recent releases, but ATYFB in kernel seems to be broken on my sb100 since=20
somewhere after 2.6.17-rc3..

I have to use a serial console now, haven't done extensive debugging on it,=
=20
but now I see the topic mentioned, what is the situation? :)
--=20
Regards,
Per =D8yvind Karlsen
Mandriva
