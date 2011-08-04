From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 04 Aug 2011 09:43:15 +0000
Subject: Re: sparc: rename atomic_add_unless
Message-Id: <20110804094315.GA2005@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110728104017.GA27861@entuzijast.net>
In-Reply-To: <20110728104017.GA27861@entuzijast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, Aug 04, 2011 at 07:39:16PM +1000, Stephen Rothwell wrote:
> Hi Dave,
>=20
> On Thu, 04 Aug 2011 01:21:46 -0700 (PDT) David Miller <davem@davemloft.ne=
t> wrote:
> >
> > From: Josip Rodin <joy@entuzijast.net>
> > Date: Thu, 28 Jul 2011 12:40:17 +0200
> >=20
> > > This patch[0] seems to fix a build issue, but it doesn't fix the
> > > functionality - the previous change[1] changed the return value seman=
tics,
> > > it's now supposed to be to be just the old value, rather than a compa=
rison.
> > >=20
> > > [0] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.gi=
t;a=3Dcommitdiff;hg8624e401b0b7747762b5223fb23f86dcdacc93
> > > [1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.gi=
t;a=3Dcommitdiff;h=F24219b4e90cf70ec4a211b17fbabc725a0ddf3c
> >=20
> > Stephen please post a fix for this before a 32-bit sparc person
> > loses their filesystem or worse.
>=20
> Um, I could try to figure out how to do that, but what I did was respond
> in July 29 to the message above cc'ing the author of the orignal patch in
> the hope that they would write a fix.  Clearly that hope was in vain :-(

It should be fairly trivial:

diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 8600eb2..1d32b54 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -65,7 +65,7 @@ int __atomic_add_unless(atomic_t *v, int a, int u)
        if (ret !=3D u)
                v->counter +=3D a;
        spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
-       return ret !=3D u;
+       return ret;
 }
 EXPORT_SYMBOL(__atomic_add_unless);

--=20
     2. That which causes joy or happiness.
