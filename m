From: Jason Wever <weeve@gentoo.org>
Date: Fri, 12 Mar 2004 17:52:10 +0000
Subject: Re: kernel panic with iptables when using -j ULOG
Message-Id: <Pine.LNX.4.58.0403121051040.18728@stargazer.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463810780-1892710332-1079113930=:18728"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0403120940160.18618@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0403120940160.18618@stargazer.weeve.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463810780-1892710332-1079113930=:18728
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 12 Mar 2004, Jason Wever wrote:

> This is all that shows up when running headless.  There is no backtrace or
> any other information, and the machine locks up hard.   The env I found
> this in was an Ultra 1 running linux-2.4.25 and iptables-1.2.9.  I
> attached the patch I used to make the -j ULOG arg "work".

Forgot to include another patch for iptables which makes the one in my 
previous email work.  Attached to this one...

- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUfjMdKvgdVioq28RAikQAKCOFIfkn1WjlEogSsqTIh2ziRmZcgCghiaw
crhdA4ikv/M5p/Ki3NafWQo=
=NS66
-----END PGP SIGNATURE-----
---1463810780-1892710332-1079113930=:18728
Content-Type: APPLICATION/octet-stream; name="sparc64_limit_fix.patch.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403121052100.18728@stargazer.weeve.org>
Content-Description: 
Content-Disposition: attachment; filename="sparc64_limit_fix.patch.bz2"

QlpoOTFBWSZTWR6aWfIAA3jfgEIwf////3/v30T/7//qUAUa1ZvASCrsAUBK
KelI/VH6p6TymJk0zSDTQyaGjEDQADQNBoJQppqm8SnqZAep6mgAAA0AyAAA
ABKnopR5qjINPUBiA0aGQaMmRiAAAAHGRpkxNBkyYTTIGQ0BoDTJoYATQGEk
mkaaBMEAgEjQ2p6j0jQNNDQ0aYR6g8o0k5BoNApJhMmN1HOdKFdeDeWcDolb
PrfvZ8WJIPcWxZhTyvzVxLi17NvJqQlnyI0gys1HPItJqqWjbMZmvowgX8Xl
dskSJFCXLEVM0RFKbYsJjDoegrGeu7i/ASe51KR0BrIm/dWE0wRBDQSnAIpX
P4SZJA+VB9xSPIPrpjuVJUWWiONhzOtPEV9NzVq83MTKRgkwWX8O+qxxSYru
qyWzFJKQPcLbA+PMqjZNOk5GeMa8koIH9g4X1YmN/SzblvEnzEkITCSREy2S
BMDXQT03FByEeFApKIyhWiznVS2pZ2bwnzWyBUciYIcQRom7qSNqZJkydI9d
4OBybP82hkZ/b2jdfEKw5kwMmXYqVwVoLA7KyA6kdAOBaJyDDB3CoFUHLhfW
XduBAFIF8gS62ZmZu2FkOkPHq5Gw6RhhtmOxm1kIFgXBTIagPA3gsbNBxOs1
AXmE4uAudRTJl8bpjkdSZY0AoLtJPYqh3gok1mKSYLAUXWgpqRUpBYqV8HcK
QcAuqnyIXeQm4i20c1FyvIN6XNwrLxahagoR1BhkhUso6A13YCk80ZR21sJM
PScVFnbtawq1aB0bdpqIUsMUzLeiCP2DjK6coDw3gugY0TXDs9g9Uao/Gl8V
HLiEc6UnlMYicPXYLEgwM6PYrFEXs9wtYsXFbb+ws2S/rIMkpqkaYpMHvYwK
9YSC1IIDBDNpJWUxYLAYaeIohEKCXoD2g5UGYqLIo0Wh3YmQr/z3lQFbJLdc
qQXdswdkQZnFlm08ksKhaRWoDG8xAiFtYr5nQwqxWBgY3Sc0TC7jyC8XUd4F
oYBxeBTBQ5AScCHMzg3AUfsIcs4vh3hB6RerooebRmtq8qmu8F4xelCHPQBi
BUSZmbozBCQkYif9df7lRhx6aq43xV1kZo8wY+EfKyBhTTzyA5cK6rVh/Xw8
tRfiBkBdjIWpYCkInsChJJ0IBfMMDHznEd6gyPqDl54hOzt1B52MKQMw2AjR
a9CW2OQRX2ByYoMk20a7ZBJwcYIElV8MDTljyhSsA5iIV+QNAd0Qw0QtYF7c
eTJmdTKpGrMOVhxTKXDRVcfEBt3TGxuDFEN4QyLoMCYcCY6CQ6OYVpDnDjmE
g9xHEOGCIcXUmmCLwXREr1I7yUwjAnYbwrCiYXkha1VRITzR4VA9ISTw3FKC
K5m1otPAtiq2KSkcJ1CoQQAZT8vCA+6vTJQjsYKeCo2txRCAEM6UWBMtIHtL
i6mm9rnSSo2kDANQ0kxjDJw3rUFDsRxKkpJ3igPUEsNCmeeDpANFmmcCMiol
AMSScqKw6whSjqkGJbc8nsXTXm8cVcytwhCMGeugRQA0hsUI9QzDVMBGoPeE
n3kEFhkKUaFAaNbQ6QwZXSMUbKaweTAQuUODhVcXFskweaEFTubQcHquFQaj
X/4u5IpwoSA9NLPk

---1463810780-1892710332-1079113930=:18728--
