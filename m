From: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Date: Fri, 07 Jul 2006 08:40:49 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <6BC755BB-644B-4CA4-9C6F-E06468BC6A6F@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On Jul 5, 2006, at 11:07 PM, Ludovic Court=E8s wrote:

> 2 days, 9 hours, 28 minutes, 40 seconds ago, Mikael Pettersson wrote:
>> In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with
>> frequent lock-up like behaviour on my Ultra5 (ATI Mach64).
>>
>> I finally managed to trace the cause to this change in 2.6.16-git6:
>
> Can you be more specific as to which version of Xorg you are using?
>
> Several people including me have reported being unable to run Xorg 7.0
> on ATI-based sparc64 machines such as U5s [0].  Symptoms include =20
> kernel
> hangs as well as transient [1,2] or permanent [3] filesystem =20
> corruptions.
>
> I just recompiled a kernel with your patch and it doesn't make any
> difference in that respect (besides, re-adding the
> `prot =3D __pgprot(...)' line looks questionable since the input =20
> value of
> PROT becomes unused as a result).
>
> Xorg 6.9, OTOH, was apparently working fine for most people.

Xorg 7.0 works for me on said U5 and U30 just fine ("distribution" is
T2 - http://www.t2-project.org).

When I'm back in the office (abroad right now) I can patch X to mmap
as advised by David.

Yours,

--=20
Rene Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://=20
rebe.name
            +49 (0)30 / 255 897 45


