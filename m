From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jan 2008 07:27:56 +0000
Subject: Re: [Bug 9106] Sun Fire v100 dmfe driver bug
Message-Id: <20080121.232756.107909847.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Grant Grundler <grundler@parisc-linux.org>
Date: Sun, 6 Jan 2008 01:35:32 -0700

[ Andrew, one of your warning fixes from yesteryear broke
  SROM parsing in the DMFE tulip driver, see below.  ]

> Thanks! This was the case with the dmfe driver on SPARC.
> I've attached a patch as comment #6 on:
> 	http://bugzilla.kernel.org/show_bug.cgi?id=9106

If there is no MAC address in the SROM you'll also have to handle the
fact that there's almost guarenteed to not be any media mode data
there either.  Actually, there might be such information there and
this could be a clue.  See below.

This driver did work on sparc64 to some extent at some point in the
past.  So something did change over time to subtly break this thing.

The users log with the TX timeouts probably indicates that the chip
cannot DMA properly or send to the network for whatever reason.  Maybe
the media type is wrong.

BTW, I noticed this while reading the DMFE code:

	db->buf_pool_ptr =3D pci_alloc_consistent(pdev, TX_BUF_ALLOC *
			TX_DESC_CNT + 4, &db->buf_pool_dma_ptr);

That size looks strange, is this supposed to be:

	(TX_BUF_ALLOC * TX_DESC_CNT) + 4

or:

	TX_BUF_ALLOC * (TX_DESC_CNT + 4)

I think the latter is the intention, but the former is what
is actually happening.

Looking through the driver history I definitely see some bugs
introduced into the SROM code, for example:

	commit 16b110c3fd760620b4a787db6ed512fe531ab1b5
	Author: Andrew Morton <akpm@osdl.org>
	Date:   Mon Jun 20 15:32:59 2005 -0700

	[PATCH] dmfe warning fix
 ...
	This is basically a guess:
   =20
	Cc: Jeff Garzik <jgarzik@pobox.com>
	Signed-off-by: Andrew Morton <akpm@osdl.org>

--- a/drivers/net/tulip/dmfe.c
+++ b/drivers/net/tulip/dmfe.c
@@ -1802,7 +1802,7 @@ static void dmfe_parse_srom(struct dmfe_board_info * =
db)
 	if ( ( (int) srom[18] & 0xff) =3D SROM_V41_CODE) {
 		/* SROM V4.01 */
 		/* Get NIC support media mode */
-		db->NIC_capability =3D le16_to_cpup(srom + 34);
+		db->NIC_capability =3D le16_to_cpup((__le16 *)srom + 34/2);
 		db->PHY_reg4 =3D 0;
 		for (tmp_reg =3D 1; tmp_reg < 0x10; tmp_reg <<=3D 1) {
 			switch( db->NIC_capability & tmp_reg ) {
@@ -1814,7 +1814,8 @@ static void dmfe_parse_srom(struct dmfe_board_info * =
db)
 		}
=20
 		/* Media Mode Force or not check */
-		dmfe_mode =3D le32_to_cpup(srom + 34) & le32_to_cpup(srom + 36);
+		dmfe_mode =3D le32_to_cpup((__le32 *)srom + 34/4) &
+				le32_to_cpup((__le32 *)srom + 36/4);
 		switch(dmfe_mode) {
 		case 0x4: dmfe_media_mode =3D DMFE_100MHF; break;	/* 100MHF */
 		case 0x2: dmfe_media_mode =3D DMFE_10MFD; break;	/* 10MFD */

Basically he is trying to deal with the fact that "srom" is
a "char *" but the typing requires converting to 16-bit
and 32-bit pointers so the offsets have to be adjusted.

But it is totally wrong in the cases where the offsets were not
a multiple or 2 or 4, respectively.  (hint: (34 % 4) =3D 2)

It would have been better to use expressions like:

	(__le16 *) (srom + 34)
	(__le32 *) (srom + 34)
	(__le32 *) (srom + 36)

So that change definitely subtly changed how the SROM is accessed
and likely is a good explanation for certain bugs, maybe even this
one we are discussing.

Thinking about this some more, these accesses are extremely queer.
Why would it use 32-bit accesses here to two 32-bit datums which
overlap, and "and" them together to figure out the 'dmfe_mode'?

This driver is in a bit of a state of disrepair.  Who is Tobias
Ringstrom (from MAINTAINERS) and when was the last time he did any
maintainence on dmfe?  He definitely hasn't done anything in
the GIT era as I look through the changelog.

Anyways, here is a fix for the above regression, if that DMA
sizing error above is a real one that will need a fix too:

[TULIP] DMFE: Fix SROM parsing regression.

Changeset 16b110c3fd760620b4a787db6ed512fe531ab1b5 (dmfe warning fix)
bothed up the offsets read from the SROM so that it doesn't read the
same datums it used to.

The change made transformations like turning:

	"srom + 34"

into

	"(__le32 *)srom + 34/4"

which doesn't work because 4 does not divide evenly
into 34 so we're using a different pointer offset
than in the original code.

I've changed theses cases in dmfe_parse_srom() to
consistently use "(type *)(srom + offset)" preserving
the offsets from the original code.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/tulip/dmfe.c b/drivers/net/tulip/dmfe.c
index b4891ca..6562004 100644
--- a/drivers/net/tulip/dmfe.c
+++ b/drivers/net/tulip/dmfe.c
@@ -1909,7 +1909,7 @@ static void dmfe_parse_srom(struct dmfe_board_info * =
db)
 	if ( ( (int) srom[18] & 0xff) =3D SROM_V41_CODE) {
 		/* SROM V4.01 */
 		/* Get NIC support media mode */
-		db->NIC_capability =3D le16_to_cpup((__le16 *)srom + 34/2);
+		db->NIC_capability =3D le16_to_cpup((__le16 *) (srom + 34));
 		db->PHY_reg4 =3D 0;
 		for (tmp_reg =3D 1; tmp_reg < 0x10; tmp_reg <<=3D 1) {
 			switch( db->NIC_capability & tmp_reg ) {
@@ -1921,8 +1921,8 @@ static void dmfe_parse_srom(struct dmfe_board_info * =
db)
 		}
=20
 		/* Media Mode Force or not check */
-		dmfe_mode =3D le32_to_cpup((__le32 *)srom + 34/4) &
-				le32_to_cpup((__le32 *)srom + 36/4);
+		dmfe_mode =3D (le32_to_cpup((__le32 *) (srom + 34)) &
+			     le32_to_cpup((__le32 *) (srom + 36)));
 		switch(dmfe_mode) {
 		case 0x4: dmfe_media_mode =3D DMFE_100MHF; break;	/* 100MHF */
 		case 0x2: dmfe_media_mode =3D DMFE_10MFD; break;	/* 10MFD */
