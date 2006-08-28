From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Mon, 28 Aug 2006 18:33:10 +0000
Subject: Re: [PATCH] sparc32: max_cache_size fallback
Message-Id: <44f336e6110b7@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part44f336e6137d9"
List-Id: <sparclinux.vger.kernel.org>
References: <44de28a4e7531@wp.pl>
In-Reply-To: <44de28a4e7531@wp.pl>
To: sparclinux@vger.kernel.org

<20060825.162458.107683420.davem@davemloft.net>
<44f00d6b8b482@wp.pl> <20060826.164852.26965744.davem@davemloft.net>
In-reply-to: <44de28a4e7531@wp.pl>
<20060825.162458.107683420.davem@davemloft.net>
<44f00d6b8b482@wp.pl> <20060826.164852.26965744.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="part44f336e6137d9"
X-Mailer: Interfejs WWW poczty Wirtualnej Polski
Organization: Poczta Wirtualnej Polski S.A. http://www.wp.pl/
X-User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4a) Gecko/20030401
X-WP-IP: 213.76.92.156
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO AS2=NO(0.500134) AS3=NO AS4=NO AS5=NO                                                             

This is a multi-part message in MIME format.

--part44f336e6137d9
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

From: Krzysztof Helt (krzysztof.h1@wp.pl)

It adds a fallback for CPU cache size detection. According to Sun
documentation, it is possible to have SMP system with SM40 modules.
It counts only data cache after David Miller suggestion.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl) 
---

I don't think that counting only data cache is right but it does
not matter as scheduler do not use values lesser than 64KB (it
uses 64KB instead).

Regards,
Krzysztof

----------------------------------------------------
Weekendowe trunkowanie czyli przepisy na drinki i nalewki - Kliknij:
http://klik.wp.pl/?adr=http%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fk23.html&sid=859

--part44f336e6137d9
Content-Type: application/octet-stream; name="sparc32-max-cache-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sparc32-max-cache-fix.patch"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4xNy9hcmNoL3NwYXJjL2tlcm5lbC9zbXAuYyBsaW51eC1uZXcv
YXJjaC9zcGFyYy9rZXJuZWwvc21wLmMKLS0tIGxpbnV4LTIuNi4xNy9hcmNoL3NwYXJjL2tlcm5l
bC9zbXAuYwkyMDA2LTA4LTEwIDA4OjU4OjMxLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtbmV3
L2FyY2gvc3BhcmMva2VybmVsL3NtcC5jCTIwMDYtMDgtMTIgMTk6MTE6MjAuMDAwMDAwMDAwICsw
MjAwCkBAIC03OSw2ICs3OCw5IEBAIHZvaWQgX19jcHVpbml0IHNtcF9zdG9yZV9jcHVfaW5mbyhp
bnQgaWQKIAkJY2FjaGVfbmxpbmVzID0gMHg4MDAwOwogCQljYWNoZV9ubGluZXMgPSBwcm9tX2dl
dGludGRlZmF1bHQoY3B1X25vZGUsICJlY2FjaGUtbmxpbmVzIiwgY2FjaGVfbmxpbmVzKTsKIAkJ
bWF4X2NhY2hlX3NpemUgPSBjYWNoZV9saW5lICogY2FjaGVfbmxpbmVzOworCQkvKiB0aGlzIGlz
IGZvciBTTTQwIFN1cGVyU3BhcmMgbW9kdWxlcyAqLworCQlpZiAobWF4X2NhY2hlX3NpemUgPT0g
MCkKKwkJCW1heF9jYWNoZV9zaXplID0gMTYgKiAxMDI0OwogCX0KIAlpZiAoY3B1X2RhdGEoaWQp
Lm1pZCA8IDApCiAJCXBhbmljKCJObyBNSUQgZm91bmQgZm9yIENQVSVkIGF0IG5vZGUgMHglMDhk
IiwgaWQsIGNwdV9ub2RlKTsKCg==

--part44f336e6137d9--


