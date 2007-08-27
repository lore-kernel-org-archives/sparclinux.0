From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 27 Aug 2007 14:26:15 +0000
Subject: Re: Re. [SPARC32]: Fix bogus ramdisk image location check.
Message-Id: <Pine.LNX.4.61.0708271512190.2529@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-1486508478-1188224775=:2529"
List-Id: <sparclinux.vger.kernel.org>
References: <46CA19DE.3000108@earthlink.net>
In-Reply-To: <46CA19DE.3000108@earthlink.net>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-1486508478-1188224775=:2529
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi Robert,

I beleive that the attached+inserted patch should have the desired 
characteristics. Can you check it out to ensure it does nothing silly.

(This same check may also be valid for SPARC64)

--- linux-2.6/arch/sparc/mm/init.c	2007-08-14 23:24:41.000000000 +0100
+++ linux-mark/arch/sparc/mm/init.c	2007-08-27 13:09:21.000000000 +0100
@@ -206,7 +206,7 @@ unsigned long __init bootmem_init(unsign
  #ifdef CONFIG_BLK_DEV_INITRD
  	/* Now have to check initial ramdisk, so that bootmap does not overwrite it */
  	if (sparc_ramdisk_image) {
-		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
+		if (sparc_ramdisk_image >= KERNBASE)
  			sparc_ramdisk_image -= KERNBASE;
  		initrd_start = sparc_ramdisk_image + phys_base;
  		initrd_end = initrd_start + sparc_ramdisk_size;


--1750305931-1486508478-1188224775=:2529
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ramdisk.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0708271526140.2529@mtfhpc.demon.co.uk>
Content-Description: 
Content-Disposition: attachment; filename="ramdisk.patch"

RnJvbTogTWFyayBGb3J0ZXNjdWUgPG1hcmtAbXRmaHBjLmRlbW9uLmNvLnVr
Pg0KDQpbU1BBUkMzMl06IEZpeCBib2d1cyByYW1kaXNrIGltYWdlIGxvY2F0
aW9uIGNoZWNrLg0KDQpJdCB3YXMgb3JpZ2luYWxseSB0aG91Z2h0IHRoYXQg
c3BhcmNfcmFtZGlza19pbWFnZSBzaG91bGQgYWx3YXlzIGJlIGRlY3JlbWVu
dGVkDQpieSBLRVJOQkFTRSBzbyB0aGUgY2hlY2sgY291bGQganVzdCBiZSBk
cm9wcGVkLCBidXQgaXQgdHVybnMgb3V0IHRoYXQgdGhpcyBpcw0Kbm90IHRo
ZSBjYXNlLiBKdXN0IGNoZWNraW5nIGlmIHRoZSBpbWFnZSBpcyBncmVhdGVy
IHRoYW4gS0VSTkJBU0Ugc2hvdWxkIGJlDQpzdWZmaWNpZW50IHRvIGNvcnJl
Y3RseSBpZGVudGlmeSBpZiB0aGUgY29ycmVjdGlvbiBpcyBuZWVkZWQgYW5k
IGF2b2lkcyBhbnkNCnBvc2libGUgaXNzdWVzIHdpdGggY2hhbmdlcyB0byB0
aGUgbGlua2VyIHNjcmlwdCBvcmRlcmluZyB0aGF0IGFyZSBwcmVzZW50IGlm
DQomZW5kIGlzIHVzZWQgd2l0aCBhIGZpeGVkIDIgcGFnZSBvZmZzZXQuDQoN
ClNpZ25lZC1vZmYtYnk6IE1hcmsgRm9ydGVzY3VlIDxtYXJrQG10ZmhwYy5k
ZW1vbi5jby51az4NCi0tLQ0KVGhpcyBzYW1lIGNoZWNrIG1heSBhbHNvIGJl
IHZhbGlkIGZvciBTUEFSQzY0DQoNCi0tLSBsaW51eC0yLjYvYXJjaC9zcGFy
Yy9tbS9pbml0LmMJMjAwNy0wOC0xNCAyMzoyNDo0MS4wMDAwMDAwMDAgKzAx
MDANCisrKyBsaW51eC1tYXJrL2FyY2gvc3BhcmMvbW0vaW5pdC5jCTIwMDct
MDgtMjcgMTM6MDk6MjEuMDAwMDAwMDAwICswMTAwDQpAQCAtMjA2LDcgKzIw
Niw3IEBAIHVuc2lnbmVkIGxvbmcgX19pbml0IGJvb3RtZW1faW5pdCh1bnNp
Z24NCiAjaWZkZWYgQ09ORklHX0JMS19ERVZfSU5JVFJEDQogCS8qIE5vdyBo
YXZlIHRvIGNoZWNrIGluaXRpYWwgcmFtZGlzaywgc28gdGhhdCBib290bWFw
IGRvZXMgbm90IG92ZXJ3cml0ZSBpdCAqLw0KIAlpZiAoc3BhcmNfcmFtZGlz
a19pbWFnZSkgew0KLQkJaWYgKHNwYXJjX3JhbWRpc2tfaW1hZ2UgPj0gKHVu
c2lnbmVkIGxvbmcpJl9lbmQgLSAyICogUEFHRV9TSVpFKQ0KKwkJaWYgKHNw
YXJjX3JhbWRpc2tfaW1hZ2UgPj0gS0VSTkJBU0UpDQogCQkJc3BhcmNfcmFt
ZGlza19pbWFnZSAtPSBLRVJOQkFTRTsNCiAJCWluaXRyZF9zdGFydCA9IHNw
YXJjX3JhbWRpc2tfaW1hZ2UgKyBwaHlzX2Jhc2U7DQogCQlpbml0cmRfZW5k
ID0gaW5pdHJkX3N0YXJ0ICsgc3BhcmNfcmFtZGlza19zaXplOw0K

--1750305931-1486508478-1188224775=:2529--
