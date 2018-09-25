From: Kees Cook <keescook@chromium.org>
Date: Tue, 25 Sep 2018 03:17:55 +0000
Subject: Re: [PATCH] sparc64: viohs: Remove VLA usage
Message-Id: <CAGXu5jL4q_FRn7ehDy4MtXpHanhtsu9M_RGKQMZ+by+Rq9ncKw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180905220351.GA48213@beast>
In-Reply-To: <20180905220351.GA48213@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Allen Pais <allen.pais@oracle.com>, Philippe Ombredanne <pombredanne@nexb.com>, sparclinux <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Sep 5, 2018 at 3:03 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates a fixed size array for the maximum number of cookies and
> adds a runtime sanity check.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1
> RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping. Dave, can you take this?

Thanks!

-Kees

> ---
>  arch/sparc/kernel/viohs.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
> index 635d67ffc9a3..7db5aabe9708 100644
> --- a/arch/sparc/kernel/viohs.c
> +++ b/arch/sparc/kernel/viohs.c
> @@ -180,11 +180,17 @@ static int send_dreg(struct vio_driver_state *vio)
>                 struct vio_dring_register pkt;
>                 char all[sizeof(struct vio_dring_register) +
>                          (sizeof(struct ldc_trans_cookie) *
> -                         dr->ncookies)];
> +                         VIO_MAX_RING_COOKIES)];
>         } u;
> +       size_t bytes = sizeof(struct vio_dring_register) +
> +                      (sizeof(struct ldc_trans_cookie) *
> +                       dr->ncookies);
>         int i;
>
> -       memset(&u, 0, sizeof(u));
> +       if (WARN_ON(bytes > sizeof(u)))
> +               return -EINVAL;
> +
> +       memset(&u, 0, bytes);
>         init_tag(&u.pkt.tag, VIO_TYPE_CTRL, VIO_SUBTYPE_INFO, VIO_DRING_REG);
>         u.pkt.dring_ident = 0;
>         u.pkt.num_descr = dr->num_entries;
> @@ -206,7 +212,7 @@ static int send_dreg(struct vio_driver_state *vio)
>                        (unsigned long long) u.pkt.cookies[i].cookie_size);
>         }
>
> -       return send_ctrl(vio, &u.pkt.tag, sizeof(u));
> +       return send_ctrl(vio, &u.pkt.tag, bytes);
>  }
>
>  static int send_rdx(struct vio_driver_state *vio)
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
