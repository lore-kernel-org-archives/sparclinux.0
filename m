From: David Miller <davem@davemloft.net>
Date: Wed, 20 Mar 2013 19:02:44 +0000
Subject: Re: [PATCH] TTY: serial, stop accessing potential NULLs
Message-Id: <20130320.150244.1737796795204659028.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1363217434-29262-1-git-send-email-jslaby@suse.cz>
In-Reply-To: <1363217434-29262-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jslaby@suse.cz
Cc: gregkh@linuxfoundation.org, jirislaby@gmail.com, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, sparclinux@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>
Date: Thu, 14 Mar 2013 00:30:34 +0100

> The following commits:
> * 6732c8bb8671acbdac6cdc93dd72ddd581dd5e25 (TTY: switch
>   tty_schedule_flip)
> * 2e124b4a390ca85325fae75764bef92f0547fa25 (TTY: switch
>   tty_flip_buffer_push)
> * 05c7cd39907184328f48d3e7899f9cdd653ad336 (TTY: switch
>   tty_insert_flip_string)
> * 92a19f9cec9a80ad93c06e115822deb729e2c6ad (TTY: switch
>   tty_insert_flip_char)
> * 227434f8986c3827a1faedd1feb437acd6285315 (TTY: switch
>   tty_buffer_request_room to tty_port)
> 
> introduced a potential NULL dereference to some drivers. In
> particular, when the device is used as a console, incoming bytes can
> kill the box. This is caused by removed checks for TTY against NULL.
> 
> It happened because it was unclear to me why the checks were there. I
> assumed them superfluous because the interrupts were unbound or
> otherwise stopped. But this is not the case for consoles for these
> drivers, as was pointed out by David Miller.
> 
> Now, this patch re-introduces the checks (at this point we check
> port->state, not the tty proper, as we do not care about tty pointers
> anymore). For both of the drivers, we place the check below the
> handling of break signal so that sysrq can actually work. (One needs
> to issue a break and then sysrq key within the following 5 seconds.)
> 
> We do not change sc26xx, sunhv, and sunsu here because they behave the
> same as before.  People having that hardware should fix the driver
> eventually, however. They always could unconditionally dereference tty
> in receive_chars, port->state in uart_handle_dcd_change, and
> up->port.state->port.tty.
> 
> There is perhaps more to fix in all those drivers, but they are at
> least in a state they were before.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: David S. Miller <davem@davemloft.net>
