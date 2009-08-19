From: Konrad Eisele <konrad@gaisler.com>
Date: Wed, 19 Aug 2009 11:34:10 +0000
Subject: Sparc-leon uart driver patch for review
Message-Id: <4A8BE332.80309@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, Here is a patch (will be sent as a reply to this mail) for review
that will add a sparc-leon uart driver to the
kernel. It includes the amba plug and play (ambapp) core bus routines
drivers/ambapp/ambapp.c and drivers/ambapp/ambapp_driver.c
as well as the first driver drivers/ambapp/gaisler/apbuart/apbuart.c.
There are some more drivers (ethernet and gpio) that I'll post
after this one has been accepted.

  drivers/Kconfig                          |    2 +
  drivers/Makefile                         |    1 +
  drivers/ambapp/Kconfig                   |    9 +
  drivers/ambapp/Makefile                  |    6 +
  drivers/ambapp/ambapp.c                  |  361 +++++++++++++
  drivers/ambapp/ambapp.h                  |  246 +++++++++
  drivers/ambapp/ambapp_driver.c           |  219 ++++++++
  drivers/ambapp/gaisler/Kconfig           |   20 +
  drivers/ambapp/gaisler/Makefile          |    3 +
  drivers/ambapp/gaisler/apbuart/Makefile  |    3 +
  drivers/ambapp/gaisler/apbuart/apbuart.c |  837 ++++++++++++++++++++++++++++++
  include/linux/serial_core.h              |    3 +

It also includes the _amba_init() routine that is called
from within sparc at bootup and that will dynamically build the
device tree.

Having the Sparc-leon architectural part and the uart driver
one can build a simple system for leon already (bootloader and
user apps on top)...

I'm not shure wher to add the drivers/ambapp/Kconfig, I just
added it to drivers/Kconfig however maybe arch/sparc/Kconfig
might be more approprite.

-- Greetings Konrad
