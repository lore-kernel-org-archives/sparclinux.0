From: David Miller <davem@davemloft.net>
Date: Mon, 28 Jul 2014 22:49:43 +0000
Subject: Re: [PATCH] Fix BBC I2C envctrl on SunBlade 2000
Message-Id: <20140728.154943.884725723310916037.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271504.05258.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271504.05258.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 15:04:04 +0200

Thanks for all of your patches today.

Firstly, please format your Subject line correctly, it should
be of the form:

	[PATCH] ${subsystem}: Description.

Here subsystem could be "bbc-i2c: ".

> +       /* Need to initialize some fields of bbc_cpu_temperature */
> +       INIT_LIST_HEAD(&(tp->bp_list));
> +       INIT_LIST_HEAD(&(tp->glob_list));
> +

The innermost parenthesis are unnecessary, please remove them.

> +       /* Need to initialize some fields of bbc_fan_control */
> +       INIT_LIST_HEAD(&(fp->bp_list));
> +       INIT_LIST_HEAD(&(fp->glob_list));
> +

Likewise, and for the rest of your list initialization additions.

> -       bp->i2c_bussel_reg = of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2c_bussel");
> -       if (!bp->i2c_bussel_reg)
> -               goto fail;
> +       if(op->num_resources = 2) {

Please put a space between "if" and the openning parenthesis of the
condition being tested.

> +       if(op->num_resources = 2) {

Likewise.

> +               bp->i2c_bussel_reg = of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2c_bussel");
> +               if (!bp->i2c_bussel_reg) {
> +                       goto fail;
> +               }

Please do not use curly braces around single line basic blocks.
