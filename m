From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 13 Mar 2012 23:37:46 +0000
Subject: Re: sata_mv change breaks sparc builds?
Message-Id: <CAP=VYLo1K=gyWSrPBLcYK39HnnefWj+94Mi6HRcFzu-R4bA7cQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAP=VYLrzrtJBUdojYos+9L30nNSoboPvfAh0u2tuJSvGX5Ao9Q@mail.gmail.com>
In-Reply-To: <CAP=VYLrzrtJBUdojYos+9L30nNSoboPvfAh0u2tuJSvGX5Ao9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Mar 13, 2012 at 6:39 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Hi guys,
>
> I've not bisected to concretely determine this is true, but at 1st
> glance, it would appear perhaps that the change:
>
> -------------
> commit f1e1e148c5cbf62b6db26ae828c1e54e76579dfd
> Author: Michael Walle <michael@walle.cc>
> Date: =A0 Sun Nov 13 22:23:57 2011 +0100
>
> =A0 =A0ARM: kirkwood: sata_mv: add device tree binding
>
> =A0 =A0Based on devicetree work by Michael Walle. =A0Changed compatible p=
roperty
> =A0 =A0to "mrvl,orion-sata", simplified retrieving nr_ports from fdt.
>
> =A0 =A0Signed-off-by: Michael Walle <michael@walle.cc>
> =A0 =A0Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> --------------
>
> might be responsible for these new sparc build failures?
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/5869562/
> http://kisskb.ellerman.id.au/kisskb/buildresult/5869535/
>
> If you could confirm or deny, that would be great help.

Just a follow up to this -- I just realized that the linux-next
toolchain for sparc changed, so that *may* somehow have
a bearing on this (i.e. how weak is handled etc etc.)

P.
--
>
> Thanks,
> Paul.
