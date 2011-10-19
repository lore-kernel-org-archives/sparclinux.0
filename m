From: David Miller <davem@davemloft.net>
Date: Wed, 19 Oct 2011 19:29:51 +0000
Subject: Re: [PATCH 3/4] sparc32: return destination pointer on return from
Message-Id: <20111019.152951.1289973252553591449.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1318489205-315-4-git-send-email-konrad@gaisler.com>
In-Reply-To: <1318489205-315-4-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Wed, 19 Oct 2011 10:33:25 +0200

> Isnt the simplest way to apply the original gdbstub.c patch instead?

It's wrong, memcpy() is not implemented properly on 32-bit sparc, fix
it.

> It seems to me that memcpy is tightly programmed. Is saving 2 lines of gdbstub.c
> diff worth a memcpy rewrite?

You really can't find another register to save the initial %o0 value in?
Have you even tried?
