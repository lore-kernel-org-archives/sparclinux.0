From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 11 Nov 2004 22:22:17 +0000
Subject: Re: [PATCH] remove unnecessary pm_idle comment
Message-Id: <20041111142217.6be6ae4a.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ec7cefb04111014511a1326a3@mail.gmail.com>
In-Reply-To: <ec7cefb04111014511a1326a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 10 Nov 2004 14:51:07 -0800
Eric Brower <ebrower@gmail.com> wrote:

> This is a trivial matter, but we ought to remove the 2.6 kernel
> comments that indicate confusion over the conditional use of pm_idle
> in process.c-- systems with APC or PMC (basically, SS4/5 and Voyager)
> have the ability to idle the CPU and do so.  Please see
> .../kernel/apc.c or pmc.c for details.
> 
> Please review attached patch-- no need for confusion.

Applied, thanks Eric.
