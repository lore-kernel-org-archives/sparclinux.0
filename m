From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 05 Mar 2007 16:56:08 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <1173113768.1407.45.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2007-03-05 at 01:11 -0800, David Miller wrote:
> Anyone with a SunBlade100 or SunBlade150 trying to use
> kernels built with gcc-4.1.x or later and seeing hangs
> should try out this patch.

Confirmed that it works on the Aurora side, atyfb is working again on
the SB100.

Thanks a lot for this Dave, that was one of our two showstopper bugs, I
can focus on the other one now (esp on sparc32 being hosed).

~spot

