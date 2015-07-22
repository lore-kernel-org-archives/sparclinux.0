From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 22 Jul 2015 02:02:14 +0000
Subject: [PATCH 0/4] tty/serial: delete orphaned code in non-modules
Message-Id: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org

In the previous merge window, we made changes to allow better
delineation between modular and non-modular code in commit
0fd972a7d91d6e15393c449492a04d94c0b89351 ("module: relocate module_init
from init.h to module.h").  This allows us to now ensure module code
looks modular and non-modular code does not accidentally look modular
without suffering build breakage.

Here we target code that is, by nature of their Kconfig settings, only
available to be built-in, but implicitly presenting itself as being
possibly modular by way of using modular headers, macros, and functions.

The goal here is to remove that illusion of modularity from these
drivers, but in a way that leaves the actual runtime unchanged.
In doing so, we remove code that has never been tested and adds
no value to the tree.  And we begin the process of expecting a
level of consistency between the Kconfig of a driver and the code
that the driver uses.

Even though some of these drivers have their origin predating git
history, we change them as well; since the reality is that most linux
drivers are created by copying existing drivers.  Given that, our
new code will only be as good as the examples we have in tree.

Build tested for allyesconfig on sparc32, sparc64 and x86-64, on
tty/tty-next (currently v4.2-rc3).

Paul.
---

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: sparclinux@vger.kernel.org

Paul Gortmaker (4):
  drivers/tty: make serial/sn_console.c driver explicitly non-modular
  drivers/tty: make serial/lantic.c driver explicitly non-modular
  drivers/tty: make serial/suncore.c driver explicitly non-modular
  drivers/tty: make serial/sunhv.c driver explicitly non-modular

 drivers/tty/serial/lantiq.c     |  8 +-------
 drivers/tty/serial/sn_console.c | 32 +++++++++-----------------------
 drivers/tty/serial/suncore.c    | 11 +++--------
 drivers/tty/serial/sunhv.c      | 13 +++----------
 4 files changed, 16 insertions(+), 48 deletions(-)

-- 
2.2.1
