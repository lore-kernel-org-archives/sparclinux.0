From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sun, 30 Oct 2005 15:12:01 +0000
Subject: sparc64 errors
Message-Id: <1130685122.7972.27.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

For the purpose of documentation, I'm posting the errors that I'm seeing
with buildcheck under 2.6 sparc64. I have no idea if these are false
positives or not.

+ make ARCH=sparc64 buildcheck
perl /usr/src/redhat/BUILD/kernel-2.6.13/linux-2.6.13/scripts/reference_discarded.pl
perl /usr/src/redhat/BUILD/kernel-2.6.13/linux-2.6.13/scripts/reference_init.pl
Finding objects, 3551 objects, ignoring 1875 module(s)
Finding conglomerates, ignoring 98 conglomerate(s)
Scanning objects
Error: ./arch/sparc64/kernel/time.o .data.read_mostly refers to
0000000000000000 R_SPARC_64        .init.data
Error: ./drivers/serial/sunsu.o .data refers to 0000000000000048
R_SPARC_64        .init.text+0x00000000000001d8
Error: ./drivers/serial/sunzilog.o .data refers to 0000000000000028
R_SPARC_64        .init.text+0x0000000000000058
Error: ./drivers/video/aty/atyfb_base.o .text refers to 0000000000002968
R_SPARC_HI22      .init.data
Error: ./drivers/video/aty/atyfb_base.o .text refers to 000000000000296c
R_SPARC_LO10      .init.data
Error: ./drivers/video/console/promcon.o .text refers to
0000000000000334 R_SPARC_WDISP30   .init.text+0x0000000000000118
Error: ./init/main.o .text refers to 00000000000000d0
R_SPARC_HI22      .init.data+0x0000000000000160
Error: ./init/main.o .text refers to 00000000000000d4
R_SPARC_LO10      .init.data+0x0000000000000160
Done

Thanks,

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

