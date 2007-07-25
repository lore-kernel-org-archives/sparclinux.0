From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 25 Jul 2007 16:47:29 +0000
Subject: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-2096783728-1185382049=:20510"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-2096783728-1185382049=:20510
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Add in fix to prevent the VTOC table being used if it is not present
(it was not implemented until Solaris 2.x so SunOS 4.1.x will not have
valid VTOC data) and correct the Solaris x86 number of partitions (slices).

Signed-off-by: Mark Fortescue <mark@mtfhpc.demon.co.uk>
---
Patch attached in case it gets mangled.
diff -ruNpd -x .git -x .gitignore -x .mailmap linux-2.6/fs/partitions/sun.c linux-test/fs/partitions/sun.c
--- linux-2.6/fs/partitions/sun.c	2007-07-24 22:47:22.000000000 +0100
+++ linux-test/fs/partitions/sun.c	2007-07-12 09:34:16.000000000 +0100
@@ -19,24 +19,35 @@ int sun_partition(struct parsed_partitio
  	Sector sect;
  	struct sun_disklabel {
  		unsigned char info[128];   /* Informative text string */
-		unsigned char spare0[14];
-		struct sun_info {
-			unsigned char spare1;
-			unsigned char id;
-			unsigned char spare2;
-			unsigned char flags;
-		} infos[8];
-		unsigned char spare[246];  /* Boot information etc. */
+		struct sun_vtoc {
+		    __be32 version;     /* Layout version */
+		    char   volume[8];   /* Volume name */
+		    __be16 nparts;      /* Number of partitions */
+		    struct sun_info {           /* Partition hdrs, sec 2 */
+			__be16 id;
+			__be16 flags;
+		    } infos[8];
+		    __be16 padding;      /* Alignment padding */
+		    __be32 bootinfo[3];  /* Info needed by mboot */
+		    __be32 sanity;       /* To verify vtoc sanity */
+		    __be32 reserved[10]; /* Free space */
+		    __be32 timestamp[8]; /* Partition timestamp */
+		} vtoc;
+		__be32 write_reinstruct; /* sectors to skip, writes */
+		__be32 read_reinstruct;  /* sectors to skip, reads */
+		unsigned char spare[148]; /* Padding */
  		__be16 rspeed;     /* Disk rotational speed */
  		__be16 pcylcount;  /* Physical cylinder count */
  		__be16 sparecyl;   /* extra sects per cylinder */
-		unsigned char spare2[4];   /* More magic... */
+		__be16 obs1;       /* gap1 */
+		__be16 obs2;       /* gap2 */
  		__be16 ilfact;     /* Interleave factor */
  		__be16 ncyl;       /* Data cylinder count */
  		__be16 nacyl;      /* Alt. cylinder count */
  		__be16 ntrks;      /* Tracks per cylinder */
  		__be16 nsect;      /* Sectors per track */
-		unsigned char spare3[4];   /* Even more magic... */
+		__be16 obs3;       /* bhead - Label head offset */
+		__be16 obs4;       /* ppart - Physical Partition */
  		struct sun_partition {
  			__be32 start_cylinder;
  			__be32 num_sectors;
@@ -81,10 +92,13 @@ int sun_partition(struct parsed_partitio
  		if (num_sectors) {
  			put_partition(state, slot, st_sector, num_sectors);
  			state->parts[slot].flags = 0;
-			if (label->infos[i].id == LINUX_RAID_PARTITION)
-				state->parts[slot].flags |= ADDPART_FLAG_RAID;
-			if (label->infos[i].id == SUN_WHOLE_DISK)
-				state->parts[slot].flags |= ADDPART_FLAG_WHOLEDISK;
+			/* Need to validate the VTOC before we use it */
+			if (be32_to_cpu(label->vtoc.sanity) == SUN_VTOC_SANITY) {
+				if (be16_to_cpu(label->vtoc.infos[i].id) == LINUX_RAID_PARTITION)
+					state->parts[slot].flags |= ADDPART_FLAG_RAID;
+				else if (be16_to_cpu(label->vtoc.infos[i].id) == SUN_WHOLE_DISK)
+					state->parts[slot].flags |= ADDPART_FLAG_WHOLEDISK;
+			}
  		}
  		slot++;
  	}
diff -ruNpd -x .git -x .gitignore -x .mailmap linux-2.6/fs/partitions/sun.h linux-test/fs/partitions/sun.h
--- linux-2.6/fs/partitions/sun.h	2007-04-30 01:29:02.000000000 +0100
+++ linux-test/fs/partitions/sun.h	2007-07-12 09:34:16.000000000 +0100
@@ -3,5 +3,6 @@
   */

  #define SUN_LABEL_MAGIC          0xDABE
+#define SUN_VTOC_SANITY          0x600DDEEE

  int sun_partition(struct parsed_partitions *state, struct block_device *bdev);
diff -ruNpd -x .git -x .gitignore -x .mailmap linux-2.6/include/linux/genhd.h linux-test/include/linux/genhd.h
--- linux-2.6/include/linux/genhd.h	2007-07-24 22:47:26.000000000 +0100
+++ linux-test/include/linux/genhd.h	2007-07-12 09:34:16.000000000 +0100
@@ -264,7 +264,7 @@ static inline void set_capacity(struct g

  #ifdef CONFIG_SOLARIS_X86_PARTITION

-#define SOLARIS_X86_NUMSLICE	8
+#define SOLARIS_X86_NUMSLICE	16
  #define SOLARIS_X86_VTOC_SANE	(0x600DDEEEUL)

  struct solaris_x86_slice {
--1750305931-2096783728-1185382049=:20510
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="Sun-Partition.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0707251747260.20510@mtfhpc.demon.co.uk>
Content-Description: 
Content-Disposition: attachment; filename="Sun-Partition.patch"

RnJvbTogTWFyayBGb3J0ZXNjdWUgPG1hcmtAbXRmaHBjLmRlbW9uLmNvLnVr
Pg0KDQpBZGQgaW4gZml4IHRvIHByZXZlbnQgdGhlIFZUT0MgdGFibGUgYmVp
bmcgdXNlZCBpZiBpdCBpcyBub3QgcHJlc2VudA0KKGl0IHdhcyBub3QgaW1w
bGVtZW50ZWQgdW50aWwgU29sYXJpcyAyLnggc28gU3VuT1MgNC4xLnggd2ls
bCBub3QgaGF2ZQ0KdmFsaWQgVlRPQyBkYXRhKSBhbmQgY29ycmVjdCB0aGUg
U29sYXJpcyB4ODYgbnVtYmVyIG9mIHBhcnRpdGlvbnMgKHNsaWNlcykuDQoN
ClNpZ25lZC1vZmYtYnk6IE1hcmsgRm9ydGVzY3VlIDxtYXJrQG10ZmhwYy5k
ZW1vbi5jby51az4NCi0tLQ0KZGlmZiAtcnVOcGQgLXggLmdpdCAteCAuZ2l0
aWdub3JlIC14IC5tYWlsbWFwIGxpbnV4LTIuNi9mcy9wYXJ0aXRpb25zL3N1
bi5jIGxpbnV4LXRlc3QvZnMvcGFydGl0aW9ucy9zdW4uYw0KLS0tIGxpbnV4
LTIuNi9mcy9wYXJ0aXRpb25zL3N1bi5jCTIwMDctMDctMjQgMjI6NDc6MjIu
MDAwMDAwMDAwICswMTAwDQorKysgbGludXgtdGVzdC9mcy9wYXJ0aXRpb25z
L3N1bi5jCTIwMDctMDctMTIgMDk6MzQ6MTYuMDAwMDAwMDAwICswMTAwDQpA
QCAtMTksMjQgKzE5LDM1IEBAIGludCBzdW5fcGFydGl0aW9uKHN0cnVjdCBw
YXJzZWRfcGFydGl0aW8NCiAJU2VjdG9yIHNlY3Q7DQogCXN0cnVjdCBzdW5f
ZGlza2xhYmVsIHsNCiAJCXVuc2lnbmVkIGNoYXIgaW5mb1sxMjhdOyAgIC8q
IEluZm9ybWF0aXZlIHRleHQgc3RyaW5nICovDQotCQl1bnNpZ25lZCBjaGFy
IHNwYXJlMFsxNF07DQotCQlzdHJ1Y3Qgc3VuX2luZm8gew0KLQkJCXVuc2ln
bmVkIGNoYXIgc3BhcmUxOw0KLQkJCXVuc2lnbmVkIGNoYXIgaWQ7DQotCQkJ
dW5zaWduZWQgY2hhciBzcGFyZTI7DQotCQkJdW5zaWduZWQgY2hhciBmbGFn
czsNCi0JCX0gaW5mb3NbOF07DQotCQl1bnNpZ25lZCBjaGFyIHNwYXJlWzI0
Nl07ICAvKiBCb290IGluZm9ybWF0aW9uIGV0Yy4gKi8NCisJCXN0cnVjdCBz
dW5fdnRvYyB7DQorCQkgICAgX19iZTMyIHZlcnNpb247ICAgICAvKiBMYXlv
dXQgdmVyc2lvbiAqLw0KKwkJICAgIGNoYXIgICB2b2x1bWVbOF07ICAgLyog
Vm9sdW1lIG5hbWUgKi8NCisJCSAgICBfX2JlMTYgbnBhcnRzOyAgICAgIC8q
IE51bWJlciBvZiBwYXJ0aXRpb25zICovDQorCQkgICAgc3RydWN0IHN1bl9p
bmZvIHsgICAgICAgICAgIC8qIFBhcnRpdGlvbiBoZHJzLCBzZWMgMiAqLw0K
KwkJCV9fYmUxNiBpZDsNCisJCQlfX2JlMTYgZmxhZ3M7DQorCQkgICAgfSBp
bmZvc1s4XTsNCisJCSAgICBfX2JlMTYgcGFkZGluZzsgICAgICAvKiBBbGln
bm1lbnQgcGFkZGluZyAqLw0KKwkJICAgIF9fYmUzMiBib290aW5mb1szXTsg
IC8qIEluZm8gbmVlZGVkIGJ5IG1ib290ICovDQorCQkgICAgX19iZTMyIHNh
bml0eTsgICAgICAgLyogVG8gdmVyaWZ5IHZ0b2Mgc2FuaXR5ICovDQorCQkg
ICAgX19iZTMyIHJlc2VydmVkWzEwXTsgLyogRnJlZSBzcGFjZSAqLw0KKwkJ
ICAgIF9fYmUzMiB0aW1lc3RhbXBbOF07IC8qIFBhcnRpdGlvbiB0aW1lc3Rh
bXAgKi8NCisJCX0gdnRvYzsNCisJCV9fYmUzMiB3cml0ZV9yZWluc3RydWN0
OyAvKiBzZWN0b3JzIHRvIHNraXAsIHdyaXRlcyAqLw0KKwkJX19iZTMyIHJl
YWRfcmVpbnN0cnVjdDsgIC8qIHNlY3RvcnMgdG8gc2tpcCwgcmVhZHMgKi8N
CisJCXVuc2lnbmVkIGNoYXIgc3BhcmVbMTQ4XTsgLyogUGFkZGluZyAqLw0K
IAkJX19iZTE2IHJzcGVlZDsgICAgIC8qIERpc2sgcm90YXRpb25hbCBzcGVl
ZCAqLw0KIAkJX19iZTE2IHBjeWxjb3VudDsgIC8qIFBoeXNpY2FsIGN5bGlu
ZGVyIGNvdW50ICovDQogCQlfX2JlMTYgc3BhcmVjeWw7ICAgLyogZXh0cmEg
c2VjdHMgcGVyIGN5bGluZGVyICovDQotCQl1bnNpZ25lZCBjaGFyIHNwYXJl
Mls0XTsgICAvKiBNb3JlIG1hZ2ljLi4uICovDQorCQlfX2JlMTYgb2JzMTsg
ICAgICAgLyogZ2FwMSAqLw0KKwkJX19iZTE2IG9iczI7ICAgICAgIC8qIGdh
cDIgKi8NCiAJCV9fYmUxNiBpbGZhY3Q7ICAgICAvKiBJbnRlcmxlYXZlIGZh
Y3RvciAqLw0KIAkJX19iZTE2IG5jeWw7ICAgICAgIC8qIERhdGEgY3lsaW5k
ZXIgY291bnQgKi8NCiAJCV9fYmUxNiBuYWN5bDsgICAgICAvKiBBbHQuIGN5
bGluZGVyIGNvdW50ICovDQogCQlfX2JlMTYgbnRya3M7ICAgICAgLyogVHJh
Y2tzIHBlciBjeWxpbmRlciAqLw0KIAkJX19iZTE2IG5zZWN0OyAgICAgIC8q
IFNlY3RvcnMgcGVyIHRyYWNrICovDQotCQl1bnNpZ25lZCBjaGFyIHNwYXJl
M1s0XTsgICAvKiBFdmVuIG1vcmUgbWFnaWMuLi4gKi8NCisJCV9fYmUxNiBv
YnMzOyAgICAgICAvKiBiaGVhZCAtIExhYmVsIGhlYWQgb2Zmc2V0ICovDQor
CQlfX2JlMTYgb2JzNDsgICAgICAgLyogcHBhcnQgLSBQaHlzaWNhbCBQYXJ0
aXRpb24gKi8NCiAJCXN0cnVjdCBzdW5fcGFydGl0aW9uIHsNCiAJCQlfX2Jl
MzIgc3RhcnRfY3lsaW5kZXI7DQogCQkJX19iZTMyIG51bV9zZWN0b3JzOw0K
QEAgLTgxLDEwICs5MiwxMyBAQCBpbnQgc3VuX3BhcnRpdGlvbihzdHJ1Y3Qg
cGFyc2VkX3BhcnRpdGlvDQogCQlpZiAobnVtX3NlY3RvcnMpIHsNCiAJCQlw
dXRfcGFydGl0aW9uKHN0YXRlLCBzbG90LCBzdF9zZWN0b3IsIG51bV9zZWN0
b3JzKTsNCiAJCQlzdGF0ZS0+cGFydHNbc2xvdF0uZmxhZ3MgPSAwOw0KLQkJ
CWlmIChsYWJlbC0+aW5mb3NbaV0uaWQgPT0gTElOVVhfUkFJRF9QQVJUSVRJ
T04pDQotCQkJCXN0YXRlLT5wYXJ0c1tzbG90XS5mbGFncyB8PSBBRERQQVJU
X0ZMQUdfUkFJRDsNCi0JCQlpZiAobGFiZWwtPmluZm9zW2ldLmlkID09IFNV
Tl9XSE9MRV9ESVNLKQ0KLQkJCQlzdGF0ZS0+cGFydHNbc2xvdF0uZmxhZ3Mg
fD0gQUREUEFSVF9GTEFHX1dIT0xFRElTSzsNCisJCQkvKiBOZWVkIHRvIHZh
bGlkYXRlIHRoZSBWVE9DIGJlZm9yZSB3ZSB1c2UgaXQgKi8NCisJCQlpZiAo
YmUzMl90b19jcHUobGFiZWwtPnZ0b2Muc2FuaXR5KSA9PSBTVU5fVlRPQ19T
QU5JVFkpIHsNCisJCQkJaWYgKGJlMTZfdG9fY3B1KGxhYmVsLT52dG9jLmlu
Zm9zW2ldLmlkKSA9PSBMSU5VWF9SQUlEX1BBUlRJVElPTikNCisJCQkJCXN0
YXRlLT5wYXJ0c1tzbG90XS5mbGFncyB8PSBBRERQQVJUX0ZMQUdfUkFJRDsN
CisJCQkJZWxzZSBpZiAoYmUxNl90b19jcHUobGFiZWwtPnZ0b2MuaW5mb3Nb
aV0uaWQpID09IFNVTl9XSE9MRV9ESVNLKQ0KKwkJCQkJc3RhdGUtPnBhcnRz
W3Nsb3RdLmZsYWdzIHw9IEFERFBBUlRfRkxBR19XSE9MRURJU0s7DQorCQkJ
fQ0KIAkJfQ0KIAkJc2xvdCsrOw0KIAl9DQpkaWZmIC1ydU5wZCAteCAuZ2l0
IC14IC5naXRpZ25vcmUgLXggLm1haWxtYXAgbGludXgtMi42L2ZzL3BhcnRp
dGlvbnMvc3VuLmggbGludXgtdGVzdC9mcy9wYXJ0aXRpb25zL3N1bi5oDQot
LS0gbGludXgtMi42L2ZzL3BhcnRpdGlvbnMvc3VuLmgJMjAwNy0wNC0zMCAw
MToyOTowMi4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC10ZXN0L2ZzL3Bh
cnRpdGlvbnMvc3VuLmgJMjAwNy0wNy0xMiAwOTozNDoxNi4wMDAwMDAwMDAg
KzAxMDANCkBAIC0zLDUgKzMsNiBAQA0KICAqLw0KIA0KICNkZWZpbmUgU1VO
X0xBQkVMX01BR0lDICAgICAgICAgIDB4REFCRQ0KKyNkZWZpbmUgU1VOX1ZU
T0NfU0FOSVRZICAgICAgICAgIDB4NjAwRERFRUUNCiANCiBpbnQgc3VuX3Bh
cnRpdGlvbihzdHJ1Y3QgcGFyc2VkX3BhcnRpdGlvbnMgKnN0YXRlLCBzdHJ1
Y3QgYmxvY2tfZGV2aWNlICpiZGV2KTsNCmRpZmYgLXJ1TnBkIC14IC5naXQg
LXggLmdpdGlnbm9yZSAteCAubWFpbG1hcCBsaW51eC0yLjYvaW5jbHVkZS9s
aW51eC9nZW5oZC5oIGxpbnV4LXRlc3QvaW5jbHVkZS9saW51eC9nZW5oZC5o
DQotLS0gbGludXgtMi42L2luY2x1ZGUvbGludXgvZ2VuaGQuaAkyMDA3LTA3
LTI0IDIyOjQ3OjI2LjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LXRlc3Qv
aW5jbHVkZS9saW51eC9nZW5oZC5oCTIwMDctMDctMTIgMDk6MzQ6MTYuMDAw
MDAwMDAwICswMTAwDQpAQCAtMjY0LDcgKzI2NCw3IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBzZXRfY2FwYWNpdHkoc3RydWN0IGcNCiANCiAjaWZkZWYgQ09O
RklHX1NPTEFSSVNfWDg2X1BBUlRJVElPTg0KIA0KLSNkZWZpbmUgU09MQVJJ
U19YODZfTlVNU0xJQ0UJOA0KKyNkZWZpbmUgU09MQVJJU19YODZfTlVNU0xJ
Q0UJMTYNCiAjZGVmaW5lIFNPTEFSSVNfWDg2X1ZUT0NfU0FORQkoMHg2MDBE
REVFRVVMKQ0KIA0KIHN0cnVjdCBzb2xhcmlzX3g4Nl9zbGljZSB7DQo=

--1750305931-2096783728-1185382049=:20510--
