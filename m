From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Sun, 04 Feb 2007 17:07:56 +0000
Subject: Re: GCC and SPARC Kernels
Message-Id: <200702041807.57675.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <FEC0BFE7-59AA-4DC3-97DF-3B703B26CD71@polyad.org>
In-Reply-To: <FEC0BFE7-59AA-4DC3-97DF-3B703B26CD71@polyad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I am resending this one as my mail bounced sending to your address, also yo=
u=20
should not set reply-to, this will make one post to your mail by default in=
=20
stead of the list..
S=F8ndag 04 februar 2007 16:23, skrev Luis F. Ortiz:
> What's the scoop on building SPARC Kernels and which version(s) of
> GCC to use?
>
> I've got:
>
> 	GCC 3.3.6
> 	GCC 3.4.6
> 	GCC 4.0.4
> 	GCC 4.1.2
>
> and intend to build:
>
> 	2.6.17, 18, 19 and 20-rc7
>
> for my little old SparcBlade 100.
>
> Anyone out there have hints about which combinations are known to be
> either bad or good?
>
>
> Luis F. Ortiz
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
4.0.4 should be fine, usinig 4.1* series seems to break atyfb driver which =
you=20
probably want no your SB100 (I know I do:)

--=20
Regards,
Per =D8yvind Karlsen
Mandriva
