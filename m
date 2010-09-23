From: Alex Mach <alexvm12e@mail.ru>
Date: Thu, 23 Sep 2010 13:56:04 +0000
Subject: Question about interrupt processing on Sparc64
Message-Id: <E1OymHM-0000pp-00.alexvm12e-mail-ru@f159.mail.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Why ttable.S and sun4v_ivec.S aren't linked to kernel in Makefile at /arch/sparc/kernel? As I understend these files are necessary for interrupt processing (sun4v_dev_mondo() and handle_irq() functions).

Thanks,
Alex.
