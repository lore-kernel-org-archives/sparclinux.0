From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Wed, 25 Oct 2006 20:08:45 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <200610252208.46108.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Onsdag 25 oktober 2006 17:23, skrev Per =D8yvind Karlsen:
> So I'm really puzzled, could it be related to any possible changes in
> toolchain causing this or something similar?
I reverted back to old gcc 4.0.3 to build kernel, now -rc3 seemed to initia=
te=20
display properly at least, so it seems to be related to the compiler..

Will now build latest kernel release with 4.0.3 to see if it works properly=
=20
now :)

davem: thanks for your patience and for troubling you with this one
--=20
Regards,
Per =D8yvind Karlsen
Mandriva
