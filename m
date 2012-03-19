From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 19 Mar 2012 00:42:22 +0000
Subject: Re: [PATCH] Kbuild: centralize MKIMAGE and cmd_uimage definitions
Message-Id: <201203182042.27555.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1907359.PSrC6TrMqE"
List-Id: <sparclinux.vger.kernel.org>
References: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, Russell King <linux@arm.linux.org.uk>, nico@fluxnic.net, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Michal Simek <monstr@monstr.eu>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

--nextPart1907359.PSrC6TrMqE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 16 March 2012 17:03:55 Stephen Warren wrote:
> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> to avoid duplication.
>=20
> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> parameterized version in Makefile.lib to avoid duplication.

seems to build for Blackfin systems.
Tested-by: Mike Frysinger <vapier@gentoo.org>
=2Dmike

--nextPart1907359.PSrC6TrMqE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPZoDzAAoJEEFjO5/oN/WBNgQQAMPZgBK615QybGUVJKi8HK4b
JGhyM1dJ2fHxH5TOlz5+y9U7xDZigScV5AFvI1COuC/6ydYIJ6vS5NxOC0bHC8KL
um65Ii3M8R0J34QT7XVUsickNE91ixb2FON/rg9ctFEyADy0bgm+8e5rPFGXhBHM
tVLTQndeEJ/x7VmeL0ZIVrbKEQdHBtWXmezBxolku1L8nVCCGDHh57oYIhCIR3cL
pEO+6WhuQs4k9OLsazffE8yzPHY8VqjfFb5WV3OB0xlMKXaHifEIooCIRCN4gLB/
BjeI3JShQsDkDneW8zNx93nhpeDRRvFDFR7eYMKPXq/vFNdLqkBTql7FzyyBZg54
2JpTvSvoeQhpsGKlF+KEBR5IKidno4uxBeaZnjl6yWOUJoeEqzrD3X+k9NlcTxqJ
kJNog/TBmaX2Jo8edy0Iz2pRmnbr5RKCPMv/qDLXVrrIHyUmujaionPzq9XP22jn
OYmU4P40iB8OkR+4aIlRzLFY3xrI6LVBpvTW3thyvHkYOeIv3Bc689KOecQENO2p
IGBB9x/31JZIxA8FTCY5iUZqQLumoLkxZAAUVNce1OreIgxPdiNUPelTuVWns2ln
HbFOqXOX9GePpXGkEx+LPT3PRxWDbGynw8v7+hEh6/ZWwNhNq1uMCHfQKhIejM9q
1sb3U3ZzbfJXs+1Ila3i
=LDHk
-----END PGP SIGNATURE-----

--nextPart1907359.PSrC6TrMqE--
