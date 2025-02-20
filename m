Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACC1F2BB5;
	Thu, 20 Feb 2025 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050173; cv=none; b=PBqd53Ntl9Dc5cJTPE606V+PtWbmjwOkzWpQ/55KGWyhOJYVrtGjgXwU0Y/ghk02oq22m3KGi1dzpLA5RVu3zreg4QoJFqzIIQ8UDbZFWCatH+YELQTrxfhPJDxTZWoT74ohrSGKaVc7e0S4RAk8OkyOsez2HxnlfcnHTE+G6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050173; c=relaxed/simple;
	bh=Iqri3H4l7MINuskI1RcHgMhBsNlYFaxp53yd+z2TvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVD5qzt4AM4to0yTZe2rxktXGiBI/DtNaYE3uI8dnfY6WGYUPp7kOgBtk/aNHhSmnUOMzk0pH0tRtGnGPyvpgN7CtiDZt4Ah65gyMv0a+05J4FOx1kscCIBk4W+HSzdG9zFZHrVgVCqN46tRqsU4KUQjJ0bSj0Qm5LSB//eZJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b12PjNii; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b12PjNii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03C7C4CED1;
	Thu, 20 Feb 2025 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050173;
	bh=Iqri3H4l7MINuskI1RcHgMhBsNlYFaxp53yd+z2TvQE=;
	h=From:To:Cc:Subject:Date:From;
	b=b12PjNiiGqku601OHJrDa/9YCDx0fJyQ7Bdp/ajH184yil9nFzdUdcDe5/ZyRh5m4
	 gLzO1tSw8M34I0X9YAkX4dhc1vCz1nrdAgNhIe1DfvgV6tMcBNDCCvRobcS7IJ8oCf
	 xPSDPzpE9ULLVTIqAFS3ItO8Dl3mn37LJ661h4LPDOBbJgCuS3qjUGJkbV3+SlCQXc
	 Wn5OMkQryz1tLQUJHbJuI72OkPI2qc58tTceZiTUlwAAboJsgJAMlz2p7QHI8ZlV/Z
	 sHQIak/D/jc2CZZWmMl5XCwrQ7mzhT3fKX5LFSRzky0lfYQAPQsieBjjPLv0FP4X7x
	 gqLF2shVX1i9g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lin <dtwlin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	greybus-dev@lists.linaro.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Matt Turner <mattst88@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	sparclinux@vger.kernel.org
Subject: [PATCH 00/29] tty: cleanup no. 99
Date: Thu, 20 Feb 2025 12:15:37 +0100
Message-ID: <20250220111606.138045-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

this is (again) a series of cleanup in tty. I am trying to rework
tty+serial to avoid limitations of devices (so called NR_UART or
tty_alloc_driver()'s first parameter). And the below popped up while
crawling through the code. So this is only a prep cleanup.

* many tty flags are now enums
* many functions were improved for readability
* quite a few unused or old code dropped

In particular, the runtime behaviour of the kernel before and after the
changes is supposed to be bug to bug compatible (except moxa's ioctl
and ISA evils dropped). That is, noone should notice.

Cc: Alex Elder <elder@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lin <dtwlin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: greybus-dev@lists.linaro.org
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-alpha@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Cc: Matt Turner <mattst88@gmail.com>
Cc: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: sparclinux@vger.kernel.org

Jiri Slaby (SUSE) (29):
  tty: convert "TTY Struct Flags" to an enum
  tty: audit: do not use N_TTY_BUF_SIZE
  tty: caif: do not use N_TTY_BUF_SIZE
  tty: move N_TTY_BUF_SIZE to n_tty
  tty: n_tty: use uint for space returned by tty_write_room()
  tty: n_tty: simplify process_output()
  tty: n_tty: clean up process_output_block()
  tty: n_tty: drop n_tty_trace()
  tty: n_tty: extract n_tty_continue_cookie() from n_tty_read()
  tty: n_tty: extract n_tty_wait_for_input()
  tty: n_tty: move more_to_be_read to the end of n_tty_read()
  tty: tty_driver: move TTY macros to the top
  tty: tty_driver: convert "TTY Driver Flags" to an enum
  tty: tty_driver: document both {,__}tty_alloc_driver() properly
  tty: tty_driver: introduce TTY driver sub/types enums
  tty: serdev: drop serdev_controller_ops::write_room()
  tty: moxa: drop version dump to logs
  tty: moxa: drop ISA support
  tty: moxa: carve out special ioctls and extra tty_port
  tty: srmcons: fix retval from srmcons_init()
  tty: staging/greybus: pass tty_driver flags to tty_alloc_driver()
  tty: sunsu: drop serial_{in,out}p()
  tty: sunsu: remove unused serial_icr_read()
  serial: remove redundant tty_port_link_device()
  serial: pass struct uart_state to uart_line_info()
  serial: 8250: use serial_in/out() helpers
  serial: 8250_rsa: simplify rsa8250_{request/release}_resource()
  serial: 8250_port: do not use goto for UPQ_NO_TXEN_TEST code flow
  serial: 8250_port: simplify serial8250_request_std_resource()

 Documentation/driver-api/tty/tty_driver.rst |   4 +-
 Documentation/driver-api/tty/tty_struct.rst |   2 +-
 arch/alpha/kernel/srmcons.c                 |  62 ++---
 drivers/net/caif/caif_serial.c              |   2 +-
 drivers/staging/greybus/uart.c              |   4 +-
 drivers/tty/Kconfig                         |   2 +-
 drivers/tty/moxa.c                          | 251 +-------------------
 drivers/tty/n_tty.c                         | 212 ++++++++---------
 drivers/tty/serdev/core.c                   |  11 -
 drivers/tty/serdev/serdev-ttyport.c         |   9 -
 drivers/tty/serial/8250/8250_dw.c           |  17 +-
 drivers/tty/serial/8250/8250_fsl.c          |   8 +-
 drivers/tty/serial/8250/8250_omap.c         |   2 +-
 drivers/tty/serial/8250/8250_port.c         |  59 ++---
 drivers/tty/serial/8250/8250_rsa.c          |  21 +-
 drivers/tty/serial/serial_core.c            |   6 +-
 drivers/tty/serial/sunsu.c                  | 178 ++++++--------
 drivers/tty/tty_audit.c                     |  10 +-
 drivers/tty/tty_io.c                        |   8 +-
 include/linux/serdev.h                      |   6 -
 include/linux/tty.h                         |  53 +++--
 include/linux/tty_driver.h                  | 180 +++++++-------
 22 files changed, 410 insertions(+), 697 deletions(-)

-- 
2.48.1

