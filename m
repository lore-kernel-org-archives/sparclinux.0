From: Wolf Ruediger Spielmann <RSpielmann@gmx.de>
Date: Fri, 09 Oct 2020 15:50:07 +0000
Subject: Re: SMP is broken on sparc64 with kernel 4.x/5.x
Message-Id: <20201009175007.bb89773b656cf944cf90937f@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201009161924.c8f031c079dd852941307870@gmx.de>
In-Reply-To: <20201009161924.c8f031c079dd852941307870@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Adrian,

On Fri, 9 Oct 2020 16:49:32 +0200
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> On 10/9/20 4:40 PM, Wolf Ruediger Spielmann wrote:
> > It's (in my opinion) pcpu-alloc:
> > kernel 4.x/5.x: pcpu-alloc: [0] 0 1=20
> > kernel 3.x: pcpu-alloc: [0] 0 2=20
>=20
> Interesting. I have not yet seen this issue on any of our Debian developm=
ent
> machines. What distribution are you running? Is this Gentoo?
>=20
> Our of curiosity, could you give it a go with Debian?

Yes - my distro is gentoo. All of my machines run Gentoo: the SUNs as well =
as x64 (for crosscompiling).
My first shot compiling the kernel native on the SUN took 4 hours and only =
5mins crosscompiling on x86 :-D

I'll give debian a try.

R=FCdiger
