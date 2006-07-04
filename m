From: Rene Rebe <rene@exactcode.de>
Date: Tue, 04 Jul 2006 07:41:07 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <200607040941.07108.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi,

On Monday 03 July 2006 13:17, Mikael Pettersson wrote:
> In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with
> frequent lock-up like behaviour on my Ultra5 (ATI Mach64).
> I finally managed to trace the cause to this change in 2.6.16-git6:

I can confirm this behaviour, on a U5 with ATi onboard, but for me it
happens also on the Creator 3D of a U30, likewise.

I'll try to test if this changeset makes a difference for me as well
as soon as possible.

--=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45
