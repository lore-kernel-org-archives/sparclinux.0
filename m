From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Aug 2018 14:13:15 +0000
Subject: Re: [PATCH] sparc: Convert to using %pOFn instead of device_node.name
Message-Id: <CAL_JsqK-U02dwj8H5KW9uF06NuK7AgCfAVeatsB-F-GGsxafvg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-7-robh@kernel.org>
In-Reply-To: <20180828015252.28511-7-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

On Mon, Aug 27, 2018 at 8:52 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

> @@ -201,7 +201,7 @@ char * __init build_path_component(struct device_node *dp)
>         tmp_buf[0] = '\0';
>         __build_path_component(dp, tmp_buf);
>         if (tmp_buf[0] = '\0')
> -               strcpy(tmp_buf, dp->name);
> +               snprint(tmp_buf, sizeof(tmp_buf), "%pOFn", dp);

Ugg, v2 coming soon.

Rob
