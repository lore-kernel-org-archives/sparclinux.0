From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 14 Feb 2005 16:43:51 +0000
Subject: Re: size-differences of long(userspace) / long(kernel)
Message-Id: <20050214084351.74202405.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 14 Feb 2005 17:32:07 +0100
"Jurzitza, Dieter" <DJurzitza@harmanbecker.com> wrote:

> nevertheless we may run into space issues because structures may grow on their way from userland to kernel-country, thereby kmalloc() calls are subject to earlier failures, as the maximum size of allocable memory for kmalloc() remains the same.

We don't use kmalloc() always, in fact most often we use alloc_user_space()
(named compat_alloc_user_space()) so that the limits are the same.
