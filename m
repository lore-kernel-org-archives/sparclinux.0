From: "Eric Brower" <ebrower@gmail.com>
Date: Fri, 29 Feb 2008 19:46:19 +0000
Subject: Re: bbc_envctrl & sunblade1000 temp/fan monitoring
Message-Id: <ec7cefb0802291146s5595dee1va9883eb0ddd51f10@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY123-W223997AE674E1FB857BC07D1260@phx.gbl>
In-Reply-To: <BAY123-W223997AE674E1FB857BC07D1260@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Pablo,

There are some experimental, out-of-kernel drivers for SUNW,envctrl
(E450) and SUNW,envctrltwo (E250) located here:

  http://www.david-web.co.uk/index.php?p=3Denvctrl

This may provide some inspiration on using sysfs for accessing sensors
information.

It would be welcome for a motivated somebody to attempt to port the
bbc_envctrl driver into this same infrastructure, though this is
experimental and there is no guarantee it will ever be submitted to
the mainline kernel.

Thanks,
E

On Fri, Feb 29, 2008 at 11:06 AM, David Miller <davem@davemloft.net> wrote:
> From: Pablo_Andr=E9s_Martikian <pablomartikian@hotmail.com>
>  Date: Fri, 29 Feb 2008 17:37:33 +0100
>
>  > sorry about that. my fault. I've added the file.
>
>  :-(  A patch would definitely be preferred over
>  posting the entire file next time.
>
>  Thanks.
>
>
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
E
