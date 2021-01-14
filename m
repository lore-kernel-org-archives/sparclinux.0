From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 14 Jan 2021 17:57:15 +0000
Subject: [PATCH 0/3] tty: some cleanups in remove functions
Message-Id: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

Hello,

while working on changing the prototype of struct vio_driver::remove to
return void I noticed a few exit paths in such callbacks that return an
error code.

This is a bad thing because the return value is ignored (which is the
motivation to make it void) and the corresponding device then ends in
some limbo state.

Luckily for the three offenders here these cases cannot happen and are
simplified accordingly. This then makes the patch that changes the
remove callback's prototype simpler because it only changes prototypes
and drops "return 0"s.

Best regards and thanks for considering,
Uwe Kleine-König

Uwe Kleine-König (3):
  tty: hvcs: Drop unnecessary if block
  tty: vcc: Drop unnecessary if block
  tty: vcc: Drop impossible to hit WARN_ON

 drivers/tty/hvc/hvcs.c |  3 ---
 drivers/tty/vcc.c      | 10 ++--------
 2 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.29.2
