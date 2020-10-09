From: Wolf Ruediger Spielmann <RSpielmann@gmx.de>
Date: Fri, 09 Oct 2020 14:40:26 +0000
Subject: Re: SMP is broken on sparc64 with kernel 4.x/5.x
Message-Id: <20201009164026.1c811fa50ae5f71551717fef@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201009161924.c8f031c079dd852941307870@gmx.de>
In-Reply-To: <20201009161924.c8f031c079dd852941307870@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi John

On Fri, 9 Oct 2020 16:30:35 +0200
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> It mostly affects older machines, the newer machines such as T5220, T5240=
 and T5 that
> we have in Debian have no issues with the latest kernel versions.
>=20
> We do have an UltraSPARC IIIi machine that we need to keep at 4.19 as the=
 machine otherwise
> becomes unstable.

I have absolute no stability issues.
It's (in my opinion) pcpu-alloc:
kernel 4.x/5.x: pcpu-alloc: [0] 0 1=20
kernel 3.x: pcpu-alloc: [0] 0 2=20

Is it fixable? Or will it stay in state "broken" ?

R=FCdiger
