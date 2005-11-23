From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Nov 2005 08:26:12 +0000
Subject: Re: Still some serial console corruption on sunsab
Message-Id: <Pine.SOC.4.61.0511231023480.13524@math.ut.ee>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-559023410-1804928587-1132734372=:13524"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1804928587-1132734372=:13524
Content-Type: TEXT/PLAIN; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

> Give this one a spin.

It's still corrupting the same way it has been done before.

BUT now I noticed that the previous patch garbled it differently.
Ususally I see things like that:
..=C9.=A5=BD..2.86 booting
(instead of init version 2.86 booting)

and I still see it with this patch. But with previous patch I saw
  version 2.86 booting
and perhaps some more dropped characters here and there. Entering=20
runlevel 2 message was still garbage with previous patch too.

--=20
Meelis Roos (mroos@linux.ee)
---559023410-1804928587-1132734372=:13524--
