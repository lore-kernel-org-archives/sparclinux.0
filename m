From: Rob Herring <robherring2@gmail.com>
Date: Sun, 22 Sep 2013 21:08:26 +0000
Subject: Re: [PATCH v2 07/10] of/irq: Propagate errors in of_irq_to_resource_table()
Message-Id: <CAL_JsqJ+4P26hRrJcrbBmwfNPDAS+1GhXj12B+UvqmZZGjqT0g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-8-git-send-email-treding@nvidia.com>
In-Reply-To: <1379510692-32435-8-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Now that all helpers return precise error codes, this function can
> propagate these errors to the caller properly.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - return 0 on success or a negative error code on failure
> - convert callers to new calling convention

[snip]

> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index e4f38c0..6d7f824 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -397,18 +397,20 @@ int of_irq_count(struct device_node *dev)
>   * @res: array of resources to fill in
>   * @nr_irqs: the number of IRQs (and upper bound for num of @res elements)

You are effectively changing this to require an exact match rather
than an upper bound. That seems to be okay since that is what all the
callers want, but the documentation should be updated.

>   *
> - * Returns the size of the filled in table (up to @nr_irqs).
> + * Returns 0 on success or a negative error code on failure.
>   */
>  int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
>                 int nr_irqs)
>  {
> -       int i;
> +       int i, ret;
>
> -       for (i = 0; i < nr_irqs; i++, res++)
> -               if (!of_irq_to_resource(dev, i, res))

The error handling here needs to be updated in the previous patch.

> -                       break;
> +       for (i = 0; i < nr_irqs; i++, res++) {
> +               ret = of_irq_to_resource(dev, i, res);
> +               if (ret < 0)
> +                       return ret;
> +       }
>
> -       return i;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_irq_to_resource_table);
>
