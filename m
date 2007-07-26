From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 26 Jul 2007 00:15:51 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <Pine.LNX.4.61.0707260043340.21378@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-844006836-1185408950=:21378"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-844006836-1185408950=:21378
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi David,

On Wed, 25 Jul 2007, David Miller wrote:

> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Wed, 25 Jul 2007 22:46:07 +0100 (BST)
>
>> It looks like I will have to change the patch to use a kernal/module
>> parameter to enable VTOC checking. David, would this be suficient in your
>> view?
>
> I still don't like it too much.  Please find a way to distinguish
> the two situations, I truly believe there is some way to figure
> this out.  For example, one thing you can depend upon is that the
> faulty Linux tools will always zero out version and sanity along
> with the num_partitions field in the VTOC.
>

Not easy. I will put a new disk on the Sparc and see what is actually
written to the VTOC location in the disk label (marked as padding in the
SunOS 4.1.x header file).

>> With regard to the id and flag values - the spare1 and spare2 values are
>> currently meant to be zero so using the 16bit filing system endian
>> conversion functions means that 8 partition disk label created on x86
>> systems should work correctly as well as those created on Sparc systems.
>> It would be posible to change the code to use bytes but the coding begins
>> to get very messy when we start accessing bytes swaped partition labels
>> as these use spare1/2 for id/flags.
>
> Yes, I believe this part of the changes are fine.  If you look at the
> fdisk sun label fixes I made in util-linux-ng the other week I did
> basically the same thing.
>

Should I mask out the bottom 8 bits ?

>> The final part of the patch - increasing the number of x86 slices
>> (partitions) from 8 to 16 will correct the x86 Solaris disk label usually
>> used in x86 solaris systems but again may break Linux systems that have
>> been created using the incorrect value.
>
> It is truly a shame that Sun decided to use a different number of
> partitions value on x86.  BUT, for these cases it is easy to detect
> dynamically because the num_partitions field will contain 16.
>
> For broken linux tools and Solaris/Sparc, the field will contain
> either 0 or 8.
>
> So a lot of this should be dynamically detectable, even considering
> tools that do not fill in version and sanity properly.
>

OK This one is easy as the VTOC structure is only used in 
fs/partions/msdos.c and the parts that get moved by changing the number 
of slices are not used yet (v2.6.22). I have attached a patch.

> Please try hard to avoid a module parameter, I'm willing to help
> with testing as I have all of the Linux and current generation
> Solaris/Sparc disk label cases handy locally.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--1750305931-844006836-1185408950=:21378
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="SolarisParition.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0707260115490.21378@mtfhpc.demon.co.uk>
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
QEAgLTIxOCw0ICsyMTksNiBAQCBwYXJzZV9zb2xhcmlzX3g4NihzdHJ1Y3Qg
cGFyc2VkX3BhcnRpdGlvDQogCQlwdXRfZGV2X3NlY3RvcihzZWN0KTsNCiAJ
CXJldHVybjsNCiAJfQ0KLQlmb3IgKGk9MDsgaTxTT0xBUklTX1g4Nl9OVU1T
TElDRSAmJiBzdGF0ZS0+bmV4dDxzdGF0ZS0+bGltaXQ7IGkrKykgew0KKwkv
KiBFbnN1cmUgd2UgY2FuIGhhbmRsZSBwcmV2aW91cyBjYXNlIG9mIFZUT0Mg
d2l0aCA4IGVudHJpZXMgZ3JhY2VmdWxseSAqLyAgDQorCW1heF9ucGFydHMg
PSBsZTE2X3RvX2NwdSAodi0+dl9ucGFydHMpID4gOCA/IFNPTEFSSVNfWDg2
X05VTVNMSUNFIDogODsNCisJZm9yIChpPTA7IGk8bWF4X25wYXJ0cyAmJiBz
dGF0ZS0+bmV4dDxzdGF0ZS0+bGltaXQ7IGkrKykgew0KCQlzdHJ1Y3Qgc29s
YXJpc194ODZfc2xpY2UgKnMgPSAmdi0+dl9zbGljZVtpXTsNCiAJCWlmIChz
LT5zX3NpemUgPT0gMCkNCiAJCQljb250aW51ZTsNCmRpZmYgLXJ1TnBkIC14
IC5naXQgLXggLmdpdGlnbm9yZSAteCAubWFpbG1hcCBsaW51eC0yLjYvaW5j
bHVkZS9saW51eC9nZW5oZC5oIGxpbnV4LXRlc3QvaW5jbHVkZS9saW51eC9n
ZW5oZC5oDQotLS0gbGludXgtMi42L2luY2x1ZGUvbGludXgvZ2VuaGQuaAky
MDA3LTA3LTI0IDIyOjQ3OjI2LjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4
LXRlc3QvaW5jbHVkZS9saW51eC9nZW5oZC5oCTIwMDctMDctMjYgMDA6Mzg6
MzAuMDAwMDAwMDAwICswMTAwDQpAQCAtMjY0LDcgKzI2NCw3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBzZXRfY2FwYWNpdHkoc3RydWN0IGcNCiANCiAjaWZk
ZWYgQ09ORklHX1NPTEFSSVNfWDg2X1BBUlRJVElPTg0KIA0KLSNkZWZpbmUg
U09MQVJJU19YODZfTlVNU0xJQ0UJOA0KKyNkZWZpbmUgU09MQVJJU19YODZf
TlVNU0xJQ0UJMTYNCiAjZGVmaW5lIFNPTEFSSVNfWDg2X1ZUT0NfU0FORQko
MHg2MDBEREVFRVVMKQ0KIA0KIHN0cnVjdCBzb2xhcmlzX3g4Nl9zbGljZSB7
DQo=

--1750305931-844006836-1185408950=:21378--
