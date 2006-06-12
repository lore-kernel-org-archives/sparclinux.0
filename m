From: Raymond Burns <rayburns@comcast.net>
Date: Mon, 12 Jun 2006 17:28:07 +0000
Subject: sun4d: missing spin_lock_init
Message-Id: <Pine.LNX.4.10.10606121207290.11270-200000@coalcreekmill.cm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="279707904-1238653674-1150139804=:11270"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279707904-1238653674-1150139804=:11270
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi

It appears the only one using this is the sun4d 

The patch clears up:
scsi0 : Sparc ESP236-FAST
BUG: spinlock bad magic on CPU#0, swapper/1
 lock: f0f00800, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
...

Thanx
  Ray


--279707904-1238653674-1150139804=:11270
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch_sun4d_spin_lock_init.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10606121216440.11270@coalcreekmill.cm.com>
Content-Description: 
Content-Disposition: attachment; filename="patch_sun4d_spin_lock_init.txt"

LS0tIGxpbnV4LTIuNi4xNy1yYzYub3JpZy9hcmNoL3NwYXJjL21tL2lvLXVu
aXQuYwlUdWUgSnVuICA2IDAwOjU3OjAyIDIwMDYNCisrKyBsaW51eC0yLjYu
MTctcmM2L2FyY2gvc3BhcmMvbW0vaW8tdW5pdC5jCU1vbiBKdW4gMTIgMDQ6
MjU6NDAgMjAwNg0KQEAgLTY1LDYgKzY1LDcgQEANCiAJDQogCXNidXMtPmlv
bW11ID0gKHN0cnVjdCBpb21tdV9zdHJ1Y3QgKilpb3VuaXQ7DQogCWlvdW5p
dC0+cGFnZV90YWJsZSA9IHhwdDsNCisJc3Bpbl9sb2NrX2luaXQoJmlvdW5p
dC0+bG9jayk7DQogCQ0KIAlmb3IgKHhwdGVuZCA9IGlvdW5pdC0+cGFnZV90
YWJsZSArICgxNiAqIFBBR0VfU0laRSkgLyBzaXplb2YoaW9wdGVfdCk7DQog
CSAgICAgeHB0IDwgeHB0ZW5kOykNCg==
--279707904-1238653674-1150139804=:11270--
