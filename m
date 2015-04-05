From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Sun, 05 Apr 2015 22:23:10 +0000
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
Message-Id: <alpine.LFD.2.11.1504052319340.21028@eddie.linux-mips.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
In-Reply-To: <1428258294.2775.69.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, 5 Apr 2015, Joe Perches wrote:

>  drivers/tty/serial/dz.c                     | 2 +-
>  drivers/tty/serial/zs.c                     | 2 +-

 For these verified that the change works correctly, thanks for your work.

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
