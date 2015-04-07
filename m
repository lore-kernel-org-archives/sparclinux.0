From: Patrice Chotard <patrice.chotard@st.com>
Date: Tue, 07 Apr 2015 07:14:10 +0000
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
Message-Id: <552383C2.3050502@st.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1428169665.2775.53.camel@perches.com>	
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
In-Reply-To: <1428258294.2775.69.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi

On 04/05/2015 08:24 PM, Joe Perches wrote:
> These structs can be const, so make them const.
>
> Miscellanea:
>
> o Add static to struct uart_ops declaration in bfin_sport_uart
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
[...]

for
>   drivers/tty/serial/st-asc.c                 | 2 +-

Acked-by: Patrice Chotard <patrice.chotard@st.com>


Thanks


