From: David Miller <davem@davemloft.net>
Date: Tue, 18 Dec 2007 22:34:09 +0000
Subject: Re: sparc64 with 32-bit user-space context switching question
Message-Id: <20071218.143409.05828942.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18279.47071.463773.734087@harpo.it.uu.se>
In-Reply-To: <18279.47071.463773.734087@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 18 Dec 2007 13:06:55 +0100

> Also, does anyone know what Solaris does to the
> high 32 bits during context switches?

Solaris handles things identically to Linux.

These rules are even encoded into places like the
GCC backend for sparc, when generating v9 code
for 32-bit.
