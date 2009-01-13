From: David Miller <davem@redhat.com>
Date: Tue, 13 Jan 2009 05:05:01 +0000
Subject: pcf50663 MFD driver modular build failure
Message-Id: <20090112.210501.215941396.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, balajirrao@openmoko.org, andy@openmoko.com, sameo@openedhand.com, mingo@elte.hu, yinghai@kernel.org, akpm@linux-foundation.org, sfr@canb.auug.org.au


This started happening with Linus's pull from today for
sparc64 allmodconfig:

ERROR: "__set_irq_handler" [drivers/mfd/pcf50633-core.ko] undefined!
ERROR: "handle_level_irq" [drivers/mfd/pcf50633-core.ko] undefined!

Sure we can export __set_irq_handler() and handle_level_irq() to
modules to fix this, but that looks like some hokey stuff for
a MFD driver to be doing :-)
