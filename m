From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2011 21:35:22 +0000
Subject: Re: [PATCH 1/1] apbuart: fix section mismatch warning
Message-Id: <20111227.163522.2156869510683224447.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111227212253.GA8161@merkur.ravnborg.org>
In-Reply-To: <20111227212253.GA8161@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Dec 2011 22:22:53 +0100

>>From b82ccce349dee62fe5acd3167a19490bbe9a7e18 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 27 Dec 2011 22:07:23 +0100
> Subject: [PATCH] apbuart: fix section mismatch warning
> 
> Fix following warnings:
> 
> WARNING: drivers/tty/serial/built-in.o(.text+0x7370): Section mismatch in reference from the function grlib_apbuart_configure() to the variable .init.data:apbuart_match
> The function grlib_apbuart_configure() references
> the variable __initdata apbuart_match.
> This is often because grlib_apbuart_configure lacks a __initdata
> annotation or the annotation of apbuart_match is wrong.
> 
> + 3 more warnings like this.
> 
> There is no guarantee that grlib_apbuart_of_driver.of_match_table
> is only used at __init time - so drop the __initdata annotation.
> 
> grlib_apbuart_configure() is only used during __init so add __init
> to this method too.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Hellstrom <daniel@gaisler.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

Applied to sparc-next, thanks.

Taking a look at the output of "git grep of_device_id | grep __initdata"
shows that a lot of drivers take liberties in this area, perhaps assuming
that they are built in or something like that.

But that isn't even a safe situation, because even built-in drivers can
have their of_device_id accessed later after we bootup, for example when
a bus is hot-plugged in or even via sysfs dumps of the avaialble drivers.

Probably the thing to do is to remove all of these __initdata tags,
because as far as I can tell they are _all_ wrong.  And perhaps add
'const' where missing as well.
