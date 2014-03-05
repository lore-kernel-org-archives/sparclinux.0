From: Allen Pais <allen.pais@oracle.com>
Date: Wed, 05 Mar 2014 04:42:20 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <5316A85C.9080508@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <530D9D1C.1060905@oracle.com> <39171393599083@web13h.yandex.ru> <20140304.141003.1969905483115684548.davem@davemloft.net> <20140304.152835.432307123220321373.davem@davemloft.net>
In-Reply-To: <20140304.152835.432307123220321373.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: tkhai@yandex.ru, linux-rt-users@vger.kernel.org, sparclinux@vger.kernel.org, bigeasy@linutronix.de

On Wednesday 05 March 2014 01:58 AM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 04 Mar 2014 14:10:03 -0500 (EST)
> 
>> From: Kirill Tkhai <tkhai@yandex.ru>
>> Date: Fri, 28 Feb 2014 18:51:23 +0400
>>
>>> This should be fixed like that's done for 8250
>>> [patch drivers-serial-cleanup-locking-for-rt.patch]
>>
>> Like the patch below?

tested. Sounds good to me.
Tested-by: Allen Pais <allen.pais@oracle.com>

> 
> Here's an updated patch that takes care of all of the Sun serial
> drivers, and is compile tested:
> 
> --------------------
> sparc: serial: Clean up the locking for -rt
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
> index cf86e72..dc697ce 100644
> --- a/drivers/tty/serial/sunhv.c
> +++ b/drivers/tty/serial/sunhv.c
> @@ -433,13 +433,10 @@ static void sunhv_console_write_paged(struct console *con, const char *s, unsign
>  	unsigned long flags;
>  	int locked = 1;
>  
> -	local_irq_save(flags);
> -	if (port->sysrq) {
> -		locked = 0;
> -	} else if (oops_in_progress) {
> -		locked = spin_trylock(&port->lock);
> -	} else
> -		spin_lock(&port->lock);
> +	if (port->sysrq || oops_in_progress)
> +		locked = spin_trylock_irqsave(&port->lock, flags);
> +	else
> +		spin_lock_irqsave(&port->lock, flags);
>  
>  	while (n > 0) {
>  		unsigned long ra = __pa(con_write_page);
> @@ -470,8 +467,7 @@ static void sunhv_console_write_paged(struct console *con, const char *s, unsign
>  	}
>  
>  	if (locked)
> -		spin_unlock(&port->lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
>  static inline void sunhv_console_putchar(struct uart_port *port, char c)
> @@ -492,7 +488,10 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
>  	unsigned long flags;
>  	int i, locked = 1;
>  
> -	local_irq_save(flags);
> +	if (port->sysrq || oops_in_progress)
> +		locked = spin_trylock_irqsave(&port->lock, flags);
> +	else
> +		spin_lock_irqsave(&port->lock, flags);
>  	if (port->sysrq) {
>  		locked = 0;
>  	} else if (oops_in_progress) {
> @@ -507,8 +506,7 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
>  	}
>  
>  	if (locked)
> -		spin_unlock(&port->lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
>  static struct console sunhv_console = {
> diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
> index 380fb53..5faa8e9 100644
> --- a/drivers/tty/serial/sunsab.c
> +++ b/drivers/tty/serial/sunsab.c
> @@ -844,20 +844,16 @@ static void sunsab_console_write(struct console *con, const char *s, unsigned n)
>  	unsigned long flags;
>  	int locked = 1;
>  
> -	local_irq_save(flags);
> -	if (up->port.sysrq) {
> -		locked = 0;
> -	} else if (oops_in_progress) {
> -		locked = spin_trylock(&up->port.lock);
> -	} else
> -		spin_lock(&up->port.lock);
> +	if (up->port.sysrq || oops_in_progress)
> +		locked = spin_trylock_irqsave(&up->port.lock, flags);
> +	else
> +		spin_lock_irqsave(&up->port.lock, flags);
>  
>  	uart_console_write(&up->port, s, n, sunsab_console_putchar);
>  	sunsab_tec_wait(up);
>  
>  	if (locked)
> -		spin_unlock(&up->port.lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&up->port.lock, flags);
>  }
>  
>  static int sunsab_console_setup(struct console *con, char *options)
> diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
> index db79b76..9a0f24f 100644
> --- a/drivers/tty/serial/sunsu.c
> +++ b/drivers/tty/serial/sunsu.c
> @@ -1295,13 +1295,10 @@ static void sunsu_console_write(struct console *co, const char *s,
>  	unsigned int ier;
>  	int locked = 1;
>  
> -	local_irq_save(flags);
> -	if (up->port.sysrq) {
> -		locked = 0;
> -	} else if (oops_in_progress) {
> -		locked = spin_trylock(&up->port.lock);
> -	} else
> -		spin_lock(&up->port.lock);
> +	if (up->port.sysrq || oops_in_progress)
> +		locked = spin_trylock_irqsave(&up->port.lock, flags);
> +	else
> +		spin_lock_irqsave(&up->port.lock, flags);
>  
>  	/*
>  	 *	First save the UER then disable the interrupts
> @@ -1319,8 +1316,7 @@ static void sunsu_console_write(struct console *co, const char *s,
>  	serial_out(up, UART_IER, ier);
>  
>  	if (locked)
> -		spin_unlock(&up->port.lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&up->port.lock, flags);
>  }
>  
>  /*
> diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
> index 45a8c6a..a2c40ed 100644
> --- a/drivers/tty/serial/sunzilog.c
> +++ b/drivers/tty/serial/sunzilog.c
> @@ -1195,20 +1195,16 @@ sunzilog_console_write(struct console *con, const char *s, unsigned int count)
>  	unsigned long flags;
>  	int locked = 1;
>  
> -	local_irq_save(flags);
> -	if (up->port.sysrq) {
> -		locked = 0;
> -	} else if (oops_in_progress) {
> -		locked = spin_trylock(&up->port.lock);
> -	} else
> -		spin_lock(&up->port.lock);
> +	if (up->port.sysrq || oops_in_progress)
> +		locked = spin_trylock_irqsave(&up->port.lock, flags);
> +	else
> +		spin_lock_irqsave(&up->port.lock, flags);
>  
>  	uart_console_write(&up->port, s, count, sunzilog_putchar);
>  	udelay(2);
>  
>  	if (locked)
> -		spin_unlock(&up->port.lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&up->port.lock, flags);
>  }
>  
>  static int __init sunzilog_console_setup(struct console *con, char *options)
> 

