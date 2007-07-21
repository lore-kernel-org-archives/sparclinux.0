From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 21 Jul 2007 17:49:46 +0000
Subject: [PATCH] Alter sparc32 __ndelay/__udelay delay calculations
Message-Id: <Pine.LNX.4.61.0707211703570.10310@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-311965207-1185035874=:10310"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-311965207-1185035874=:10310
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; format=flowed
Content-ID: <Pine.LNX.4.61.0707211739301.10310@mtfhpc.demon.co.uk>

__ndelay and __udelay have not been delaying >= specified time.
The problem with __ndelay has been tacked down to the rounding of the
multiplier constant. By changing this, delays > app 18us are correctly
calculated.
The problem with __udelay has also been tracked down to rounding issues.
Changing the multiplier constant (to match that used in sparc64) corrects
for large delays and adding in a rounding constant corrects for trunctaion
errors in the claculations for short delays.
Many short delays will return without looping. This is not an error as there
is the fixed delay of doing all the maths to calculate the loop count.

Signed-off-by: Mark Fortescue <mark@mtfhpc.demon.co.uk>
---
Patch also attahced as the inline version will probably get mangled by 
my mailer.

The investigation was prompted by David Miller while I was looking at SCSI 
driver issues. Changing the code does not apear to have helped with the 
SCSI driver issue I am having but fixing it eliminates a potential cause of 
problems.

The __udelay and __ndelay functions can be improved for accuracy for many 
delays but this will be at the expense of accuracy for some of the short 
delays due to the extra instructions needed to calculate the loop count.
I decided that it would be best to make the minimum of changes required to 
ensure the delays do not get too short so I have not put in any 
instruction count corrections or the __udelay HZ multiply correction (for 
full accuracy, it needs a 64bit x HZ multiply, not a 32bit x HZ multiply).

--- linux-2.6/arch/sparc/kernel/entry.S	2007-07-21 03:26:40.000000000 +0100
+++ linux-test/arch/sparc/kernel/entry.S	2007-07-21 17:01:17.000000000 +0100
@@ -1749,8 +1749,8 @@ fpload:
  __ndelay:
  	save	%sp, -STACKFRAME_SZ, %sp
  	mov	%i0, %o0
-	call	.umul
-	 mov	0x1ad, %o1		! 2**32 / (1 000 000 000 / HZ)
+	call	.umul			! round multiplier up so large ns ok
+	 mov	0x1ae, %o1		! 2**32 / (1 000 000 000 / HZ)
  	call	.umul
  	 mov	%i1, %o1		! udelay_val
  	ba	delay_continue
@@ -1760,11 +1760,17 @@ __ndelay:
  __udelay:
  	save	%sp, -STACKFRAME_SZ, %sp
  	mov	%i0, %o0
-	sethi	%hi(0x10c6), %o1
+	sethi	%hi(0x10c7), %o1	! round multiplier up so large us ok
  	call	.umul
-	 or	%o1, %lo(0x10c6), %o1	! 2**32 / 1 000 000
+	 or	%o1, %lo(0x10c7), %o1	! 2**32 / 1 000 000
  	call	.umul
  	 mov	%i1, %o1		! udelay_val
+	sethi	%hi(0x028f4b62), %l0	! Add in rounding constant * 2**32,
+	or	%g0, %lo(0x028f4b62), %l0
+	addcc	%o0, %l0, %o0		! 2**32 * 0.009 999
+	bcs,a	3f
+	 add	%o1, 0x01, %o1
+3:
  	call	.umul
  	 mov	HZ, %o0			! >>32 earlier for wider range

Regards
 	Mark Fortescue.

On Sat, 21 Jul 2007, Mark Fortescue wrote:

> On Fri, 20 Jul 2007, David Miller wrote:
>
>> 
>> I think these reports all point to a problem with the sparc32
>> kernel far outside of the drivers in question.
>> 
>> We have no reports like this on sparc64.
>> 
>> My running theory is that things like msleep() are returning
>> immediately on sparc32, or at least too fast, instead of delaying
>> the minimum necessary amount.
>> 
>> This will screw up the scsi reset settle delay, and the devices will
>> return scsi command status's that the SCSI bus probe will consider not
>> good enough to recognize the device.
>> 
>> This is exactly what tracing from Tom Callaway has shown in the past.
>> 
>> So this is a sparc32 kernel bug of some sort, most likely, not a
>> driver bug.
--1750305931-311965207-1185035874=:10310
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="delay.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0707211737530.10310@mtfhpc.demon.co.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="delay.patch"

