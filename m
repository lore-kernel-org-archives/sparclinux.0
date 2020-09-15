From: David Miller <davem@davemloft.net>
Date: Tue, 15 Sep 2020 00:03:21 +0000
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions; use string size
Message-Id: <20200914.170321.1710628974878239639.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
In-Reply-To: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mfwitten@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Michael Witten <mfwitten@gmail.com>
Date: Fri, 04 Sep 2020 19:40:00 -0000

> @@ -34,10 +34,10 @@ EXPORT_SYMBOL(of_console_options);
>  int of_getintprop_default(struct device_node *np, const char *name, int def)
>  {
>  	struct property *prop;
> -	int len;
> +	int size;
>  
> -	prop = of_find_property(np, name, &len);
> -	if (!prop || len != 4)
> +	prop = of_find_property(np, name, &size);
> +	if (!prop || size != 4)
>  		return def;

This is just changing the variable name and makes no functional change
at all, and therefore is gratuitous.

Please only include pure functional changes that fix the bug(s) in
question.

If there are multiple bugs, please fix one bug per patch and include a
detailed explanation of each bug fix in the body of the commit
message.

Thank you.
