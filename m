From: "Grant Likely" <grant.likely@secretlab.ca>
Date: Thu, 21 Aug 2008 22:52:32 +0000
Subject: Re: [PATCH 3/3]: of: Add some I2C mod aliases table entries for sparc64 systems.
Message-Id: <fa686aa40808211552x4ff22c4bve2b8c9dbc88ff0e4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001025.76289480.davem@davemloft.net>
In-Reply-To: <20080821.001025.76289480.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, paulus@samba.org, devicetree-discuss@ozlabs.org

On Thu, Aug 21, 2008 at 1:10 AM, David Miller <davem@davemloft.net> wrote:
>
> of: Add some I2C mod aliases table entries for sparc64 systems.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>

I'd like to see a comment above these three lines stating that they
appear in Sparc systems, but otherwise...

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

> ---
>  drivers/of/base.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ad8ac1a..e849f69 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -410,7 +410,9 @@ struct of_modalias_table {
>        char *modalias;
>  };
>  static struct of_modalias_table of_modalias_table[] = {
> -       /* Empty for now; add entries as needed */
> +       { "i2c-adm1031", "adm1031" },
> +       { "i2c-at24c64", "24c64" },
> +       { "i2c-at34c02", "spd" },
>  };
>
>  /**
> --
> 1.5.6.5.GIT
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