RnJvbTogTWFyayBGb3J0ZXNjdWUgPG1hcmtAbXRmaHBjLmRlbW9uLmNvLnVr
Pg0KDQpfX25kZWxheSBhbmQgX191ZGVsYXkgaGF2ZSBub3QgYmVlbiBkZWxh
eXVuZyA+PSBzcGVjaWZpZWQgdGltZS4NClRoZSBwcm9ibGVtIHdpdGggX19u
ZGVsYXkgaGFzIGJlZW4gdGFja2VkIGRvd24gdG8gdGhlIHJvdW5kaW5nIG9m
IHRoZQ0KbXVsdGlwbGllciBjb25zdGFudC4gQnkgY2hhbmdpbmcgdGhpcywg
ZGVsYXlzID4gYXBwIDE4dXMgYXJlIGNvcnJlY3RseQ0KY2FsY3VsYXRlZC4N
ClRoZSBwcm9ibGVtIHdpdGggX191ZGVsYXkgaGFzIGFsc28gYmVlbiB0cmFj
a2VkIGRvd24gdG8gcm91bmRpbmcgaXNzdWVzLg0KQ2hhbmdpbmcgdGhlIG11
bHRpcGxpZXIgY29uc3RhbnQgKHRvIG1hdGNoIHRoYXQgdXNlZCBpbiBzcGFy
YzY0KSBjb3JyZWN0cw0KZm9yIGxhcmdlIGRlbGF5cyBhbmQgYWRkaW5nIGlu
IGEgcm91bmRpbmcgY29uc3RhbnQgY29ycmVjdHMgZm9yIHRydW5jdGFpb24N
CmVycm9ycyBpbiB0aGUgY2xhY3VsYXRpb25zLg0KTWFueSBzaG9ydCBkZWxh
eXMgd2lsbCByZXR1cm4gd2l0aG91dCBsb29waW5nLiBUaGlzIGlzIG5vdCBh
biBlcnJvciBhcyB0aGVyZQ0KaXMgdGhlIGZpeGVkIGRlbGF5IG9mIGRvaW5n
IGFsbCB0aGUgbWF0aHMgdG8gY2FsY3VsYXRlIHRoZSBsb29wIGNvdW50Lg0K
DQpTaWduZWQtb2ZmLWJ5OiBNYXJrIEZvcnRlc2N1ZSA8bWFya0BtdGZocGMu
ZGVtb24uY28udWs+DQotLS0NCg0KLS0tIGxpbnV4LTIuNi9hcmNoL3NwYXJj
L2tlcm5lbC9lbnRyeS5TCTIwMDctMDctMjEgMDM6MjY6NDAuMDAwMDAwMDAw
ICswMTAwDQorKysgbGludXgtdGVzdC9hcmNoL3NwYXJjL2tlcm5lbC9lbnRy
eS5TCTIwMDctMDctMjEgMTc6MDE6MTcuMDAwMDAwMDAwICswMTAwDQpAQCAt
MTc0OSw4ICsxNzQ5LDggQEAgZnBsb2FkOg0KIF9fbmRlbGF5Og0KIAlzYXZl
CSVzcCwgLVNUQUNLRlJBTUVfU1osICVzcA0KIAltb3YJJWkwLCAlbzANCi0J
Y2FsbAkudW11bA0KLQkgbW92CTB4MWFkLCAlbzEJCSEgMioqMzIgLyAoMSAw
MDAgMDAwIDAwMCAvIEhaKQ0KKwljYWxsCS51bXVsCQkJISByb3VuZCBtdWx0
aXBsaWVyIHVwIHNvIGxhcmdlIG5zIG9rDQorCSBtb3YJMHgxYWUsICVvMQkJ
ISAyKiozMiAvICgxIDAwMCAwMDAgMDAwIC8gSFopDQogCWNhbGwJLnVtdWwN
CiAJIG1vdgklaTEsICVvMQkJISB1ZGVsYXlfdmFsDQogCWJhCWRlbGF5X2Nv
bnRpbnVlDQpAQCAtMTc2MCwxMSArMTc2MCwxNyBAQCBfX25kZWxheToNCiBf
X3VkZWxheToNCiAJc2F2ZQklc3AsIC1TVEFDS0ZSQU1FX1NaLCAlc3ANCiAJ
bW92CSVpMCwgJW8wDQotCXNldGhpCSVoaSgweDEwYzYpLCAlbzENCisJc2V0
aGkJJWhpKDB4MTBjNyksICVvMQkhIHJvdW5kIG11bHRpcGxpZXIgdXAgc28g
bGFyZ2UgdXMgb2sNCiAJY2FsbAkudW11bA0KLQkgb3IJJW8xLCAlbG8oMHgx
MGM2KSwgJW8xCSEgMioqMzIgLyAxIDAwMCAwMDANCisJIG9yCSVvMSwgJWxv
KDB4MTBjNyksICVvMQkhIDIqKjMyIC8gMSAwMDAgMDAwDQogCWNhbGwJLnVt
dWwNCiAJIG1vdgklaTEsICVvMQkJISB1ZGVsYXlfdmFsDQorCXNldGhpCSVo
aSgweDAyOGY0YjYyKSwgJWwwCSEgQWRkIGluIHJvdW5kaW5nIGNvbnN0YW50
ICogMioqMzIsDQorCW9yCSVnMCwgJWxvKDB4MDI4ZjRiNjIpLCAlbDANCisJ
YWRkY2MJJW8wLCAlbDAsICVvMAkJISAyKiozMiAqIDAuMDA5IDk5OQ0KKwli
Y3MsYQkzZg0KKwkgYWRkCSVvMSwgMHgwMSwgJW8xDQorMzoNCiAJY2FsbAku
dW11bA0KIAkgbW92CUhaLCAlbzAJCQkhID4+MzIgZWFybGllciBmb3Igd2lk
ZXIgcmFuZ2UNCiANCg==

--1750305931-311965207-1185035874=:10310--
