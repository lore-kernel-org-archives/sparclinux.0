From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sun, 29 Apr 2007 13:14:17 +0000
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
Message-Id: <1177852457.4390.26.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704291345480.690@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704291345480.690@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2007-04-29 at 14:02 +0100, Mark Fortescue wrote:
> Hi,
> 
> Does any one have or know of a good reference that would help me in 
> identifing the cause of a CPU soft lockup that apears to be related to 
> changes in the vertual memory handling between these two versions of the 
> kernel?

Have you tried git bisecting between the two kernels to find the
specific patch that breaks?

~spot

