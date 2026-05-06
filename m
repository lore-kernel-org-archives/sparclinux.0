Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB614B977;
	Wed,  6 May 2026 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069770; cv=none; b=W3rfhIq9vxUODQJF3DTDr2itiaFSDDaja/cja/vQAIMQNUTuteOgUfPXP0tdxZI88NHauh4K+Wfyr5fyCUbLTpzH4xuhODIf9yZvxHO95/Eumt4acGzCy0WUZah4EXbNFff24nrxH1EeRGU5B7znD/QnYuQeOIBG5aA5bkZDoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069770; c=relaxed/simple;
	bh=x+Bc1kuWG1hcJxmVzrQn0qSYj0iUKEhtmICqJ94J7uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/TLj9ulTaYXaTmVXz355fLziJvgL3JPX8DOrng6NQuqjfxLcJsqjwxx7600k0M4LqbHavVKKorTDlr8Aizwsr/73967PEkFR8KMrPKhVPrGjpx7PziX69hGt56ECfjE4aOsqbCUl43AB2sttWm7Ha43Qab49lPZCRatrVRZjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEZNfb6a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HDAiL6vd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEZNfb6a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HDAiL6vd"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778069767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+1/uCUb/9Eo1Px+rgMFN1iRosL2spXsTi3KsPZ1F3xA=;
	b=KEZNfb6au2XwQeEEi0swhycY4FJgNVfQtWY/FhK/yCoI3hSDLSwaRRZI7RlzCEMExUQY7f
	T+QvDlQipN8FjeKi9rITCGTCItHT1Du7tdlSvZgdhQ74eu9zdcBtt8pwU8sOJ181n2cmw8
	J9/k9sA5/zZtm5ooh/ksw3AgrucA71XVof7sdGHN+LWlrg0VV3tte3HlksbB5VLszGhz28
	H4IgGvitX+Dn21W9SBCcjK0JOXsIi/JrEVu6xlth/4EHNuMcc01rZuEvaxqYBbT1EoX7Cs
	d0OeQzL+2UoVRxfvwy9zy3ryLgFelOU8Zr/F5jtXA+rwQit7NsJnRKlvKmc2QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778069767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+1/uCUb/9Eo1Px+rgMFN1iRosL2spXsTi3KsPZ1F3xA=;
	b=HDAiL6vdcaFMCJJ0GmldyQzwhs3/86r20VaemvAKGIZwBdTF4E/PwfsT+zLFPFOhI9PuXQ
	Bfk90npEht4yNjAQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	Joseph Tilahun <jtilahun@astranis.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH tty v4 0/6] 8250: Add console flow control
Date: Wed,  6 May 2026 14:21:55 +0206
Message-ID: <20260506121606.5805-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v4 of a series to implement console flow control for the
8250 serial driver. v3 is here [0].

The 8250 driver already has code in place to support console flow
control. However, there is no way to activate it and it is
incomplete. This series provides the necessary missing pieces while
attempting to be as conservative as possible, so as not to introduce
any side effects into the many 8250 variants or other non-8250 serial
drivers.

For patch 2 I used the following Coccinelle script to perform the
modifications...

===== BEGIN cons_flow.cocci =====
// SPDX-License-Identifier: GPL-2.0-only
// Options: --all-includes

virtual patch

@r1@
type T1;
identifier U;
@@

T1 {
   ...
   struct uart_port U;
   ...
};

@r2@
r1.T1 *E;
@@

- (E->port.flags & UPF_CONS_FLOW)
+ uart_cons_flow_enabled(&E->port)

@r3@
struct uart_port *U;
@@

- (U->flags & UPF_CONS_FLOW)
+ uart_cons_flow_enabled(U)

@r4@
struct uart_port *U;
@@

- U->flags |= UPF_CONS_FLOW
+ uart_set_cons_flow_enabled(U, true)
===== END cons_flow.cocci =====

Changes for v4:

- Rename uart_get_cons_flow() to uart_cons_flow_enabled().

- Rename uart_set_cons_flow() to uart_set_cons_flow_enabled().

Changes for v3:

- Deprecate UPF_CONS_FLOW. Provide separate boolean with wrappers as
  alternative.

- Update all UPF_CONS_FLOW users to new cons_flow wrappers.

- Use irqsave variant of spin lock for status update.

- When 8250 console flow control is not specified, clear the policy.

Changes for v2:

- Prepend a patch to perform an extra LSR wait after CTS assertion if
  the initial LSR wait timed out.

- Close a window in serial8250_register_8250_port() where console
  flow control was briefly disabled.

- Add port lock synchronization to the port->status RMW update in
  uart_set_options().

John Ogness

[0] https://lore.kernel.org/lkml/20260417102423.40984-1-john.ogness@linutronix.de

John Ogness (6):
  serial: core: Add dedicated uart_port field for console flow
  serial: Replace driver usage of UPF_CONS_FLOW
  serial: sh-sci: Avoid deprecated UPF_CONS_FLOW
  serial: 8250: Set cons_flow on port registration
  serial: 8250: Check LSR timeout on console flow control
  serial: 8250: Add support for console flow control

 drivers/tty/serial/8250/8250_core.c |  6 ++++++
 drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++++++----
 drivers/tty/serial/bcm63xx_uart.c   |  2 +-
 drivers/tty/serial/omap-serial.c    |  2 +-
 drivers/tty/serial/pch_uart.c       |  2 +-
 drivers/tty/serial/pxa.c            |  2 +-
 drivers/tty/serial/samsung_tty.c    |  8 ++++----
 drivers/tty/serial/serial_core.c    | 21 ++++++++++++++++++++-
 drivers/tty/serial/serial_txx9.c    |  4 ++--
 drivers/tty/serial/sh-sci.c         |  5 ++++-
 drivers/tty/serial/sunsu.c          |  2 +-
 include/linux/serial_core.h         | 20 ++++++++++++++++++++
 12 files changed, 78 insertions(+), 17 deletions(-)


base-commit: a2083fd1fa7aa0ef5cd8fd92396da0de2d0654b0
-- 
2.47.3

