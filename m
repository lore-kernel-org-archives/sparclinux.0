From: Jason Wever <weeve@gentoo.org>
Date: Fri, 12 Mar 2004 16:46:56 +0000
Subject: kernel panic with iptables when using -j ULOG
Message-Id: <Pine.LNX.4.58.0403120940160.18618@stargazer.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463810780-1845810840-1079110016=:18618"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463810780-1845810840-1079110016=:18618
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Recently, in testing out ulogd, I found that iptables-1.2.9 didn't think 
that the -j ULOG argument was valid.  In searching around, I found the 
following post showing a patch for iptables to make this work 
<http://lists.gnumonks.org/pipermail/ulogd/2003-December/000458.html>.  
The patch seems to fix the problem as now rules with -j ULOG no longer 
return "invalid argument", but now there's a kernel panic each time a rule 
is run.  The panic is as shown below;

Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 00000000000007b6
tsk->{mm,active_mm}->pgd = fffff8003f4e9000
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

This is all that shows up when running headless.  There is no backtrace or 
any other information, and the machine locks up hard.   The env I found 
this in was an Ultra 1 running linux-2.4.25 and iptables-1.2.9.  I 
attached the patch I used to make the -j ULOG arg "work".

Any thoughts?
- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUemCdKvgdVioq28RAh+kAKCUlc1BOGRQzCL1FahYLAGZLoTkSwCgpIoY
hbZpDYY1kdH0AU988VjPKTQ=
=+9UW
-----END PGP SIGNATURE-----
---1463810780-1845810840-1079110016=:18618
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sparc64_ulog_fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403120946560.18618@stargazer.weeve.org>
Content-Description: 
Content-Disposition: attachment; filename="sparc64_ulog_fix.patch"

LS0tIGlwdGFibGVzLTEuMi45L2V4dGVuc2lvbnMvbGliaXB0X1VMT0cuYy5v
cmlnCTIwMDQtMDMtMTEgMTY6NDk6MjMuMDAwMDAwMDAwIC0wNTAwDQorKysg
aXB0YWJsZXMtMS4yLjkvZXh0ZW5zaW9ucy9saWJpcHRfVUxPRy5jCTIwMDQt
MDMtMTEgMTY6NTE6MzEuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMTksNiArMTks
MTcgQEANCiAjaW5jbHVkZSA8bGludXgvbmV0ZmlsdGVyX2lwdjQvaXBfdGFi
bGVzLmg+DQogI2luY2x1ZGUgPGxpbnV4L25ldGZpbHRlcl9pcHY0L2lwdF9V
TE9HLmg+DQogDQorI2lmIGRlZmluZWQoS0VSTkVMXzY0X1VTRVJTUEFDRV8z
MikNCitzdHJ1Y3QgaXB0X3Vsb2dfaW5mb19jb21wYXQgew0KKwl1X2ludDY0
X3QgbmxfZ3JvdXA7DQorICAgICAgdV9pbnQ2NF90IGNvcHlfcmFuZ2U7DQor
ICAgICAgdV9pbnQ2NF90IHF0aHJlc2hvbGQ7DQorICAgICAgY2hhciBwcmVm
aXhbVUxPR19QUkVGSVhfTEVOXTsNCit9Ow0KKyAgICAgIA0KKyNkZWZpbmUg
ICAgICAgIGlwdF91bG9nX2luZm8gICAgaXB0X3Vsb2dfaW5mb19jb21wYXQN
CisjZW5kaWYNCisNCiAjZGVmaW5lIFVMT0dfREVGQVVMVF9OTEdST1VQIDEN
CiAjZGVmaW5lIFVMT0dfREVGQVVMVF9RVEhSRVNIT0xEIDENCiANCg==

---1463810780-1845810840-1079110016=:18618--
