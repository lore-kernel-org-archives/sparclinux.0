From: Jim Watson <jim@amarooas.com.au>
Date: Thu, 19 Oct 2006 11:34:00 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <F2658A44-9A52-40AA-8D89-6F65EF3ABC82@amarooas.com.au>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


On 19/10/2006, at 9:18 PM, Per =D8yvind Karlsen wrote:

> Yes, but what I was wondering about is if you got any display at =20
> all or were
> relying on serial console or something? Is it possible to have display
> without framebuffer?
>
> My config etc. were working fine with 2.6.17-rc3, don't know when =20
> the atyfb
> breakage occured, but in 2.6.17 it was broken...


Sorry I dont know about that breakage. All I know is:
(a) my patched 2.6.18 kernel is built with the debian config file
(b) my kernel would not boot at all, unless i used video:atyfb=3Doff

The X (xorg) display works fine with that parameter but the console =20
is weird. The only reason I tried that parameter is because of word =20
association,  it was known to me previously as a fix for some "red =20
dots" issue, not for any other reason,

jim