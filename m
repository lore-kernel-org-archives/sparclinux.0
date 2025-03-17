Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC721ABB2;
	Mon, 17 Mar 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195013; cv=none; b=U349gBRyCb96hl/WrgfRrXVFv+zbKw75ON4QiwZg0r9klm5sjItsXBHoN9I8kFVQqeWj7566X6S+o3ysnggW7fZFTW8/Jt8G8liRk/z5eGNEGHNsGGSTpwRayJxQgYx/zr06VYaqcDjLIG2d1d9fX1bmb8mRk5xfgrrZGcHatHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195013; c=relaxed/simple;
	bh=0S6jABz1EhUz2qAICCSfATcRswehOmpQ5Ix7yQj4L4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7nXV7nONNzNLx+2hrxElM8juc7SKbPOc/cx9um9kqY1kB2WDa8aEZpxcuNjMLfOEp85ua3kACpFrzmpxCOWnoGvuEBVArToY/4NKHqS2ygCQRlM3DaQb48El7TyjOvxEwLnGE4Jo43tNCqfysHRBgsoaloHYPucQBDmL43Tcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMItLiTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMItLiTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77230C4CEE3;
	Mon, 17 Mar 2025 07:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195012;
	bh=0S6jABz1EhUz2qAICCSfATcRswehOmpQ5Ix7yQj4L4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fMItLiTF+iO7c74vQ/xjH2PFaEgKVE35W2iU2KFFlLvnjF1GTlcWO5i3oS6OrjGZD
	 kF55DFHVGWC5Y3t8WA5AcvdpzwDNS2rIDUwaW/8d7Ao2m4nP/EIj4Ma3QzWp7ZeD8T
	 qRuBBic00D1uDfElKImUyByL2b7md1BcBjM9wBC56W3o2OCjJJPGO7mb0LmaU+PZB2
	 n4OXjyGj6rBVYpDrqd00JprfvhoKdT/E13GfJlNjQ3+QPRRUwp0meWMRCxKsfvqxwG
	 u5TbL1tj+fY74snkyVD5rGJlMzVXZSzcOyLi7FnA2P0XnDa9PvTmjIG5G+oxqERDjy
	 RFkaqNKURuqCw==
Message-ID: <ee234a02-f218-45ae-9261-5f71ff48e840@kernel.org>
Date: Mon, 17 Mar 2025 08:03:26 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/31] tty: cleanup no. 99
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Lin <dtwlin@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, greybus-dev@lists.linaro.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Johan Hovold <johan@kernel.org>,
 linux-alpha@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-staging@lists.linux.dev, Matt Turner <mattst88@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rob Herring <robh@kernel.org>, sparclinux@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Cc (sorry):
Alex Elder <elder@kernel.org>
Andrew Lunn <andrew+netdev@lunn.ch>
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
David Lin <dtwlin@gmail.com>
"David S. Miller" <davem@davemloft.net>
Eric Dumazet <edumazet@google.com>
greybus-dev@lists.linaro.org
"Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Jakub Kicinski <kuba@kernel.org>
Johan Hovold <johan@kernel.org>
linux-alpha@vger.kernel.org
linux-mmc@vger.kernel.org
linux-staging@lists.linux.dev
Matt Turner <mattst88@gmail.com>
netdev@vger.kernel.org
Paolo Abeni <pabeni@redhat.com>
Richard Henderson <richard.henderson@linaro.org>
Rob Herring <robh@kernel.org>
sparclinux@vger.kernel.org
Ulf Hansson <ulf.hansson@linaro.org>

