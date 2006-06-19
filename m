From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 19 Jun 2006 02:39:02 +0000
Subject: 2.6.17 SMP kernel problems
Message-Id: <Pine.LNX.4.63.0606181910050.3512@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Test build of the 2.6.17 released yesterday does not boot on my Ultra60 
SMP machine: it hangs at random places during boot. After that even 
sending a break over serial console to get into prom does not work, 
machine has to be power-cycled. Kernel was built using gcc-4.0, config 
used is available at http://www.wooyd.org/junk/config-2.6.17-sparc64-smp. 
UP kernel does not appear to be affected. Anyone seeing anything similar?

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
