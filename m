From: David Miller <davem@davemloft.net>
Date: Mon, 03 Dec 2018 04:57:52 +0000
Subject: Re: [PATCH] serial/sunsu: add missing of_node_put()
Message-Id: <20181202.205752.1359988041150979586.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181121160615.23666-1-tiny.windzz@gmail.com>
In-Reply-To: <20181121160615.23666-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tiny.windzz@gmail.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>
Date: Wed, 21 Nov 2018 11:06:15 -0500

> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> This place is not doing this, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Several coding style problems and you are adding two new
leaks.

> +		struct device_node *tmp;
>  		const char *keyb = of_get_property(ap, "keyboard", NULL);
>  		const char *ms = of_get_property(ap, "mouse", NULL);

Always order local variable declarations from longest to
shortest line.

>  
>  		if (keyb) {
> -			if (dp = of_find_node_by_path(keyb))
> -				return SU_PORT_KBD;
> +			tmp = of_find_node_by_path(keyb);
> +			if (tmp && dp = tmp){

Always put a space between ")" and the "{" openning a new basic
block.

> +				rc = SU_PORT_KBD;
> +				goto out;
> +			}
>  		}
>  		if (ms) {
> -			if (dp = of_find_node_by_path(ms))
> -				return SU_PORT_MS;
> +			tmp = of_find_node_by_path(ms);
> +			if (tmp && dp = tmp){
> +				rc = SU_PORT_MS;
> +				goto out;
> +			}
>  		}
>  	}
>  
> -	return SU_PORT_PORT;
> +out:
> +	of_node_put(ap);
> +	return rc;

Now you have two references, one held by 'ap' and one held by 'tmp'.

You are not releasing the one held by 'tmp', and you must release
'tmp' even if it equals 'dp'.

It's pretty obvious you have no way by which to test these changes and
therefore are not doing so.
