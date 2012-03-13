From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 13 Mar 2012 22:28:18 +0000
Subject: New build failures in sparc.
Message-Id: <CAP=VYLpfM0AFWQp7Q=xYHnCd_6vEXKKL1EL5daGcO9gsJZH=7Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-next@vger.kernel.org

Just a heads up that these turned up today in linux-next:

------------
arch/sparc/lib/mul.S:134: Error: Hardware capability "mul32" not
enabled for "smul".
make[2]: *** [arch/sparc/lib/mul.o] Error 1
arch/sparc/lib/rem.S:378: Error: Hardware capability "div32" not
enabled for "sdivcc".
arch/sparc/lib/rem.S:381: Error: Hardware capability "mul32" not
enabled for "smul".
arch/sparc/lib/sdiv.S:377: Error: Hardware capability "div32" not
enabled for "sdivcc".
make[2]: *** [arch/sparc/lib/rem.o] Error 1
make[2]: *** [arch/sparc/lib/sdiv.o] Error 1
arch/sparc/lib/udiv.S:356: Error: Hardware capability "div32" not
enabled for "udiv".
arch/sparc/lib/umul.S:168: Error: Hardware capability "mul32" not
enabled for "umul".
make[2]: *** [arch/sparc/lib/udiv.o] Error 1
arch/sparc/lib/urem.S:354: Error: Hardware capability "div32" not
enabled for "udiv".
arch/sparc/lib/urem.S:355: Error: Hardware capability "mul32" not
enabled for "umul".
make[2]: *** [arch/sparc/lib/umul.o] Error 1
make[2]: *** [arch/sparc/lib/urem.o] Error 1
make[1]: *** [arch/sparc/lib] Error 2
make: *** [sub-make] Error 2
-------------

http://kisskb.ellerman.id.au/kisskb/buildresult/5869520/
http://kisskb.ellerman.id.au/kisskb/buildresult/5869567/

I've not done any investigation into the root cause (yet).

Paul.
