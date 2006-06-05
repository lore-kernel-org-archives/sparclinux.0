From: Raymond Burns <rayburns@comcast.net>
Date: Mon, 05 Jun 2006 19:54:18 +0000
Subject: sun4d cpu-unit prom node
Message-Id: <Pine.LNX.4.10.10606051423490.11270-200000@coalcreekmill.cm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="279707904-1956914914-1149543775=:11270"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279707904-1956914914-1149543775=:11270
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi

The sun4d prom still has the cpu-unit node in the prom tree.

By dragging forward the attached code snippet/patch, applying the
patchs of Bob Breuer and Krzysztof Helt with the essence of Bob
Breuer's patch applied to the sun4d files allows a SMP sun4d boot to
progress past populate_rootfs

Thank you gentlemen

back to the hunt.

Thanx
  Ray


--279707904-1956914914-1149543775=:11270
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch_sun4d_cpu-unit
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10606051442550.11270@coalcreekmill.cm.com>
Content-Description: 
Content-Disposition: attachment; filename=patch_sun4d_cpu-unit

KioqIGxpbnV4LTIuNi4xNy1yYzQub3JpZy9hcmNoL3NwYXJjL2tlcm5lbC9k
ZXZpY2VzLmMJVGh1IE1heSAxMSAyMzozMTo1MyAyMDA2DQotLS0gbGludXgt
Mi42LjE3LXJjNC9hcmNoL3NwYXJjL2tlcm5lbC9kZXZpY2VzLmMJTW9uIEp1
biAgNSAxOToxNTo1MCAyMDA2DQoqKioqKioqKioqKioqKioNCioqKiA3MSw4
MSAqKioqDQogIAkJcmV0dXJuIDA7DQogIA0KICAJbmQgPSBwcm9tX2dldGNo
aWxkKG5kKTsNCiEgCXdoaWxlICgobmQgPSBwcm9tX2dldHNpYmxpbmcobmQp
KSAhPSAwKSB7DQohIAkJZXJyID0gY2hlY2tfY3B1X25vZGUobmQsICZjdXJf
aW5zdCwgY29tcGFyZSwgY29tcGFyZV9hcmcsDQohIAkJCQkgICAgIHByb21f
bm9kZSwgbWlkKTsNCiAgCQlpZiAoIWVycikNCiAgCQkJcmV0dXJuIDA7DQog
IAl9DQogIA0KICAJcmV0dXJuIC1FTk9ERVY7DQotLS0gNzEsOTQgLS0tLQ0K
ICAJCXJldHVybiAwOw0KICANCiAgCW5kID0gcHJvbV9nZXRjaGlsZChuZCk7
DQohIAlpZiAoc3BhcmNfY3B1X21vZGVsID09IHN1bjRkKSB7DQohIAkJZm9y
IChuZCA9IHByb21fc2VhcmNoc2libGluZ3MobmQsICJjcHUtdW5pdCIpOyBu
ZDsNCiEgCQkJbmQgPSBwcm9tX3NlYXJjaHNpYmxpbmdzKHByb21fZ2V0c2li
bGluZyhuZCksDQohIAkJCQkiY3B1LXVuaXQiKSkNCiEgCQl7DQohIAkJCWlu
dCBub2RlID0gcHJvbV9nZXRjaGlsZChuZCk7DQohIAkJCWVyciA9IGNoZWNr
X2NwdV9ub2RlKG5vZGUsICZjdXJfaW5zdCwgY29tcGFyZSwNCiEgCQkJCWNv
bXBhcmVfYXJnLCBwcm9tX25vZGUsIG1pZCk7DQohIAkJCWlmICghZXJyKQ0K
ISAJCQkJcmV0dXJuIDA7DQohIAkJfQ0KISAJfSBlbHNlIHsNCiEgCQl3aGls
ZSAoKG5kID0gcHJvbV9nZXRzaWJsaW5nKG5kKSkgIT0gMCkgew0KISAJCQll
cnIgPSBjaGVja19jcHVfbm9kZShuZCwgJmN1cl9pbnN0LCBjb21wYXJlLA0K
ISAJCQkJY29tcGFyZV9hcmcsIHByb21fbm9kZSwgbWlkKTsNCiAgCQlpZiAo
IWVycikNCiAgCQkJcmV0dXJuIDA7DQorIAkJfQ0KICAJfQ0KICANCiAgCXJl
dHVybiAtRU5PREVWOw0K
--279707904-1956914914-1149543775=:11270--
