From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 10:58:00 +0000
Subject: Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc code
Message-Id: <56D02FB8.90803@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MPfmd7xTLfbLOLcfqcMIdQLw0jEA0eQw5"
List-Id: <sparclinux.vger.kernel.org>
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org

--MPfmd7xTLfbLOLcfqcMIdQLw0jEA0eQw5
Content-Type: multipart/mixed; boundary="n3hSwNTt54sEapiDHNUIguP5Sl9N4B5nF"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org
Message-ID: <56D02FB8.90803@ti.com>
Subject: Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc
 code
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>

--n3hSwNTt54sEapiDHNUIguP5Sl9N4B5nF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/02/16 05:13, Paul Gortmaker wrote:
> This series of commits is a part of a larger project to ensure
> people don't reference modular support functions in non-modular
> code.  Overall there was roughly 5k lines of dead code in the
> kernel due to this.  So far we've fixed several areas, like tty,
> x86, net, ... and we continue to work on other areas.
>=20
> There are several reasons to not use module support for code that
> can never be built as a module, but the big ones are:
>=20
>  (1) it is easy to accidentally write unused module_exit and remove cod=
e
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else, thus adding to CPP overhead.
>  (4) it gets copied/replicated into other code and spreads like weeds.

I think all the "normal" drivers should be compilable as modules. If
they can't, it should be fixed. However, we have lots of old drivers for
which it may be difficult to get anyone to fix them or test them.

Then again, with that kind of drivers it may be better to just let them
be, if there's no big reason to start cleaning them up. In other words,
if the driver is old and not actively developed/maintained, compiles
fine, presumably works fine, doesn't obstruct any other development,
then why touch it at all...

While doing this, did you just go forward removing the module support,
or did you check if it would be trivial to make the driver build as a
module? I wouldn't be surprised if in some cases all that would need to
be done is change the Kconfig's bool to tristate.

 Tomi


--n3hSwNTt54sEapiDHNUIguP5Sl9N4B5nF--

--MPfmd7xTLfbLOLcfqcMIdQLw0jEA0eQw5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0C+5AAoJEPo9qoy8lh71mvcP/RVeIwt3scrHgn6Ux/EJUff0
wwA+TGlTCyLIw8W+24bmkbFY2HJj04IuDop5zgi6xJlV/p6yLwAhlG5hmYCxNbu1
EfpMX78XB4v+JGPzj72nHq7u5nnUT2VhTCBUYazEWQ7zOk+4qJb3Q3q5dw2NlcCf
6q2FcbapzmiUYRda6gtTYaKws0Xk5fsfLBw7mCzPKxS1loX9NathFvQZ50HqdXNt
p33vv+4m2AgtMNHvo5G/VyQBmLYOVw7IHOrajP7sZWQEwT+OBjYcJwQ6a4vLe429
dd2QVRMGyOqE8PcPqnDQl41pQjlQfuMA2/O8G6GV8IZlb70vME6iVc1suokLn0Mt
mdMWiX9AMbMk8xTrBNyhX9O40ZnHDqKzPN3rdKcXUetpy4sOHpPmXB3UYjMxd2p1
zaNifjQpYfR26G76W7vW4jYieBzkRR0mvu/9j5q/gSeRrEnNrOt58J5TN6uqzRqI
PIpVyE9C68/YhmhKczoA//NYtk5TMkcWz8e2tIaGvG0gyXlSkg9BYd7mQjboZ1fe
hcTsyiceN6MpyzlA/5w7U5jsgSWyqzJdIY/6wzY92AiGnzzcuvfpI2qt+522jCvl
bsAzppWL6dIrxT9c67k0F7ATLCe+npw/gnok72huMg25rR5zxWlWtvC09krPVOvV
Oyg3MY3n4YZ6V7a6v/UK
=R8Cm
-----END PGP SIGNATURE-----

--MPfmd7xTLfbLOLcfqcMIdQLw0jEA0eQw5--
