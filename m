From: Andrew Morton <akpm@osdl.org>
Date: Wed, 18 Jan 2006 00:09:52 +0000
Subject: Re: [PATCH] fix up sbuslib for new fb_comapt_ioctl prototype
Message-Id: <20060117160952.06b96f73.akpm@osdl.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060115205554.GA19609@lst.de>
In-Reply-To: <20060115205554.GA19609@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> Start sticking -Werror in a subdirectory from time to time :)
>

CFLAGS += $(shell if [ $(whoami) != "akpm" ] ; then echo "-Werror" ; fi )

