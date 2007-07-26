From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 26 Jul 2007 01:30:07 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <Pine.LNX.4.61.0707260227560.21616@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-1546318251-1185413407=:21616"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-1546318251-1185413407=:21616
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


And third time lucky - forgot to remove the white space.

On Wed, 25 Jul 2007, David Miller wrote:

> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Thu, 26 Jul 2007 01:15:51 +0100 (BST)
>
>> OK This one is easy as the VTOC structure is only used in
>> fs/partions/msdos.c and the parts that get moved by changing the number
>> of slices are not used yet (v2.6.22). I have attached a patch.
>
> Doesn't apply to 2.6.23-rc1, can you rediff for me and kill
> the trailing whitespace on the line with the comment you
> added?
>
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--1750305931-1546318251-1185413407=:21616
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="SolarisParition.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0707260230060.21616@mtfhpc.demon.co.uk>
Content-Description: 
Content-Disposition: attachment; filename="SolarisParition.patch"

RnJvbTogTWFyayBGb3J0ZXNjdWUgPG1hcmtAbXRmaHBjLmRlbW9uLmNvLnVr
Pg0KDQpDb3JyZWN0IHRoZSBTb2xhcmlzIHg4NiBudW1iZXIgb2YgcGFydGl0
aW9ucyAoc2xpY2VzKSBpcyBhIHdheSB0aGF0IGlzDQpiYWNrd2FyZCBjb21w
YXRpYmxlIHdpdGggdGhlIGVhcmxpZXIgc2l6ZS4NClRoaXMgd29ya3Mgd2l0
aG91dCBhIG5ldyBWVE9DIHN0cnVjdHVyZSBkZWZpbml0aW9uIGFzIHRoZSB0
aW1lc3RhbXANCmFuZCB2X2FzY2lpbGFiZWwgZmllbGRzIGluIHRoZSBWVE9D
IGFyZSBub3QgdXNlZCBieSB0aGUga2VybmVsIHlldC4NCg0KU2lnbmVkLW9m
Zi1ieTogTWFyayBGb3J0ZXNjdWUgPG1hcmtAbXRmaHBjLmRlbW9uLmNvLnVr
Pg0KLS0tDQpkaWZmIC1ydU5wZCAteCAuZ2l0IC14IC5naXRpZ25vcmUgLXgg
Lm1haWxtYXAgbGludXgtMi42L2ZzL3BhcnRpdGlvbnMvbXNkb3MuYyBsaW51
eC10ZXN0L2ZzL3BhcnRpdGlvbnMvbXNkb3MuYw0KLS0tIGxpbnV4LTIuNi9m
cy9wYXJ0aXRpb25zL21zZG9zLmMJMjAwNy0wNy0yNCAyMjo0NzoyMi4wMDAw
MDAwMDAgKzAxMDANCisrKyBsaW51eC10ZXN0L2ZzL3BhcnRpdGlvbnMvbXNk
b3MuYwkyMDA3LTA3LTI2IDAwOjQwOjQxLjAwMDAwMDAwMCArMDEwMA0KQEAg
LTIwMyw2ICsyMDMsNyBAQCBwYXJzZV9zb2xhcmlzX3g4NihzdHJ1Y3QgcGFy
c2VkX3BhcnRpdGlvDQogCVNlY3RvciBzZWN0Ow0KIAlzdHJ1Y3Qgc29sYXJp
c194ODZfdnRvYyAqdjsNCiAJaW50IGk7DQorCXNob3J0IG1heF9ucGFydHM7
DQogDQogCXYgPSAoc3RydWN0IHNvbGFyaXNfeDg2X3Z0b2MgKilyZWFkX2Rl
dl9zZWN0b3IoYmRldiwgb2Zmc2V0KzEsICZzZWN0KTsNCiAJaWYgKCF2KQ0K
QEAgLTIxOCw3ICsyMTksOSBAQCBwYXJzZV9zb2xhcmlzX3g4NihzdHJ1Y3Qg
cGFyc2VkX3BhcnRpdGlvDQogCQlwdXRfZGV2X3NlY3RvcihzZWN0KTsNCiAJ
CXJldHVybjsNCiAJfQ0KLQlmb3IgKGk9MDsgaTxTT0xBUklTX1g4Nl9OVU1T
TElDRSAmJiBzdGF0ZS0+bmV4dDxzdGF0ZS0+bGltaXQ7IGkrKykgew0KKwkv
KiBFbnN1cmUgd2UgY2FuIGhhbmRsZSBwcmV2aW91cyBjYXNlIG9mIFZUT0Mg
d2l0aCA4IGVudHJpZXMgZ3JhY2VmdWxseSAqLw0KKwltYXhfbnBhcnRzID0g
bGUxNl90b19jcHUgKHYtPnZfbnBhcnRzKSA+IDggPyBTT0xBUklTX1g4Nl9O
VU1TTElDRSA6IDg7DQorCWZvciAoaT0wOyBpPG1heF9ucGFydHMgJiYgc3Rh
dGUtPm5leHQ8c3RhdGUtPmxpbWl0OyBpKyspIHsNCiAJCXN0cnVjdCBzb2xh
cmlzX3g4Nl9zbGljZSAqcyA9ICZ2LT52X3NsaWNlW2ldOw0KIAkJaWYgKHMt
PnNfc2l6ZSA9PSAwKQ0KIAkJCWNvbnRpbnVlOw0KZGlmZiAtcnVOcGQgLXgg
LmdpdCAteCAuZ2l0aWdub3JlIC14IC5tYWlsbWFwIGxpbnV4LTIuNi9pbmNs
dWRlL2xpbnV4L2dlbmhkLmggbGludXgtdGVzdC9pbmNsdWRlL2xpbnV4L2dl
bmhkLmgNCi0tLSBsaW51eC0yLjYvaW5jbHVkZS9saW51eC9nZW5oZC5oCTIw
MDctMDctMjQgMjI6NDc6MjYuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgt
dGVzdC9pbmNsdWRlL2xpbnV4L2dlbmhkLmgJMjAwNy0wNy0yNiAwMDozODoz
MC4wMDAwMDAwMDAgKzAxMDANCkBAIC0yNjQsNyArMjY0LDcgQEAgc3RhdGlj
IGlubGluZSB2b2lkIHNldF9jYXBhY2l0eShzdHJ1Y3QgZw0KIA0KICNpZmRl
ZiBDT05GSUdfU09MQVJJU19YODZfUEFSVElUSU9ODQogDQotI2RlZmluZSBT
T0xBUklTX1g4Nl9OVU1TTElDRQk4DQorI2RlZmluZSBTT0xBUklTX1g4Nl9O
VU1TTElDRQkxNg0KICNkZWZpbmUgU09MQVJJU19YODZfVlRPQ19TQU5FCSgw
eDYwMERERUVFVUwpDQogDQogc3RydWN0IHNvbGFyaXNfeDg2X3NsaWNlIHsN
Cg==

--1750305931-1546318251-1185413407=:21616--
