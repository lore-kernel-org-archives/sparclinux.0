From: "David S. Miller" <davem@redhat.com>
Date: Fri, 23 Jan 2004 19:49:46 +0000
Subject: Re: 2.6.2-rc1 smp crash
Message-Id: <20040123114946.165e761f.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040123134628.GH27566@phunnypharm.org>
In-Reply-To: <20040123134628.GH27566@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 23 Jan 2004 10:32:20 -0500
Ben Collins <bcollins@debian.org> wrote:

> Give the attached patch a try. Seems sunzilog was pulling down some
> spinlocks that the serial_core was already doing.
> 
> I think there may be one other issue, but I know this patch is atleast
> correct.

Applied, thanks a lot Ben.
