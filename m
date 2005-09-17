From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Date: Sat, 17 Sep 2005 17:49:17 +0000
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
Message-Id: <Pine.BSO.4.62.0509171945280.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-1434987158-1126979357=:5000"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
 <20050915.133026.21581824.davem@davemloft.net> <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
 <20050916.155919.41629794.davem@redhat.com> <Pine.BSO.4.62.0509171707410.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509171707410.5000@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1434987158-1126979357=:5000
Content-Type: TEXT/PLAIN; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Sep 2005, Tomasz K=B3oczko wrote:
[..]

Something new.
I'm just finish rewrite backup procedure from dumping to NFS volume to
using piped dump|ssh|dd.
During this happens:

PSYCHO0: Uncorrectable Error, primary error type[DMA Write]
PSYCHO0: bytemask[0000] dword_offset[7] UPA_MID[1f] was_block(1)
PSYCHO0: UE AFAR [000000005c8bc040]
PSYCHO0: UE Secondary errors [(DMA Write)]
PSYCHO0: IOMMU Error, type[Protection Error]

kloczek
--=20
-----------------------------------------------------------
*Ludzie nie maj=B1 problem=F3w, tylko sobie sami je stwarzaj=B1*
-----------------------------------------------------------
Tomasz K=B3oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.p=
l*
--0-1434987158-1126979357=:5000--