On 17. 03. 25, 8:00, Jiri Slaby (SUSE) wrote:
> Hi,
> 
> this is (again) a series of cleanup in tty. I am trying to rework
> tty+serial to avoid limitations of devices (so called NR_UART or
> tty_alloc_driver()'s first parameter). And the below popped up while
> crawling through the code. So this is only a prep cleanup.
> 
> * many tty flags are now enums
> * many functions were improved for readability
> * quite a few unused or old code dropped
> 
> In particular, the runtime behaviour of the kernel before and after the
> changes is supposed to be bug to bug compatible (except moxa's ioctl
> and ISA evils dropped). That is, noone should notice.
> 
> [v2]
>   * use serial_port_in/out() helpers in 26/30 (and not use serial_in/out())
>   * the last patch is new
> 
> Jiri Slaby (SUSE) (31):
>    tty: convert "TTY Struct Flags" to an enum
>    tty: audit: do not use N_TTY_BUF_SIZE
>    tty: caif: do not use N_TTY_BUF_SIZE
>    tty: move N_TTY_BUF_SIZE to n_tty
>    tty: n_tty: use uint for space returned by tty_write_room()
>    tty: n_tty: simplify process_output()
>    tty: n_tty: clean up process_output_block()
>    tty: n_tty: drop n_tty_trace()
>    tty: n_tty: extract n_tty_continue_cookie() from n_tty_read()
>    tty: n_tty: extract n_tty_wait_for_input()
>    tty: n_tty: move more_to_be_read to the end of n_tty_read()
>    tty: tty_driver: move TTY macros to the top
>    tty: tty_driver: convert "TTY Driver Flags" to an enum
>    tty: tty_driver: document both {,__}tty_alloc_driver() properly
>    tty: tty_driver: introduce TTY driver sub/types enums
>    tty: serdev: drop serdev_controller_ops::write_room()
>    tty: mmc: sdio: use bool for cts and remove parentheses
>    tty: moxa: drop version dump to logs
>    tty: moxa: drop ISA support
>    tty: moxa: carve out special ioctls and extra tty_port
>    tty: srmcons: fix retval from srmcons_init()
>    tty: staging/greybus: pass tty_driver flags to tty_alloc_driver()
>    tty: sunsu: drop serial_{in,out}p()
>    tty: sunsu: remove unused serial_icr_read()
>    serial: remove redundant tty_port_link_device()
>    serial: pass struct uart_state to uart_line_info()
>    serial: 8250: use serial_port_in/out() helpers
>    serial: 8250_rsa: simplify rsa8250_{request/release}_resource()
>    serial: 8250_port: do not use goto for UPQ_NO_TXEN_TEST code flow
>    serial: 8250_port: simplify serial8250_request_std_resource()
>    serial: switch change_irq and change_port to bool in uart_set_info()
> 
>   Documentation/driver-api/tty/tty_driver.rst |   4 +-
>   Documentation/driver-api/tty/tty_struct.rst |   2 +-
>   arch/alpha/kernel/srmcons.c                 |  62 ++---
>   drivers/mmc/core/sdio_uart.c                |   2 +-
>   drivers/net/caif/caif_serial.c              |   2 +-
>   drivers/staging/greybus/uart.c              |   4 +-
>   drivers/tty/Kconfig                         |   2 +-
>   drivers/tty/moxa.c                          | 251 +-------------------
>   drivers/tty/n_tty.c                         | 212 ++++++++---------
>   drivers/tty/serdev/core.c                   |  11 -
>   drivers/tty/serdev/serdev-ttyport.c         |   9 -
>   drivers/tty/serial/8250/8250_dw.c           |  16 +-
>   drivers/tty/serial/8250/8250_fsl.c          |   8 +-
>   drivers/tty/serial/8250/8250_omap.c         |   2 +-
>   drivers/tty/serial/8250/8250_port.c         |  59 ++---
>   drivers/tty/serial/8250/8250_rsa.c          |  21 +-
>   drivers/tty/serial/serial_core.c            |  10 +-
>   drivers/tty/serial/sunsu.c                  | 178 ++++++--------
>   drivers/tty/tty_audit.c                     |  10 +-
>   drivers/tty/tty_io.c                        |   8 +-
>   include/linux/serdev.h                      |   6 -
>   include/linux/tty.h                         |  53 +++--
>   include/linux/tty_driver.h                  | 180 +++++++-------
>   23 files changed, 412 insertions(+), 700 deletions(-)
> 


-- 
js
suse labs
