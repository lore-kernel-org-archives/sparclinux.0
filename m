From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 13 Mar 2012 22:39:26 +0000
Subject: sata_mv change breaks sparc builds?
Message-Id: <CAP=VYLrzrtJBUdojYos+9L30nNSoboPvfAh0u2tuJSvGX5Ao9Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi guys,

I've not bisected to concretely determine this is true, but at 1st
glance, it would appear perhaps that the change:

-------------
commit f1e1e148c5cbf62b6db26ae828c1e54e76579dfd
Author: Michael Walle <michael@walle.cc>
Date:   Sun Nov 13 22:23:57 2011 +0100

    ARM: kirkwood: sata_mv: add device tree binding

    Based on devicetree work by Michael Walle.  Changed compatible property
    to "mrvl,orion-sata", simplified retrieving nr_ports from fdt.

    Signed-off-by: Michael Walle <michael@walle.cc>
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>
--------------

might be responsible for these new sparc build failures?

http://kisskb.ellerman.id.au/kisskb/buildresult/5869562/
http://kisskb.ellerman.id.au/kisskb/buildresult/5869535/

If you could confirm or deny, that would be great help.

Thanks,
Paul.
