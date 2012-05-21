From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 May 2012 18:24:00 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20120521182400.GA6043@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521.050300.1434374935904126254.davem@davemloft.net> <CA+55aFzag=LfduvHSmE34nEVYOk=MRhUMzK854+icLwthmz5Ng@mail.gmail.com>
In-Reply-To: <CA+55aFzag=LfduvHSmE34nEVYOk=MRhUMzK854+icLwthmz5Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 21, 2012 at 10:37:23AM -0700, Linus Torvalds wrote:
> On Mon, May 21, 2012 at 2:03 AM, David Miller <davem@davemloft.net> wrote:
> >
> > There is going to be a merge conflict between the commit in the
> > net-next tree that adds the Sparc BPF JIT, and the one in here which
> > adds arch/sparc/Kbuild. =A0It should be quite easy to resolve.
>=20
> Ok, so that had a very obvious resolution, and a "cleaner, but scarier" v=
ersion.
>=20
> I picked the cleaner but scarier one - the one that should make the
> BFP JIT be built when you do "make arch/sparc" by putting the net
> thing into the new arch/sparc/Kbuild file.
OK.

>=20
> I did minimal testing with "make ARCH=3Dsparc" without actually
> *building* anything, and in the process also fixed the fact that you
> should not select HAVE_BPF_JIT unless networking is enabled (crappy
> interface - maybe that "if NET" part really should be in the
> HAVE_BPF_JIT rules, not in all the architectures?)

HAVE_BPF_JIT is only used to make the BPF_JIT prompt visible.
And BPF_JIT depends on NET.

So the "if NET" part in the select is redundant but not strictly wrong.

	Sam
