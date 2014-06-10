From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 10 Jun 2014 21:20:08 +0000
Subject: Re: Linux 3.15: SPARC serial console regression
Message-Id: <53977688.5080802@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140609205917.GA913@drone.musicnaut.iki.fi> <1402357697-20976-1-git-send-email-peter@hurleysoftware.com> <20140610192438.GA6846@ravnborg.org>
In-Reply-To: <20140610192438.GA6846@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seth Bollinger <sethb@digi.com>

Hi Sam,

On 06/10/2014 03:24 PM, Sam Ravnborg wrote:
>> From: Peter Hurley <peter@hurleysoftware.com>
>> Date: Mon, 9 Jun 2014 19:21:43 -0400
>> Subject: [PATCH] serial: sunsab: Test for no tx data on tx restart
>>
>> Commit 717f3bbab3c7628736ef738fdbf3d9a28578c26c,
>> 'serial_core: Fix conditional start_tx on ring buffer not empty'
>> exposes an incorrect assumption in sunsab's start_tx method; the
>> tx ring buffer can, in fact, be empty when restarting tx when
>> performing flow control.
>>
>> Test for empty tx ring buffer when in sunsab's start_tx method.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>
> Hi Peter.
>
> Can you please take a look at sunzilog.c.
> It looks like the same test is missing in sunzilog_start_tx():

Yeah, when I saw that yesterday, I put
   * audit uart drivers' start_tx() methods
on my TODO list.

>          } else {
>                  struct circ_buf *xmit = &port->state->xmit;
>
>                  writeb(xmit->buf[xmit->tail], &channel->data);
>                  ZSDELAY();
>                  ZS_WSYNC(channel);
>
>                  xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>                  port->icount.tx++;
>
>                  if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>                          uart_write_wakeup(&up->port);
>          }
>
>
> I did not review all drives - only a few sun drivers
> and this was the only one that occured to me also
> required this check.
>
> I also noticed the typical pattern is:
>
>      if (uart_circ_empty(xmit) || uart_tx_stopped(port))
>
> Should you use this pattern also in sunsab.c?

What a mess.

uart_tx_stopped() _should_ be redundant for the start_tx() method.
However, I see that uart_resume_port() doesn't check either flow state
and uart_handle_cts_change() doesn't check the soft-flow state.

The semantics of the start_tx() method should be 'tx may commence; begin
xmitting if data is ready'. Except in the case where send_xchar() is not
supported by the uart driver. <sigh>

Regards,
Peter Hurley


