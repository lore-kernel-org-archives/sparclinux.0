From: Baptiste SIMON <baptiste.simon@e-glop.net>
Date: Thu, 06 May 2004 20:03:15 +0000
Subject: parport_sunbpp
Message-Id: <409A9A03.1080008@e-glop.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Derrick,

I've just compiled and insmod the parport_sunbpp.o module and I'm
surprised : it taints my kernel... I think that the license is GPL but
it's not be explicit in your driver's code.

The email wants to be informative... but if you can do something for it :cb

here is the patch to solve that :
- -- ---
--- 2.4.26/drivers/parport/parport_sunbpp.c    Thu May  6 21:48:27 2004
+++ 2.4.26-b/drivers/parport/parport_sunbpp.c  Thu May  6 21:40:58 2004
@@ -389,6 +389,7 @@
  MODULE_AUTHOR("Derrick J Brashear");
  MODULE_DESCRIPTION("Parport Driver for Sparc bidirectional Port");
  MODULE_SUPPORTED_DEVICE("Sparc Bidirectional Parallel Port");
+MODULE_LICENSE("GPL");

  void
  cleanup_module(void)
- -- ---

note that my current kernel is 2.4.26 vanilla.
Thanks for your work !! :c)

PS: I've not subscribed to the list... so Cc: me if needed.

--=20
Baptiste SIMON
    aka BeTa
Administrateur syst=E8mes GNU/Linux & Unix / IPv6
http://www.e-glop.net/
