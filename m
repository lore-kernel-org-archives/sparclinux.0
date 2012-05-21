From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 May 2012 17:37:23 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFzag=LfduvHSmE34nEVYOk=MRhUMzK854+icLwthmz5Ng@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521.050300.1434374935904126254.davem@davemloft.net>
In-Reply-To: <20120521.050300.1434374935904126254.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 21, 2012 at 2:03 AM, David Miller <davem@davemloft.net> wrote:
>
> There is going to be a merge conflict between the commit in the
> net-next tree that adds the Sparc BPF JIT, and the one in here which
> adds arch/sparc/Kbuild. =A0It should be quite easy to resolve.

Ok, so that had a very obvious resolution, and a "cleaner, but scarier" ver=
sion.

I picked the cleaner but scarier one - the one that should make the
BFP JIT be built when you do "make arch/sparc" by putting the net
thing into the new arch/sparc/Kbuild file.

I did minimal testing with "make ARCH=3Dsparc" without actually
*building* anything, and in the process also fixed the fact that you
should not select HAVE_BPF_JIT unless networking is enabled (crappy
interface - maybe that "if NET" part really should be in the
HAVE_BPF_JIT rules, not in all the architectures?)

But I do not have (nor do I really want) a sparc cross-compile
environment, so maybe my "cleaner" resolution is just garbage. Can you
please check the end result?

So if I broke something, please call me names and tell me to not try
to think too much, and worry my little brain with things I don't
understand.

The thing is pushed out, so you can see what I did.

                    Linus
