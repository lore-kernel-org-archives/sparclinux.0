From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 26 Jul 2007 01:25:24 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <Pine.LNX.4.61.0707260222260.21378@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-648431206-1185413124=:21378"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-648431206-1185413124=:21378
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


Sorry about that. The patch lost a space character. This one has been 
checked on the latest git from 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git so it 
should work.

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
>
--1750305931-648431206-1185413124=:21378
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="SolarisParition.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0707260225230.21378@mtfhpc.demon.co.uk>
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
d2l0aCA4IGVudHJpZXMgZ3JhY2VmdWxseSAqLyAgDQorCW1heF9ucGFydHMg
PSBsZTE2X3RvX2NwdSAodi0+dl9ucGFydHMpID4gOCA/IFNPTEFSSVNfWDg2
X05VTVNMSUNFIDogODsNCisJZm9yIChpPTA7IGk8bWF4X25wYXJ0cyAmJiBz
dGF0ZS0+bmV4dDxzdGF0ZS0+bGltaXQ7IGkrKykgew0KIAkJc3RydWN0IHNv
bGFyaXNfeDg2X3NsaWNlICpzID0gJnYtPnZfc2xpY2VbaV07DQogCQlpZiAo
cy0+c19zaXplID09IDApDQogCQkJY29udGludWU7DQpkaWZmIC1ydU5wZCAt
eCAuZ2l0IC14IC5naXRpZ25vcmUgLXggLm1haWxtYXAgbGludXgtMi42L2lu
Y2x1ZGUvbGludXgvZ2VuaGQuaCBsaW51eC10ZXN0L2luY2x1ZGUvbGludXgv
Z2VuaGQuaA0KLS0tIGxpbnV4LTIuNi9pbmNsdWRlL2xpbnV4L2dlbmhkLmgJ
MjAwNy0wNy0yNCAyMjo0NzoyNi4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51
eC10ZXN0L2luY2x1ZGUvbGludXgvZ2VuaGQuaAkyMDA3LTA3LTI2IDAwOjM4
OjMwLjAwMDAwMDAwMCArMDEwMA0KQEAgLTI2NCw3ICsyNjQsNyBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgc2V0X2NhcGFjaXR5KHN0cnVjdCBnDQogDQogI2lm
ZGVmIENPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT04NCiANCi0jZGVmaW5l
IFNPTEFSSVNfWDg2X05VTVNMSUNFCTgNCisjZGVmaW5lIFNPTEFSSVNfWDg2
X05VTVNMSUNFCTE2DQogI2RlZmluZSBTT0xBUklTX1g4Nl9WVE9DX1NBTkUJ
KDB4NjAwRERFRUVVTCkNCiANCiBzdHJ1Y3Qgc29sYXJpc194ODZfc2xpY2Ug
ew0K

--1750305931-648431206-1185413124=:21378--
