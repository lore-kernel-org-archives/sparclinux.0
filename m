From: Ciaran McCreesh <ciaranm@gentoo.org>
Date: Fri, 20 Aug 2004 21:05:34 +0000
Subject: Re: Buglet making vmlinux with -j
Message-Id: <20040820220534.50858f5d@snowdrop.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__20_Aug_2004_22_05_34_+0100_3SJmCSz4PzBPMi.a"
List-Id: <sparclinux.vger.kernel.org>
References: <200408202156.06459.crn@netunix.com>
In-Reply-To: <200408202156.06459.crn@netunix.com>
To: sparclinux@vger.kernel.org

--Signature=_Fri__20_Aug_2004_22_05_34_+0100_3SJmCSz4PzBPMi.a
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 20 Aug 2004 13:59:56 -0700 William Lee Irwin III
<wli@holomorphy.com> wrote:
| On Fri, Aug 20, 2004 at 09:56:06PM +0100, C.Newport wrote:
| > If I build a 2.4.27 kernel with -j6 to strsss test an SMP system 
| > it compiles but silently finishes before linking.
| > Is this a bug or expected behaviour ?
| 
| You're going to have to be more precise in your description for me to
| tell. I am not sure from this description whether this describes a
| failure to build or an unusual kind of output while otherwise building
| successfully or maybe even something else.

It's known behaviour for 2.4.x (2.6.x should work). Keith had a patch,
although I believe it wasn't applied because of suspected side effects.

-- 
Ciaran McCreesh : Gentoo Developer (Sparc, MIPS, Vim, Fluxbox)
Mail            : ciaranm at gentoo.org
Web             : http://dev.gentoo.org/~ciaranm


--Signature=_Fri__20_Aug_2004_22_05_34_+0100_3SJmCSz4PzBPMi.a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJmeo96zL6DUtXhERAh0jAKCmd/u3dKKpvvoM3+25onXltNmBsgCgq3IN
EBMq/HRpZeD+JObusZWArbg=
=SAmG
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Aug_2004_22_05_34_+0100_3SJmCSz4PzBPMi.a--
