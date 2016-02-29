From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Feb 2016 08:44:59 +0000
Subject: Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc code
Message-Id: <56D4050B.1000502@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="o3qQI7jUFIojbN5FkpJ16Q9fE4CQwHRn5"
List-Id: <sparclinux.vger.kernel.org>
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
 <56D02FB8.90803@ti.com> <20160226135813.GD15454@windriver.com>
In-Reply-To: <20160226135813.GD15454@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org

--o3qQI7jUFIojbN5FkpJ16Q9fE4CQwHRn5
Content-Type: multipart/mixed; boundary="RhckCB6DHj2If5P22W4nH1sLOGlaWjoig"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org
Message-ID: <56D4050B.1000502@ti.com>
Subject: Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc
 code
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
 <56D02FB8.90803@ti.com> <20160226135813.GD15454@windriver.com>
In-Reply-To: <20160226135813.GD15454@windriver.com>

--RhckCB6DHj2If5P22W4nH1sLOGlaWjoig
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/02/16 15:58, Paul Gortmaker wrote:

> A counter point would be that if an old driver has remained non-modular=

> for all these years, then clearly there is no demand for adding a new
> modular implementation at this point in time.

True. Then again, I think fbdev drivers are almost always used as
built-in to get the console up and running early. For fbdev I see the
module support mostly as a way to improve the code quality and to
simplify development and testing.

> The main reason is listed as #4 above -- if we keep drivers around that=

> reflect a disconnect between Kconfig and code, the same mistake gets
> copied into more and more new drivers as they are created.

Yep, but the same could be said about having drivers without module
support too =3D).

In any case, I don't accept new fbdev drivers except in special cases,
so fbdev drivers' value as examples is not that much.

> If the argument was to not go in and rewrite core code for legacy
> drivers, I'd agree with that, but that isn't what is happening here.
> In a lot of these type changes, where the only change is to replace
> module_init with device initcall, the object files are identical.

Yes, the patches look simple enough. Ensuring they would work as modules
would be riskier.

> If subsystem maintainers would rather have blanket tristate coversions
> and whatever changes are required to make it compile and modpost, and
> are OK to assume things will just work, then that could be an option...=


Nope, I think these are fine. I'll queue them up for 4.6.

 Tomi


--RhckCB6DHj2If5P22W4nH1sLOGlaWjoig--

--o3qQI7jUFIojbN5FkpJ16Q9fE4CQwHRn5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1AULAAoJEPo9qoy8lh71gFUQAIzzMD96puRyvLxaqoY/VHZJ
hfgTAKnpbR0vWGVS4dDsCdiR+shk4NjLDMY6iOGo/OYxrhrJmpANI8HBqmNHgEQJ
TJmUBmnsq0w5cXGPQpohZHWutHi5xHRKuYTPl2hyksFi7QalhYKLnocAgN+Ut+Eu
/jgylHVvJ1HmDfh8QYGeLUJpm1ZgHu2QOruCHOHIygDIT/xW+P4aMplmvY8BhUR9
9FUB1xC1f91yjZOFQBEMvxIIOOElucHjUT6nvNYq4oJWPvAFuAkXbPs+MfnaAso6
RrA0LiYN/ELzAzs7kNrz/TNUWCv/nS2iKHmFFyibAoUaMcKEhIq9E/cs1Ped9d94
x0vxVD6U4XxX1H+3Ss5XsANlfwnDQwfmwj3FkAMmMUwF16ndLwPJfLdC9E1N/Bcr
85HS3xTrCciYaPo0msht0UenWXdr++Kve6+myxNh8wc3Tlcy6+Rc7PhcuXS4LjA0
JGSy1NHIrsJr3UrTS6r16HpEcgqWrjqA+3BhRPaYDLn342byPuYbBanP68BSklLy
jM/6KQWXM3FjtoHMVJ48uro78mMywv3rh5gncbp0iW9UxnsWAate3iC5NaDr42Oz
B6rwAQdlFdOKOTtSeb+BlCZGGZeEzlCfds90kQthCQ+pye3Sp+Y72SMbbP96Eedl
DOtN6EV5SMoya3Yz2h4X
=NgSQ
-----END PGP SIGNATURE-----

--o3qQI7jUFIojbN5FkpJ16Q9fE4CQwHRn5--
